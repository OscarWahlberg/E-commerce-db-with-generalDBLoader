-- Categorys ---------------------------------------------------------------------
-- insert into Category (CategoryName) values('');
insert into Category (CategoryName) values('Weapons');
insert into Category (CategoryName) values('Bandages');
insert into Category (CategoryName) values('Flowers');
insert into Category (CategoryName) values('Fertilizer');

-- Products ----------------------------------------------------------------------
-- insert into Product (ProductID, CategoryID, ProductName, Color, Size, Brand, Price) values('', 0, '', '', 0, '', 0);
insert into Product (ProductID, CategoryID, ProductName, Color, Size, Brand, Price) 
	values('AK47000001', 1, 'AK-47', 'Black+Wood', 7.62, 'Michail Kalasjnikov', 249);
    
insert into Product (ProductID, CategoryID, ProductName, Color, Size, Brand, Price) 
	values('M2CG000001', 1, 'Carl Gustaf recoilless rifle', 'Green', 84, 'Saab Bofors Dynamics', 2390);

insert into Product (ProductID, CategoryID, ProductName, Color, Size, Brand, Price)
	values('FAK1000001', 2, 'First Aid Kit', 'Red+White', 150, 'Red Cross', 14.9);

insert into Product (ProductID, CategoryID, ProductName, Color, Size, Brand, Price)
	values('PERG000001', 3, 'Petunia', 'Red+Green', 20, 'Mr GreenThumb Productions', 0);
    
insert into Product (ProductID, CategoryID, ProductName, Color, Size, Brand, Price)
	values('MBF0000001', 4, 'Magic Blossom Fertilizer', 'Compost', 50, 'Dunghill Inc', 13.9);

-- Stock -------------------------------------------------------------------------
-- insert into Stock (ProductID, Quantity) values('', 0);
insert into Stock (ProductID, Quantity) values('AK47000001', 5);
insert into Stock (ProductID, Quantity) values('M2CG000001', 3);
insert into Stock (ProductID, Quantity) values('FAK1000001', 2);
insert into Stock (ProductID, Quantity) values('PERG000001', 7);
insert into Stock (ProductID, Quantity) values('MBF0000001', 100);

-- Customer -----------------------------------------------------------------------
-- insert into Customer (FirstName, LastName, Country, City, Adress) values();
insert into Customer (FirstName, LastName, Country, City, Adress)
	values('Bobbie', 'Brown', 'North America', 'Alabama', 'Alabama Street 13');
insert into Customer (FirstName, LastName, Country, City, Adress)
	values('Watson', 'Holmes', 'Great Brittain', 'London', '221B Baker Street');
insert into Customer (FirstName, LastName, Country, City, Adress)
	values('Svenne', 'Svensson', 'Sweden', 'Stockholm', 'Blåsippegränd 9');


-- Orders --------------------------------------------------------------------------
-- insert into Orders (CustomerID, OrderDate) values(1, '2016-09-20 00:00:00');

insert into Orders (CustomerID, OrderDate) values(1, '2016-09-20 00:00:00');
insert into Orders (CustomerID, OrderDate) values(2, '2016-09-23 00:00:00');
insert into Orders (CustomerID, OrderDate) values(3, '2016-09-26 00:00:00');
insert into Orders (CustomerID, OrderDate) values(1, '2016-09-25 00:00:00');

-- ProductLine ---------------------------------------------------------------------
-- insert into ProductLine(ProductID, OrderID, Quantity) values(1, 2, 3);

-- Bobbie nr1
insert into ProductLine(ProductID, OrderID, Quantity) values('AK47000001', 1, 2);
insert into ProductLine(ProductID, OrderID, Quantity) values('M2CG000001', 1, 1);

-- Watson
insert into ProductLine(ProductID, OrderID, Quantity) values('PERG000001', 2, 3);
insert into ProductLine(ProductID, OrderID, Quantity) values('MBF0000001', 2, 1);

-- Svenne
insert into ProductLine(ProductID, OrderID, Quantity) values('PERG000001', 3, 2);
insert into ProductLine(ProductID, OrderID, Quantity) values('FAK1000001', 3, 1);
insert into ProductLine(ProductID, OrderID, Quantity) values('M2CG000001', 3, 1);

-- Bobbie nr2
insert into ProductLine(ProductID, OrderID, Quantity) values('FAK1000001', 4, 1);

-- TEST-TABLE-DATA ---------------------------------------------------------------
insert into TestTable(varcharTest, datetimeTest, doubleTest) values('varcharTestData1', '2016-09-20 00:00:00', 5.2);





