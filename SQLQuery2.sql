select * from Employees
select * from Categories
select * from products
select * from Receipts
select * from Details

select * 
from INFORMATION_SCHEMA.TABLES
Where TABLE_TYPE = 'base table'

exec sp_help 'dbo.products'

select
ProductID,
ProductName,
UnitPrice
from Products;

select
ProductName AS ชื่อสินค้า,
UnitPrice AS ราคา
from Products;
--ใช้ Distinct สำหรับลดการแสดงข้อมูลที่ซ่ำกัน
select distinct position from Employees

select top (7)
ProductID,
ProductName,
UnitPrice
from Products;
--Top ใช้สำหรับข้อมูล 5รายการแรก
Select top(5) * from products
--การแก้ไขข้อมูลในตารางไห้สินค้าชื่อ ดินสอ ราคาเป็น12
update Products
set UnitPrice = 12
where productID = 1
-------------------
update Products
set UnitPrice = 15
where productName = 'ดินสอ'
--ปรับปรุงยางลบไห้เป็น10บาทและมีจำนวนคลเหลือ250
update products
set
	UnitPrice = 10, UnitsInStock = 250
	where ProductName = 'ยางลบ'
--ปรับปรุงจำนวนคงเหลือของดินสอ เพิ่มขึ้น100 ชิ้น
update products
set UnitsInStock = UnitsInStock+100
where productName = 'ดินสอ'
--ขึ้นราคาสินค้า 5% ทุกรายการ
update Products
set UnitPrice = UnitPrice * 1.05
--
select * from Products
-- ต้องการลบสินค้ารหัส3
Delete from products where productID = 3
--คำสั่ง select การใช้where
select productID, ProductName, UnitPrice
from Products
where UnitPrice<20
--ต้องการ ชื่อ สกุล พนักงานที่เป็น sale manager
select firstname, lastname from Employees
where Position = 'sale manager'
--ต้องการ รหัสสินค้า ของ ชาเขียว
select productID
from Products
where ProductName = 'ชาเขียว'
--ข้อมูลสินค้ามีจำนวนในสต๊อก ต่ำกว่า400
select * from Products where UnitsInStock < 400
--ข้อมูลสิยค้าที่รหัสหมวดหมู่ 1 และราคาไม่เกิน20
select * from Products
where CategoryID = 1 and UnitPrice <= 20
--ข้อมูลสินค้าที่รหัสหมวดหมูุ1 หรือราคาไม่เกิน20
select * from Products
where CategoryID = 1 or UnitPrice <= 20

select
	ProductID,
	ProductName,
	UnitPrice
from Products
where UnitPrice BETWEEN 10 and 20;
--
SELECT
    ProductID,
    ProductName,
    CategoryID
FROM dbo.Products
WHERE CategoryID IN (1, 2, 4);
--
SELECT
    ProductID,
    ProductName
FROM dbo.Products
WHERE ProductName LIKE 'น้ำ%';
--ชื่อพนักงานที่มีนามสกุลลงท้ายด้วย "คำ"
select firstname, lastname from Employees
where Lastname like '%คำ'
--ชื่อสินค้า ราคา สินค้าที่มีคำว่า ส้ม
select productName, unitprice
from Products
where productname like '%ส้ม'
--

Insert into Employees(FirstName, UserName,Password)
values ('เตวิช', 'tevit', '1234')
--
Insert into Employees(FirstName, LastName ,UserName,Password)
values ('กานต์','', 'karn', '1234')

select * from Employees

select * from Employees
where LastName = ''
--
select * from Employees
where LastName is null or lastname =''

--ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ทุกคน และอยู่ช่องเดียวกัน
select Title+FirstName+' '+lastname as ชื่อนามสกุลพนักงาน
from Employees

select FirstName+' '+lastname as ชื่อนามสกุลพนักงาน
from Employees
-----------------------
SELECT *
FROM Receipts
where ReceiptDate='2013/02/10'

SELECT *
FROM Receipts
where ReceiptDate<'2013/02/10'

SELECT *
FROM Receipts
where ReceiptDate>='2013/02/10'

select * from Receipts
where ReceiptDate between '2013-02-01' and '2013-02-07'
-- ใช้ function year(), Mount() มาช่วยในเงื่อไข
select * from Receipts
where year(ReceiptDate) = 2013

select * from Receipts
where year(ReceiptDate) = 2013 and month(ReceiptDate)=2

-- asscending ASC น้อยไปมาก
-- Descending DESC มากไปน้อย
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
ORDER BY UnitPrice ASC;

--------------------------------------------------

SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;
--order by ใช้สำหรับเรียงลำดับ จะใส่ตอนท้ายของคำสั่ง SQL
select productID, ProductName, UnitPrice, UnitsInStock
from Products
order by ProductName asc

select productID, ProductName, UnitPrice, UnitsInStock 
from Products
order by UnitPrice desc

select top(3) * from Products
order by UnitsInStock desc
