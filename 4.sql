-- Sanal Ýsimlendirme
select ProductName as 'Ürün Adý' from Products
select ProductName 'Ürün Adý' from Products
select ProductName as [Ürün Adý] from Products
select ProductName [Ürün Adý] from Products

-- Aggregate Functionlar
-- min() , max(), avg(), sum(), count()
-- ürünler tablosunda en yüksek fiyatlý ürünü getir.
-- eski yöntem
select top(1) UnitPrice from Products order by UnitPrice desc
-- max() methodu satýlardan en yüksek deðerli olan satýrý getirir. metinsel ifadelerle çalýþýr.
select max(UnitPrice) as 'En yüksek Fiyat' from Products
-- ürünler tablosunda en düþük fiyatlý ürünü getir.
-- min() methodu satýlardan en düþük deðerli olan satýrý getirir.  metinsel ifadelerle çalýþýr.
select min(UnitPrice) as 'En düþük Fiyat' from Products

-- count() => istenilen tablodaki satýr sayýsýný getirir.  metinsel ifadelerle çalýþýr.
-- ürünler tablomda kaç ürün vardýr
select count(ProductID) as 'Ürün Sayýsý' from Products
-- kaç adet sipariþ vardýr.
select count(OrderID) as 'Sipariþ Sayýsý' from Orders

-- NOT : count null olan kayýtlarý saymaz.
select count(Region) from Employees
select * from Employees
select count(EmployeeID) - count(Region) from Employees -- Null olan sayýsý

-- kaç adet sipariþ vardýr.
select count(OrderID) from Orders
select count(ShipRegion) from Orders
select * from Orders

-- sum() => satýlarý alta alta kümülatif (yýðýlmalý) olarak toplar.  metinsel ifadelerle çalýþmaz.
select sum(UnitPrice) as 'Ürünlerin UnitPrice Toplamý' from Products

select sum(UnitPrice*Quantity) as 'Tüm Sipariþlerin Toplam Fiyatý' from [Order Details]

-- avg() => average satýrlarýn ortalamasýný alýr. metinsel ifadelerle çalýþmaz.
select sum(UnitsInStock) / count(UnitsInStock)  from Products
select avg(UnitsInStock) from Products
select * from Products

select avg(Quantity) from [Order Details]

-- Anne isimli çalýþanýn aldýðý sipariþlerin toplam kargo maliyeti nedir.
select sum(Freight) from Orders 
where EmployeeID in (select EmployeeID from Employees where FirstName = 'Anne')

-- min,max datetime alanlarla çalýþýr.
-- en yaþlý çalýþan
select min(BirthDate) from Employees
-- en genç çalýþan
select max(BirthDate) from Employees
-- tüm sipariþlerin ortalamasý
select avg(UnitPrice*Quantity) from [Order Details]

-- çalýþanlarýn toplam sipariþ sayýsýný bulunuz
select EmployeeID,count(OrderID) from Orders -- hata verir çünkü employeeID tekrar eden bir yapý aggregate function ise tekil bir sonuç döndüren bir yapý
-- GROUP BY
-- Aggregate functionlar dýþýnda select yapýlan sütun yada sütunlar var ise burada gelecek 
-- satýrlardan birden fazla olacaðýndan dolayý tekrarlý sütunu gruplamamýz gerekir.
select EmployeeID,count(OrderID) as 'Çalýþan bazýnda toplam sipariþ' 
from Orders group by EmployeeID

-- Hangi kategoride kaç adet ürün vardýr.

select CategoryID, count(ProductID) from Products group by CategoryID

-- her personelin almýþ olduðu sipariþlerin toplam kargo maliyeti
select EmployeeID, sum(Freight) from Orders group by EmployeeID
order by sum(Freight)

select EmployeeID, sum(Freight) from Orders group by EmployeeID
order by 1

select EmployeeID, sum(Freight) from Orders group by EmployeeID
order by 2

select EmployeeID, sum(Freight) as 'Kargo Maliyeti' from Orders group by EmployeeID
order by 'Kargo Maliyeti'

-- her bir sipariþin maliyetini OrderID ye göre gruplayýn.
select OrderID, sum(UnitPrice*Quantity) from [Order Details] group by OrderID

-- her bir siparite kaç kalem sipariþ verilmiþtir OrderID ye göre gruplayýn.
select OrderID, count(OrderID) from [Order Details] group by OrderID
order by 2
-- saðlamasý
select * from [Order Details] where OrderID in (11077)

-- Çalýþanlarýn kaç adet sipariþ aldýklarýný bulunuz fakat bunlardan 100 üstü sipariþ alanlarý listeyiniz.

select EmployeeID,count(OrderID) from Orders group by EmployeeID
where count(OrderID) > 100 -- Hata verir.

-- NOT: eðer bir sorguda aggregate function ile ilgili bir koþul durumu var ise bu durumda
-- where kullanýlamaz !! bunun yerine having keywordü kullanýlýr.
select EmployeeID,count(OrderID) from Orders group by EmployeeID
having count(OrderID) > 100 

-- sipariþ detaylarýnda tüm sipariþlerin toplam UnitPrice ý 100 den büyük ise göster.
select sum(UnitPrice) from [Order Details] having sum(UnitPrice) >100






-- Ödev 

-- Kategori bazýnda her kategoride olan ürünlerin stoklarýný yazýnýz.
SELECT CategoryID, SUM([Order Details].Quantity) FROM Products, [Order Details] WHERE Products.ProductID = [Order Details].ProductID GROUP BY Products.CategoryID;
select * from [Order Details]

-- ürün bazýnda tekrarlanan sipariþ sayýsýnýn ortalamasýný bulunuz.
select ProductID, sum(UnitPrice*Quantity) from [Order Details] group by ProductID
SELECT ProductID, COUNT(*) AS SipariþSayýsý FROM [Order Details] GROUP BY ProductID;


-- ürün bazýnda quantity olarak en fazla sipariþ verilen ürünün adýný bulunuz.
select * from Products 
where ProductID in (select top(1) ProductID from [Order Details] order by Quantity desc)




