create database oscar_t1;
use oscar_t1;
-- drop database oscar_t1;

create table Category
(
	CategoryID int not null auto_increment,
	CategoryName varchar(50) not null,
    primary key (CategoryID)
);

create table Product
(
	ProductID varchar(50) not null,
    CategoryID int not null auto_increment,
    ProductName varchar(50) not null,
    Color varchar(10),
    Size double,
    Brand varchar(50),
    Price double not null,
    primary key (ProductID),
    foreign key (CategoryID) references Category(CategoryID)
);

create table Stock
(
	StockID int not null auto_increment,
    ProductID varchar(50) not null,
    Quantity int not null,
    primary key (StockID),
    foreign key (ProductID) references Product(ProductID)
);

create table Customer
(
	CustomerID int not null auto_increment,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Country varchar(50) not null,
    City varchar(50) not null,
    Adress varchar(50) not null,
    primary key (CustomerID)
);

create table Orders
(
	OrderID int not null auto_increment,
    CustomerID int not null,
    OrderDate datetime not null,
    primary key (OrderID),
    foreign key (CustomerID) references Customer(CustomerID)
);

create table ProductLine
(
	ProductLineID int not null auto_increment,
    ProductID varchar(50),
    OrderID int not null,
    Quantity int not null,
    primary key (ProductLineID),
    foreign key (ProductID) references Product(ProductID),
    foreign key (OrderID) references Orders(OrderID)
);

create table TestTable
(
	intTest int not null auto_increment,
    varcharTest varchar(50),
    datetimeTest datetime not null,
    doubleTest double,
    primary key (intTest)
);

-- ## STORED PROCEDURED #########################################################

-- getCustomers()
DELIMITER //
CREATE PROCEDURE getCustomers()
	BEGIN
    
    SELECT CustomerID, FirstName, LastName, Country, City, Adress FROM Customer ORDER BY CustomerID ASC, FirstName DESC;
    
    END //
DELIMITER ;

-- insertOrder() ------- OBS OBS OBS CHECK VARCHAR(19)!!!!!
DELIMITER //
CREATE PROCEDURE insertOrder(IN CustomerID int, IN OrderDate VARCHAR(19))
	BEGIN
                      
	insert into Orders (CustomerID, OrderDate) values(CustomerID, OrderDate);
          
	END //				
DELIMITER ;

-- getTestTable()
DELIMITER //
CREATE PROCEDURE getTestTable()
	BEGIN
    
    SELECT intTest, varcharTest, CAST(datetimeTest AS char)  AS DateTimeTest, doubleTest FROM TestTable;
    
    END //
DELIMITER ;