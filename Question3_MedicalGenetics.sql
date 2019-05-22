-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MedicalGenetics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MedicalGenetics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MedicalGenetics` ;
USE `MedicalGenetics` ;

-- -----------------------------------------------------
-- Table `MedicalGenetics`.`Syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalGenetics`.`Syndrome` (
  `SyndromeID` INT NOT NULL,
  `SyndromeName` VARCHAR(45) NULL,
  `SyndromeDescription` VARCHAR(250) NULL,
  PRIMARY KEY (`SyndromeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MedicalGenetics`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalGenetics`.`Patients` (
  `PatientNo` INT NOT NULL,
  `PatientName` VARCHAR(45) NULL,
  `SyndromeID` INT NOT NULL,
  `Gender` ENUM('F', 'M') NULL,
  `AgeAtDiagnosis` VARCHAR(45) NULL,
  PRIMARY KEY (`PatientNo`),
  INDEX `fk_Patients_1_idx` (`SyndromeID` ASC) VISIBLE,
  CONSTRAINT `fk_Patients_1`
    FOREIGN KEY (`SyndromeID`)
    REFERENCES `MedicalGenetics`.`Syndrome` (`SyndromeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MedicalGenetics`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalGenetics`.`Gene` (
  `GeneID` INT NOT NULL,
  `GeneName` VARCHAR(45) NULL,
  `GeneDescription` VARCHAR(250) NULL,
  PRIMARY KEY (`GeneID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MedicalGenetics`.`Mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalGenetics`.`Mutation` (
  `MutationID` INT NOT NULL,
  `Start` INT NULL,
  `End` INT NULL,
  `Chromosome` VARCHAR(10) NULL,
  `GeneID` INT NOT NULL,
  PRIMARY KEY (`MutationID`),
  INDEX `fk_Mutation_1_idx` (`GeneID` ASC) VISIBLE,
  CONSTRAINT `fk_Mutation_1`
    FOREIGN KEY (`GeneID`)
    REFERENCES `MedicalGenetics`.`Gene` (`GeneID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MedicalGenetics`.`Mutation_Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MedicalGenetics`.`Mutation_Patients` (
  `idMutation_Patients` INT NOT NULL,
  `MutationID` INT NOT NULL,
  `PatientNo` INT NOT NULL,
  PRIMARY KEY (`idMutation_Patients`),
  INDEX `fk_Mutation_Patients_1_idx` (`MutationID` ASC) VISIBLE,
  INDEX `fk_Mutation_Patients_2_idx` (`PatientNo` ASC) VISIBLE,
  CONSTRAINT `fk_Mutation_Patients_1`
    FOREIGN KEY (`MutationID`)
    REFERENCES `MedicalGenetics`.`Mutation` (`MutationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mutation_Patients_2`
    FOREIGN KEY (`PatientNo`)
    REFERENCES `MedicalGenetics`.`Patients` (`PatientNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
