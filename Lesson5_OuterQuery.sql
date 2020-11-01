use BookShopPublisher

---alias
select b.*,a.AuthorName
from Book as b, Author as a
Where b.AuthorId=2 AND b.AuthorId=a.Id

----підзапит в where---------
select * from Book
Where Book.AuthorId=2

SELECT*FROM Book
WHERE Book.AuthorId=
(SELECT Id FROM Author
WHERE Author.AuthorName='Petrov'
)

SELECT Book.BookName, Category.CategotyName
FROM Book, Category
WHERE Book.CategoryId=
(SELECT Id FROM Category
WHERE Category.CategotyName='Дитячі'
)
AND Book.CategoryId=Category.Id

SELECT Book.BookName, Category.CategotyName
FROM Book, Category
WHERE Book.CategoryId=
(SELECT Id FROM Category
WHERE Category.CategotyName='Дитячі' OR Category.CategotyName='Худжні'
)
AND Book.CategoryId=Category.Id


SELECT Book.BookName
FROM Book
WHERE 
(SELECT Id FROM Category
WHERE Category.CategotyName='Дитячі' OR Category.CategotyName='Накові'
)=CategoryId;

--правильно лише при умові що існує лише одна категорія

---------------------IN---------------
SELECT Book.BookName, Category.CategotyName
FROM Book, Category
WHERE Book.CategoryId in
(SELECT Id FROM Category
WHERE Category.CategotyName='Дитячі' OR Category.CategotyName='Наукові'
)
AND Book.CategoryId=Category.Id

-- Вывести список книг, которые имеют цену выше средней дата видавництва после 01/06/2011
select Book.BookName, Book.PublishDate, Book.Price
FROM Book
Where Book.Price>
(SELECT AVG(Book.Price) FROM Book WHERE Book.PublishDate>'01.06.2011')

--  Определить, какие книги издательства продаются в магазинах України

SELECT Book.BookName, Publish.PublishName, Shop.ShopName, Country.CountryName
FROM Book, Publish, Shop, Country, Author, Sales
WHERE Book.AuthorId=Author.Id AND Author.PublishId=Publish.Id
AND Shop.Id=Sales.ShopId AND Sales.BookId=Book.Id AND Shop.CountryId=Country.Id
AND PublishId=
(SELECT Id FROM Publish WHERE Publish.PublishName='ZirkaBook')
AND
Shop.CountryId=
(SELECT Id FROM Country WHERE CountryName='Ukraine')

SELECT Book.BookName, Category.CategotyName
FROM Book, Category
WHERE Book.CategoryId=Category.Id AND Book.CategoryId NOT IN
(SELECT Category.Id FROM Category WHERE  CategotyName='Дитячі')

----------ANY---ALL-------

SELECT Book.BookName, Book.Price, Category.CategotyName
FROM Book, Category
WHERE Price<(SELECT MAX(Price) FROM Book WHERE CategoryId=
(SELECT Id From Category WHERE CategotyName='Історичні'))
AND Category.Id=Book.CategoryId

SELECT Book.BookName, Book.Price, Category.CategotyName
FROM Book, Category
WHERE Price<ANY(SELECT Price FROM Book WHERE CategoryId=
(SELECT Id From Category WHERE CategotyName='Історичні'))
AND Category.Id=Book.CategoryId

SELECT Book.BookName, Book.Price, Category.CategotyName
FROM Book, Category
WHERE Price<ALL(SELECT Price FROM Book WHERE CategoryId=
(SELECT Id From Category WHERE CategotyName='Історичні'))
AND Category.Id=Book.CategoryId


------------підзапит в SELECT----------
SELECT*,(SELECT Category.CategotyName FROM Category WHERE Id=Book.CategoryId) as Category
FROM Book

SELECT  BookName, 
        Price, 
        (SELECT Category.CategotyName FROM Category 
        WHERE Category.Id = Book.CategoryId) AS Category
FROM Book

----------------EXIST---------------

SELECT *FROM Book, Sales
WHERE Book.Id=Sales.BookId

SELECT*FROM Book
WHERE EXISTS (SELECT * From Sales WHERE Sales.BookId=Book.Id)
---автори книжки яких не продавались--
SELECT*FROM Author
WHERE NOT EXISTS(SELECT*FROM Sales,Book WHERE Sales.BookId=Book.Id AND Book.AuthorId=Author.Id)

SELECT*FROM Author
WHERE Id NOT IN(SELECT AuthorId FROM Sales,Book WHERE Sales.BookId=Book.Id AND Book.AuthorId=Author.Id)

SELECT COUNT(*)as [Кількість авторів що не продавали книжки]
FROM Author as a
WHERE NOT EXISTS(SELECT*FROM Sales as s,Book as b WHERE s.BookId=b.Id AND b.AuthorId=a.Id)


---кореляційний підзапит---


--книжки, вартість яких вище середньої ціни книжок для даного категорії
SELECT Book.BookName, Price,CategoryId,
(SELECT AVG(Price) FROM Book as categ WHERE categ.CategoryId=Book.CategoryId) as AVGPrice
FROM Book
WHERE Price>=(SELECT AVG(Price) FROM Book as categ WHERE categ.CategoryId=Book.CategoryId)
-----------------------------------------------------------------------------
--0. Показать категорию, книг которой в магазине находится меньше всего.

select top 1 Category.CategotyName, SUM(Sales.Amount)
from Category, Book, Sales
where Category.Id=Book.CategoryId and Book.Id=Sales.BookId
Group by Category.CategotyName
order by SUM(Sales.Amount)

SELECT Category.CategotyName, sum(Sales.Amount)
FROM Category, Book, Sales
WHERE Category.ID=Book.CategoryID and Sales.BookId=Book.Id
GROUP BY Category.CategotyName
HAVING Sum(Sales.Amount)< ANY 
(select Sum(Sales.Amount) from Sales, Book where Sales.BookId=Book.Id
 group by Book.CategoryId);


