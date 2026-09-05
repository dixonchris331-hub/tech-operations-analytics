# Tech Operations & Fulfillment Analytics

**Project Highlight:** I found that just 3 devices were responsible for 60% of all repair events, showing that most of the repair problems came from a small group of devices.

## Project Overview



This project uses SQL to analyze a synthetic tech operations dataset. The data includes devices, repair events, upload activity, shipments, and different facility locations.



The goal was to find patterns that could help an operations team understand where problems are happening. I looked at questions such as which devices fail the most, which locations have slower repairs, which failure types take the longest to fix, and where shipments take the longest to arrive.



All data used in this project is synthetic and was created for learning and portfolio purposes. It does not contain any private or company data.





\## Business Questions



The project focuses on questions such as:



\- How are devices distributed across locations?

\- What are the most common failure types?

\- Which locations have the most repair events?

\- Which locations take the longest to complete repairs?

\- Which failure types take the longest to repair?

\- Are certain devices responsible for a large number of repairs?

\- Do devices with repeated repairs also have upload failures?

\- Is repair activity increasing or decreasing over time?

\- Which locations have the longest shipment delivery times?

\- What shipment patterns do we see among devices with repeated repairs?





\## Tools Used



\- PostgreSQL

\- pgAdmin 4

\- SQL

\- GitHub





\## SQL Skills Used



\- INNER JOIN and LEFT JOIN

\- Multi table joins

\- COUNT and AVG

\- GROUP BY and HAVING

\- Common Table Expressions (CTEs)

\- Window functions using LAG()

\- Date calculations

\- Filtering data

\- Month over month analysis

\- Analyzing data across multiple related tables





\## Key Findings



\- \*\*A small number of devices caused most of the repair activity.\*\* Three devices accounted for 9 of the 15 repair events, which was 60% of all repairs.



\- \*\*The same devices had problems in multiple areas.\*\* The three devices with the most repairs also had the highest number of upload failures. This suggests that many of the problems were centered around a small group of devices.



\- \*\*Repair times were different between locations.\*\* Phoenix had the longest average repair time at about 3.67 days. Austin had the most repair events and the second longest average repair time at about 3.33 days.



\- \*\*Some failure types took much longer to repair.\*\* Hardware Failures took an average of 5 days to repair, while No Ping issues averaged 4 days. Upload Errors averaged 2.25 days and Storage Issues averaged about 1.67 days.



\- \*\*Repair activity increased during the three months analyzed.\*\* There were 3 repair events in June, 6 in July, and 6 in August.



\- \*\*Shipment times were also different between locations.\*\* Phoenix had the longest average inbound delivery time at about 4.75 days. Denver averaged 4.67 days and Austin averaged 4.50 days.





\## Recommendations



\- \*\*Look into the repeat problem devices first. Since three devices accounted for 60% of all repairs and also had the most upload failures, finding out why these devices keep having problems could help reduce a large amount of the repair activity.



\- \*\*Review Hardware Failure and No Ping issues. These problems took the longest to repair. Looking at how these issues are diagnosed and handled could help find ways to reduce repair time.



\- \*\*Take a closer look at Phoenix. Phoenix had both the longest average repair time and the longest average inbound shipment time. This does not prove that shipment time caused slower repairs, but it gives the operations team another area worth investigating.



\- \*\*Keep tracking repair activity. Repairs increased from June to July and stayed at the same level in August. More months of data would be needed to know if this is a long term trend.





\## Dataset Structure



The synthetic dataset contains five connected tables:



\- \*\*locations\*\* — Information about each facility and where it is located.

\- \*\*devices\*\* — Device information such as serial number, type, capacity, status, and location.

\- \*\*repair\_events\*\* — Information about device failures, repair dates, repair status, and failure types.

\- \*\*upload\_events\*\* — Information about device uploads, upload dates, data size, and upload status.

\- \*\*shipments\*\* — Information about devices being shipped between locations, including shipment and delivery dates.



The tables are connected using device IDs and location IDs. This makes it possible to analyze the same devices across repairs, uploads, shipments, and locations.





\## Project Limitations



\- The dataset is synthetic and was created for learning and portfolio purposes.

\- The data only covers three months, so it is too early to identify long-term trends.

\- The dataset is small and is meant to demonstrate SQL and data analysis skills rather than large scale data processing.

\- Patterns found in the data do not automatically prove that one problem caused another. More data would be needed to make those conclusions.

