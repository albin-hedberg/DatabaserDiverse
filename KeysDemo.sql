----**************************************************************************************************
----Create new database
----**************************************************************************************************
USE master
DROP DATABASE KeysDemoDb
GO

CREATE DATABASE KeysDemoDb
GO

USE KeysDemoDb
GO
----**************************************************************************************************
----Create Table Countries:
----**************************************************************************************************
CREATE TABLE Countries (
    Id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100),
    [Population] INT
);

GO
----**************************************************************************************************
----Create Table Cities:
----**************************************************************************************************
CREATE TABLE Cities (
    Id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    CountryId INT FOREIGN KEY REFERENCES Countries(Id),
    [Name] NVARCHAR(100),
    [Population] INT
);

GO
----**************************************************************************************************
---- Populating Countries
----**************************************************************************************************
INSERT INTO Countries ([Name], [Population])
VALUES
('Sweden', 10430000),
('Denmark', 5857000),
('Finland', 5542000),
('Norway', 5480000),
('Iceland', 372295);

GO
----**************************************************************************************************
---- Populating Cities
----**************************************************************************************************
INSERT INTO Cities (CountryId, [Name], [Population])
VALUES
(1, 'Gothenburg', 625000),
(1, 'Stockholm', 1679000),
(1, 'Malmoe', 351749),
(2, 'Kopenhagen', 1370000),
(2, 'Odense', 204795),
(3, 'Helsinki', 1328000),
(3, 'Espoo', 300000),
(4, 'Oslo', 1071062),
(4, 'Bergen', 287888),
(5, 'Reykjavik', 131136);

GO
----**************************************************************************************************
---- Create View to display cities with their linked countries and populations
----**************************************************************************************************
CREATE VIEW vCitiesInCountries
AS
SELECT
    Cities.[Name]           AS [CityName],
    Cities.[Population]     AS [CityPopulation],
    Countries.[Name]        AS [CountryName],
    Countries.[Population]  AS [CountryPopulation]
FROM Cities
JOIN Countries ON CountryId = Countries.Id;

GO
----**************************************************************************************************
---- Alter View to also display how big part of the country population a city has
----**************************************************************************************************
-- ALTER VIEW vCitiesInCountries
-- AS
-- SELECT
--     Cities.[Name]           AS [CityName],
--     Cities.[Population]     AS [CityPopulation],
--     Countries.[Name]        AS [CountryName],
--     Countries.[Population]  AS [CountryPopulation],
--     FORMAT(CONVERT(FLOAT, Cities.[Population]) / CONVERT(FLOAT, Countries.[Population]), 'p') AS [PartOfTotal]
-- FROM Cities
-- JOIN Countries ON CountryId = Countries.Id;

ALTER VIEW vCitiesInCountries
AS
SELECT
    Cities.[Name]           AS [CityName],
    Cities.[Population]     AS [CityPopulation],
    Countries.[Name]        AS [CountryName],
    Countries.[Population]  AS [CountryPopulation],
    CONVERT(FLOAT, Cities.[Population]) / Countries.[Population] AS [PartOfTotal],
    FORMAT(CONVERT(FLOAT, Cities.[Population]) / CONVERT(FLOAT, Countries.[Population]), 'p') AS [PartOfTotal(%)]
FROM Cities
JOIN Countries ON CountryId = Countries.Id;

GO
----**************************************************************************************************
---- Create three tables, one for students, one for courses and one to link them both that has a
---- composite primary key.
----**************************************************************************************************
CREATE TABLE Students (
    Id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [FirstName] NVARCHAR(100),
    [LastName] NVARCHAR(100)
);

GO

CREATE TABLE Courses (
    Id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100),
    [Points] INT
);

GO

CREATE TABLE StudentPlans (
    [StudentId] INT NOT NULL,
    [CourseId] INT NOT NULL,
    CONSTRAINT PK_StudentPlan PRIMARY KEY ([StudentId], [CourseId]),
    CONSTRAINT FK_StudentId_Students FOREIGN KEY ([StudentId]) REFERENCES Students(Id),
    CONSTRAINT FK_CourseId_Courses FOREIGN KEY ([CourseId]) REFERENCES Courses(Id)
);

