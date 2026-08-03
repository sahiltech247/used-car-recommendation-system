Create database Used_Car_DWH;
USE Used_Car_DWH;

CREATE TABLE Fact_Used_Cars (
Brand_ID INT,
Model_ID INT,
Segment_ID INT,
Vehicle_Name TEXT,
Year_of_Manufacture INT,
Vehicle_Age INT,
Insurance TEXT,
Fuel_Type TEXT,
Seats_Capacity INT,
Kms_Driven INT,
RTO_Location TEXT,
Ownership TEXT,
Engine_Displacement DOUBLE,
Transmission TEXT,
Power_BHP DOUBLE,
Drive_Type TEXT,
Mileage_By_Fuel_Type DOUBLE,
New_Vehicle_Price_Lakh DOUBLE,
Vehicle_Price_Lakh DOUBLE,
Depreciation_Percentage DOUBLE,
Other_Features TEXT,
Value_For_Money_Score DOUBLE
);

LOAD DATA LOCAL INFILE 'C:/Users/sahil/OneDrive/Desktop/DATA ANALYTICS HANDBOOKS/Indian_Used_Car_Analytics/used cars csv/Fact_Used_Cars_Final.csv'
INTO TABLE Fact_Used_Cars
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
Brand_ID,
Model_ID,
Segment_ID,
Vehicle_Name,
Year_of_Manufacture,
Vehicle_Age,
Insurance,
Fuel_Type,
Seats_Capacity,
Kms_Driven,
RTO_Location,
Ownership,
Engine_Displacement,
Transmission,
Power_BHP,
Drive_Type,
Mileage_By_Fuel_Type,
New_Vehicle_Price_Lakh,
Vehicle_Price_Lakh,
Depreciation_Percentage,
Other_Features,
Value_For_Money_Score
);


ALTER TABLE Dim_Brand
ADD PRIMARY KEY (Brand_ID);

ALTER TABLE Dim_Model
ADD PRIMARY KEY (Model_ID);

ALTER TABLE Dim_Segment
ADD PRIMARY KEY (Segment_ID);

ALTER TABLE Fact_Used_Cars
ADD CONSTRAINT fk_brand
FOREIGN KEY (Brand_ID)
REFERENCES Dim_Brand(Brand_ID);

ALTER TABLE Fact_Used_Cars
ADD CONSTRAINT fk_model
FOREIGN KEY (Model_ID)
REFERENCES Dim_Model(Model_ID);

ALTER TABLE Fact_Used_Cars
ADD CONSTRAINT fk_segment
FOREIGN KEY (Segment_ID)
REFERENCES Dim_Segment(Segment_ID);

-- ============================================
-- Insight 1: Top 5 Most Listed Car Brands
-- ============================================
select Car_Brand, count(*) as Total_Listings from dim_brand db
inner join Fact_Used_Cars fc
on db.Brand_ID = fc.Brand_ID
group by db.Brand_ID, db.car_Brand
order by Total_Listings desc
limit 5;

-- ============================================
-- Insight 2: Top 3 Most Popular Vehicle Segments
-- ============================================
select Segment, count(*) as total_listings from dim_segment ds
inner join Fact_Used_Cars fc
on fc.Segment_ID = ds.segment_ID
group by ds.Segment_ID, ds.Segment
order by total_listings desc
limit 3;

-- ============================================
-- Insight 3: Distribution of Used Cars by Fuel Type
-- ============================================
select Fuel_Type, count(*) as total_listings from Fact_Used_Cars
group by Fuel_Type
order by total_listings desc
limit 5;

-- ============================================
-- Insight 4: Average Resale Price by Vehicle Segment
-- ============================================
select Segment, round(avg(Vehicle_Price_Lakh),2) as avg_segment_price from Fact_Used_Cars fc
inner join dim_segment ds
on ds.Segment_ID = fc.Segment_ID
group by ds.Segment_ID, ds.segment
order by avg_segment_price desc;

