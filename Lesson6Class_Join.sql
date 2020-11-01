----UNION
SELECT 'Incomes',Book.BookName, DateIncomes, NULL FROM Book, Incomes
WHERE Incomes.BookId=Book.Id
UNION
SELECT 'Sales',Book.BookName, DateSale, Price FROM Book, Sales
WHERE Sales.BookId=Book.Id
ORDER BY Book.BookName

---INTERSECT
SELECT Book.BookName FROM Book, Incomes
WHERE Incomes.BookId=Book.Id
INTERSECT
SELECT Book.BookName FROM Book, Sales
WHERE Sales.BookId=Book.Id
ORDER BY Book.BookName

---EXCEPT
SELECT Book.BookName FROM Book, Incomes
WHERE Incomes.BookId=Book.Id
EXCEPT
SELECT Book.BookName FROM Book, Sales
WHERE Sales.BookId=Book.Id
ORDER BY Book.BookName

---JOIN
SELECT Book.BookName FROM Book, Incomes
WHERE Incomes.BookId=Book.Id

SELECT Book.BookName, DateIncomes FROM Book
INNER JOIN Incomes ON BookId=Book.Id

SELECT Book.BookName, Category.CategotyName
FROM Book INNER JOIN Category ON Book.CategoryId=Category.Id

---LEFT OUTER JOIN
SELECT Book.BookName, DateIncomes FROM Book
LEFT OUTER JOIN Incomes ON BookId=Book.Id

SELECT Book.BookName, Category.CategotyName
FROM Book LEFT OUTER JOIN Category ON Book.CategoryId=Category.Id

---RIGHT OUTER JOIN
SELECT Book.BookName, Category.CategotyName
FROM Book RIGHT OUTER JOIN Category ON Book.CategoryId=Category.Id

---книжки які не продавались
SELECT Book.BookName, Sales.Id
FROM Book LEFT OUTER JOIN Sales ON Book.Id=Sales.BookId
WHERE Sales.Id IS NULL

---обрати книжку, автора і країну автора
SELECT Book.BookName, Author.AuthorName, Country.CountryName
FROM Book INNER JOIN (Author INNER JOIN 
(Address INNER JOIN Country ON Address.CountryId=Country.Id)
ON Author.AddressId=Address.Id)
ON Book.AuthorId=Author.Id

--- самообєднання
SELECT b1.BookName, b2.BookName
FROM Book as b1, Book as b2
WHERE b1.AuthorId=b2.AuthorId
AND b1.BookName<>b2.BookName

---cross join
SELECT Book.BookName, Category.CategotyName
FROM Book CROSS JOIN Category 

select *
from Sales as s
where exists (select * from Sales as s2 where s2.Amount>10 AND s.Id=s2.Id)

--- довести що продажі по категорїї Історичні максимальні

SELECT TOP 1 SUM(Amount), Category.CategotyName
FROM Sales INNER JOIN 
(Category INNER JOIN Book ON Category.Id=Book.CategoryId) ON Sales.BookId=Book.Id
WHERE Category.CategotyName='Історичні'
GROUP BY Category.CategotyName
UNION
SELECT TOP 1 SUM(Amount), Category.CategotyName
FROM Sales INNER JOIN 
(Category INNER JOIN Book ON Category.Id=Book.CategoryId) ON Sales.BookId=Book.Id
GROUP BY Category.CategotyName
ORDER BY SUM(Amount) DESC

--- вивести категорії з максимальною кількістю продаж

SELECT SUM(Amount), Category.CategotyName
FROM Sales INNER JOIN 
(Category INNER JOIN Book ON Category.Id=Book.CategoryId) ON Sales.BookId=Book.Id
GROUP BY Category.CategotyName
HAVING
SUM(Amount) = (
SELECT TOP 1 SUM(Amount)
FROM Sales INNER JOIN 
(Category INNER JOIN Book ON Category.Id=Book.CategoryId) ON Sales.BookId=Book.Id
GROUP BY Category.CategotyName
)

---- форма дати

SELECT FORMAT(DateSale, 'dd місяць MM-yy')
FROM Sales


--- вивести в процентах 
SELECT FORMAT(SUM(Amount)*100/(
SELECT SUM(Amount) From Sales),'N')+'%',
Category.CategotyName
FROM Sales INNER JOIN 
(Category INNER JOIN Book ON Category.Id=Book.CategoryId) ON Sales.BookId=Book.Id
GROUP BY Category.CategotyName
WITH ROLLUP