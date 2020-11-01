  --variables---
  
  declare @var int=5
  PRINT @var

  declare @name varchar(20)='Ivanov';
  PRINT 'Author '+@name;

  SELECT * FROM Author
  WHERE AuthorName=@name;

  set @name ='Petrov';
  PRINT 'Author '+@name;
  SELECT * FROM Author
  WHERE AuthorName=@name;


  ----SELECT INTO---
  SELECT Author.AuthorName as Author, Book.BookName as Book
  INTO AuthorBooks
  From Author INNER JOIN Book ON Author.Id=Book.AuthorId
  
  SELECT *FROM AuthorBooks

  ALTER TABLE AuthorBooks
  ADD Id INT IDENTITY

  ALTER TABLE AuthorBooks ADD
  CONSTRAINT PKey PRIMARY KEY (Id)

  ----SELECT INTO#---
  SELECT Author.AuthorName as Author, Book.BookName as Book
  INTO #AuthorBooks1
  From Author INNER JOIN Book ON Author.Id=Book.AuthorId
  
  SELECT *FROM #AuthorBooks1

  ALTER TABLE #AuthorBooks1
  ADD Id INT IDENTITY

  ALTER TABLE #AuthorBooks1 ADD
  CONSTRAINT PKey PRIMARY KEY (Id)

   ----SELECT INTO#---
  SELECT Author.AuthorName as Author, Book.BookName as Book
  INTO ##AuthorBooksGlob
  From Author INNER JOIN Book ON Author.Id=Book.AuthorId
  

  SELECT *FROM ##AuthorBooksGlob

  ALTER TABLE ##AuthorBooksGlob
  ADD Id INT IDENTITY

  ALTER TABLE ##AuthorBooksGlob ADD
  CONSTRAINT PKey PRIMARY KEY (Id)
  ---INSERT---

  INSERT INTO Sales(ShopId, BookId, DateSale, Amount, SalePrice)
  SELECT (SELECT Shop.Id FROM Shop WHERE ShopName='Slovo'), Book.Id, GETDATE(), 10, Book.Price*1.1
  FROM Book WHERE Book.CategoryId = (SELECT Id FROM Category WHERE CategotyName='Історичні')

  SELECT * FROM Sales

  ---DELETE---



  ---UPDATE---
  SELECT * FROM Book
  ORDER BY CategoryId

  UPDATE Book 
  SET Price=Price*1.1
  WHERE CategoryId=(SELECT Id FROM Category WHERE CategotyName='Наукові')

  ----VIEW---

  CREATE VIEW CategoryBooks
  AS SELECT Category.CategotyName, Book.BookName
  FROM Book INNER JOIN Category ON Book.CategoryId=Category.Id


  SELECT*FROM CategoryBooks

  ALTER VIEW CategoryBooks
  AS SELECT Category.CategotyName, Book.BookName, Book.Price
  FROM Book INNER JOIN Category ON Book.CategoryId=Category.Id

  ALTER VIEW CategoryBooks
  AS SELECT Book.Price
  FROM Book

  INSERT INTO CategoryBooks(Category.CategotyName) VALUES('Мистецькі')
  SELECT*FROM Category  

  DROP VIEW CategoryBooks

  CREATE VIEW BookView
  AS SELECT BookName AS Book, Description, Price
  FROM Book

INSERT INTO BookView (Book, Description, Price)
VALUES ('Супер книжка','Про все на світі',200)

SELECT * FROM BookView
SELECT * FROM Book

CREATE VIEW [Category Sales] AS
SELECT DISTINCT CategotyName, Sum(Sales.Amount) AS CategorySales
FROM Sales INNER JOIN (Category INNER JOIN Book ON Book.CategoryId=Category.Id) ON Sales.BookId=Book.Id
GROUP BY CategotyName;

SELECT * FROM [Category Sales]


     ----PIVOT----

  SELECT  'AVG', [BookName]
  FROM  Book as SourceTable
  PIVOT(AVG (Price) for BookPrice in([BookName])) as PivotTable

