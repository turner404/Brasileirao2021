-- MySQL Script generated by MySQL Workbench
-- Mon Aug 23 20:14:45 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`time` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profissional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profissional` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `time_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profissional_time1_idx` (`time_id` ASC) ,
  CONSTRAINT `fk_profissional_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `mydb`.`time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`arbitro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cameponato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cameponato` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `premio` INT NOT NULL,
  `ano` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rodada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rodada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NOT NULL,
  `cameponato_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rodada_cameponato1_idx` (`cameponato_id` ASC) ,
  CONSTRAINT `fk_rodada_cameponato1`
    FOREIGN KEY (`cameponato_id`)
    REFERENCES `mydb`.`cameponato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estadio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estadio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `capacidade` INT NOT NULL,
  `time_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estadio_time1_idx` (`time_id` ASC) ,
  CONSTRAINT `fk_estadio_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `mydb`.`time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`partida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rodada_id` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `estadio_id` INT NOT NULL,
  `arbitro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_partida_rodada1_idx` (`rodada_id` ASC) ,
  INDEX `fk_partida_estadio1_idx` (`estadio_id` ASC) ,
  INDEX `fk_partida_arbitro1_idx` (`arbitro_id` ASC) ,
  CONSTRAINT `fk_partida_rodada1`
    FOREIGN KEY (`rodada_id`)
    REFERENCES `mydb`.`rodada` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partida_estadio1`
    FOREIGN KEY (`estadio_id`)
    REFERENCES `mydb`.`estadio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_partida_arbitro1`
    FOREIGN KEY (`arbitro_id`)
    REFERENCES `mydb`.`arbitro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`resultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`resultado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `partida_id` INT NOT NULL,
  `casa` INT NOT NULL,
  `visitante` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_resultado_partida2_idx` (`partida_id` ASC) ,
  CONSTRAINT `fk_resultado_partida2`
    FOREIGN KEY (`partida_id`)
    REFERENCES `mydb`.`partida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gols`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gols` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `profissional_id` INT NOT NULL,
  `partida_id` INT NOT NULL,
  `time_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_resultado_profissional1_idx` (`profissional_id` ASC) ,
  INDEX `fk_resultado_partida1_idx` (`partida_id` ASC) ,
  INDEX `fk_resultado_time1_idx` (`time_id` ASC) ,
  CONSTRAINT `fk_resultado_profissional1`
    FOREIGN KEY (`profissional_id`)
    REFERENCES `mydb`.`profissional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultado_partida1`
    FOREIGN KEY (`partida_id`)
    REFERENCES `mydb`.`partida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resultado_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `mydb`.`time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comissao_tecnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comissao_tecnica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time_id` INT NOT NULL,
  `tecnico_id` INT NOT NULL,
  `treinador_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comissao_tecnica_time1_idx` (`time_id` ASC) ,
  INDEX `fk_comissao_tecnica_profissional1_idx` (`tecnico_id` ASC) ,
  INDEX `fk_comissao_tecnica_profissional2_idx` (`treinador_id` ASC) ,
  CONSTRAINT `fk_comissao_tecnica_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `mydb`.`time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_tecnica_profissional1`
    FOREIGN KEY (`tecnico_id`)
    REFERENCES `mydb`.`profissional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comissao_tecnica_profissional2`
    FOREIGN KEY (`treinador_id`)
    REFERENCES `mydb`.`profissional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
