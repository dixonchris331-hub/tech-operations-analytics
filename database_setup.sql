-- Tech Operations & Fulfillment Analytics
-- Synthetic database setup
-- This dataset was created for learning and portfolio purposes.

CREATE TABLE locations (
    location_id INTEGER,
    location_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    location_type VARCHAR(50)
);

CREATE TABLE devices (
    device_id INTEGER,
    device_serial VARCHAR(50),
    device_type VARCHAR(50),
    storage_tb INTEGER,
    device_status VARCHAR(30),
    location_id INTEGER
);

CREATE TABLE repair_events (
    repair_id INTEGER,
    device_id INTEGER,
    location_id INTEGER,
    failure_date DATE,
    repair_date DATE,
    repair_status VARCHAR(30),
    failure_type VARCHAR(50)
);

CREATE TABLE shipments (
    shipment_id INTEGER,
    device_id INTEGER,
    origin_location_id INTEGER,
    destination_location_id INTEGER,
    ship_date DATE,
    delivery_date DATE,
    shipment_status VARCHAR(30)
);

CREATE TABLE upload_events (
    upload_id INTEGER,
    device_id INTEGER,
    location_id INTEGER,
    upload_date DATE,
    data_tb NUMERIC(10,2),
    upload_status VARCHAR(30)
);


INSERT INTO locations (location_id, location_name, city, state, location_type) VALUES
(1, 'Bay Area Operations Center', 'San Jose', 'CA', 'Operations Center'),
(2, 'Austin Test Facility', 'Austin', 'TX', 'Test Site'),
(3, 'Phoenix Test Facility', 'Phoenix', 'AZ', 'Test Site'),
(4, 'Seattle Validation Site', 'Seattle', 'WA', 'Validation Site'),
(5, 'Denver Storage Hub', 'Denver', 'CO', 'Storage Hub');

INSERT INTO devices (device_id, device_serial, device_type, storage_tb, device_status, location_id) VALUES
(101, 'SN-A1001', 'Type A', 4, 'Active', 1),
(102, 'SN-A1002', 'Type A', 8, 'Active', 1),
(103, 'SN-B1001', 'Type B', 8, 'Repair', 2),
(104, 'SN-B1002', 'Type B', 16, 'Active', 2),
(105, 'SN-A1003', 'Type A', 4, 'Active', 3),
(106, 'SN-C1001', 'Type C', 16, 'Repair', 3),
(107, 'SN-C1002', 'Type C', 32, 'Active', 4),
(108, 'SN-B1003', 'Type B', 8, 'Active', 4),
(109, 'SN-A1004', 'Type A', 4, 'Active', 5),
(110, 'SN-C1003', 'Type C', 32, 'Inactive', 5),
(111, 'SN-B1004', 'Type B', 16, 'Active', 1),
(112, 'SN-A1005', 'Type A', 8, 'Repair', 2),
(113, 'SN-C1004', 'Type C', 32, 'Active', 3),
(114, 'SN-B1005', 'Type B', 16, 'Active', 4),
(115, 'SN-A1006', 'Type A', 8, 'Active', 5);

INSERT INTO shipments (shipment_id, device_id, origin_location_id, destination_location_id, ship_date, delivery_date, shipment_status) VALUES
(1001, 101, 1, 2, '2026-06-03', '2026-06-06', 'Delivered'),
(1002, 102, 1, 3, '2026-06-05', '2026-06-09', 'Delivered'),
(1003, 103, 2, 1, '2026-06-10', '2026-06-14', 'Delivered'),
(1004, 104, 2, 4, '2026-06-12', '2026-06-17', 'Delivered'),
(1005, 105, 3, 1, '2026-06-18', '2026-06-21', 'Delivered'),
(1006, 106, 3, 2, '2026-06-20', '2026-06-26', 'Delivered'),
(1007, 107, 4, 1, '2026-07-02', '2026-07-05', 'Delivered'),
(1008, 108, 4, 5, '2026-07-04', '2026-07-09', 'Delivered'),
(1009, 109, 5, 1, '2026-07-07', '2026-07-11', 'Delivered'),
(1010, 110, 5, 3, '2026-07-10', '2026-07-16', 'Delivered'),
(1011, 111, 1, 4, '2026-07-15', '2026-07-18', 'Delivered'),
(1012, 112, 2, 3, '2026-07-20', '2026-07-25', 'Delivered'),
(1013, 113, 3, 4, '2026-08-01', '2026-08-04', 'Delivered'),
(1014, 114, 4, 2, '2026-08-03', '2026-08-08', 'Delivered'),
(1015, 115, 5, 2, '2026-08-05', '2026-08-09', 'Delivered'),
(1016, 101, 1, 5, '2026-08-10', '2026-08-13', 'Delivered'),
(1017, 103, 2, 1, '2026-08-12', NULL, 'In Transit'),
(1018, 106, 3, 1, '2026-08-14', NULL, 'In Transit'),
(1019, 108, 4, 3, '2026-08-16', '2026-08-20', 'Delivered'),
(1020, 112, 2, 5, '2026-08-18', '2026-08-24', 'Delivered');

