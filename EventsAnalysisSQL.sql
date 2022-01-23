-- Which companies attend the most events?
SELECT CompanyName, COUNT(*) As 'Number of Attendees'
FROM Attendees
GROUP BY CompanyName
ORDER BY COUNT(*) DESC;

-- How many people attended each event?

SELECT EventName, COUNT(*) As 'Number of Attendees'
FROM Events e
JOIN Attendence a
	ON e.EventId = a.EventId
GROUP BY EventName
ORDER BY 2 DESC;

-- Which company type attended the most events?
WITH CTE_Company (CompanyType, Count)
AS 
(
SELECT CompanyType, 
Count(*) AS Count
FROM Attendence
WHERE CompanyType IS NOT NULL
Group by CompanyType
ORDER BY 2 DESC

)
SELECT CompanyType, Count, Count * 100 / (SELECT SUM(Count) from CTE_Company) as 'Percentage of total (%)'
FROM CTE_Company

-- Which countries are the attendees from?
SELECT Country, Count(*) as 'Count'
FROM Attendence
WHERE Country IS NOT NULL
GROUP BY Country
ORDER BY 2 DESC;


-- What is the mean amount per Event?
SELECT EventName, AVG(CAST(Amount as NUMERIC)) as 'Mean Amount'
FROM Events e
JOIN Attendence a
	ON e.EventId = a.EventId
GROUP BY EventName
ORDER BY 2 DESC;

-- What is the total amount per Event?
SELECT EventName, SUM(CAST(Amount as NUMERIC)) as 'Total Amount', SalesTarget as 'Sale Target'
FROM Events e
JOIN Attendence a
	ON e.EventId = a.EventId
GROUP BY EventName
ORDER BY 2;

-- Which company types make up the attendees?
WITH tbl AS (
            SELECT CompanyType, 
                       Count(*) AS Count
                FROM Attendence
                WHERE CompanyType IS NOT NULL 
                Group by CompanyType
)
SELECT CompanyType,Count FROM tbl WHERE Count>50
UNION ALL
SELECT 'Other' as CompanyType,sum(Count) as Count  
FROM tbl WHERE Count<=50
ORDER BY Count DESC;

WITH tbl2 AS (
						SELECT Country, COUNT(*) AS Count
						FROM Attendence
						WHERE Country IS NOT NULL
						GROUP BY Country
)
SELECT Country, Count FROM tbl2 WHERE Count > 20
UNION ALL 
SELECT 'Other' as Country,sum(Count) as Count
FROM tbl2 WHERE Count<=20
ORDER BY Count DESC;

-- Which attendee record type attended the most events?
SELECT AttendeeRecordType, COUNT(*) as Count
FROM Attendence
GROUP BY 1
ORDER BY 2 DESC


-- What was the average price per Attendee record type?
SELECT AttendeeRecordType, AVG(CAST(Amount as int)) as 'Average'
FROM Attendence
GROUP BY 1
ORDER BY 2 DESC

-- What was the count of lead type?
SELECT LeadType, COUNT(*) as Count
FROM Attendence
WHERE LeadType IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC

-- What was the average price per lead type?
SELECT LeadType, AVG(CAST(Amount as int)) as 'Average'
FROM Attendence
GROUP BY 1
ORDER BY 2 DESC
