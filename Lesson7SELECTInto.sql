SELECT BookName, Category.CategotyName
INTO CategBook
FROM Book INNER JOIN Category ON Category.Id=Book.CategoryId

SELECT* FROM CategBook WHERE CategotyName='��������'

SELECT BookName, Category.CategotyName
INTO #CategBookTemp
FROM Book INNER JOIN Category ON Category.Id=Book.CategoryId
