SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `StoreProject` DEFAULT CHARACTER SET utf8 ;
USE `StoreProject` ;



-- `Store`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Store` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Boss_Employee_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Store_Boss1_idx` (`Boss_Employee_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Store_Boss1`
    FOREIGN KEY (`Boss_Employee_ID`)
    REFERENCES `StoreProject`.`Boss` (`Employee_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Store( Boss_Employee_ID)
	VALUES
    (1);
    


-- `Ware`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Ware` (
  `WID` INT NOT NULL AUTO_INCREMENT,
  `Discount` DECIMAL(2,0) NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  `Store_ID` INT NOT NULL,
  `Price` INT NOT NULL,
  PRIMARY KEY (`WID`, `Store_ID`),
  UNIQUE INDEX `WID_UNIQUE` (`WID` ASC) VISIBLE,
  INDEX `fk_Ware_Store1_idx` (`Store_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Ware_Store1`
    FOREIGN KEY (`Store_ID`)
    REFERENCES `StoreProject`.`Store` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Ware( Discount, Name, Store_ID, Price)
	VALUES
    ( 80, 'Solardom1', 1, 50000),
    ( 0, 'Stove1', 1, 60000),
    ( 75, 'VacuumCleaner1', 1, 70000),
    ( 33, 'Laundry1', 1, 80000),
    ( 99, 'DishWasher1', 1, 90000),
    ( 0, 'Television1', 1, 90000),
    ( 0, 'Solardom2', 1, 50000),
    ( 0, 'Stove2', 1, 60000),
    ( 0, 'VacuumCleaner2', 1, 70000),
    ( 40, 'Laundry2', 1, 80000),
    ( 50, 'DishWasher2', 1, 90000),
    ( 0, 'Television1', 1, 90000),
    ( 0, 'Solardom3', 1, 50000),
    ( 0, 'Stove3', 1, 60000),
    ( 42, 'VacuumCleaner3', 1, 70000),
    ( 76, 'Laundry3', 1, 80000),
    ( 95, 'DishWasher3', 1, 90000),
    ( 85, 'Television1', 1, 90000);



-- `Employee`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Employee` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `Birth_Date` DATE NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Store_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Employee_Store1_idx` (`Store_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Store1`
    FOREIGN KEY (`Store_ID`)
    REFERENCES `StoreProject`.`Store` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Employee( Name, Birth_Date, Address, Store_ID)
	VALUES
    ( 'Ali', '1380-12-11', 'Daneshjoo 1 Pelak 10', 1),
    ( 'Mohammad', '1380-1-1', 'Daneshjoo 2 Pelak 20', 1),
    ( 'Reza', '1380-1-2', 'Daneshjoo 3 Pelak 30', 1),
    ( 'Mahdi', '2022-1-2', 'Daneshjoo 4 Pelak 40', 1),
    ( 'Amir', '1380-1-5', 'Daneshjoo 5 Pelak 50', 1);



-- `Boss`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Boss` (
  `Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  CONSTRAINT `fk_Boss_Employee1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `StoreProject`.`Employee` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Boss(Employee_ID)
	VALUES
    (4);



-- `Customer`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Customer` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  `Store_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `idcustomer_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Customer_Store1_idx` (`Store_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Store1`
    FOREIGN KEY (`Store_ID`)
    REFERENCES `StoreProject`.`Store` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Customer( Name, Store_ID)
	value
    ( 'Maryam', 1),
    ( 'Fateme', 1),
    ( 'Zeynab', 1),
    ( 'Sara', 1),
    ( 'Zahra', 1);



-- `Cart`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Cart` (
  `CID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NULL,
  `Total_Price` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  PRIMARY KEY (`CID`),
  UNIQUE INDEX `CID_UNIQUE` (`CID` ASC) VISIBLE,
  INDEX `fk_Cart_Customer1_idx` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Cart_Customer1`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `StoreProject`.`Customer` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Cart( Name, Total_Price, Customer_ID)
	VALUE
    ( 'A', 10000, 1),
    ( 'B', 20000, 1),
    ( 'C', 30000, 1),
    ( 'D', 40000, 1),
    ( 'E', 50000, 1);



-- `Provider`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Provider` (
  `PID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`PID`),
  UNIQUE INDEX `PID_UNIQUE` (`PID` ASC) VISIBLE)
;
INSERT INTO Provider( Name)
	VALUE
    ( 'LG'),
    ( 'Emersan'),
    ( 'Bimax'),
    ( 'Bosch'),
    ( 'Philips');



-- `Normal_Employee`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Normal_Employee` (
  `Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  CONSTRAINT `fk_Normal_Employee_Employee1`
    FOREIGN KEY (`Employee_ID`)
    REFERENCES `StoreProject`.`Employee` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Normal_Employee(Employee_ID)
	VALUE
    (1),
    (2),
    (3),
    (5);



-- `Profile`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Profile` (
  `PID` INT NOT NULL AUTO_INCREMENT,
  `Address` VARCHAR(45) NULL,
  `Phone_Number` NVARCHAR(11) NOT NULL,
  `Birth_Date` DATE NOT NULL,
  `Customer_ID` INT NOT NULL,
  PRIMARY KEY (`PID`),
  UNIQUE INDEX `ID_UNIQUE` (`PID` ASC) VISIBLE,
  INDEX `fk_Profile_Customer1_idx` (`Customer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Profile_Customer1`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `StoreProject`.`Customer` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Profile( Address, Phone_Number, Birth_Date, Customer_ID)
	VALUE
    ( 'Bahonar 1 Pelak 100', '09152022285',  '2022-12-5', 1),
    ( 'Bahonar 2 Pelak 200', '09152022286',  '2022-12-9', 2),
    ( 'Bahonar 3 Pelak 300', '09152022287',  '2022-12-8', 3),
    ( 'Bahonar 4 Pelak 400', '09152022288',  '2022-12-7', 4),
    ( 'Bahonar 5 Pelak 500', '09152022289', '2022-12-6', 5);



-- `Bill`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Bill` (
  `BID` INT NOT NULL AUTO_INCREMENT,
  `Total_Price` INT NOT NULL,
  `Is_Paid` BIT(1) NOT NULL,
  `Cart_CID` INT NOT NULL,
  PRIMARY KEY (`BID`),
  UNIQUE INDEX `BID_UNIQUE` (`BID` ASC) VISIBLE,
  INDEX `fk_Bill_Cart1_idx` (`Cart_CID` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Cart1`
    FOREIGN KEY (`Cart_CID`)
    REFERENCES `StoreProject`.`Cart` (`CID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Bill( Total_Price, Is_Paid, Cart_CID)
	VALUE
    ( 15100, TRUE, 5),
    ( 16200, FALSE, 1),
    ( 17300, TRUE, 2),
    ( 18400, FALSE, 3),
    ( 19500, TRUE, 4);



-- `Date_Price`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Date_Price` (
  `Date` DATE NOT NULL,
  `Price` INT NOT NULL,
  `Ware_WID` INT NOT NULL,
  PRIMARY KEY (`Date`, `Ware_WID`),
  INDEX `fk_Date_Price_Ware1_idx` (`Ware_WID` ASC) VISIBLE,
  CONSTRAINT `fk_Date_Price_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Date_Price(Date, Price, Ware_WID)
	VALUE
    ('2022-12-5', 150000, 1),
    ('2022-12-6', 300000, 1),
    ('2022-12-7', 450000, 2),
    ('2022-12-8', 600000, 2),
    ('2022-12-9', 750000, 4);



-- `Solardom`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Solardom` (
  `Ware_WID` INT NOT NULL,
  `Instructions` VARCHAR(1) NULL,
  PRIMARY KEY (`Ware_WID`),
  CONSTRAINT `fk_Solardom_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Solardom(Ware_WID, Instructions)
	VALUE
    (1, 'A'),
    (7, 'B'),
    (13, 'C');



-- `Stove`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Stove` (
  `Ware_WID` INT NOT NULL,
  `Number_Of_Burner` INT NULL,
  PRIMARY KEY (`Ware_WID`),
  CONSTRAINT `fk_Stove_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Stove(Ware_WID, Number_Of_Burner)
	VALUE
    (2, 5),
    (8, 4),
    (14, 5);



-- `VacuumCleaner`
CREATE TABLE IF NOT EXISTS `StoreProject`.`VacuumCleaner` (
  `Ware_WID` INT NOT NULL,
  `Power` INT NULL,
  PRIMARY KEY (`Ware_WID`),
  CONSTRAINT `fk_VacuumCleaner_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO VacuumCleaner(Ware_WID, Power)
	VALUE
    (3, 1000),
    (9, 2000),
    (15, 1000);



-- `Laundry`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Laundry` (
  `Ware_WID` INT NOT NULL,
  `Engine_Power` INT NULL,
  `Cold_Water` BIT(1) NULL,
  PRIMARY KEY (`Ware_WID`),
  CONSTRAINT `fk_Laundry_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Laundry(Ware_WID, Engine_Power, Cold_Water)
	VALUE
    (4, 3500, TRUE),
    (10, 6500, FALSE),
    (16, 7500, FALSE);



-- `DishWasher`
CREATE TABLE IF NOT EXISTS `StoreProject`.`DishWasher` (
  `Ware_WID` INT NOT NULL,
  `Instructions` VARCHAR(1) NULL,
  `Metals_Support` BIT(1) NULL,
  PRIMARY KEY (`Ware_WID`),
  CONSTRAINT `fk_DishWasher_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO DishWasher(Ware_WID, Instructions, Metals_Support)
	VALUE
    (5, 'Z', TRUE),
    (11, 'V', FALSE),
    (17, 'B', TRUE);



-- `Television`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Television` (
  `Ware_WID` INT NOT NULL,
  `Screen_Szie` INT NULL,
  PRIMARY KEY (`Ware_WID`),
  CONSTRAINT `fk_Television_Ware1`
    FOREIGN KEY (`Ware_WID`)
    REFERENCES `StoreProject`.`Ware` (`WID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Television(Ware_WID, Screen_Szie)
	VALUE
    (6, 60),
    (12, 65),
    (18, 55);



-- `Ware_has_Cart`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Ware_has_Cart` (
  `Ware_WID` INT NOT NULL,
  `Ware_Store_ID` INT NOT NULL,
  `Cart_CID` INT NOT NULL,
  `Count` INT NOT NULL,
  PRIMARY KEY (`Ware_WID`, `Ware_Store_ID`, `Cart_CID`),
  INDEX `fk_Ware_has_Cart_Cart1_idx` (`Cart_CID` ASC) VISIBLE,
  INDEX `fk_Ware_has_Cart_Ware1_idx` (`Ware_WID` ASC, `Ware_Store_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Ware_has_Cart_Ware1`
    FOREIGN KEY (`Ware_WID` , `Ware_Store_ID`)
    REFERENCES `StoreProject`.`Ware` (`WID` , `Store_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ware_has_Cart_Cart1`
    FOREIGN KEY (`Cart_CID`)
    REFERENCES `StoreProject`.`Cart` (`CID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Ware_has_Cart(Ware_WID, Ware_Store_ID, Cart_CID, Count)
	VALUE
    (1, 1, 2, 10),
    (3, 1, 4, 15),
    (5, 1, 1, 20),
    (12, 1, 2, 25),
    (6, 1, 5, 30);



-- `Provider_has_Ware`
CREATE TABLE IF NOT EXISTS `StoreProject`.`Provider_has_Ware` (
  `Provider_PID` INT NOT NULL,
  `Ware_WID` INT NOT NULL,
  `Ware_Store_ID` INT NOT NULL,
  PRIMARY KEY (`Provider_PID`, `Ware_WID`, `Ware_Store_ID`),
  INDEX `fk_Provider_has_Ware_Ware1_idx` (`Ware_WID` ASC, `Ware_Store_ID` ASC) VISIBLE,
  INDEX `fk_Provider_has_Ware_Provider1_idx` (`Provider_PID` ASC) VISIBLE,
  CONSTRAINT `fk_Provider_has_Ware_Provider1`
    FOREIGN KEY (`Provider_PID`)
    REFERENCES `StoreProject`.`Provider` (`PID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Provider_has_Ware_Ware1`
    FOREIGN KEY (`Ware_WID` , `Ware_Store_ID`)
    REFERENCES `StoreProject`.`Ware` (`WID` , `Store_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;
INSERT INTO Provider_has_Ware(Provider_PID, Ware_WID, Ware_Store_ID)
	VALUE
    (1, 6, 1),
    (2, 12, 1),
    (2, 7, 1),
    (3, 2, 1),
    (4, 2, 1);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;