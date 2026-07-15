--สร้างฐานข้อมูล ใส่ชื่อ

Create database Myminimart
-------------------------------
Create table Employees(
	EmployeeID	int identity(1,1) Primary Key,
	Title		varchar(20),
	FirstName	varchar(50) not null,
	LastName	varchar(50),
	Position	varchar(50),
	Username	varchar(50) Unique,
	PasswordHash varchar(255) not null,
	IsActive Bit not null Default 1
)
----------------------------------
Insert into Employees (
	Title, FirstName, LastName,
	Position, Username, PasswordHash)
Values(
'นางสาว', 'เต้', 'บุญขันธ์', 'Sale Manager', 'User2'
, 'hashed1');
--ดูข้อมูลเพิ่มเติม
Select * from Employees


drop table Employees --waning**

----------------------------
Alter Database Myminimart
Collate Thai_CI_AS;

--สร้างตารางหมวดหมู่สินค้า

Create Table Categories(
	CategoryID INT Identity(1,1) Primary Key,
	CategoryName Varchar(50) not null Unique,
	Discription varchar(200)
)
--หลังจากสร้างตารางแล้ว เพิ่มข้อมูล 5 หมวดหมู่จามสไลด์ ยีงไม่ต้องใส่รายละเอียดก็ได้
--เครื่องปรุง, เครื่องดื่มเย็น, อาหารสำเร็จรูป, เครื่องสำอาง, เวชภัณฑ์
Insert into Categories(CategoryName) values ('เครื่องปรุง')
Insert into Categories(CategoryName) values ('เครื่องดื่มเย็น')
Insert into Categories(CategoryName) values ('อาหารสำเร็จรูป')
Insert into Categories(CategoryName) values ('เครื่องสำอาง')
Insert into Categories(CategoryName) values ('เวชภัณฑ์')
--ดูข้อมูล
Select * from Categories
--สร้างตารางสินค้าที่มีข้อกำหนดหลายอย่าง โดยเฉพาะ FK
Create Table Products(
	ProductID varchar(13) Primary KEY,
	productName varchar(100) not null,
	unitPrice Decimal(10,2)not null Default 0,
	UnitsInstock int Not null Default 0,
	CategoryID Int not null,
	Discontinued Bit not null Default 0,

	Constraint CK_Products_unitprice
		Check (UnitPrice >= 0),

	Constraint CK_Products_UnitInStock
		Check (UnitsInstock >= 0),

	Constraint FK_Products_Categories
		Foreign Key (CategoryID)
		References Categories(CategoryID)
);
-----------------------
select * from Products
--------------------------------
Insert into Products
	(ProductID, productName, unitPrice, UnitsInstock, CategoryID)
	Values(
		'8858757001948', 'โค้ก', 15.00, 290, 1
	);
	----------------------------------------
	Insert into Products
	(ProductID, productName, unitPrice, UnitsInstock, CategoryID)
	Values(
		'8858757001949', 'โค้ก', 15.00, 20, 1
	);

	select * from Products
	
	
	-----------------------------------------------------
	CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);
---------------------------------------------------------
INSERT INTO Receipts
    (EmployeeID, TotalCash)
VALUES
    (1, 115.00);

SELECT *
FROM Receipts;
----------------------------------------------------------
CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
----------------------------------------------------
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 3);
----------------------------------------------------
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 0);
-----------------------------------------------------
SELECT *
FROM Details;