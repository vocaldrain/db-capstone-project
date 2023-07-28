-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db-capstone-project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-capstone-project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-capstone-project` ;
USE `db-capstone-project` ;

-- -----------------------------------------------------
-- Table `db-capstone-project`.`CustomerDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`CustomerDetails` (
  `CustomerID` INT NOT NULL,
  `Name` INT NULL,
  `ContactDetails` VARCHAR(45) NULL,
  `OrderID` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Customer` (
  `CustomerID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `CustomerDetails_CustomerID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_Customer_CustomerDetails1_idx` (`CustomerDetails_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_CustomerDetails1`
    FOREIGN KEY (`CustomerDetails_CustomerID`)
    REFERENCES `db-capstone-project`.`CustomerDetails` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Bookings` (
  `BookingId` INT NOT NULL,
  `CustomerID` INT NULL,
  `TableNumber` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingId`),
  INDEX `fk_Bookings_Customer1_idx` (`Customer_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `db-capstone-project`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATETIME NULL,
  `TotalCost` DECIMAL NULL,
  `Quantity` INT NULL,
  `CustomerID` INT NULL,
  `MenuID` INT NULL,
  `Customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Customer1_idx` (`Customer_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `db-capstone-project`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`OrderDeliveryStatus` (
  `OrderID` INT NOT NULL,
  `DeliveryDate` VARCHAR(45) NULL,
  `Status` VARCHAR(45) NULL,
  `Orders_OrderID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_OrderStatus_Orders_idx` (`Orders_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderStatus_Orders`
    FOREIGN KEY (`Orders_OrderID`)
    REFERENCES `db-capstone-project`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Menu` (
  `MenuID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Cuisine` VARCHAR(45) NULL,
  `Orders_OrderID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_Menu_Orders1_idx` (`Orders_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Orders1`
    FOREIGN KEY (`Orders_OrderID`)
    REFERENCES `db-capstone-project`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Role` (
  `RoleID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`RoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Staff` (
  `idStaff` INT NOT NULL,
  `StaffID` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Salary` VARCHAR(45) NULL,
  `RoleID` INT NULL,
  `Role_RoleID` INT NOT NULL,
  `OrderDeliveryStatus_OrderID` INT NOT NULL,
  PRIMARY KEY (`idStaff`),
  INDEX `fk_Staff_Role1_idx` (`Role_RoleID` ASC) VISIBLE,
  INDEX `fk_Staff_OrderDeliveryStatus1_idx` (`OrderDeliveryStatus_OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Role1`
    FOREIGN KEY (`Role_RoleID`)
    REFERENCES `db-capstone-project`.`Role` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Staff_OrderDeliveryStatus1`
    FOREIGN KEY (`OrderDeliveryStatus_OrderID`)
    REFERENCES `db-capstone-project`.`OrderDeliveryStatus` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
