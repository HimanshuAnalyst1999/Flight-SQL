-- Q1> Find the busiest airport by the number of flight takes off.
select top 1 name as airport_name, count(name) as total_flights from flights F
inner join airports a
ON a.airportid = f.origin
group by name
order by total_flights desc;


-- Q2> Find the total number of tickets sold per airlines.
select al.name, count(name) as total_tickets from tickets t
inner join flights f
ON t.flightid = f.flightid
inner join airlines al
ON f.airlineid = al.airlineid
group by al.name
order by total_tickets desc;


-- Q3> List all the flights operated by 'INDIGO' with airport names (origin and destination).
select f.flightid, a.name as origin_airport, a2.name as destination_airport 
from flights F
inner join airlines al ON f.airlineid = al.airlineid
inner join airports a on f.origin  = a.airportid
inner join airports a2 on f.destination  = a2.airportid
where al.name = 'indigo';



-- Q4> for each airport, show the top airline by number of flights departing from there.
with cte as (
select f.origin, f.airlineid, count(*) as flight_count from Flights F
group by f.origin, f.airlineid),
ranked_airline as (
	select  * , row_number() over (partition by origin order by flight_count desc) as rn
	from cte)
select a.name as airport_name, al.name as airlinename, r.flight_count from ranked_airline r
inner join airports a 
on r.origin = a.airportid
inner join airlines al
on r.airlineid = al.airlineid
where rn = 1



-- Q5> FOR EACH FLIGHT, SHOW TIME TAKEN IN HOURS AND CATEGORIZE IT AS SHORT (< 2H), MEDIUM (2-5 HR) OR LONG (> 5H).
SELECT *, DATEDIFF(MINUTE, DEPARTURETIME, ARRIVALTIME) / 60.0 AS DURATION_HOURS,
	CASE
		WHEN DATEDIFF(MINUTE, DEPARTURETIME, ARRIVALTIME) <  120 THEN 'SHORT_FLIGHT'
		WHEN DATEDIFF(MINUTE, DEPARTURETIME, ARRIVALTIME) <= 300 THEN 'MEDIUM'
		ELSE 'long'
	END AS FLIGHTCATEGORY
FROM FLIGHTS;




 --Q6. SHOW EACH PASSENGER'S FIRST AND LAST FLIGHT DATES AND NUMBER OF FLIGHTS
 WITH CTE AS (
 SELECT PASSENGERID, MIN(F.DEPARTURETIME) AS FIRSTFLIGHT, MAX(F.DEPARTURETIME) AS LASTFLIGHT, COUNT(*) AS TOTAL_FLIGHTS  FROM TICKETS AS T
 INNER JOIN FLIGHTS F
 on T.FLIGHTID = F.FLIGHTID
 GROUP BY PASSENGERID)
 SELECT P.NAME, CT.FIRSTFLIGHT, CT.LASTFLIGHT, CT.TOTAL_FLIGHTS
 FROM CTE AS CT
 INNER JOIN PASSENGERS P
 on P.PASSENGERID = CT.PASSENGERID;



-- Q7> FIND FLIGHTS WITH THE HIGHEST PRICE TICKET SOLD FOR EACH ROUTE (ORIGIN-----> DESTINATION).
WITH CTE AS (
SELECT F.FLIGHTID, F.ORIGIN, F.DESTINATION, T.TICKETID, T.PRICE
	,DENSE_RANK() OVER (PARTITION BY F.ORIGIN, F.DESTINATION ORDER BY PRICE DESC) AS RN 
	FROM TICKETS T
INNER JOIN FLIGHTS F
ON T.FLIGHTID = F.FLIGHTID)
SELECT A1.NAME AS ORIGIN_AIRPORT, A2.NAME AS DESTINATION_AIRPORT, CT.PRICE, CT.TICKETID
FROM CTE AS CT
INNER JOIN AIRPORTS A1
ON CT.ORIGIN = A1.AIRPORTID
INNER JOIN AIRPORTS A2
ON CT.DESTINATION = A2.AIRPORTID
WHERE RN = 1;




-- Q8> FIND THE HIGHEST SPENDING PASSENGER IN EACH FREQUENT FLYER STATUS GROUP.
WITH CTE AS (
SELECT P.PASSENGERID, P.NAME, P.FREQUENTFLYERSTATUS, SUM(T.PRICE) AS TOTAL_SPEND  FROM PASSENGERS P
INNER JOIN TICKETS T
ON T.PASSENGERID = P.PASSENGERID
GROUP BY P.PASSENGERID, P.NAME, P.FREQUENTFLYERSTATUS),
RANKED AS (
	SELECT *, RANK() OVER (PARTITION BY FREQUENTFLYERSTATUS ORDER BY TOTAL_SPEND DESC) AS RN FROM CTE)
SELECT * FROM RANKED
WHERE RN = 1;







