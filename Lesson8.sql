SELECT AuthorId, AVG(Price) AS AveragePrice
FROM Book
GROUP BY AuthorId;
-----------------PIVOT
SELECT 'AveragePrice' AS Price_Sorted_By_AuthorId, 
[0] as 'Ivanov', [1] as 'Petrov', [2], [3], [4], [5], [6]
FROM
(SELECT AuthorId, Price FROM Book) AS s
PIVOT
(
AVG(Price)
FOR AuthorId IN ([0], [1], [2], [3], [4], [5], [6])
) AS p;


SELECT 'AveragePrice' AS Price_Sorted_By_AuthorId, 
*
FROM
(SELECT AuthorId, Price FROM Book) AS s
PIVOT
(
AVG(Price)
FOR AuthorId IN ([0], [1], [2], [3], [4], [5], [6])
) AS p;

-----unpivot------------------------------
select authorId, price
from ( select 'AveragePrice' as Price_Sorted_By_AuthorId, 
[0], [1], [2], [3], [4], [5], [6]
FROM
(SELECT b.AuthorId as authorId, b.Price as price
    FROM Book b) AS SourceTable
PIVOT
(
AVG(price)
FOR authorId IN ([0], [1], [2], [3], [4], [5], [6])
) AS PivotTable) as pvt
unpivot (price for authorId in ([0], [1], [2], [3], [4], [5], [6])) as UnpivotTable; 

--------unpivot----------------------------
select author, price
from
(
select 'AveragePrice' as [shop], [0], [1], [2], [3], [4], [5], [6]
from 
(
select Book.AuthorId as author, Book.Price as price
from Book 
group by Book.AuthorId,Book.Price
)as SourceTable
pivot
(
AVG(price) for author in ([0], [1], [2], [3], [4], [5], [6])
)
as PivoteTable
) as Unpvt
unpivot
(
price for author
in ([0], [1], [2], [3], [4], [5], [6])
)
as unpvt;



SELECT 'sales' as Prices, -- столбец (столбцы), значения из которого формируют заголовки строк
[250], [300], [100],[70.5] -- значения из столбца, который указан в предложении type, 
-- формирующие заголовки столбцов 
FROM (SELECT SalePrice, Amount FROM Sales) as SourceTable-- здесь может быть подзапрос
PIVOT -- формирование пивот-таблицы
(SUM(Amount) -- агрегатная функция, формирующая содержимое сводной таблицы
FOR SalePrice -- указывается столбец, 
-- уникальные значения в котором будут являться заголовками столбцов
IN([250], [300], [100],[70.5]) --указываются конкретные значения в столбце type, 
 -- которые следует использовать в качестве заголовков, 
 -- т.к. нам могут потребоваться не все
) pvt ;-- алиас для сводной таблицы


SELECT * FROM Shop

SELECT 'Amount books saled' as Shop,
[1] as PolandShop, [2] as Slovo
FROM (Select ShopId, Amount FROM Sales)
as SourceTable
PIVOT
(
SUM(Amount)
FOR ShopId
IN ([1],[2])
) pvt;


----------------UNPIVOT--------------
SELECT s, amount
FROM
(
SELECT 'Amount books saled' as Shop,
[1] as PolandShop, [2] as Slovo
FROM (Select ShopId as s, Amount FROM Sales)
as SourceTable
PIVOT
(
SUM(Amount)
FOR s
IN ([1],[2])
) pvt
) as Unpvt
UNPIVOT
(
Amount for s IN (PolandShop,Slovo)
)
as unpvt;


SELECT * 
FROM (
    SELECT BookName, [Category]=(SELECT CategotyName FROM Category WHERE Book.CategoryId=Category.Id)
    FROM Book
) t
PIVOT (
    COUNT(BookName) 
    FOR [Category] IN (
        Історичні, Наукові, Дитячі, Поезія, Художні
    )
) p;

select SUM(Sales.SalePrice), CategotyName
from Sales inner join (Book inner join Category on Book.CategoryId=Category.Id) on Sales.BookId=Book.Id
group by CategotyName

select *
from(
select SalePrice, [Category]=(SELECT Category.CategotyName FROM Category Where Category.Id IN
(SELECT CategoryId from Book WHERE Sales.BookId=Book.Id)
)
from Sales
) as t
PIVOT
(
SUM(SalePrice)
FOR [Category] IN (Дитячі, Історичні, Наукові, Художні)
)p;
