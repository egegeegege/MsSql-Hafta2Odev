-- Sanal İsimlendirme
select ProductName as 'Ürün Adı' from Products
select ProductName 'Ürün Adı' from Products
select ProductName as [Ürün Adı] from Products
select ProductName [Ürün Adı] from Products 

-- Aggregate Functionlar
-- min() , max(), avg(), sum(), count()
-- ürünler tablosunda en yüksek fiyatlı ürünü getir.
-- eski yöntem
select top(1) UnitPrice from Products order by UnitPrice desc
-- max() methodu satılardan en yüksek değerli olan satırı getirir. metinsel ifadelerle çalışır.
select max(UnitPrice) as 'En yüksek Fiyat' from Products
-- ürünler tablosunda en düşük fiyatlı ürünü getir.
-- min() methodu satılardan en düşük değerli olan satırı getirir.  metinsel ifadelerle çalışır.
select min(UnitPrice) as 'En düşük Fiyat' from Products

-- count() => istenilen tablodaki satır sayısını getirir.  metinsel ifadelerle çalışır.
-- ürünler tablomda kaç ürün vardır
select count(ProductID) as 'Ürün Sayısı' from Products
-- kaç adet sipariş vardır.
select count(OrderID) as 'Sipariş Sayısı' from Orders

-- NOT : count null olan kayıtları saymaz.
select count(Region) from Employees
select * from Employees
select count(EmployeeID) - count(Region) from Employees -- Null olan sayısı

-- kaç adet sipariş vardır.
select count(OrderID) from Orders
select count(ShipRegion) from Orders
select * from Orders

-- sum() => satıları alta alta kümülatif (yığılmalı) olarak toplar.  metinsel ifadelerle çalışmaz.
select sum(UnitPrice) as 'Ürünlerin UnitPrice Toplamı' from Products

select sum(UnitPrice*Quantity) as 'Tüm Siparişlerin Toplam Fiyatı' from [Order Details]

-- avg() => average satırların ortalamasını alır. metinsel ifadelerle çalışmaz.
select sum(UnitsInStock) / count(UnitsInStock)  from Products
select avg(UnitsInStock) from Products
select * from Products

select avg(Quantity) from [Order Details]

-- Anne isimli çalışanın aldığı siparişlerin toplam kargo maliyeti nedir.
select sum(Freight) from Orders 
where EmployeeID in (select EmployeeID from Employees where FirstName = 'Anne')

-- min,max datetime alanlarla çalışır.
-- en yaşlı çalışan
select min(BirthDate) from Employees
-- en genç çalışan
select max(BirthDate) from Employees
-- tüm siparişlerin ortalaması
select avg(UnitPrice*Quantity) from [Order Details]

-- çalışanların toplam sipariş sayısını bulunuz
select EmployeeID,count(OrderID) from Orders -- hata verir çünkü employeeID tekrar eden bir yapı aggregate function ise tekil bir sonuç döndüren bir yapı
-- GROUP BY
-- Aggregate functionlar dışında select yapılan sütun yada sütunlar var ise burada gelecek 
-- satırlardan birden fazla olacağından dolayı tekrarlı sütunu gruplamamız gerekir.
select EmployeeID,count(OrderID) as 'Çalışan bazında toplam sipariş' 
from Orders group by EmployeeID

-- Hangi kategoride kaç adet ürün vardır.

select CategoryID, count(ProductID) from Products group by CategoryID

-- her personelin almış olduğu siparişlerin toplam kargo maliyeti
select EmployeeID, sum(Freight) from Orders group by EmployeeID
order by sum(Freight)

select EmployeeID, sum(Freight) from Orders group by EmployeeID
order by 1

select EmployeeID, sum(Freight) from Orders group by EmployeeID
order by 2

select EmployeeID, sum(Freight) as 'Kargo Maliyeti' from Orders group by EmployeeID
order by 'Kargo Maliyeti'

-- her bir siparişin maliyetini OrderID ye göre gruplayın.
select OrderID, sum(UnitPrice*Quantity) from [Order Details] group by OrderID

-- her bir siparite kaç kalem sipariş verilmiştir OrderID ye göre gruplayın.
select OrderID, count(OrderID) from [Order Details] group by OrderID
order by 2
-- sağlaması
select * from [Order Details] where OrderID in (11077)

-- Çalışanların kaç adet sipariş aldıklarını bulunuz fakat bunlardan 100 üstü sipariş alanları listeyiniz.

select EmployeeID,count(OrderID) from Orders group by EmployeeID
where count(OrderID) > 100 -- Hata verir.

-- NOT: eğer bir sorguda aggregate function ile ilgili bir koşul durumu var ise bu durumda
-- where kullanılamaz !! bunun yerine having keywordü kullanılır.
select EmployeeID,count(OrderID) from Orders group by EmployeeID
having count(OrderID) > 100 

-- sipariş detaylarında tüm siparişlerin toplam UnitPrice ı 100 den büyük ise göster.
select sum(UnitPrice) from [Order Details] having sum(UnitPrice) >100






-- Ödev 

-- Kategori bazında her kategoride olan ürünlerin stoklarını yazınız.
SELECT CategoryID, SUM([Order Details].Quantity) FROM Products, [Order Details] WHERE Products.ProductID = [Order Details].ProductID GROUP BY Products.CategoryID;
select * from [Order Details]

-- ürün bazında tekrarlanan sipariş sayısının ortalamasını bulunuz.
select ProductID, sum(UnitPrice*Quantity) from [Order Details] group by ProductID
SELECT ProductID, COUNT(*) AS SiparişSayısı FROM [Order Details] GROUP BY ProductID;


-- ürün bazında quantity olarak en fazla sipariş verilen ürünün adını bulunuz.
select * from Products 
where ProductID in (select top(1) ProductID from [Order Details] order by Quantity desc)




