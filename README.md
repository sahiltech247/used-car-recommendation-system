live application: https://used-car-recommendation-system-sk.streamlit.app

# Used Car Recommendation System

An end-to-end data analytics project focused on cleaning, transforming, analyzing, and recommending used cars based on customer preferences.

The project processes a used car dataset containing **10,143 vehicle records** and demonstrates an analytics workflow from raw data preparation to an interactive recommendation application.

---

# Project Overview

The project covers:

* Data cleaning and transformation
* ETL pipeline development
* Feature engineering
* SQL-based business analysis
* Recommendation scoring system
* Separated Model, Brand, Segement cloumn into 3 dimension tables
* Streamlit application development

The objective is to identify market trends and provide suitable used car recommendations based on budget, fuel type, transmission, and vehicle segment.

---

# Tools & Their Role

## Python

### Role:

Used for data processing, automation, and recommendation logic.

### What was done:

* Loaded and explored raw vehicle data
* Cleaned inconsistent values
* Handled missing data
* Standardized categorical columns
* Converted price formats into numerical values
* Created new analytical features
* Built recommendation scoring logic

Libraries used:

* Pandas
* NumPy

---

## Excel / Power Query

### Role:

Initial data exploration and cleaning support.

### What was done:

* Inspected raw dataset structure
* Identified missing values and inconsistencies
* Studied column quality
* Analysed issues before building the Python ETL pipeline

---

## SQL

### Role:

Used for structured data analysis and extracting business insights.

### What was done:

* Queried cleaned vehicle data
* Analysed brands, segments, fuel types, and pricing trends
* Used aggregations, joins, filtering, and ranking queries
* Extracted insights from the final analytical tables

---

## Streamlit

### Role:

Used to build an interactive recommendation application.

### What was done:

* Created user input filters
* Added budget selection
* Added fuel type filtering
* Added transmission filtering
* Added vehicle segment filtering
* Displayed ranked recommendations

---

## Jupyter Notebook

### Role:

Used for experimentation and analysis.

### What was done:

* Performed ETL development
* Tested cleaning steps
* Validated feature engineering
* Developed recommendation scoring approach

---

# ETL Pipeline

## Data Cleaning

The raw dataset contained multiple data quality issues:

* Missing vehicle specifications
* Inconsistent categorical values
* Mixed price formats
* Duplicate vehicle naming patterns
* Incorrect numerical formats

Cleaning steps included:

* Standardizing fuel and transmission categories
* Handling missing values
* Extracting brand and model information
* Converting price fields into numerical format
* Removing inconsistencies

---

# Feature Engineering

Created additional features to improve analysis and recommendations:

## Vehicle Age

Calculated vehicle age based on registration/manufacturing details.

## Price Advantage

Measures how much cheaper a used vehicle is compared to its new vehicle price.

## Depreciation Percentage

Helps understand vehicle value reduction over time.

## Value For Money Score

A combined score considering:

* Vehicle price
* Age
* Kilometres driven
* Depreciation

## Recommendation Score

Final ranking metric combining multiple vehicle factors to recommend better options.

---

# Recommendation System

The recommendation system ranks vehicles according to user preferences.

Users can select:

* Budget range
* Fuel type
* Transmission
* Vehicle segment

The system filters suitable vehicles and returns the highest Recommendation Score cars.

---

# SQL Analysis Insights

## Brand Insights

* Maruti, Hyundai, and other mass-market brands had higher availability in the used car market.
* Popular brands generally offered more affordable options due to larger market presence.

---

## Segment Insights

* SUVs and Hatchbacks represented a significant portion of available used vehicles.
* Hatchbacks provided more budget-friendly options.
* SUVs showed higher average prices due to larger vehicle size and features.

---

## Fuel Type Insights

* Petrol vehicles had strong availability in the used market.
* Diesel vehicles were more common in larger segments such as SUVs and MUVs.
* Fuel preference significantly affected vehicle pricing.

---

## Pricing Insights

* Used vehicle prices varied significantly across segments and brands.
* Some vehicles showed strong price advantage compared to their new vehicle prices.
* Premium vehicles experienced larger depreciation compared to mass-market vehicles.

---

## Vehicle Condition Insights

* Lower kilometres driven vehicles generally received higher recommendation scores.
* Vehicle age and depreciation had a strong impact on final ranking.

---

# Application Output

The Streamlit application provides:

* Top recommended vehicles
* Vehicle details
* Recommendation ranking
* User-based filtering

---

# Technologies Used

* Python– Data cleaning, ETL, feature engineering, and recommendation logic
* Pandas & NumPy – Data manipulation and numerical calculations
* Excel / Power Query – Initial data exploration and data quality checks
* SQL – Data analysis and business insights extraction
* Jupyter Notebook – ETL development and experimentation
* Streamlit – Interactive recommendation application
* VS Code – Development environment
* Git & GitHub – Version control and project sharing

# Future Improvements

* Add vehicle price prediction model
* Improve recommendation algorithm using machine learning
* Add interactive visual dashboards
* Include more user preferences

---
## Dataset Disclaimer

The dataset used in this project is included for educational and analytical purposes. 
Dataset ownership and licensing belong to the original data provider.
source kaggle
name: Indian Second-Hand Cars Dataset

# Author

Sahil Khaire