GO

----**************************************************************************************************
---- Populate Students, Courses and StudentPlans
----**************************************************************************************************
INSERT INTO Students ([FirstName], [LastName])
VALUES
('Peter', 'Parker'),
('John', 'Logan'),
('Hank', 'McCoy'),
('Francis', 'Castle'),
('Matt', 'Murdoc'),
('Bruce', 'Banner'),
('Anthony', 'Stark'),
('Johnny', 'Storm');

GO

INSERT INTO Courses ([Name], [Points])
VALUES
('Heroism', 100),
('Flying', 50),
('Survivalism', 40),
('Engineering', 60),
('Chemestry', 50),
('Acrobatics', 100),
('Wrestling', 50),
('Marksmanship', 100);

GO

INSERT INTO StudentPlans ([StudentId], [CourseId])
VALUES
(1, 1),
(1, 4),
(1, 5),
(1, 6),
(2, 3),
(2, 6),
(2, 7),
(3, 1),
(3, 3),
(3, 4),
(3, 5),
(3, 7),
(4, 3),
(4, 7),
(4, 8),
(5, 1),
(5, 6),
(5, 7),
(6, 4),
(6, 5),
(7, 1),
(7, 2),
(7, 4),
(7, 5),
(7, 8),
(8, 1),
(8, 2),
(8, 6);

GO
----**************************************************************************************************
---- Create View to display students linked with their total course points
----**************************************************************************************************
CREATE VIEW vStudentInfo
AS
SELECT
    TOP 3 Students.FirstName,
    SUM(Courses.Points) AS TotalPoints
FROM Courses
JOIN StudentPlans ON Courses.Id = StudentPlans.CourseId
JOIN Students ON Students.Id = StudentPlans.StudentId
GROUP BY Students.FirstName
ORDER BY TotalPoints DESC;

GO


--
----
------
--------
----------
------------
--------------
----------------
------------------
--------------------
----**************************************************************************************************
---- SELECT: Countries & Cities
----**************************************************************************************************
SELECT *
FROM Countries;

SELECT
    Cities.Name,
    Countries.Name
FROM Cities
JOIN Countries ON Cities.CountryId = Countries.Id;

SELECT * FROM vCitiesInCountries;

SELECT
    Countries.Name,
    COUNT(Cities.Id) AS NumberOfCities
FROM Cities
    JOIN Countries ON Cities.CountryId = Countries.Id
GROUP BY Countries.Name
ORDER BY NumberOfCities DESC;

SELECT
    Countries.Name,
    COUNT(Cities.Id) AS NumberOfCities
FROM Cities
    JOIN Countries ON Cities.CountryId = Countries.Id
GROUP BY Countries.Name
ORDER BY NumberOfCities DESC;

----**************************************************************************************************
---- SELECT: Students & Courses
----**************************************************************************************************
SELECT * FROM Students;

SELECT * FROM Courses;

SELECT * FROM StudentPlans;

SELECT *
FROM Students
CROSS JOIN Courses;

SELECT * FROM vStudentInfo;

SELECT
    Students.FirstName,
    Courses.Name
FROM Courses
    JOIN StudentPlans ON Courses.Id = StudentPlans.CourseId
    JOIN Students ON Students.Id = StudentPlans.StudentId
WHERE Students.FirstName LIKE 'Francis';

SELECT TOP 3
    TotalPoints,
    FirstName
FROM vStudentInfo
ORDER BY TotalPoints DESC;

SELECT Courses.Name
FROM Students
    JOIN StudentPlans ON Students.Id = StudentPlans.StudentId
    JOIN Courses ON Courses.Id = StudentPlans.CourseId
WHERE Students.FirstName LIKE 'Johnny' AND Students.LastName LIKE 'Storm';
----**************************************************************************************************
---- END
----**************************************************************************************************
--------------------
------------------
----------------
--------------
------------
----------
--------
------
----
--
