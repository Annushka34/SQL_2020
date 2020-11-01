drop database BookShopPublisher
use BookShop

CREATE TABLE cust  
(  
 CustomerID uniqueidentifier NOT NULL  
   DEFAULT newid(),  
 Company varchar(30) NOT NULL,  
 ContactName varchar(60) NOT NULL,   
 Address varchar(30) NOT NULL,   
 City varchar(30) NOT NULL,  
 StateProvince varchar(10) NULL,  
 PostalCode varchar(10) NOT NULL,   
 CountryRegion varchar(20) NOT NULL,   
 Telephone varchar(15) NOT NULL,  
 Fax varchar(15) NULL  
);  



create database BookShopPublisher
Go
use BookShopPublisher
Go

CREATE TABLE Country(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CountryName varchar(20),
);


CREATE TABLE Publish
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
PublishName varchar(30) NOT NULL,
CountryId INT CONSTRAINT FK_Publish_Country Foreign KEY  References Country(Id)
);

CREATE TABLE Address
(
Id INT NOT NULL PRIMARY KEY IDENTITY,
Street varchar(20) NOT NULL default 'no street',
City varchar(20) NOT NULL,
CountryId INT CONSTRAINT FK_Address_Country Foreign KEY  References Country(Id)
);


CREATE TABLE Author
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
AuthorName varchar(30) NOT NULL,
AddressId INT CONSTRAINT Fk_Author_Address FOREIGN KEY REFERENCES Address(Id),
PublishId INT CONSTRAINT Fk_Author_Publish FOREIGN KEY REFERENCES Publish(Id)
);

CREATE TABLE Category
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
CategotyName varchar(50) NOT NULL
);

CREATE TABLE Book
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
BookName varchar(250) NOT NULL,
Description varchar(MAX) NULL,
NumberPages INT,
Price Money NOT NULL,
PublishDate Date DEFAULT GETDATE(),
AuthorId INT CONSTRAINT Fk_Book_Author FOREIGN KEY REFERENCES Author(Id),
CategoryId INT CONSTRAINT Fk_Book_Category FOREIGN KEY REFERENCES Category(Id)
);

CREATE TABLE UserProfile
(
Id INT PRIMARY KEY IDENTITY,
Email varchar(30) UNIQUE NOT NULL CHECK (Email LIKE '%@%'),
Password varchar(20) NOT NULL CHECK (LEN(Password)>6),
CONSTRAINT FK_UserProfile_Author FOREIGN KEY(Id) REFERENCES Author(Id)
);

CREATE TABLE Shop
(
Id INT PRIMARY KEY IDENTITY,
ShopName varchar(30) NOT NULL,
CountryId INT CONSTRAINT Fk_Shop_Country FOREIGN KEY REFERENCES Country(Id)
);

CREATE TABLE Incomes
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
ShopId INT NOT NULL,
BookId INT NOT NULL,
DateIncomes Date NOT NULL,
Amount INT NOT NULL,
CONSTRAINT Fk_Incomes_Shop Foreign Key (ShopId) REFERENCES Shop(Id),
CONSTRAINT Fk_Incomes_Book Foreign Key (BookId) REFERENCES Book(Id),
);

