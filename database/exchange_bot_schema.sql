-- MySQL Script generated by MySQL Workbench
-- Sun Jul 16 00:25:12 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema exchange_bot
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exchange_bot
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exchange_bot` DEFAULT CHARACTER SET utf8 ;
USE `exchange_bot` ;

-- -----------------------------------------------------
-- Table `exchange_bot`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(100) NOT NULL,
  `block_status` INT NOT NULL DEFAULT 0,
  `telegram_acc` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NULL,
  `country_id` INT NULL,
  `town_id` INT NULL,
  `sex` INT NULL,
  `birth_date` DATE NULL,
  `name` VARCHAR(100) NULL,
  `surname` VARCHAR(100) NULL,
  `chat_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idusers_UNIQUE` (`id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`user_name` ASC),
  UNIQUE INDEX `chat_id_UNIQUE` (`chat_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`frequency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`frequency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `good_time` TIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idfrequency_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`issuers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`issuers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `short_name` VARCHAR(45) NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `url_stock` VARCHAR(500) NULL,
  `url_price_history` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idsources_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`sources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`sources` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `issuer_id` INT NOT NULL,
  `url` VARCHAR(500) NOT NULL,
  `spider_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`issuer_id` ASC),
  CONSTRAINT `id_issuers_sources`
    FOREIGN KEY (`issuer_id`)
    REFERENCES `exchange_bot`.`issuers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`users_tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`users_tasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `source_id` INT NOT NULL,
  `frequency_id` INT NOT NULL,
  PRIMARY KEY (`id`, `frequency_id`),
  UNIQUE INDEX `idtasks_UNIQUE` (`id` ASC),
  INDEX `fk_users_tasks_frequency1_idx` (`frequency_id` ASC),
  INDEX `fk_users_tasks_users_idx` (`user_id` ASC),
  INDEX `fk_users_tasks_sources_idx` (`source_id` ASC),
  CONSTRAINT `fk_users_tasks_frequency`
    FOREIGN KEY (`frequency_id`)
    REFERENCES `exchange_bot`.`frequency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_tasks_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `exchange_bot`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_tasks_sources`
    FOREIGN KEY (`source_id`)
    REFERENCES `exchange_bot`.`sources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`content_sent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`content_sent` (
  `user_id` INT NOT NULL,
  `content_md5` VARCHAR(32) NOT NULL,
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `userid`
    FOREIGN KEY (`user_id`)
    REFERENCES `exchange_bot`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`brokers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`brokers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `short_name` VARCHAR(45) NOT NULL,
  `full_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idsources_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`currencies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `short_name` VARCHAR(3) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchange_bot`.`deals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_bot`.`deals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `datetime_open` DATETIME NOT NULL,
  `broker_id` INT NULL,
  `issuer_id` INT NOT NULL,
  `direction_long` TINYINT NOT NULL COMMENT 'If long than 1, if short than 0',
  `price_open` DECIMAL(12,6) NOT NULL,
  `price_close` DECIMAL(12,6) NULL,
  `risk_value` DECIMAL(5,2) NULL,
  `comment_open` VARCHAR(500) NULL,
  `comment_close` VARCHAR(500) NULL,
  `currency_id` INT NULL,
  `datetime_close` DATETIME NULL,
  `quantity` DECIMAL(16,6) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`user_id` ASC),
  INDEX `id_idx1` (`broker_id` ASC),
  INDEX `id_idx2` (`issuer_id` ASC),
  INDEX `id_idx3` (`currency_id` ASC),
  CONSTRAINT `id_users_deals`
    FOREIGN KEY (`user_id`)
    REFERENCES `exchange_bot`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_brokers_deals`
    FOREIGN KEY (`broker_id`)
    REFERENCES `exchange_bot`.`brokers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_issuers_deals`
    FOREIGN KEY (`issuer_id`)
    REFERENCES `exchange_bot`.`issuers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_currencies_deals`
    FOREIGN KEY (`currency_id`)
    REFERENCES `exchange_bot`.`currencies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `exchange_bot`;

DELIMITER $$
USE `exchange_bot`$$
CREATE TRIGGER insert_user_task AFTER INSERT ON deals
FOR EACH ROW

BEGIN


	-- Тригер создаёт новое задание на доставку новостей при добавлении сделки (если ранее не создано)
    DECLARE count_user_tasks INT;
    
    SET count_user_tasks = (SELECT count(user_id) FROM users_tasks WHERE user_id = NEW.user_id AND source_id = (SELECT id FROM sources WHERE `sources`.`issuer_id` = NEW.issuer_id LIMIT 1));
    
    IF count_user_tasks < 1 THEN
		INSERT INTO `users_tasks` (`id`, `user_id`, `source_id`, `frequency_id`) VALUES (NULL, NEW.user_id, (SELECT id FROM sources WHERE `sources`.`issuer_id` = NEW.issuer_id LIMIT 1), 1);
	END IF;


END$$


DELIMITER ;
CREATE USER 'parser' IDENTIFIED BY 'shaDOW';

GRANT SELECT, INSERT, TRIGGER ON TABLE `exchange_bot`.* TO 'parser';
CREATE USER 'manager' IDENTIFIED BY 'shaDOW';

GRANT SELECT, INSERT, TRIGGER ON TABLE `exchange_bot`.* TO 'manager';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `exchange_bot`.* TO 'manager';
GRANT EXECUTE ON ROUTINE `exchange_bot`.* TO 'manager';
CREATE USER 'publicator' IDENTIFIED BY 'shaDOW';

GRANT SELECT ON TABLE `exchange_bot`.* TO 'publicator';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