-- ============================================
-- Insight 5: Top 5 Premium Brands by Average Resale Price
-- (Minimum 50 Listings)
-- ============================================
select Car_brand, count(*) as total_listings, round(avg(Vehicle_Price_Lakh),2) as avg_brand_price from Fact_Used_Cars fc
inner join dim_brand db
on db.Brand_ID = fc.Brand_ID
group by db.Brand_ID, db.Car_Brand
having count(*) > 50
order by avg_brand_price desc
limit 5;

-- ============================================
-- Insight 6: Brands with the Lowest Average Depreciation
-- (Minimum 50 Listings)
-- ============================================
select Car_Brand, count(*) as total_listings, round(avg(Depreciation_Percentage),2) as avg_depreciated from Fact_Used_Cars fc
inner join dim_brand db
on db.Brand_ID = fc.Brand_ID
group by db.Brand_ID, Car_Brand
having count(*)>50
order by avg_depreciated 
limit 5;

-- ============================================
-- Insight 7: Best Value-for-Money Car Brands
-- (Minimum 50 Listings)
-- ============================================
select Car_Brand, count(*) as total_listings, round(avg(Value_For_Money_Score),2) as avg_value_score from Fact_Used_Cars fc
inner join dim_brand db
on db.Brand_ID = fc.Brand_ID
group by db.Brand_ID, db.Car_Brand
having count(*)>50
order by avg_value_score desc
limit 5;

-- ============================================
-- Insight 8: Top Value-for-Money Used Car Models
-- ============================================
select Car_Brand, Car_Model, Vehicle_Price_Lakh, Value_For_Money_Score, Kms_Driven, Vehicle_Age, Depreciation_Percentage  
from Fact_Used_Cars fc
inner join dim_model dm
on dm.Model_ID = fc.Model_ID
inner join dim_brand db
on db.Brand_ID = fc.Brand_ID
where Vehicle_Price_Lakh <= 10
order by Value_For_Money_Score desc, Kms_Driven, Vehicle_Age, Depreciation_Percentage
limit 10;

-- ============================================
-- Insight 9: Average Resale Price by Transmission Type
-- ============================================
select Transmission, count(*) as total_listings, round(avg(Vehicle_Price_Lakh),2) as avg_val_by_transmission  from Fact_Used_Cars
group by Transmission
order by avg_val_by_transmission;

-- ============================================
-- Insight 10: Average Resale Price by Ownership Category
-- ============================================
select Ownership, count(*) as total_listings, round(avg(Vehicle_Price_Lakh),2) as avg_vehicle_price from Fact_Used_Cars
where Ownership != 'Unknown'
group by Ownership
order by avg_vehicle_price desc;

-- ============================================
-- Insight 11: Brands with the Highest Average Engine Power (BHP)
-- (Valid BHP Values Only, Minimum 100 Listings)
-- ============================================
select Car_Brand, count(*) as total_listings, round(avg(Power_BHP),2) as avg_power_bhp from Fact_Used_cars fc
inner join dim_brand db
on db.Brand_ID = fc.Brand_ID
where Power_BHP > 0
group by fc.brand_ID, db.Car_Brand
having count(*) > 100
order by avg_power_bhp desc
limit 5 ;

-- ============================================
-- Insight 12: Average Resale Price by Fuel Type
-- ============================================
select Fuel_Type, count(*) as total_listings, round(avg(Vehicle_Price_Lakh),2) as avg_vehicle_price from Fact_Used_Cars
group by Fuel_Type
order by avg_vehicle_price desc;


-- ============================================
-- Insight 13: Impact of Vehicle Age on Average Resale Price
-- ============================================
select
case
when Vehicle_Age >= 0 and Vehicle_Age <= 5 then '0-5'
when Vehicle_Age >= 6 and Vehicle_Age <= 10 then '6-10'
when Vehicle_Age >= 11 and Vehicle_Age <= 15 then '11-15'
else '16+'
end as age_group,  count(*) as total_listings, round(avg(Vehicle_Price_Lakh),2) as avg_vehicle_price
from Fact_Used_Cars
group by age_group
order by avg_vehicle_price desc;


select * from Fact_Used_Cars;
select * from dim_model;
select * from dim_segment;
select * from dim_brand;




