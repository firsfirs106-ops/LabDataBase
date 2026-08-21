--lab ในชั้นเรียนวันที่19 ส.ค. 2569
--calulate Column การประมวลผลในคอลัมน์
--ต้องการข้อมูล เลขใบสั่งซื้อ และยอดเงินจำหน่ายสินค้าในใบสั่งซื้อนั้น
select orderID, ProductID, UnitPrice,Quantity,Discount,
UnitPrice*Quantity*(1-Discount) as ราคารวม
from [Order Details]
--ต้องการ รหัส ชื่อเต็มพนักงาน(คำนำหน้า ชื่อ นามสกุล) ตำแหน่ง โทร ของพนักงาน
select EmployeeID,TitleOfCourtesy + firstName+space(2)+LastName as EmpName,
title,HomePhone
from Employees
--ต้องการ รหัสาสินค้า ราคา จำนวนที่ขายได้ เรียงตามลำดับสินค้า
Select ProductID ,sum(quantity) as จำนวนที่ขายได้
, cast(sum(UnitPrice*Quantity*(1-Discount)) as numeric(10,2))as ยอดเงินที่ขายได้
from [Order Details]
group by ProductID
order by sum(UnitPrice*Quantity*(1-Discount)) desc
--Cast(000 as numeric(10,2))
--ต้องการชื่อพนักงานและปีที่เข้าทำงาน
select TitleOfCourtesy + firstName+space(2)+LastName as EmpName,
year (hiredate)+543 [ปีที่ พ.ศ. เข้าทำงาน]
from Employees
-- รหัสสินค้า ชื่อสิ้นค้า ราคา และช่วงราคา(สูง ปานกลาง ต่ำ)
select ProductID, ProductName, UnitPrice,
case when UnitPrice >= 75 then 'High'
when UnitPrice >= 35 then 'Mediam'
else 'Low'
end as priceLevel
from Products

--การ Join ตาราง ที่มีความสัมพันธ์กัน
-- join 2ตาราง
--ต้องการชื่อสินค้าทั้งหมด และชื่อหมวดหมูสิ้นค้า
select products.ProductName, Categories.CategoryName
from Products join Categories
on products.CategoryID = Categories.CategoryID
--หรือเขียนย่อ
select ProductName, CategoryName, c.CategoryID
from Products as p join Categories as c
on p.CategoryID = c.CategoryID
--supplier
select
p.ProductName,
s.Companyname AS supplier
from Products as p
JOIN suppliers as s
on p.SupplierID = s.SupplierID;
--Order แต่ละรายการเป็นของลูกค้ารายใด
select orderID, Convert(varchar,orderDate,6) as [order date], c.CompanyName
from orders as o join Customers as c 
on o.CustomerID = c.customerID
Order by 3 asc

--convert(varchar, getdate(), 6)

--1. ต้องการชื่อบริษัทขนส่ง และจำนวนใบสั่งซื้อเกี่วข้อง
select
s.CompanyName as ชื่อบริษัทขนส่ง,
count(o.orderID) as จำนวนใบสั่งซื้อ
from Orders  as o
join shippers as s
on o.shipvia = s.shipperID
group by s.CompanyName;

--2.1. ต้องการชื่อเต็มพนักงาน
select
e.EmployeeID,
e.Titleofcourtesy+e.firstName+space(2)+e.LastName as empname,
count(o.orderID) as จำนวนการสั่งซื้อ
from Employees as e
join orders as o
on e.employeeID = o.EmployeeID
group by e.EmployeeID, e.Titleofcourtesy,e.firstName,e.lastName
order by จำนวนการสั่งซื้อ desc
--2.2. ชื่อบริษัทลูกค้า ประเทศลูกค้า และจำนวนใบสั่งซื้อที่เกี่ยวข้อง
select c.CompanyName,
c.country,
count(orderID) as ordercount
from orders as o join customers as c on o.customerID = c.CustomerID
group by c.companyName, c.Country
order by ordercount
--3.1. หมายเลขใบสั่งซื้อ และ ชื่อบริษัทขนส่ง
select o.orderID,s.companyNAme as shipper
from orders as o
join shippers as s
on o.shipvia =s.ShipperID;
--3.2. รหัสสินค้า ชื่อสินค้า และชื่อบริษัทผู้จำหน่าย (supplier)
select
p.productID as 'รหัสสินค้า',
p.productName as 'ชื่อสินค้า',
s.companyName as 'ชื่อบริษัท'
from products p
join suppliers s on p.supplierID = s.supplierID;
--4. รหัสหมวดหมู่ ชื่อสินค้า และจำนวน ชนิดสินค้าในแต่ละหมวดหมุ่
select
c.CategoryID as 'รหัสหมวดหมู่',
c.categoryNAme as 'ชื่อหมวดหมู่สินค้า',
count(p.productID) as 'จำนวนสินค้า'
from categories c join Products p
on c.CategoryID = p.CategoryID
group by c.categoryID, c.categoryNAme

--การjoin 3 ตารางขึ้นไป
--ต้องการหมายเลขใบสั่งซื้อ วันที่สั่งซื้อ บริษัทลูกค้า ชื่อสกุลพนักงานผู้ขาย
select orderID, convert(varchar,orderDate,6) as [order date],
c.companyName, e.FirstName + space(2) + e.LastName as empName
from orders o
inner join customers c on o.customerID = c.CustomerID
inner join Employees e on o.EmployeeID = e.EmployeeID

--ต้องการรหัสสินค้า ชื่อสินค้า ราคาต่อน่วย ชื่อหมวดหมู่ ชื่อบริษัทผู้จำหน่าย

select productID,ProductName,UnitPrice, categoryName, companyName
from products p join categories c on p.CategoryID = c.CategoryID
join Suppliers s on p.SupplierID = s.SupplierID
--ต้องการ รหัสหมวดหมุู่ ชื่อหมวดหมู่ ยอดขายทั้งหมดในหมวดหมู่ แสดงเฉพาะยอด ขายสุงสุด 3อันดับแรก
select top 3
c.CategoryID, c.CategoryName,
cast(sum(od.unitprice*Quantity*(1-discount)) as numeric(10,2)) as totalprice
from categories c join products p on c.CategoryID = p.CategoryID
				  join [Order details] od on od.productID = p.productID
group by c.categoryID , c.categoryName
order by 3 desc

--(4 ตาราง) ในแต่ละรายการสั่งซื้อ มีบรืษัทลูกค้าใดซื้อสิ้นค้า ชื่ออะไร จำนวนเท่าไร จำนวน และมียอดขายเท่าใด
Select o.orderID,c.CompanyName,p.ProductName,od.Quantity,
od.Unitprice*quantity*(1-discount) as [totalsale]
from orders o join customers c        on o.customerID = c.customerID
			  join[Order Details] od on o.OrderDate = od.OrderID
			  join Products p        on p.ProductID = od.ProductID
--ลูกค้าบริษัทใด มีการซื้อสินค้าที่มาจากประเทศ USA บ้าง(5ตาราง)
SELECT DISTINCT 
    c.CompanyName
FROM Customers as c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
JOIN [Order Details] od 
    ON o.OrderID = od.OrderID
JOIN Products p 
    ON od.ProductID = p.ProductID
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID
WHERE s.Country = 'USA'
ORDER BY c.CompanyName;