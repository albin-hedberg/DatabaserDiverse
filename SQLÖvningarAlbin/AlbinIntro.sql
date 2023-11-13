--CREATE DATABASE DbDemo;

--1
--CREATE DATABASE DjurDB;

--USE DjurDB;

--2
--CREATE TABLE DjurTbl(
--	Id int PRIMARY KEY,
--	Namn nvarchar(max) not null
--);

--3
--INSERT INTO DjurTbl(Id, Namn)
--VALUES (1, 'Hamster'), (2, 'Hund'), (3, 'Katt'), (4, 'Kanin');

--4
--SELECT * FROM DjurTbl;

--5
--SELECT * FROM DjurTbl WHERE Namn LIKE '%a%';

--6
--DROP TABLE DjurTbl;
--USE DbDemo;
--USE master;
--DROP DATABASE DjurDB;

--7
--CREATE DATABASE KlassenDb;

USE KlassenDb;

--8
--CREATE TABLE Students(
--	[Id] int PRIMARY KEY,
--	[Förnamn] nvarchar(max) not null,
--	[Efternamn] nvarchar(max) not null,
--	[Ålder] int,
--	[Hemort] nvarchar(max) not null
--);

--9
--INSERT INTO Students
--VALUES
--	(1, 'Kevin', 'Sahlén', 33, 'Göteborg'),
--	(2, 'Maria', 'Edstrom', 28, 'Stockholm'),
--	(3, 'Sebastian', 'Moya Schöndorff', 37, 'Göteborg'),
--	(4, 'Lotta', 'Harmonen', 28, 'Mikkeli'),
--	(5, 'Albin', 'Hedberg Abarahamsson', 30, 'Mölndal');

SELECT * FROM Students;
