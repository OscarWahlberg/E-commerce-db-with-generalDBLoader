create database oscar_t1;
use oscar_t1;
-- drop database oscar_t1;

-- TESTTABLE -----------------------------------------------------
CREATE TABLE `oscar_t1`.`testtable` (
  `testTableID` INT NOT NULL AUTO_INCREMENT,
  `testInt` INT NULL,
  `testDouble` DOUBLE NULL,
  `testString` VARCHAR(45) NULL,
  `testDateTime` DATETIME NULL,
  PRIMARY KEY (`testTableID`));

-- insertTestTable() ----------------
DELIMITER // 
CREATE PROCEDURE insertTestTable(IN testInt VARCHAR(45), IN testDouble VARCHAR(45), IN testString VARCHAR(45), IN testDateTime VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`testtable` (testInt, testDouble, testString, testDateTime) values(CONVERT(CONVERT(testInt, DECIMAL), SIGNED INTEGER), CAST(testDouble AS DECIMAL(10,6)), testString, testDateTime);
    END //
DELIMITER ;

-- COMPANY -------------------------------------------------------
CREATE TABLE `oscar_t1`.`company` (
  `CompanyID` INT NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(45) NULL,
  PRIMARY KEY (`CompanyID`));

-- insertCompany() ---------------
DELIMITER // 
CREATE PROCEDURE insertCompany(IN CompanyName VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`company` (CompanyName) values(CompanyName);
    END //
DELIMITER ;

-- SUPPLIER ------------------------------------------------------
CREATE TABLE `oscar_t1`.`supplier` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `CompanyID` INT NOT NULL,
  PRIMARY KEY (`SupplierID`),
  INDEX `Supplier_CompanyID_idx` (`CompanyID` ASC),
  CONSTRAINT
    FOREIGN KEY (`CompanyID`)
    REFERENCES `oscar_t1`.`company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- insertSupplier() ---------------
DELIMITER // 
CREATE PROCEDURE insertSupplier(IN CompanyID VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`supplier` (CompanyID) values(CONVERT(CONVERT(CompanyID, DECIMAL), SIGNED INTEGER));
    END //
DELIMITER ;

-- USER ---------------------------------------------------------
CREATE TABLE `oscar_t1`.`user` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `CompanyID` INT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`UserID`),
  INDEX `User_CompanyID_idx` (`CompanyID` ASC),
  CONSTRAINT
    FOREIGN KEY (`CompanyID`)
    REFERENCES `oscar_t1`.`company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertUser() ---------------
DELIMITER //
CREATE PROCEDURE insertUser(IN companyID VARCHAR(45), IN FirstName VARCHAR(45), IN LastName VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`user` (CompanyID, FirstName, LastName) values(CONVERT(CONVERT(CompanyID, DECIMAL), SIGNED INTEGER), FirstName, LastName);
    END //
DELIMITER ;

-- CUSTOMER -----------------------------------------------------
CREATE TABLE `oscar_t1`.`customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CompanyID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `CompanyID_idx` (`CompanyID` ASC),
  CONSTRAINT
    FOREIGN KEY (`CompanyID`)
    REFERENCES `oscar_t1`.`company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insetCustomer() --------------------
DELIMITER // 
CREATE PROCEDURE insertCustomer(IN CompanyID VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`customer` (CompanyID) values(CONVERT(CONVERT(CompanyID, DECIMAL), SIGNED INTEGER));
    END //
DELIMITER ;

-- ADDRESS -------------------------------------------------------
CREATE TABLE `oscar_t1`.`address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `CompanyID` INT NULL,
  `Country` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `CompanyID_idx` (`CompanyID` ASC),
  CONSTRAINT
    FOREIGN KEY (`CompanyID`)
    REFERENCES `oscar_t1`.`company` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertAddress() --------------
DELIMITER // 
CREATE PROCEDURE insertAddress(IN CompanyID VARCHAR(45), IN Country VARCHAR(45), IN City VARCHAR(45), IN Address VARCHAR(45), IN FirstName VARCHAR(45), IN LastName VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`address` (CompanyID, Country, City, Address, FirstName, LastName) values(CONVERT(CONVERT(CompanyID, DECIMAL), SIGNED INTEGER), Country, City, Address, FirstName, LastName);
    END //
DELIMITER ;

-- CATEGORY ------------------------------------------------------
CREATE TABLE `oscar_t1`.`category` (
  `CategoryID` INT NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CategoryID`));

-- insertCategory() -------------
DELIMITER // 
CREATE PROCEDURE insertCategory(IN CategoryName VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`category` (CategoryName) values(CategoryName);
    END //
DELIMITER ;

-- PRODUCT -----------------------------------------------------
CREATE TABLE `oscar_t1`.`product` (
  `ProductID` VARCHAR(45) NOT NULL,
  `SupplierID` INT NOT NULL,
  `CategoryID` INT NOT NULL,
  `ProductName` VARCHAR(45) NOT NULL,
  `ProductPrice` DOUBLE UNSIGNED NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `SupplierID_idx` (`SupplierID` ASC),
  INDEX `CategoryID_idx` (`CategoryID` ASC),
  CONSTRAINT
    FOREIGN KEY (`SupplierID`)
    REFERENCES `oscar_t1`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`CategoryID`)
    REFERENCES `oscar_t1`.`category` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertProduct() -------------
DELIMITER // 
CREATE PROCEDURE insertProduct(IN ProductID VARCHAR(45), IN SupplierID VARCHAR(45), IN CategoryID VARCHAR(45), IN ProductName VARCHAR(45), IN ProductPrice VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`product` (ProductID, SupplierID, CategoryID, ProductName, ProductPrice) values(ProductID, CONVERT(CONVERT(SupplierID, DECIMAL), SIGNED INTEGER), CONVERT(CONVERT(CategoryID, DECIMAL), SIGNED INTEGER), ProductName, CAST(ProductPrice AS DECIMAL(10,6)));
    END //
DELIMITER ;

-- STOCK ------------------------------------------------------
CREATE TABLE `oscar_t1`.`stock` (
  `StockID` INT NOT NULL AUTO_INCREMENT,
  `ProductID` VARCHAR(45) NOT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`StockID`),
  INDEX `ProductID_idx` (`ProductID` ASC),
  CONSTRAINT
    FOREIGN KEY (`ProductID`)
    REFERENCES `oscar_t1`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertStock() ----------------
DELIMITER // 
CREATE PROCEDURE insertStock(IN ProductID VARCHAR(45), IN Quantity VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`stock` (ProductID, Quantity) values(ProductID, CONVERT(CONVERT(Quantity, DECIMAL), SIGNED INTEGER));
    END //
DELIMITER ;

-- DELIVERYCOMPANY --------------------------------------------
CREATE TABLE `oscar_t1`.`deliverycompany` (
  `DeliveryCompanyID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryCompanyName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeliveryCompanyID`));

-- insertDeliveryCompany() ---------------
DELIMITER // 
CREATE PROCEDURE insertDeliveryCompany(IN DeliveryCompanyName VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`deliverycompany` (DeliveryCompanyName) values(DeliveryCompanyName);
    END //
DELIMITER ;

-- DELIVERYMETHOD ---------------------------------------------
CREATE TABLE `oscar_t1`.`deliverymethod` (
  `DeliveryMethodID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryCompanyID` INT NOT NULL,
  `DeliveryMethodName` VARCHAR(45) NOT NULL,
  `DeliveryTime` INT NOT NULL,
  `DeliveryPrice` DOUBLE UNSIGNED NOT NULL,
  PRIMARY KEY (`DeliveryMethodID`),
  INDEX `DeliveryCompanyID_idx` (`DeliveryCompanyID` ASC),
  CONSTRAINT
    FOREIGN KEY (`DeliveryCompanyID`)
    REFERENCES `oscar_t1`.`deliverycompany` (`DeliveryCompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertDeliveryMethod() ------------
DELIMITER // 
CREATE PROCEDURE insertDeliveryMethod(IN DeliveryCompanyID VARCHAR(45), IN DeliveryMethodName VARCHAR(45), IN DeliveryTime VARCHAR(45), IN DeliveryPrice VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`deliverymethod` (DeliveryCompanyID, DeliveryMethodName, DeliveryTime, DeliveryPrice) values(CONVERT(CONVERT(DeliveryCompanyID, DECIMAL), SIGNED INTEGER), DeliveryMethodName, DeliveryTime, CAST(DeliveryPrice AS DECIMAL(10,6)));
    END //
DELIMITER ;

-- PURCHASEORDER ----------------------------------------------
CREATE TABLE `oscar_t1`.`purchaseorder` (
  `PurchaseOrderID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `SupplierID` INT NOT NULL,
  `PurchaseOrderDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `InvoiceReceived` DATETIME NULL,
  `InvoicePaid` DATETIME NULL,
  `OrderReceived` DATETIME NULL,
  PRIMARY KEY (`PurchaseOrderID`),
  INDEX `SupplierID_idx` (`SupplierID` ASC),
  INDEX `UserID_idx` (`UserID` ASC),
  CONSTRAINT
    FOREIGN KEY (`SupplierID`)
    REFERENCES `oscar_t1`.`supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`UserID`)
    REFERENCES `oscar_t1`.`user` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertPurchaseOrder() -----
DELIMITER // 
CREATE PROCEDURE insertPurchaseOrder(IN UserID VARCHAR(45), IN SupplierID VARCHAR(45), IN PurchaseOrderDate VARCHAR(45), IN InvoiceReceived VARCHAR(45), IN InvoicePaid VARCHAR(45), IN OrderReceived VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`purchaseorder` (UserID, SupplierID, PurchaseOrderDate, InvoiceReceived, InvoicePaid, OrderReceived) values(CONVERT(CONVERT(UserID, DECIMAL), SIGNED INTEGER), CONVERT(CONVERT(SupplierID, DECIMAL), SIGNED INTEGER), PurchaseOrderDate, InvoiceReceived, InvoicePaid, OrderReceived);
    END //
DELIMITER ;

-- POLINE ----------------------------------------------------
CREATE TABLE `oscar_t1`.`poline` (
  `POLineID` INT NOT NULL AUTO_INCREMENT,
  `PurchaseOrderID` INT NOT NULL,
  `ProductID` VARCHAR(45) NOT NULL,
  `Quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`POLineID`),
  INDEX `PurchaseOrdereID_idx` (`PurchaseOrderID` ASC),
  INDEX `ProductID_idx` (`ProductID` ASC),
  CONSTRAINT
    FOREIGN KEY (`PurchaseOrderID`)
    REFERENCES `oscar_t1`.`purchaseorder` (`PurchaseOrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`ProductID`)
    REFERENCES `oscar_t1`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertPOLine() --------
DELIMITER // 
CREATE PROCEDURE insertPOLine(IN PurchaseOrderID VARCHAR(45), IN ProductID VARCHAR(45), IN Quantity VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`poline` (PurchaseOrderID, ProductID, Quantity) values(CONVERT(CONVERT(PurchaseOrderID, DECIMAL), SIGNED INTEGER), ProductID, CONVERT(CONVERT(Quantity, DECIMAL), UNSIGNED INTEGER));
    END //
DELIMITER ;
    
-- SALESORDER ------------------------------------------------
CREATE TABLE `oscar_t1`.`salesorder` (
  `SalesOrderID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `DeliveryMethodID` INT NOT NULL,
  `DeliveryAddressID` INT NOT NULL,
  `BillingAddressID` INT NOT NULL,
  `SalesOrderDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `InvoiceSent` DATETIME NULL,
  `InvoicePaid` DATETIME NULL,
  `OrderSent` DATETIME NULL,
  PRIMARY KEY (`SalesOrderID`),
  INDEX `UserID_idx` (`UserID` ASC),
  INDEX `CustomerID_idx` (`CustomerID` ASC),
  INDEX `DeliveryMethodID_idx` (`DeliveryMethodID` ASC),
  CONSTRAINT
    FOREIGN KEY (`UserID`)
    REFERENCES `oscar_t1`.`user` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`CustomerID`)
    REFERENCES `oscar_t1`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`DeliveryMethodID`)
    REFERENCES `oscar_t1`.`deliverymethod` (`DeliveryMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertSalesOrder() -----
DELIMITER // 
CREATE PROCEDURE insertSalesOrder(IN UserID VARCHAR(45), IN CustomerID VARCHAR(45), IN DeliveryMethodID VARCHAR(45), IN DeliveryAddressID VARCHAR(45), IN BillingAddressID VARCHAR(45), IN SalesOrderDate VARCHAR(45), IN InvoiceSent VARCHAR(45), IN InvoicePaid VARCHAR(45), IN OrderSent VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`salesorder` (UserID, CustomerID, DeliveryMethodID, DeliveryAddressID, BillingAddressID, SalesOrderDate, InvoiceSent, InvoicePaid, OrderSent) values(CONVERT(CONVERT(UserID, DECIMAL), SIGNED INTEGER), CONVERT(CONVERT(CustomerID, DECIMAL), SIGNED INTEGER), CONVERT(CONVERT(DeliveryMethodID, DECIMAL), SIGNED INTEGER), CONVERT(CONVERT(DeliveryAddressID, DECIMAL), SIGNED INTEGER), CONVERT(CONVERT(BillingAddressID, DECIMAL), SIGNED INTEGER), SalesOrderDate, InvoiceSent, InvoicePaid, OrderSent);
    END //
DELIMITER ;

-- SOLINE ----------------------------------------------------
CREATE TABLE `oscar_t1`.`soline` (
  `SOLineID` INT NOT NULL AUTO_INCREMENT,
  `SalesOrderID` INT NOT NULL,
  `ProductID` VARCHAR(45) NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`SOLineID`),
  INDEX `ProductID_idx` (`ProductID` ASC),
  INDEX `SalesOrderID_idx` (`SalesOrderID` ASC),
  CONSTRAINT
    FOREIGN KEY (`ProductID`)
    REFERENCES `oscar_t1`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT
    FOREIGN KEY (`SalesOrderID`)
    REFERENCES `oscar_t1`.`salesorder` (`SalesOrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- insertSOLine() --------
DELIMITER // 
CREATE PROCEDURE insertSOLine(IN SalesOrderID VARCHAR(45), IN ProductID VARCHAR(45), IN Quantity VARCHAR(45))
	BEGIN
		insert into `oscar_t1`.`soline` (SalesOrderID, ProductID, Quantity) values(CONVERT(CONVERT(SalesOrderID, DECIMAL), SIGNED INTEGER), ProductID, CONVERT(CONVERT(Quantity, DECIMAL), UNSIGNED INTEGER));
    END //
DELIMITER ;
