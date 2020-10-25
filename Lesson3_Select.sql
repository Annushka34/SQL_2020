--create database Academy
--use Academy

--create table Curators(
--Id int identity not null primary key,
--Name nvarchar(max) not null,
--Surname nvarchar(max) not null
--);
--create table Faculties( -- факультет
--Id int identity not null primary key,
--Financing money not null check(Financing>0) default 0,
--Name nvarchar(100) not null check(len(name)>0) unique,
--);
--create table Departments( -- кафедри
--Id int identity not null primary key,
--Financing money not null check(Financing>0) default 0,
--Name nvarchar(100) not null check (len(Name)>0) Unique,
--FacultyId int not null FOREIGN KEY (FacultyId)  REFERENCES Faculties (Id)
--);
--create table Groups(
--Id int identity not null primary key,
--Name nvarchar(10) not null check(len(Name)>0) unique,
--[Year] int not null check(Year >0 and Year <=5),
--DepartmentId int not null Foreign key(DepartmentId) references Departments (Id)
--);
--create table GroupsCurators(
--Id int identity not null primary key,
--CuratorId int  not null foreign key(CuratorId) references Curators(Id),
--GroupId int not null foreign key(GroupId) references Groups (ID)
--);
--create table Subjects(
--Id int identity not null primary key,
--Name nvarchar(100) not null unique check(len(Name)>0),
--);
--create table Teachers(
--Id int identity not null primary key,
--Name nvarchar(max) not null check(len(Name)>0),
--Salary money not null check(Salary>=0) default 0,
--Surname nvarchar(max) not null Check(len(Surname)>0)
--);
--create table Lectures(
--Id int not null identity primary key,
--LectureRoom nvarchar(max) not null check (len(LectureRoom)>0),
--SubjectId int not null foreign key(SubjectId) references Subjects (ID),
--TeacherId int not null foreign key(TeacherId) references Teachers (ID),
--);
--create table GroupsLectures(
--Id int identity  not null primary key,
--GroupId int not null foreign key(GroupId) references Groups (Id),
--LectureId int not null foreign key(LectureId) references Lectures (Id)
--);


--INSERT Curators( Name, Surname ) VALUES ( 'Ivan', 'Ivanov');
--INSERT Curators( Name, Surname ) VALUES ( 'Pavel', 'Pavlov');
--INSERT Faculties( Name, Financing ) VALUES ( 'Economica', 10000);
--INSERT Faculties( Name, Financing ) VALUES ( 'Pravo', 15000);
--INSERT Departments( Name, Financing,FacultyId ) VALUES ( 'Gumanitarny', 200000,1);
--INSERT Departments( Name, Financing,FacultyId ) VALUES ( 'Technic', 150000,2);
--INSERT Faculties( Name, Financing ) VALUES ( 'PK-sistem', 25000);
--INSERT Groups( Name, Year,DepartmentId ) VALUES ( 'P123', 2,1);
--INSERT Groups( Name, Year,DepartmentId ) VALUES ( 'E333', 3,1);
--INSERT Groups( Name, Year,DepartmentId ) VALUES ( 'PK7', 4,2);
--INSERT GroupsCurators( CuratorId, GroupId ) VALUES ( 1,2);
--INSERT Subjects( Name ) VALUES ( 'Mikro ekonomika');
--INSERT Subjects( Name ) VALUES ( 'Makro ekonomika');
--INSERT Subjects( Name ) VALUES ( 'Mat-analiz');
--INSERT Subjects( Name ) VALUES ( 'Ocnovu Prava');
--INSERT Subjects( Name ) VALUES ( 'C++');
--INSERT Subjects( Name ) VALUES ( 'C#');
--INSERT Teachers( Name,Surname,Salary ) VALUES ( 'Galina','Petrova',5000);
--INSERT Teachers( Name,Surname,Salary ) VALUES ( 'Ahmet','Ahmrtom',6000);
--INSERT Teachers( Name,Surname,Salary ) VALUES ( 'Tom','Kruz',7000);
--INSERT Lectures( LectureRoom,SubjectId,TeacherId ) VALUES ( 'E1',1,1);
--INSERT Lectures( LectureRoom,SubjectId,TeacherId ) VALUES ( 'E1',2,1);
--INSERT Lectures( LectureRoom,SubjectId,TeacherId ) VALUES ( 'E1',3,1);
--INSERT Lectures( LectureRoom,SubjectId,TeacherId ) VALUES ( 'P1',4,3);
--INSERT Lectures( LectureRoom,SubjectId,TeacherId ) VALUES ( 'K1',5,2);
--INSERT Lectures( LectureRoom,SubjectId,TeacherId ) VALUES ( 'K2',6,2);
--INSERT GroupsLectures(GroupId,LectureId ) VALUES ( 2,1);
--INSERT GroupsLectures(GroupId,LectureId ) VALUES ( 2,2);
--INSERT GroupsLectures(GroupId,LectureId ) VALUES ( 2,3);
--INSERT GroupsLectures(GroupId,LectureId ) VALUES ( 1,4);
--INSERT GroupsLectures(GroupId,LectureId ) VALUES ( 3,5);
--INSERT GroupsLectures(GroupId,LectureId ) VALUES ( 3,6);
--INSERT GroupsCurators( CuratorId, GroupId ) VALUES ( 2,1);
--INSERT GroupsCurators( CuratorId, GroupId ) VALUES ( 2,3);
--DELETE FROM Teachers WHERE ID = 4;
--DELETE FROM Teachers WHERE ID = 5;
--DELETE FROM Teachers WHERE ID = 6;
--DELETE FROM Lectures WHERE ID = 7;


---   SELECT

select * from Departments

select Name + convert(nvarchar(MAX), Financing) as [name finan] from Departments

select Name,  Financing from Departments



select TOP(1)  Name,  Financing from Departments


select * from Subjects order by Name desc --asc

-- WHERE

select Id from Subjects where Name = 'C++'

select * from Subjects where Name LIKE 'C%'



select * from Subjects where Name LIKE '[A-M]%' AND Id > 3

--  = <>  IS NULL, IS NOT NULL, >, <

--  '2019-08-22'
--  

select * from Lectures where TeacherId IN (1,2,3)

select * from Lectures where TeacherId IN (SELECT Id from Teachers Where Surname = 'Petrova')