CREATE TABLE Sales
(
Id INT PRIMARY KEY NOT NULL IDENTITY,
ShopId INT NOT NULL,
BookId INT NOT NULL,
DateSale Date NOT NULL,
Amount INT NOT NULL,
SalePrice money NOT NULL,
CONSTRAINT Fk_Sales_Shop Foreign Key (ShopId) REFERENCES Shop(Id),
CONSTRAINT Fk_Sales_Book Foreign Key (BookId) REFERENCES Book(Id),
);
-----------INSERT VALUES--------------------------
Go
INSERT INTO Country Values
('China'),
('Poland'),
('Ukraine')
;
Go
INSERT INTO Address VALUES
('BigStreet','Vroclav',(SELECT Id FROM Country WHERE CountryName='Poland')),
('Bednarska','Varshava',(SELECT Id FROM Country WHERE CountryName='Poland')),
('Gdanska','Branevo',(SELECT Id FROM Country WHERE CountryName='Poland')),
('Миру','Рівне',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('Соборна','Рівне',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('Хрещатик','Київ',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('Cisy','Ninbo',(SELECT Id FROM Country WHERE CountryName='China'))

INSERT INTO Publish VALUES
('CoolPublisher',(SELECT Id FROM Country WHERE CountryName='Poland')),
('ZirkaBook',(SELECT Id FROM Country WHERE CountryName='Ukraine')),
('Ababagalamaga',(SELECT Id FROM Country WHERE CountryName='Ukraine'))

INSERT INTO Author VALUES
('Ivanov',(SELECT Id FROM Address WHERE Street='Миру'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('Petrov',(SELECT Id FROM Address WHERE Street='Миру'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('Верн Жюль',(SELECT Id FROM Address WHERE Street='Миру'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('Воронцов Николай',(SELECT Id FROM Address WHERE Street='Миру'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('Андерсен Ханс Кристиан',(SELECT Id FROM Address WHERE Street='Миру'),(SELECT Id FROM Publish WHERE PublishName='ZirkaBook')),
('Романова М.',(SELECT Id FROM Address WHERE Street='Bednarska'),(SELECT Id FROM Publish WHERE PublishName='CoolPublisher')),
('Скоттон Р',(SELECT Id FROM Address WHERE Street='Bednarska'),(SELECT Id FROM Publish WHERE PublishName='CoolPublisher')),
('Фани Марсо',(SELECT Id FROM Address WHERE Street='Gdanska'),(SELECT Id FROM Publish WHERE PublishName='CoolPublisher'))

INSERT INTO UserProfile VALUES
('ivanov@mail.ru','qwertyy')

INSERT INTO Category VALUES
('Історичні'),
('Наукові'),
('Дитячі'),
('Дорослі'),
('Художні'),
('Фантастика'),
('Поезія')



INSERT INTO Book  VALUES
('Roksolana',NULL,100,250.5,'12.10.2005',1,1),
('Volodimyr',NULL,NULL,400.5,'10.05.2016',1,2),
('Yaroslav',NULL,200,250.5,'2.06.2017',3,5),
('Ігри у які грають люди','Something',150,25.2,'12.12.2016',3,2),
('Психологічний помічник','Психологія101',110,25.5,'10.10.2015',6,2),
('Снежная королева','Сказка',110,25.5,'10.10.2016',5,3),
('Белий мишка','Сказка',110,25.5,'10.10.2017',1,2),
('Милашки-очаровашки','Миниатюрная книжка «Белый мишка» серии «Милашки-очаровашки» создана специально для самых маленьких читателей. ',110,25.5,'10.10.2015',2,3),
('Шмяк и пингвины','Котенок Шмяк и его друзья живут весело. ',110,25.5,'10.10.2014',3,4),
('Рассел ищет клад','Что вас ждет под обложкой: Однажды ворона принесла Расселу изрядно потрепанную карту сокровищ Лягушачьей низины. ',110,25.5,'10.10.2015',4,2),
('Котенок Шмяк. Давай играть!','Наконец-то к котёнку Шмяку в гости пришли друзья, и можно вместе поиграть.',120,30.5,'10.10.2017',5,5)


INSERT INTO Shop VALUES
('PolandShop',2),
('Slovo',3)

INSERT INTO Incomes VALUES
(1,11,'12.10.2017',20),
(2,14,GetDate(),20),
(1,12,GetDate(),10),
(2,13,GetDate(),5),
(2,12,GetDate(),7),
(2,14,GetDate(),15),
(2,15,GetDate(),30)

INSERT INTO Sales VALUES
(1,11,'12.10.2017',5,60),
(2,11,GetDate(),5,70.5),
(1,12,GetDate(),3,80.3),
(2,13,GetDate(),2,100),
(2,12,GetDate(),7,70.8),
(2,14,GetDate(),10,250)
---------------------SELECT------------
SELECT*FROM Address
SELECT*FROM Publish
SELECT*FROM Author
SELECT*FROM Publish
SELECT*FROM Book
SELECT*FROM Shop
SELECT*FROM Sales
SELECT*FROM Incomes

SELECT BookName as book, Price FROM Book
SELECT BookName+'('+Description+')', Price FROM Book
SELECT BookName+'-'+Description as [Book], Price FROM Book

SELECT BookName+'-'+Description as [Book], Price FROM Book
ORDER BY BookName

SELECT BookName+'-'+Description as [Book], Price FROM Book
ORDER BY Price

SELECT BookName+'-'+Description as [Book], Price FROM Book
ORDER BY Price,Book ---сортування в спад порядку//ASC-зрост

SELECT BookName+'-'+Description as [Book], Price FROM Book
ORDER BY Price

SELECT TOP 1 BookName, Price FROM Book ORDER BY Price DESC

SELECT BookName, Price FROM Book
ORDER BY Price OFFSET 2 ROWS

SELECT BookName, Price FROM Book
ORDER BY Price OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY

---------------WHERE----------------

SELECT BookName, Price FROM Book
WHERE Price>100

SELECT BookName, Price FROM Book
WHERE BookName='Roksolana'

SELECT BookName, Price FROM Book
WHERE BookName<>'Roksolana'

SELECT BookName, Price FROM Book
WHERE BookName<>'Roksolana' AND Price>50

SELECT BookName, Price FROM Book
WHERE BookName='Roksolana' OR Price<100

SELECT BookName, Price FROM Book
WHERE NOT BookName='Roksolana'

SELECT BookName From Book
Where AuthorId IS NULL

SELECT BookId, DateIncomes FROM Incomes
WHERE DateIncomes BETWEEN '10.10.2017' AND GETDATE()

SELECT BookId, DateIncomes FROM Incomes
WHERE DateIncomes > GETDATE()

SELECT BookId, DateIncomes FROM Incomes
WHERE DateIncomes > DATEADD("D",-30,GETDATE())

SELECT BookId, DateIncomes FROM Incomes
WHERE (DATEDIFF("D",DateIncomes,GETDATE())<10)

SELECT BookName, Price FROM Book
WHERE Price NOT BETWEEN 100 AND 500

SELECT BookName, Price FROM Book
WHERE Price IN(99,18,34)

SELECT BookName, Price FROM Book
WHERE BookName LIKE '%ія'

SELECT BookName, Price FROM Book
WHERE BookName LIKE 'М%'

SELECT BookName, Price FROM Book
WHERE BookName BETWEEN 'А%' AND 'П%'

UPDATE Book
SET BookName= 'Volodimyr'
WHERE BookName='Володимир'


----------------SELECT FROM MORE THEN ONE TABLE
SELECT Author.AuthorName as author,
       Publish.PublishName as publish
	   FROM Author, Publish
	   WHERE Author.PublishId=Publish.Id

SELECT Book.BookName, Author.AuthorName, Book.Description, Book.Price FROM Book, Author
WHERE Book.AuthorId=Author.Id
ORDER BY AuthorName DESC
OFFSET 3 ROWS
FETCH NEXT 3 ROWS ONLY

SELECT Author.AuthorName as author, UserProfile.Email as email
FROM Author, UserProfile
WHERE Author.Id=UserProfile.Id

SELECT * FROM UserProfile

SELECT*FROM Address
SELECT*FROM Publish
SELECT*FROM Author
SELECT Author.AuthorName, Address.City FROM Author, Address WHERE Author.AddressID=Address.Id
SELECT*FROM Publish
SELECT*FROM Book
SELECT*FROM Shop
SELECT*FROM Incomes

----------AGRAGATE--------------

-----------MIN------------------
SELECT MIN(Price) AS SmallestPrice
FROM Book;

SELECT MAX(Price) AS SmallestPrice
FROM Book;

SELECT MIN(DateIncomes) AS SmallestDate
FROM Incomes;


-----------COUNT---------------------кількість записів
SELECT COUNT(Amount) as Book_amount
FROM Incomes;

SELECT COUNT(NumberPages) as pages
FROM Book;

-----------СЕРЕДНЄ------------
SELECT AVG(Amount) as Book_amount
FROM Incomes;

-----------СУМА------------
SELECT SUM(Amount) as Book_amount
FROM Incomes;

-------------GROUP BY -------------------
SELECT*FROM Book

SELECT PublishDate, count(*)
from Book
GROUP BY PublishDate

SELECT CategoryId,PublishDate, count(BookName) as BookNumbers, sum(Price)
from Book
WHERE Price<100
GROUP BY CategoryId, PublishDate

-------------------HAVING------------
SELECT CategoryId,PublishDate, count(BookName) as BookNumbers, sum(Price)
from Book
WHERE Price<100
GROUP BY CategoryId, PublishDate
HAVING count(BookName) >1

SELECT DISTINCT Book.BookName,Shop.ShopName, sum(Amount) as BookNumbersIncomes
from Incomes,Book, Shop
WHERE Amount*Book.Price>100 AND Book.Id=Incomes.BookId AND Shop.Id=Incomes.ShopId
GROUP BY Book.BookName, Shop.ShopName
HAVING sum(Amount)>1

SELECT DISTINCT Book.BookName, Shop.ShopName as Shop, sum(Amount) as BookNumbers, Amount*Book.Price as Value
from Incomes,Book,Shop
WHERE Amount*Book.Price>100 AND Book.Id=Incomes.BookId AND Shop.Id=Incomes.ShopId
GROUP BY Shop.ShopName,Book.BookName, Amount*Book.Price
HAVING sum(Amount)>1

select*from Incomes
select*from Book

SELECT sum(Amount) as BookNumbersIncomes, Book.BookName,Shop.ShopName
from Incomes,Book, Shop
WHERE Book.Id=Incomes.BookId AND Shop.Id=Incomes.ShopId
GROUP BY Book.BookName, Shop.ShopName

SELECT Book.BookName, MIN(Book.Price) as [Минимальная цена] 
FROM   Book, Sales 
WHERE Sales.BookId=Book.Id
GROUP BY Book.BookName
ORDER BY MIN(Book.Price)

SELECT Book.BookName, Book.Price as ЦінаПоставки, (Sales.SalePrice) as МінЦінаПродажі 
FROM   Book, Sales 
WHERE Sales.BookId=Book.Id
ORDER BY (Sales.SalePrice)

SELECT Book.BookName, Book.Price as ЦінаПоставки,MIN(Sales.SalePrice) as МінЦінаПродажі 
FROM   Book, Sales 
WHERE Sales.BookId=Book.Id
GROUP BY Book.BookName, Book.Price
ORDER BY MIN(Sales.SalePrice)

--Вывести категории, книжки, которые к ним относятся и общую сумму их продажи. 
--Условие: книжки только категорий «Історичні» и «Наукові».

SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY Category.CategotyName, Book.BookName
HAVING Category.CategotyName IN('Історичні','Наукові')

------------ROLLUP------------------
SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY Category.CategotyName, Book.BookName WITH ROLLUP

SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY ROLLUP(Category.CategotyName, Book.BookName)

SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY ROLLUP(Category.CategotyName, Book.BookName)
ORDER BY SUM(Sales.Amount*Sales.SalePrice)

SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY Book.BookName, ROLLUP(Category.CategotyName)

----------CUBE----------------------
SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY Category.CategotyName, Book.BookName WITH CUBE

--------GROUPNG SETS-----------------
SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY GROUPING SETS (Category.CategotyName, Book.BookName)

SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY GROUPING SETS (ROLLUP(Category.CategotyName), Book.BookName)

SELECT Category.CategotyName, Book.BookName, SUM(Sales.Amount*Sales.SalePrice) as [Сума продаж]
FROM Category, Book, Sales
WHERE Category.Id=Book.CategoryId AND Sales.BookId=Book.Id
GROUP BY GROUPING SETS ((Category.CategotyName,Book.BookName), Book.BookName)

SELECT Publish.PublishName, Author.AuthorName, SUM(Sales.Amount) as [Кількість проданих книжок]
FROM Publish, Author, Sales,Book
WHERE Publish.Id=Author.PublishId AND Sales.BookId=Book.Id AND Book.AuthorId=Author.Id
GROUP BY GROUPING SETS ((Publish.PublishName, Author.AuthorName),ROLLUP(Publish.PublishName))

SELECT Publish.PublishName, Author.AuthorName, SUM(Sales.Amount) as [Кількість проданих книжок]
FROM Publish, Author, Sales,Book
WHERE Publish.Id=Author.PublishId AND Sales.BookId=Book.Id AND Book.AuthorId=Author.Id
GROUP BY GROUPING SETS ((Publish.PublishName, Author.AuthorName),Publish.PublishName,ROLLUP(Author.AuthorName))

--------------------------ISNULL-------------------
SELECT 
	ISNULL(Publish.PublishName,'Сум по автору')  AS Видавництво,
    ISNULL(Author.AuthorName,'Сум по видавництву') as Автор,
    SUM(Sales.Amount) as [Кількість проданих книжок]
FROM Publish, Author, Sales,Book
WHERE Publish.Id=Author.PublishId AND Sales.BookId=Book.Id AND Book.AuthorId=Author.Id
GROUP BY GROUPING SETS ((Publish.PublishName, Author.AuthorName),Publish.PublishName,ROLLUP(Author.AuthorName))

SELECT 
	ISNULL(Publish.PublishName,'Сум по автору')  AS Видавництво,
    ISNULL(Author.AuthorName,'Сум по видавництву') as Автор,
    SUM(Sales.Amount) as [Кількість проданих книжок]
FROM Publish, Author, Sales,Book
WHERE Publish.Id=Author.PublishId AND Sales.BookId=Book.Id AND Book.AuthorId=Author.Id
GROUP BY ROLLUP(Author.AuthorName, Publish.PublishName)
