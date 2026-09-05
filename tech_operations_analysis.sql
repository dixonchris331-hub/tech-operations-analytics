-- Business Question 1:
-- How many devices are assigned to each location?
SELECT locations.location_name,
COUNT(*) AS number_of_devices
FROM locations
INNER JOIN devices
ON locations.location_id = devices.location_id
GROUP BY locations.location_name
ORDER BY number_of_devices DESC;

-- Findings:
-- All five locations have 3 devices assigned.
-- Device inventory is evenly distributed across locations.


-- Business Question 2:
-- Which failure types occur most frequently?
SELECT failure_type, COUNT(*) AS number_of_failures 
FROM repair_events GROUP BY failure_type
ORDER BY number_of_failures DESC;

-- Findings: 
-- Upload error is the most common failure type, followed by No Ping.
-- Storage Issue and Hardware Failure are tied for the fewest occurrences. 


-- Business Question 3:
-- Which Locations experience the most repair events?
SELECT locations.location_name, COUNT(repair_events.repair_id) AS number_of_repairs 
FROM locations LEFT JOIN repair_events ON locations.location_id = repair_events.location_id
GROUP BY locations.location_name 
ORDER BY number_of_repairs DESC;

-- Findings:
-- I found that the Austin facility experienced the most repairs.
-- This was followed by Phoenix, Seattle, Bay Area, and Denver in that order.


-- Business Question 4:
-- What is the average repair time for each location
SELECT locations.location_name, AVG(repair_events.repair_date - repair_events.failure_date) AS average_repair_days 
FROM locations INNER JOIN repair_events ON locations.location_id = repair_events.location_id  
WHERE repair_events.repair_date IS NOT NULL 
GROUP BY locations.location_name 
ORDER BY average_repair_days DESC;

-- Findings:
-- Phoenix Facility has the longest average repair time at 3.67 days.
-- Austin has the highest repair volume but a close second average repair time at 3.3 days.
-- This suggests to me that repair volume alone does not explain differences in repair turnaround performance.


-- Business Question 5:
-- Which failure types have the longest average repair time? 
SELECT failure_type, AVG(repair_date - failure_date) AS average_repair_days 
FROM repair_events WHERE repair_status = 'Repaired' 
GROUP BY failure_type 
ORDER BY average_repair_days DESC;

-- Findings:
-- Hardware failure and No ping take considerably longer to repair opposed to upload error and storage issue.
-- Hardware failure 5 repair days, No ping 4 days, Upload error 2.25 days, storage issue 1.67 days.
-- Failure type could play a factor in repair turnaround differences between the locations.


-- Business Question 6:
-- What types of failures are occuring at each location?
SELECT locations.location_name, repair_events.failure_type, COUNT(repair_events.repair_id) AS number_of_repairs 
FROM locations LEFT JOIN repair_events ON locations.location_id = repair_events.location_id 
GROUP BY locations.location_name, repair_events.failure_type 
ORDER BY number_of_repairs DESC;

-- Findings
-- Austin experienced the highest rate of hardware failures and No Ping's, which are the two longest repair types.
-- Phoenix mostly experienced upload errors, despite having the average completed repair time of all locations.
-- Phoenix doesn't appear to have a pinpoint as to why such slow repair times as of yet.


-- Business Question 7:
-- Which devices experienced repeated repairs?
SELECT devices.device_serial, COUNT(repair_events.repair_id) AS number_of_repairs 
FROM devices LEFT JOIN repair_events ON devices.device_id = repair_events.device_id 
GROUP BY devices.device_serial HAVING COUNT(repair_events.repair_id) >= 2 
ORDER BY number_of_repairs DESC;

-- Findings:
-- Three devices (SN-C1001, SN-B1001, And SN - A1005) all had 3 repairs each.
-- These devices accounted for 9 of the 15 repair totals.
-- This tells me the repairs are all centered around a small set of particular failing devices.


-- Business Question 8:
-- Do devices that repeatedly require repairs also experience repeated upload failures?
SELECT devices.device_serial, COUNT(upload_events.upload_status) AS number_of_upload_failures 
FROM devices LEFT JOIN upload_events ON devices.device_id = upload_events.device_id
WHERE upload_events.upload_status = 'No Ping' OR upload_events.upload_status = 'Error'
GROUP BY devices.device_serial ORDER BY number_of_upload_failures DESC;

