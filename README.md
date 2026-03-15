# Flight Data Analysis (SQL Project)

## Project Overview
This project analyzes airline flight operations and passenger ticket data using SQL.  
The goal is to extract meaningful insights from flight, airline, airport, passenger, and ticket datasets.

The analysis focuses on identifying busiest airports, airline performance, passenger activity, ticket pricing insights, and flight duration categorization.

---

## Tools & Technologies
- SQL Server
- T-SQL
- Window Functions
- Common Table Expressions (CTE)

---

## Database Tables
The dataset consists of the following tables:

- Flights
- Airlines
- Airports
- Passengers
- Tickets

These tables were joined to analyze flight routes, ticket sales, passenger activity, and airline performance.

---

## Business Questions Solved

### 1. Busiest Airport
Identified the airport with the highest number of departing flights.

### 2. Tickets Sold per Airline
Calculated total ticket sales for each airline.

### 3. Flights Operated by INDIGO
Listed all flights operated by INDIGO with origin and destination airport names.

### 4. Top Airline by Airport
For each airport, identified the airline with the highest number of departing flights.

### 5. Flight Duration Classification
Calculated flight duration and categorized flights as:
- Short (<2 hours)
- Medium (2–5 hours)
- Long (>5 hours)

### 6. Passenger Flight Activity
For each passenger:
- First flight date
- Last flight date
- Total number of flights

### 7. Highest Ticket Price per Route
Identified the highest priced ticket sold for each route (origin → destination).

### 8. Highest Spending Passenger per Status
Determined the highest spending passenger within each frequent flyer status group.

---

## SQL Concepts Used
- Joins (Inner Join)
- Aggregations (COUNT, SUM)
- Window Functions (ROW_NUMBER, DENSE_RANK, RANK)
- Common Table Expressions (CTE)
- CASE Statements
- Date and Time Functions (DATEDIFF)
- Group By and Order By

---

## Key Insights
- Identified the busiest airport based on flight departures.
- Compared ticket sales performance across airlines.
- Analyzed passenger travel frequency and spending patterns.
- Determined the most expensive routes and ticket pricing trends.
- Classified flights based on duration to understand travel patterns.

---

## Files Included
- `Flight_SQL_Project.sql` – SQL queries used for analysis
- `dataset_files` – Sample data tables
- `README.md` – Project documentation
