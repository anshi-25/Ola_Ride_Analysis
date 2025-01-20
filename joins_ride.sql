Describe ola_rides_db; 

CREATE TABLE rides_table (
    `Booking ID` VARCHAR(40) PRIMARY KEY,
    `Booking Status` TEXT,
    `Vehicle Type` TEXT,
    `Pickup Location` TEXT,
    `Drop Location` TEXT,
    `Booking Value` DOUBLE,
    `Ride Distance` DOUBLE,
    `Month` INT,
    `Day` INT,
    `Day of Week` INT,
    `Hour` INT,
    `Driver ID` INT,
    `Customer ID` INT
);

select * from rides_table;

CREATE TABLE customers (
    `Customer ID` INT PRIMARY KEY,
    `Cancelled Rides by Customer` INT,
    `Reason for Cancelling by Customer` TEXT,
    `Customer Rating` DOUBLE
);

select * from customers;

CREATE TABLE drivers (
    `Driver ID` INT PRIMARY KEY,
    `Cancelled Rides by Driver` INT,
    `Reason for Cancelling by Driver` TEXT,
    `Driver Ratings` DOUBLE
);

select * from drivers;

CREATE TABLE ride_details (
    `Booking ID` VARCHAR(40),
    `Avg VTAT` DOUBLE,
    `Avg CTAT` DOUBLE,
    `Incomplete Rides` INT,
    `Incomplete Rides Reason` TEXT,
    FOREIGN KEY (`Booking ID`) REFERENCES rides_table(`Booking ID`)
);

select * from ride_details;

# 1. List Top 5 Customers Based on Completed Rides and Their Average Ratings
SELECT rt.`Customer ID`, COUNT(rt.`Booking ID`) AS Completed_Rides, AVG(c.`Customer Rating`) AS Avg_Rating
FROM rides_table rt JOIN customers c ON rt.`Customer ID` = c.`Customer ID` WHERE rt.`Booking Status` = 'Success' GROUP BY rt.`Customer ID` ORDER BY Completed_Rides DESC LIMIT 5;

# 2. Find Customers Who Have Not Cancelled Rides Along with Their Ratings
SELECT c.`Customer ID`,c.`Cancelled Rides by Customer`,c.`Customer Rating` FROM customers c WHERE c.`Cancelled Rides by Customer` > 0;

# 3. Identify Locations with the Most Rides and Their Total Revenue
SELECT rt.`Pickup Location`,COUNT(rt.`Booking ID`) AS Total_Rides,SUM(rt.`Booking Value`) AS Total_Revenue FROM rides_table rt GROUP BY rt.`Pickup Location` ORDER BY Total_Rides DESC;

# 4. Analyze Performance of Customers in Specific Locations
SELECT rt.`Pickup Location`,rt.`Customer ID`,AVG(c.`Customer Rating`) AS Avg_Rating,COUNT(rt.`Booking ID`) AS Total_Rides FROM rides_table rt JOIN customers c ON rt.`Customer ID` = c.`Customer ID`
GROUP BY rt.`Pickup Location`, rt.`Customer ID` ORDER BY Total_Rides DESC;

# 5. Find the Top 3 Vehicle Types with the Highest Average Booking Value
SELECT rt.`Vehicle Type`,AVG(rt.`Booking Value`) AS Avg_Booking_Value FROM rides_table rt
GROUP BY rt.`Vehicle Type` ORDER BY Avg_Booking_Value DESC LIMIT 3;

# 6. Find Customers Involved in the Most Incomplete Rides
SELECT rt.`Customer ID`,COUNT(rt.`Booking ID`) AS Incomplete_Rides FROM rides_table rt JOIN ride_details rd ON rt.`Booking ID` = rd.`Booking ID`WHERE rt.`Booking Status` = 'Incomplete' GROUP BY rt.`Customer ID` ORDER BY Incomplete_Rides DESC;

# 7. Compare Average Ratings Given by Customers Per Vehicle Type
SELECT rt.`Vehicle Type`,AVG(c.`Customer Rating`) AS Avg_Customer_Rating FROM rides_table rt JOIN customers c ON rt.`Customer ID` = c.`Customer ID` GROUP BY rt.`Vehicle Type`;

# 8. Find the Top 3 Reasons for Cancellations by Customers
SELECT c.`Reason for Cancelling by Customer`,COUNT(c.`Reason for Cancelling by Customer`) AS Count FROM customers c GROUP BY c.`Reason for Cancelling by Customer` ORDER BY Count DESC LIMIT 3;

# 9. Retrieve Revenue and Customer Ratings for Each Vehicle Type in Peak Hours
SELECT rt.`Vehicle Type`,SUM(rt.`Booking Value`) AS Total_Revenue,AVG(c.`Customer Rating`) AS Avg_Customer_Rating FROM rides_table rt JOIN customers c ON rt.`Customer ID` = c.`Customer ID` WHERE rt.`Hour` BETWEEN 17 AND 20  GROUP BY rt.`Vehicle Type`;

