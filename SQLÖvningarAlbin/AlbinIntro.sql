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
--	[F�rnamn] nvarchar(max) not null,
--	[Efternamn] nvarchar(max) not null,
--	[�lder] int,
--	[Hemort] nvarchar(max) not null
--);

--9
--INSERT INTO Students
--VALUES
--	(1, 'Albin', 'Hedberg Abarahamsson', 30, 'G�teborg'),
--	(2, 'Kevin', 'Sahl�n', 0, 'G�teborg'),
--	(3, 'Maria', 'Edstrom', 0, 'H'),
--	(4, 'Sebastian', 'Moya Sch�ndorff', 0, 'F'),
--	(5, 'Lotta', 'Harmonen', 0, '');

--SELECT * FROM Students;
