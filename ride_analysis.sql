use ola_rides;
select* from ola_rides_db;

# 1.Retrieve All Successful Bookings
SELECT * FROM ola_rides_db WHERE `Booking Status` = 'Success';

# 2.Find the Average Ride Distance for Each Vehicle Type
Create View ride_distance_for_each_vehicle as SELECT `Vehicle Type`, AVG(`Ride Distance`) AS Avg_Ride_Distance FROM ola_rides_db GROUP BY `Vehicle Type`;
select * from ride_distance_for_each_vehicle;

# Get All Booking Cancelled by Drivers
Select * from ola_rides_db where `Booking Status` = 'Cancelled by Driver';

# 3.Get the total number of cancelled rides by customers
Select COUNT(*) from ola_rides_db where `Booking Status` = 'Cancelled by Customer';

# 4.List the top 5 customers who booked the highest number of rides
Create View high_number_of_rides as SELECT `Customer ID`, COUNT(`Booking ID`) as total_rides FROM ola_rides_db GROUP BY `Customer ID` ORDER BY total_rides DESC LIMIT 5;
select * from high_number_of_rides;

# 5.Get the number of rides cancelled by drivers due to personal and car-related issues
SELECT COUNT(*) FROM ola_rides_db WHERE `Cancelled Rides by Driver` = 'Personal & Car related issue';

# 6.Find the maximum and minimum driver ratings for Prime Sedan bookings
SELECT count(*),MAX(`Driver Ratings`) as max_rating, MIN(`Driver Ratings`) as min_rating FROM ola_rides_db WHERE `Vehicle Type` = 'Prime Sedan';

# 7.Find the average customer rating per vehicle type
SELECT `Vehicle Type`, AVG(`Customer Rating`) as avg_customer_rating FROM ola_rides_db GROUP BY `Vehicle Type`;

# 8.Calculate the total booking value of rides completed successfully
SELECT SUM(`Booking Value`) as total_successful_value FROM ola_rides_db WHERE `Booking Status` = 'Success';

# 9.List all incomplete rides along with the reason
SELECT `Booking ID`, `Incomplete Rides Reason` FROM ola_rides_db WHERE `Incomplete Rides` = '0';

# 10.Find the Total Revenue Per Customer
SELECT `Customer ID`, SUM(`Booking Value`) AS Total_Revenue FROM ola_rides_db GROUP BY `Customer ID` ORDER BY Total_Revenue DESC;

# 11.Count Rides Per Day
SELECT Day, COUNT(*) AS Total_Rides FROM ola_rides_db GROUP BY Day ORDER BY Day ASC;

# 12.Identify Peak Hours for Bookings
SELECT HOUR AS Booking_Hour, COUNT(*) AS Total_Bookings FROM ola_rides_db GROUP BY Booking_Hour ORDER BY Total_Bookings DESC;

# 13.Find the Vehicle Type with the Most Cancellations
SELECT `Vehicle Type`, COUNT(*) AS Total_Cancellations FROM ola_rides_db WHERE `Booking Status` IN ('Cancelled by Driver', 'Cancelled by Customer') GROUP BY `Vehicle Type` ORDER BY Total_Cancellations DESC;

