use BookShopPublisher

--UNION
--�� ������ ���� ���� ����� 100 ��� ��� �������� =1
SELECT Book.BookName, Price, CategoryId FROM Book WHERE Price>100
UNION
SELECT Book.BookName, Price, CategoryId FROM Book WHERE CategoryId=1;

--�� ������ ���� ���� ����� 100 ��� ��� �������� ='������'

SELECT BookName, Price, Category.CategotyName 
FROM Book, Category 
WHERE Book.CategoryId=Category.Id AND Price>100  
UNION
SELECT BookName, Price, Category.CategotyName 
FROM Book, Category 
WHERE Book.CategoryId=Category.Id AND CategotyName='������';

SELECT Book.BookName, Price, Format(DateSale,'yyyy') as ����
FROM Sales, Book
WHERE Book.Id=Sales.BookId
UNION
SELECT Book.BookName, Price, Format(DateIncomes,'yyyy')
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId

SELECT 'Sale' as Type, Book.BookName, Price, Format(DateSale,'yyyy') as ����
FROM Sales, Book
WHERE Book.Id=Sales.BookId
UNION
SELECT 'Income', Book.BookName, Price, Format(DateIncomes,'yyyy')
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId

---EXCEPT//������

SELECT  Book.BookName
FROM Incomes, Book
WHERE Book.Id=Incomes.BookId
EXCEPT
SELECT  Book.BookName
FROM Sales, Book
WHERE Book.Id=Sales.BookId

---INTERSECT//�� � ��� � ���

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
--�� ������ �� � � ��� � ������� � ���� ������ ���� ���� �����������
SELECT Book.BookName, CategotyName, Sales.DateSale FROM ((Book
INNER JOIN Category ON Book.CategoryId=Category.Id)
LEFT OUTER JOIN Sales ON Sales.BookId=Book.Id)

--��  �������, � ���� � �� ������ �� �� ����������

SELECT Book.BookName, CategotyName FROM (Book
RIGHT OUTER JOIN Category ON Book.CategoryId=Category.Id)

--�� ������ �� � � ��� � �� ������� � �� ���� ������
SELECT Book.BookName, CategotyName, Sales.DateSale FROM ((Book
FULL OUTER JOIN Category ON Book.CategoryId=Category.Id)
FULL OUTER JOIN Sales ON Sales.BookId=Book.Id)

--������������
-- ���������� ��� �������� ���� �����

select sh1.ShopName as 'Shop Name' 
from Shop sh1 INNER JOIN Shop sh2 on sh1.id = sh2.id 
INNER JOIN Country c on sh2.CountryId = c.id where c.CountryName = 'Ukraine'; 

select CountryName, Shop.ShopName From Shop INNER JOIN Country ON Country.Id=Shop.CountryId
WHERE CountryName='Ukraine';

---���������� ��� ������ � ������ ������
SELECT DISTINCT b1.BookName as Name1, b2.BookName as Name2, Author.AuthorName
FROM Book as b1, Book as b2, Author
WHERE b1.AuthorId=b2.AuthorId AND b1.AuthorId=Author.Id AND b1.Id<>b2.Id
AND AuthorName='Ivanov'

---cross join
select b.BookName, t.CategotyName from Book b CROSS JOIN Category t;


----task 3
--- ������� ���� �������, ������� ���������� � ���� ������ � ��������� (��� �������) �� ����, 
--- ������� �������� �������������. 

SELECT Author.AuthorName, Book.BookName
FROM Author LEFT OUTER JOIN Book
ON Author.Id=Book.AuthorId

--- 5. ��������, ��� ����� ��������, ��������, "��������" ����������� 
--- ����� ������� �������. ����������! ��������������� ����� NULL ��������, ����� � ����� 
--- �������� ����������� �������. 

SELECT TOP 1 Category.CategotyName, SUM(Sales.Amount)
FROM Category INNER JOIN (Sales  INNER JOIN Book ON
Book.Id=Sales.BookId) ON Category.Id=Book.CategoryId
WHERE Sales.Amount=(SELECT MAX(Sales.Amount) FROM Sales)
GROUP BY Category.CategotyName
HAVING CategotyName='��������'
UNION
SELECT TOP 1 Category.CategotyName, SUM(Sales.Amount)
FROM Category INNER JOIN (Sales  INNER JOIN Book ON
Book.Id=Sales.BookId) ON Category.Id=Book.CategoryId
WHERE Sales.Amount=(SELECT MAX(Sales.Amount) FROM Sales)
GROUP BY Category.CategotyName

--- 8. ������� ����� ���� �������, ���� ������� �� �������� ��� ������������, �� ���� 
--- ������� �� ������������ � ������� Books. (�������� ��� �������� �������: ���� � �������������� 
--- �����������, ������ � �������������� ���������� ����������� ��������). 

SELECT Author.AuthorName, Book.Id
FROM Author LEFT OUTER JOIN Book ON Book.AuthorId=Author.Id
WHERE Book.Id IS NULL

SELECT Book.Id, Author.AuthorName
FROM Book RIGHT OUTER JOIN Author ON Author.Id=Book.AuthorId
WHERE Book.Id=NULL






