-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DA TE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- ----------------------------------------------------- -- Schema mydb
-- ----------------------------------------------------- -- ----------------------------------------------------- -- Schema gym
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema gym
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gym` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `gym` ;
-- -----------------------------------------------------
-- Table `gym`.`gym_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`gym_member` (
`member_id` INT NOT NULL AUTO_INCREMENT, `first_name` VARCHAR(100) NOT NULL, `last_name` VARCHAR(100) NOT NULL,
`email` VARCHAR(255) NOT NULL,
`join_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, `banned` INT NULL DEFAULT '0',
PRIMARY KEY (`member_id`),
UNIQUE INDEX `id_UNIQUE` (`member_id` ASC) VISIBLE,
UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
UNIQUE INDEX `member_last_name` (`last_name` ASC) VISIBLE, UNIQUE INDEX `FK_BANNEER` (`banned` ASC) VISIBLE)
ENGINE = InnoDB AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `gym`.`gym_staff`
-- ----------------------------------------------------- CREATE TABLE IF NOT EXISTS `gym`.`gym_staff` (
`employee_id` INT NOT NULL AUTO_INCREMENT, `first_name` VARCHAR(100) NOT NULL, `last_name` VARCHAR(100) NOT NULL, `employee_username` VARCHAR(100) NOT NULL, `employee_password` VARCHAR(250) NOT NULL, `status_employed` INT NOT NULL DEFAULT '1', `position` VARCHAR(100) NOT NULL,
PRIMARY KEY (`employee_id`),
UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE, UNIQUE INDEX `gym_staff_last_name_Index` (`last_name` ASC) VISIBLE)
ENGINE = InnoDB AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`membership_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`membership_type` (
`type_id` INT NOT NULL AUTO_INCREMENT, `type_name` VARCHAR(100) NOT NULL, `type_duration` VARCHAR(100) NOT NULL, `monthly_cost` DECIMAL(8,2) NOT NULL, PRIMARY KEY (`type_id`),
UNIQUE INDEX `type_id_UNIQUE` (`type_id` ASC) VISIBLE,
UNIQUE INDEX `membership_type_Id_Inded` (`type_id` ASC) VISIBLE) ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`gym_member_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`gym_member_account` (
`account_id` INT NOT NULL AUTO_INCREMENT,

`password` VARCHAR(64) NOT NULL,
`member_id` INT NOT NULL,
`employee_id` INT NULL DEFAULT '0',
`type_id` INT NOT NULL,
`account_active` TINYINT(1) NOT NULL DEFAULT '1', PRIMARY KEY (`account_id`),
UNIQUE INDEX `id_UNIQUE` (`account_id` ASC) VISIBLE,
UNIQUE INDEX `member_id_UNIQUE` (`member_id` ASC) VISIBLE,
UNIQUE INDEX `member_id_Index` (`member_id` ASC) VISIBLE,
INDEX `FK_EMPLOYEE_ID_ACCOUNT_MANAGE` (`employee_id` ASC) VISIBLE, INDEX `FK_TYPE_ID_ACCOUNT` (`type_id` ASC) VISIBLE,
CONSTRAINT `FK_EMPLOYEE_ID_ACCOUNT_MANAGE`
FOREIGN KEY (`employee_id`)
REFERENCES `gym`.`gym_staff` (`employee_id`) ON DELETE SET NULL
ON UPDATE CASCADE,
CONSTRAINT `FK_MEMBER_ID`
FOREIGN KEY (`member_id`)
REFERENCES `gym`.`gym_member` (`member_id`) ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `FK_TYPE_ID_ACCOUNT`
FOREIGN KEY (`type_id`)
REFERENCES `gym`.`membership_type` (`type_id`))
ENGINE = InnoDB AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`membership_type_account_enrolled`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`membership_type_account_enrolled` (
`type_id` INT NOT NULL,
`account_id` INT NOT NULL,
`account_active` TINYINT(1) NOT NULL,
PRIMARY KEY (`type_id`, `account_id`),
UNIQUE INDEX `membership_type_account_enrolled_typeId_Index` (`type_id` ASC) VISIBLE, UNIQUE INDEX `membership_type_account_enrolled_account_id_Index` (`account_id` ASC)
VISIBLE,
INDEX `FK_MEMBERSHIP_TYPE_ACCOUNT_ASSOCIATED` (`account_id` ASC) VISIBLE, CONSTRAINT `FK_ACCOUNT_ID_MNM`
FOREIGN KEY (`account_id`)

REFERENCES `gym`.`gym_member_account` (`account_id`) ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `FK_MEMBERSHIP_TYPE`
FOREIGN KEY (`type_id`)
REFERENCES `gym`.`membership_type` (`type_id`) ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`workout_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`workout_plan` (
`plan_id` INT NOT NULL AUTO_INCREMENT, `plan_name` VARCHAR(100) NOT NULL,
PRIMARY KEY (`plan_id`),
UNIQUE INDEX `workout_plan` (`plan_id` ASC) VISIBLE)
ENGINE = InnoDB AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`membership_type_has_workout_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`membership_type_has_workout_plan` (
`type_id` INT NOT NULL,
`plan_id` INT NOT NULL,
PRIMARY KEY (`type_id`, `plan_id`),
INDEX `FK_PLAN_ID` (`plan_id` ASC) VISIBLE, CONSTRAINT `FK_PLAN_ID`
FOREIGN KEY (`plan_id`)
REFERENCES `gym`.`workout_plan` (`plan_id`) ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `FK_TYPE_ID`
FOREIGN KEY (`type_id`)
REFERENCES `gym`.`membership_type` (`type_id`) ON DELETE CASCADE


ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`payment`
-- ----------------------------------------------------- 
CREATE TABLE IF NOT EXISTS `gym`.`payment` (
`payment_id` INT NOT NULL AUTO_INCREMENT, `amount` DECIMAL(8,2) NULL DEFAULT NULL, `account_id` INT NULL DEFAULT '0', `payment_date` DATE NOT NULL,
`employee_id` INT NULL DEFAULT '0',
`payment_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`payment_id`),
UNIQUE INDEX `payment_id_UNIQUE` (`payment_id` ASC) VISIBLE,
UNIQUE INDEX `account_id_UNIQUE` (`account_id` ASC) VISIBLE,
UNIQUE INDEX `payment_account_Id` (`account_id` ASC) VISIBLE,
INDEX `FK_EMPLOYEE_ID_PAYMENT_MANAGEMENT` (`employee_id` ASC) VISIBLE, CONSTRAINT `FK_ACCOUNT_ID`
FOREIGN KEY (`account_id`)
REFERENCES `gym`.`gym_member_account` (`account_id`) ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `FK_EMPLOYEE_ID_PAYMENT_MANAGEMENT` FOREIGN KEY (`employee_id`)
REFERENCES `gym`.`gym_staff` (`employee_id`)
ON DELETE SET NULL
ON UPDATE CASCADE)
ENGINE = InnoDB AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`personal_trainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`personal_trainer` (
`trainer_id` INT NOT NULL AUTO_INCREMENT, `first_name` VARCHAR(100) NOT NULL,


`employee_id` INT NOT NULL,
`last_name` VARCHAR(100) NOT NULL,
PRIMARY KEY (`trainer_id`),
UNIQUE INDEX `trainer_id_UNIQUE` (`trainer_id` ASC) VISIBLE,
UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
UNIQUE INDEX `personal_trainer_employee_Id_Inded` (`employee_id` ASC) VISIBLE, CONSTRAINT `FK_EMPLOYEE_ID`
FOREIGN KEY (`employee_id`)
REFERENCES `gym`.`gym_staff` (`employee_id`) ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`workout`
-- ----------------------------------------------------- 
CREATE TABLE IF NOT EXISTS `gym`.`workout` (
`workout_id` INT NOT NULL AUTO_INCREMENT, `workout_name` VARCHAR(100) NOT NULL, `workout_date` VARCHAR(100) NOT NULL DEFAULT 'TBA', `trainer_id` INT NULL DEFAULT '0',
PRIMARY KEY (`workout_id`),
INDEX `FK_TRAINER_ID` (`trainer_id` ASC) VISIBLE,
INDEX `workout_date_Index` (`workout_date` ASC) VISIBLE, INDEX `workout_name_Index` (`workout_name` ASC) VISIBLE, CONSTRAINT `FK_TRAINER_ID`
FOREIGN KEY (`trainer_id`)
REFERENCES `gym`.`personal_trainer` (`trainer_id`) ON DELETE SET NULL
ON UPDATE CASCADE)
ENGINE = InnoDB AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `gym`.`workout_plan_has_workout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gym`.`workout_plan_has_workout` (


`plan_id` INT NOT NULL AUTO_INCREMENT, `workout_id` INT NOT NULL,
PRIMARY KEY (`plan_id`, `workout_id`),
INDEX `FK_WORKOUT` (`workout_id` ASC) VISIBLE, CONSTRAINT `FK_PLAN_ID_MANY_TO_MANY`
FOREIGN KEY (`plan_id`)
REFERENCES `gym`.`workout_plan` (`plan_id`) ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT `FK_WORKOUT`
FOREIGN KEY (`workout_id`)
REFERENCES `gym`.`workout` (`workout_id`) ON DELETE CASCADE
ON UPDATE CASCADE)
ENGINE = InnoDB AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;