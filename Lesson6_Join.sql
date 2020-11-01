use BookShopPublisher

--UNION
--Всі книжки ціна яких більше 100 грн або категорія =1
SELECT Book.BookName, Price, CategoryId FROM Book WHERE Price>100
UNION
SELECT Book.BookName, Price, CategoryId FROM Book WHERE CategoryId=1;

--Всі книжки ціна яких більше 100 грн або категорія ='Дитячі'

SELECT BookName, Price, Category.CategotyName 
FROM Book, Category 
WHERE Book.CategoryId=Category.Id AND Price>100  
UNION
SELECT BookName, Price, Category.CategotyName 
FROM Book, Category 
WHERE Book.CategoryId=Category.Id AND CategotyName='Дитячі';

SELECT Book.BookName, Price, Format(DateSale,'yyyy') as Дата
FROM Sales, Book
WHERE Book.Id=Sales.BookId
UNION
SELECT Book.BookName, Price, Format(DateIncomes,'yyyy')
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId

SELECT 'Sale' as Type, Book.BookName, Price, Format(DateSale,'yyyy') as Дата
FROM Sales, Book
WHERE Book.Id=Sales.BookId
UNION
SELECT 'Income', Book.BookName, Price, Format(DateIncomes,'yyyy')
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId

---EXCEPT//різниця

SELECT  Book.BookName
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId
EXCEPT
SELECT  Book.BookName
FROM Sales, Book
WHERE Book.Id=Sales.BookId

---INTERSECT//які є там і там

SELECT  Book.BookName
FROM Sales, Book
WHERE Book.Id=Sales.BookId
INTERSECT
SELECT  Book.BookName
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId


---INNER JOIN
SELECT * FROM Book, Category
WHERE Book.CategoryId=Category.Id

SELECT * FROM Book
INNER JOIN Category ON Book.CategoryId=Category.Id

SELECT Book.BookName, CategotyName, Sales.DateSale FROM ((Book
INNER JOIN Category ON Book.CategoryId=Category.Id)
INNER JOIN Sales ON Sales.BookId=Book.Id)


SELECT Book.BookName, CategotyName, Sales.DateSale FROM Sales
INNER JOIN (Category 
INNER JOIN Book ON Category.Id=Book.CategoryId)ON Book.Id=Sales.BookId

--LEFT OUTER JOIN
--всі книжки що є в базі і категорії і дати продаж якщо вони продавались
SELECT Book.BookName, CategotyName, Sales.DateSale FROM ((Book
INNER JOIN Category ON Book.CategoryId=Category.Id)
LEFT OUTER JOIN Sales ON Sales.BookId=Book.Id)

--всі  категорії, і якщо є то книжки які їм відповідають

SELECT Book.BookName, CategotyName FROM (Book
RIGHT OUTER JOIN Category ON Book.CategoryId=Category.Id)

--всі книжки що є в базі і всі категорії і всі дати продаж
SELECT Book.BookName, CategotyName, Sales.DateSale FROM ((Book
FULL OUTER JOIN Category ON Book.CategoryId=Category.Id)
FULL OUTER JOIN Sales ON Sales.BookId=Book.Id)

--самообєднання
-- информациію про магазини однієї країни

select sh1.ShopName as 'Shop Name' 
from Shop sh1 INNER JOIN Shop sh2 on sh1.id = sh2.id 
INNER JOIN Country c on sh2.CountryId = c.id where c.CountryName = 'Ukraine'; 

select CountryName, Shop.ShopName From Shop INNER JOIN Country ON Country.Id=Shop.CountryId
WHERE CountryName='Ukraine';

---інформація про книжки з одного автора
SELECT DISTINCT b1.BookName as Name1, b2.BookName as Name2, Author.AuthorName
FROM Book as b1, Book as b2, Author
WHERE b1.AuthorId=b2.AuthorId AND b1.AuthorId=Author.Id AND b1.Id<>b2.Id
AND AuthorName='Ivanov'

---cross join
select b.BookName, t.CategotyName from Book b CROSS JOIN Category t;


----task 3
--- Вывести всех авторов, которые существуют в базе данных с указанием (при наличии) их книг, 
--- которые издаются издательством. 

SELECT Author.AuthorName, Book.BookName
FROM Author LEFT OUTER JOIN Book
ON Author.Id=Book.AuthorId

--- 5. Доказать, что книги тематики, например, "Історичні" выпускаются 
--- самым большим тиражом. Примечание! Доказательством будет NULL значений, иначе – книги 
--- наиболее реализуемых тематик. 

SELECT TOP 1 Category.CategotyName, SUM(Sales.Amount)
FROM Category INNER JOIN (Sales  INNER JOIN Book ON
Book.Id=Sales.BookId) ON Category.Id=Book.CategoryId
WHERE Sales.Amount=(SELECT MAX(Sales.Amount) FROM Sales)
GROUP BY Category.CategotyName
HAVING CategotyName='Історичні'
UNION
SELECT TOP 1 Category.CategotyName, SUM(Sales.Amount)
FROM Category INNER JOIN (Sales  INNER JOIN Book ON
Book.Id=Sales.BookId) ON Category.Id=Book.CategoryId
WHERE Sales.Amount=(SELECT MAX(Sales.Amount) FROM Sales)
GROUP BY Category.CategotyName

--- 8. Вывести имена всех авторов, книг которых не издавало еще издательство, то есть 
--- которые не присутствуют в таблице Books. (Написать два варианта запроса: один с использованием 
--- подзапросов, второй с использованием операторов объединения запросов). 

SELECT Author.AuthorName, Book.Id
FROM Author LEFT OUTER JOIN Book ON Book.AuthorId=Author.Id
WHERE Book.Id IS NULL

SELECT Book.Id, Author.AuthorName
FROM Book RIGHT OUTER JOIN Author ON Author.Id=Book.AuthorId
WHERE Book.Id=NULL






