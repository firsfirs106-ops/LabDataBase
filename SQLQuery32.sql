
begin tran
--เพิ่มรายการในตาราง order
Insert into Orders
(CustomerID,EmployeeID,OrderDate,RequiredDate,Freight)
values
('ALFKI',1,GETDATE(),
DATEADD(DAY,7,GETDATE()),50.00);

select SCOPE_IDENTITY() as neworderID;--11078
-- เพิ่มรายการสินค้าในตาราง order detail
insert into [Order Details]
(OrderID,ProductID,UnitPrice,Quantity,Discount)
select 11078,productID,
unitprice,2,0
from Products
where ProductID = 1;
--
insert into [Order Details]
(OrderID,ProductID,UnitPrice,Quantity,Discount)
select 11078,productID,
unitprice,3,0
from Products
where ProductID = 2;
-- ดูข้อมูล
select * from Orders
where OrderID = 11078
--
select * from [Order Details]
where OrderID = 11078;
--commitยืนยันข้อมูลที่จดไป
commit



--part 2 rollback=====================================================================================


begin tran
--เพิ่มรายการในตาราง order
Insert into Orders
(CustomerID,EmployeeID,OrderDate,RequiredDate,Freight)
values
('ALFKI',1,GETDATE(),
DATEADD(DAY,7,GETDATE()),75.00);

select SCOPE_IDENTITY() as RollbackorderID;--11079
-- เพิ่มรายการสินค้าในตาราง order detail

insert into [Order Details]
(OrderID,ProductID,UnitPrice,Quantity,Discount)
select 11079,productID,
unitprice,1,0
from Products
where ProductID = 1;
--
insert into [Order Details]
(OrderID,ProductID,UnitPrice,Quantity,Discount)
select 11079,productID,
unitprice,2,0
from Products
where ProductID = 2;
-- ดูข้อมูล
select * from Orders
where OrderID = 11079
--
select * from [Order Details]
where OrderID = 11079;
--Rollback สิ่งที่ทำ
rollback