INSERT INTO repair_events (repair_id, device_id, location_id, failure_date, repair_date, repair_status, failure_type) VALUES
(2001, 103, 2, '2026-06-08', '2026-06-10', 'Repaired', 'Upload Error'),
(2002, 106, 3, '2026-06-15', '2026-06-20', 'Repaired', 'No Ping'),
(2003, 112, 2, '2026-06-22', NULL, 'Failed', 'Hardware Failure'),
(2004, 108, 4, '2026-07-03', '2026-07-05', 'Repaired', 'Storage Issue'),
(2005, 103, 2, '2026-07-10', '2026-07-13', 'Repaired', 'No Ping'),
(2006, 106, 3, '2026-07-12', NULL, 'Failed', 'Upload Error'),
(2007, 111, 1, '2026-07-18', '2026-07-19', 'Repaired', 'Storage Issue'),
(2008, 112, 2, '2026-07-20', '2026-07-25', 'Repaired', 'Hardware Failure'),
(2009, 105, 3, '2026-07-26', '2026-07-27', 'Repaired', 'Upload Error'),
(2010, 114, 4, '2026-08-02', '2026-08-06', 'Repaired', 'No Ping'),
(2011, 103, 2, '2026-08-05', NULL, 'Failed', 'Hardware Failure'),
(2012, 106, 3, '2026-08-07', '2026-08-12', 'Repaired', 'Upload Error'),
(2013, 112, 2, '2026-08-09', NULL, 'Failed', 'No Ping'),
(2014, 107, 4, '2026-08-11', '2026-08-13', 'Repaired', 'Storage Issue'),
(2015, 101, 1, '2026-08-15', '2026-08-16', 'Repaired', 'Upload Error');

INSERT INTO upload_events (upload_id, device_id, location_id, upload_date, data_tb, upload_status) VALUES
(3001, 101, 1, '2026-06-02', 4.50, 'Complete'),
(3002, 102, 1, '2026-06-04', 7.25, 'Complete'),
(3003, 103, 2, '2026-06-07', 6.80, 'Error'),
(3004, 103, 2, '2026-06-09', 6.80, 'Complete'),
(3005, 104, 2, '2026-06-11', 12.40, 'Complete'),
(3006, 105, 3, '2026-06-14', 3.90, 'Complete'),
(3007, 106, 3, '2026-06-15', 14.20, 'No Ping'),
(3008, 106, 3, '2026-06-20', 14.20, 'Complete'),
(3009, 107, 4, '2026-07-01', 25.50, 'Complete'),
(3010, 108, 4, '2026-07-03', 7.75, 'Error'),
(3011, 108, 4, '2026-07-05', 7.75, 'Complete'),
(3012, 109, 5, '2026-07-06', 3.60, 'Complete'),
(3013, 110, 5, '2026-07-09', 28.40, 'Complete'),
(3014, 103, 2, '2026-07-10', 7.10, 'No Ping'),
(3015, 103, 2, '2026-07-13', 7.10, 'Complete'),
(3016, 106, 3, '2026-07-12', 15.30, 'Error'),
(3017, 111, 1, '2026-07-17', 13.80, 'Complete'),
(3018, 112, 2, '2026-07-20', 6.90, 'Error'),
(3019, 112, 2, '2026-07-25', 6.90, 'Complete'),
(3020, 105, 3, '2026-07-26', 4.10, 'Error'),
(3021, 105, 3, '2026-07-27', 4.10, 'Complete'),
(3022, 113, 3, '2026-08-01', 27.60, 'Complete'),
(3023, 114, 4, '2026-08-02', 14.50, 'No Ping'),
(3024, 114, 4, '2026-08-06', 14.50, 'Complete'),
(3025, 103, 2, '2026-08-05', 7.40, 'Error'),
(3026, 106, 3, '2026-08-07', 16.20, 'Error'),
(3027, 106, 3, '2026-08-12', 16.20, 'Complete'),
(3028, 112, 2, '2026-08-09', 7.30, 'No Ping'),
(3029, 107, 4, '2026-08-11', 26.80, 'Complete'),
(3030, 101, 1, '2026-08-15', 5.20, 'Error'),
(3031, 101, 1, '2026-08-16', 5.20, 'Complete'),
(3032, 115, 5, '2026-08-18', 7.80, 'Complete');