use BookShopPublisher

select b.*, a.AuthorName
FROM Author as a, Book as b
where a.Id=b.AuthorId

----------SELECT-------------
SELECT b.*, (SELECT AuthorName FROM Author Where b.AuthorId=Author.Id)
FROM  Book as b

SELECT*,(SELECT Category.CategotyName FROM Category WHERE Id=Book.CategoryId) as Category
FROM Book

SELECT  BookName, Price, 
        (SELECT Category.CategotyName FROM Category 
        WHERE Category.Id = Book.CategoryId) AS Category
FROM Book

-----------SELECT WHERE---------

SELECT BookName, CategotyName
FROM Book, Category
WHERE Category.CategotyName='ƒит€ч≥' AND Book.CategoryId=Category.Id

SELECT BookName, CategotyName
FROM Book, Category
WHERE Book.CategoryId=Category.Id AND
Book.CategoryId=(SELECT Id FROM Category WHERE CategotyName='ƒит€ч≥')

SELECT Author.AuthorName, CountryName
FROM Author, Country, Address
WHERE Country.Id=(SELECT Id FROM Country WHERE CountryName='Ukraine' or CountryName='Pland')
AND Author.AddressId=Address.Id AND Address.CountryId=Country.Id


------------------------IN--------------------------------
SELECT Author.AuthorName, CountryName
FROM Author, Country, Address
WHERE Country.Id IN (SELECT Id FROM Country WHERE CountryName='Ukraine' or CountryName='Poland')
AND Author.AddressId=Address.Id AND Address.CountryId=Country.Id

SELECT Author.AuthorName, CountryName
FROM Author, Country, Address
WHERE Country.Id NOT IN(SELECT Id FROM Country WHERE CountryName='Ukraine' or CountryName='Poland')
AND Author.AddressId=Address.Id AND Address.CountryId=Country.Id

SELECT Book.BookName, Price*Sales.Amount
From Book, Sales
WHERE Book.Id=Sales.BookId

SELECT AVG(Price*Sales.Amount)
From Book, Sales
WHERE Book.Id=Sales.BookId

SELECT Book.BookName, Price*Sales.Amount
From Book, Sales
WHERE Price*Amount<
(SELECT AVG(Price*Amount) FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId



SELECT Book.BookName, SUM(Price*Sales.Amount)
From Book, Sales
WHERE Price*Amount<>
(SELECT MIN(Price*Amount) FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId
GROUP BY Book.BookName

SELECT Book.BookName, SUM(Price*Sales.Amount)
From Book, Sales
WHERE Price*Amount<
(SELECT AVG(Price*Amount) FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId
GROUP BY Book.BookName

----------------------ANY----ALL-----
SELECT Book.BookName, SUM(Price*Sales.Amount)
From Book, Sales
WHERE Price*Amount<
(SELECT MAX(Price*Amount) FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId
GROUP BY Book.BookName

SELECT Book.BookName, SUM(Price*Sales.Amount)
From Book, Sales
WHERE Price*Amount< ANY
(SELECT Price*Amount FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId
GROUP BY Book.BookName

SELECT Book.BookName, SUM(Price*Sales.Amount)
From Book, Sales
WHERE Price*Amount>
(SELECT MIN(Price*Amount) FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId
GROUP BY Book.BookName

SELECT Book.BookName, Price
From Book
WHERE Price>ALL
(SELECT Price FROM Sales)


SELECT Book.BookName, SUM(Price*Sales.Amount)
From Book, Sales
WHERE Price*Amount>
(SELECT MIN(Price*Amount) FROM Book, Sales WHERE Book.Id=Sales.BookId)
AND Book.Id=Sales.BookId
GROUP BY Book.BookName

---обер≥ть вс≥ книжки к≥льк≥сть поставки €ких б≥льше н≥ж поставка
---будь-€коњ книжки автора ≤ванова

SELECT Book.BookName, Incomes.Amount, Author.AuthorName
FROM Book, Incomes, Author
WHERE Incomes.Amount>ANY
(SELECT Amount FROM Incomes, Book, Author WHERE Author.Id=Book.AuthorId AND Incomes.BookId=Book.Id
AND Author.Id=
(SELECT Id FROM Author WHERE AuthorName='Ivanov')

)
AND
Book.Id=Incomes.BookId AND Book.AuthorId=Author.Id