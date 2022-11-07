-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mary_maffot
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mary_maffot
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mary_maffot` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mary_maffot` ;

-- -----------------------------------------------------
-- Table `mary_maffot`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`order_status` (
  `status_id` INT NOT NULL,
  `order_statuscol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`user` (
  `iduser` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` INT(9) NOT NULL,
  PRIMARY KEY (`iduser`, `password`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`Payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`Payment_method` (
  `idPayment_method` INT NOT NULL,
  `payment_type_id` INT NOT NULL,
  `user_iduser` INT NOT NULL,
  `provider` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPayment_method`, `payment_type_id`, `user_iduser`),
  INDEX `fk_Payment_method_user1_idx` (`user_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_method_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mary_maffot`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`shipping_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`shipping_method` (
  `idshipping_method` INT NOT NULL,
  `shipping_price` DOUBLE NOT NULL,
  `shipping_type` TINYINT NOT NULL,
  PRIMARY KEY (`idshipping_method`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`address` (
  `addressid` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`addressid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`shop_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`shop_order` (
  `shop_orderid` INT NOT NULL,
  `status_id` INT NOT NULL,
  `Payment_method_id` INT NOT NULL,
  `payment_type_id` INT NOT NULL,
  `userid` INT NOT NULL,
  `shipping_method_id` INT NOT NULL,
  `addressid` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `total` DOUBLE NOT NULL,
  PRIMARY KEY (`shop_orderid`, `status_id`, `Payment_method_id`, `payment_type_id`, `userid`, `shipping_method_id`, `addressid`),
  INDEX `fk_shop_order_order_status1_idx` (`status_id` ASC) VISIBLE,
  INDEX `fk_shop_order_Payment_method1_idx` (`Payment_method_id` ASC, `payment_type_id` ASC, `userid` ASC) VISIBLE,
  INDEX `fk_shop_order_shipping_method1_idx` (`shipping_method_id` ASC) VISIBLE,
  INDEX `fk_shop_order_address1_idx` (`addressid` ASC) VISIBLE,
  CONSTRAINT `fk_shop_order_order_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `mary_maffot`.`order_status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shop_order_Payment_method1`
    FOREIGN KEY (`Payment_method_id` , `payment_type_id` , `userid`)
    REFERENCES `mary_maffot`.`Payment_method` (`idPayment_method` , `payment_type_id` , `user_iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shop_order_shipping_method1`
    FOREIGN KEY (`shipping_method_id`)
    REFERENCES `mary_maffot`.`shipping_method` (`idshipping_method`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shop_order_address1`
    FOREIGN KEY (`addressid`)
    REFERENCES `mary_maffot`.`address` (`addressid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`category` (
  `categoryid` INT NOT NULL,
  `category name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoryid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`item` (
  `itemid` INT NOT NULL,
  `categoryid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `image` VARCHAR(45) NULL,
  PRIMARY KEY (`itemid`, `categoryid`),
  INDEX `fk_item_category1_idx` (`categoryid` ASC) VISIBLE,
  CONSTRAINT `fk_item_category1`
    FOREIGN KEY (`categoryid`)
    REFERENCES `mary_maffot`.`category` (`categoryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`order_line` (
  `idorder_line` INT NOT NULL,
  `orderid` INT NOT NULL,
  `itemid` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`idorder_line`, `orderid`, `itemid`),
  INDEX `fk_order_line_shop_order1_idx` (`orderid` ASC) VISIBLE,
  INDEX `fk_order_line_item1_idx` (`itemid` ASC) VISIBLE,
  CONSTRAINT `fk_order_line_shop_order1`
    FOREIGN KEY (`orderid`)
    REFERENCES `mary_maffot`.`shop_order` (`shop_orderid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_line_item1`
    FOREIGN KEY (`itemid`)
    REFERENCES `mary_maffot`.`item` (`itemid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`cart` (
  `cartid` INT NOT NULL,
  `userid` INT NOT NULL,
  PRIMARY KEY (`cartid`, `userid`),
  INDEX `fk_cart_user1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_cart_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `mary_maffot`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`shopping_cart_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`shopping_cart_items` (
  `idshopping_cart_items` INT NOT NULL,
  `cartid` INT NOT NULL,
  `itemid` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`idshopping_cart_items`, `cartid`, `itemid`),
  INDEX `fk_shopping_cart_items_cart_idx` (`cartid` ASC) VISIBLE,
  INDEX `fk_shopping_cart_items_item1_idx` (`itemid` ASC) VISIBLE,
  CONSTRAINT `fk_shopping_cart_items_cart`
    FOREIGN KEY (`cartid`)
    REFERENCES `mary_maffot`.`cart` (`cartid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shopping_cart_items_item1`
    FOREIGN KEY (`itemid`)
    REFERENCES `mary_maffot`.`item` (`itemid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mary_maffot`.`user_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mary_maffot`.`user_address` (
  `iduser` INT NOT NULL,
  `addressid` INT NOT NULL,
  PRIMARY KEY (`iduser`, `addressid`),
  INDEX `fk_user_address_user1_idx` (`iduser` ASC) VISIBLE,
  INDEX `fk_user_address_address1_idx` (`addressid` ASC) VISIBLE,
  CONSTRAINT `fk_user_address_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `mary_maffot`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_address_address1`
    FOREIGN KEY (`addressid`)
    REFERENCES `mary_maffot`.`address` (`addressid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