-- Findings:
-- The three devices with the most repeat repairs also had the highest number of upload failures.
-- SN-B1001 and SN-C1001 have 3 upload failures and SN-A1005 has 2.
-- It seems that we have a handful of unreliable devices contributing to problems across repair and upload operations.


-- Business Question 9:
-- Which devices experienced both repairs and upload failures? 
WITH repair_counts AS (SELECT device_ID, COUNT(*) AS repair_count 
FROM repair_events GROUP BY device_id), upload_failure_counts AS (SELECT device_id, 
COUNT(*) AS upload_failure_count FROM upload_events 
WHERE upload_status = 'Error' OR upload_status = 'No Ping'
GROUP BY device_id) 
SELECT devices.device_serial, repair_counts.repair_count, upload_failure_counts.upload_failure_count 
FROM devices INNER JOIN repair_counts ON devices.device_id = repair_counts.device_id 
INNER JOIN upload_failure_counts ON devices.device_id = upload_failure_counts.device_id;

-- Findings:
-- Total of 7 devices had both repair and upload failures.
-- SN-B1001 and SN-C1001 each had the most issues with 3 fails each for each fail type.
-- SN-A1005 also had trouble with 3 repair events and 2 failures.
-- All other devices have no more than 1 event for each suggesting this is a reliability issue among a few devices.


-- Business Question 10:
-- How has monthly repair volume changed over time compared with the previous month?
WITH monthly_repairs AS (SELECT EXTRACT(MONTH FROM failure_date) AS month,
COUNT(*) AS repair_count
FROM repair_events
GROUP BY EXTRACT(MONTH FROM failure_date))
SELECT month, repair_count, LAG(repair_count) OVER (ORDER BY month) AS previous_month_repairs,
repair_count - LAG(repair_count) OVER (ORDER BY month) AS change_from_previous_month
FROM monthly_repairs ORDER BY month;

-- Findings:
-- Repair events showed as 3 in June with no previous months comparison. 
-- Increased from 3 to 6 in July, which is another 3 repair increase.
-- And remained at 6 in August.
-- Repair activity rose from june to july and remained elevated in August.


-- Business Question 11:
-- Which destination locations have the longest average delivery times for completed shipments?
SELECT AVG(delivery_date - ship_date) AS average_delivery_time, location_name 
FROM shipments INNER JOIN locations ON shipments.destination_location_id = locations.location_id
WHERE shipment_status = 'Delivered' GROUP BY location_name ORDER BY average_delivery_time DESC;

-- Findings:
-- Phoenix has the longest average inbound delivery time at 4.75 days followed by Denver at 4.7 days roughly.
-- The 3rd and 4th slowest belongs to Austin at 4.5 and Seattle at 3.7 days, with the bay area taking 3.5 days.
-- It's also recognized that Phoenix had the longest average repair time. 
-- Too early to tell if there's ties between the slow delivery days and high repair amounts.
-- It is worth looking into Phoenix for deeper review. 


-- Business Question 12:
-- Do devices with repeated repair events also experience longer shipment times?
WITH device_repairs AS (SELECT device_id, COUNT(*) AS repair_count 
FROM repair_events GROUP BY device_id HAVING COUNT(repair_status) >= 2) 
SELECT device_repairs.repair_count, AVG(shipments.delivery_date - shipments.ship_date) 
AS average_delivery_date, devices.device_serial
FROM device_repairs
INNER JOIN devices ON device_repairs.device_id = devices.device_id INNER JOIN shipments 
ON shipments.device_id = device_repairs.device_id WHERE shipment_status = 'Delivered' 
GROUP BY devices.device_serial, device_repairs.repair_count
ORDER BY average_delivery_date DESC;

-- There were 3 devices that experienced 3 repairs total.
-- SN-C1001 had the longest average delivery date with 6 days followed by SN-A1005 at 5.5 days and SN-B1001 at 4 days.
-- These three devices all experiences long delivery times but varied.
-- More comparison with devices that didn't have as many repairs would need to be accounted for to determine if,
-- longer delivery times did equal to more repairs.