CREATE DATABASE gravity_books_DWH;
GO

USE gravity_books_DWH;
GO

-- 1. Author_Dim
CREATE TABLE Author_Dim (
    Author_SK    INT PRIMARY KEY IDENTITY(1,1),
    Author_BK    INT,
    Author_Name  VARCHAR(200)
);

-- 2. Book_Dim
CREATE TABLE Book_Dim (
    Book_SK          INT PRIMARY KEY IDENTITY(1,1),
    Book_BK          INT,
    ISBN13           VARCHAR(50),
    Title            VARCHAR(500),
    Num_Pages        INT,
    Publication_Date DATE,
    
    -- Language --
    Language_BK      INT,
    Language_Code    VARCHAR(10),
    Language_Name    VARCHAR(100),
    
    -- Publisher --
    Publisher_BK     INT,
    Publisher_Name   VARCHAR(200),

    -- SCD Type 2 --
    Start_Date       DATE,
    End_Date         DATE,
    Is_Current       BIT
);

-- 3. Bridge_Book_Author
CREATE TABLE Bridge_Book_Author (
    Book_SK    INT FOREIGN KEY REFERENCES Book_Dim(Book_SK),
    Author_SK  INT FOREIGN KEY REFERENCES Author_Dim(Author_SK)
);

-- 4. Customer_Dim
CREATE TABLE Customer_Dim (
    Customer_SK  INT PRIMARY KEY IDENTITY(1,1),
    Customer_BK  INT,
    First_Name   VARCHAR(100),
    Last_Name    VARCHAR(100),
    Email        VARCHAR(200),

    -- SCD Type 2
    Start_Date   DATE,
    End_Date     DATE,
    Is_Current   BIT
);

-- 5. Address_Dim
CREATE TABLE Address_Dim (
    Address_SK     INT PRIMARY KEY IDENTITY(1,1),
    Address_BK     INT,
    Street_Number  VARCHAR(50),
    Street_Name    VARCHAR(200),
    City           VARCHAR(100),
    Country_BK     INT,
    Country_Name   VARCHAR(100),
    Status_Name    VARCHAR(50),

    -- SCD Type 2
    Start_Date     DATE,
    End_Date       DATE,
    Is_Current     BIT
);

-- 6. Shipping_Method_Dim
CREATE TABLE Shipping_Method_Dim (
    Shipping_Method_SK  INT PRIMARY KEY IDENTITY(1,1),
    Shipping_Method_BK  INT,
    Method_Name         VARCHAR(100),
    Cost                DECIMAL(10,2)
);

-- 7. Order_Status_Dim
CREATE TABLE Order_Status_Dim (
    Order_Status_SK  INT PRIMARY KEY IDENTITY(1,1),
    Status_BK        INT,
    Status_Value     VARCHAR(100)
);

-- 8. Date_Dim
CREATE TABLE Date_Dim (
    Date_SK       INT PRIMARY KEY IDENTITY(1,1),
    Full_Date     DATE,
    Day_Of_Month  INT,
    Day_Name      VARCHAR(20),
    Month_Num     INT,
    Month_Name    VARCHAR(20),
    Quarter_Num   INT,
    Year_Num      INT,
    Is_Weekend    BIT
);

--------------------------------------------------

USE gravity_books_DWH;

ALTER TABLE Book_Dim 
ALTER COLUMN Title VARCHAR(400);

ALTER TABLE Book_Dim 
ALTER COLUMN ISBN13 VARCHAR(13);

ALTER TABLE Book_Dim 
ALTER COLUMN Language_Code VARCHAR(8);

ALTER TABLE Book_Dim 
ALTER COLUMN Language_Name VARCHAR(50);

ALTER TABLE Book_Dim 
ALTER COLUMN Publisher_Name NVARCHAR(1000);

--------------------------------------------------

ALTER TABLE gravity_books_DWH.dbo.Address_Dim
ADD Status_BK INT;

--------------------------------------------------

ALTER TABLE gravity_books_DWH.dbo.Address_Dim
ALTER COLUMN Start_Date DATETIME;

ALTER TABLE gravity_books_DWH.dbo.Address_Dim
ALTER COLUMN End_Date DATETIME;

--------------------------------------------------

ALTER TABLE Customer_Dim
ALTER COLUMN Start_Date DATETIME;

ALTER TABLE Customer_Dim
ALTER COLUMN End_Date DATETIME;

--------------------------------------------------

ALTER TABLE gravity_books_DWH.dbo.Fact_Sales
DROP COLUMN Quantity;

--------------------------------------------------

USE gravity_books_DWH;

ALTER TABLE Date_Dim
ALTER COLUMN Full_Date DATETIME;