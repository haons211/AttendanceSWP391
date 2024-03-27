CREATE DATABASE  IF NOT EXISTS `swp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `swp`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: swp34
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `type_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `file` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `status` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  `complete_date` datetime DEFAULT NULL,
  `replyContent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`application_id`),
  KEY `type_id` (`type_id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type_application` (`type_id`),
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `application_ibfk_3` FOREIGN KEY (`receiver_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,2,1,3,'','da','da','complete','2024-03-20 13:10:27','2024-03-20 13:19:53','ad'),(2,2,1,3,'','toi da update','toi da update','Pending','2024-03-20 13:22:32',NULL,NULL);
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `image` varchar(50) NOT NULL,
  `remainDay_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `in_time` time DEFAULT NULL,
  `out_time` time DEFAULT NULL,
  `notes` varchar(120) DEFAULT NULL,
  `in_status` varchar(120) NOT NULL DEFAULT 'Not yet',
  `out_status` varchar(120) NOT NULL DEFAULT 'Not yet',
  `status` varchar(11) NOT NULL DEFAULT 'Absent',
  PRIMARY KEY (`attendance_id`),
  KEY `employee_id` (`employee_id`),
  KEY `department_id` (`department_id`),
  KEY `remainDay_id` (`remainDay_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `attendance_ibfk_3` FOREIGN KEY (`remainDay_id`) REFERENCES `remainday` (`remainDay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,1,'van_a.jpg',1,1,'2024-03-01','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(2,2,'thi_b.jpg',2,3,'2024-03-01','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(3,3,'van_c.jpg',3,2,'2024-03-01','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(4,4,'thi_d.jpg',4,3,'2024-03-01','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(5,5,'van_e.jpg',5,1,'2024-03-01','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(6,1,'van_a.jpg',1,1,'2024-03-02','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(7,2,'thi_b.jpg',2,3,'2024-03-02','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(8,3,'van_c.jpg',3,2,'2024-03-02','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(9,4,'thi_d.jpg',4,3,'2024-03-02','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(10,5,'van_e.jpg',5,1,'2024-03-02','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(11,1,'van_a.jpg',1,1,'2024-03-03','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(12,2,'thi_b.jpg',2,3,'2024-03-03','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(13,3,'van_c.jpg',3,2,'2024-03-03','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(14,4,'thi_d.jpg',4,3,'2024-03-03','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(15,5,'van_e.jpg',5,1,'2024-03-03','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(16,1,'van_a.jpg',1,1,'2024-03-04','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(17,2,'thi_b.jpg',2,3,'2024-03-04','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(18,3,'van_c.jpg',3,2,'2024-03-04','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(19,4,'thi_d.jpg',4,3,'2024-03-04','07:50:00','16:00:00','','Checked In','Early','Present'),(20,5,'van_e.jpg',5,1,'2024-03-04','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(21,1,'van_a.jpg',1,1,'2024-03-05','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(22,2,'thi_b.jpg',2,3,'2024-03-05','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(23,3,'van_c.jpg',3,2,'2024-03-05','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(24,4,'thi_d.jpg',4,3,'2024-03-05','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(25,5,'van_e.jpg',5,1,'2024-03-05','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(26,1,'van_a.jpg',1,1,'2024-03-06','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(27,2,'thi_b.jpg',2,3,'2024-03-06','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(28,3,'van_c.jpg',3,2,'2024-03-06','07:50:00','09:00:00','hehe','Checked In','Early','Absent'),(29,4,'thi_d.jpg',4,3,'2024-03-06','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(30,5,'van_e.jpg',5,1,'2024-03-06','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(31,1,'van_a.jpg',1,1,'2024-03-07','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(32,2,'thi_b.jpg',2,3,'2024-03-07','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(33,3,'van_c.jpg',3,2,'2024-03-07','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(34,4,'thi_d.jpg',4,3,'2024-03-07','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(35,5,'van_e.jpg',5,1,'2024-03-07','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(36,1,'van_a.jpg',1,1,'2024-03-08','07:50:00','09:00:00','','Checked In','Early','Absent'),(37,2,'thi_b.jpg',2,3,'2024-03-08','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(38,3,'van_c.jpg',3,2,'2024-03-08','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(39,4,'thi_d.jpg',4,3,'2024-03-08','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(40,5,'van_e.jpg',5,1,'2024-03-08','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(41,1,'van_a.jpg',1,1,'2024-03-09','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(42,2,'thi_b.jpg',2,3,'2024-03-09','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(43,3,'van_c.jpg',3,2,'2024-03-09','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(44,4,'thi_d.jpg',4,3,'2024-03-09','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(45,5,'van_e.jpg',5,1,'2024-03-09','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(46,1,'van_a.jpg',1,1,'2024-03-10','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(47,2,'thi_b.jpg',2,3,'2024-03-10','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(48,3,'van_c.jpg',3,2,'2024-03-10','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(49,4,'thi_d.jpg',4,3,'2024-03-10','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(50,5,'van_e.jpg',5,1,'2024-03-10','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(51,1,'van_a.jpg',1,1,'2024-03-11','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(52,2,'thi_b.jpg',2,3,'2024-03-11','07:50:00','12:00:00','','Checked In','Early','Absent'),(53,3,'van_c.jpg',3,2,'2024-03-11','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(54,4,'thi_d.jpg',4,3,'2024-03-11','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(55,5,'van_e.jpg',5,1,'2024-03-11','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(56,1,'van_a.jpg',1,1,'2024-03-12','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(57,2,'thi_b.jpg',2,3,'2024-03-12','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(58,3,'van_c.jpg',3,2,'2024-03-12','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),(59,4,'thi_d.jpg',4,3,'2024-03-12','07:50:00','17:00:00','','Checked In','Checked Out','Present'),(60,5,'van_e.jpg',5,1,'2024-03-12','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),(61,1,'van_a.jpg',1,1,'2024-03-13','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(62,2,'thi_b.jpg',2,3,'2024-03-13','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(63,3,'van_c.jpg',3,2,'2024-03-13','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(64,4,'thi_d.jpg',4,3,'2024-03-13','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(65,5,'van_e.jpg',5,1,'2024-03-13','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(66,1,'van_a.jpg',1,1,'2024-03-14','07:50:00','12:54:36','','Checked In','Early','Absent'),(67,2,'thi_b.jpg',2,3,'2024-03-14','07:50:00','13:16:38','f','Checked In','Early','Absent'),(68,3,'van_c.jpg',3,2,'2024-03-14','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(69,4,'thi_d.jpg',4,3,'2024-03-14','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(70,5,'van_e.jpg',5,1,'2024-03-14','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(71,1,'van_a.jpg',1,1,'2024-03-15','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(72,2,'thi_b.jpg',2,3,'2024-03-15','07:50:00','17:00:00','g','Checked In','Checked Out','Present'),(73,3,'van_c.jpg',3,2,'2024-03-15','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(74,4,'thi_d.jpg',4,3,'2024-03-15','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(75,5,'van_e.jpg',5,1,'2024-03-15','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(76,1,'van_a.jpg',1,1,'2024-03-16','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(77,2,'thi_b.jpg',2,3,'2024-03-16','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(78,3,'van_c.jpg',3,2,'2024-03-16','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(79,4,'thi_d.jpg',4,3,'2024-03-16','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(80,5,'van_e.jpg',5,1,'2024-03-16','07:50:00','17:00:00',NULL,'Checked In','Checked Out','Present'),(81,1,'van_a.jpg',1,1,'2024-03-27','14:39:00','14:39:01','','Late','Early','Absent'),(82,2,'thi_b.jpg',2,3,'2024-03-27',NULL,NULL,NULL,'Not yet','Not yet','Absent'),(83,3,'van_c.jpg',3,2,'2024-03-27',NULL,NULL,NULL,'Not yet','Not yet','Absent'),(84,4,'thi_d.jpg',4,3,'2024-03-27',NULL,NULL,NULL,'Not yet','Not yet','Absent'),(85,5,'van_e.jpg',5,1,'2024-03-27',NULL,NULL,NULL,'Not yet','Not yet','Absent');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_attendance_status_insert` BEFORE INSERT ON `attendance` FOR EACH ROW BEGIN
    IF NEW.in_time IS NOT NULL THEN
        IF NEW.in_time < (SELECT intime_config FROM config WHERE config_id = 1) THEN
            SET NEW.in_status = 'Checked In';
        ELSE
            SET NEW.in_status = 'Late';
        END IF;
    END IF;
    
    IF NEW.out_time IS NOT NULL THEN
        IF NEW.out_time < (SELECT outtime_config FROM config WHERE config_id = 1) THEN
            SET NEW.out_status = 'Early';
        ELSE
            SET NEW.out_status = 'Checked Out';
        END IF;
    END IF;
    
    IF NEW.in_time IS NOT NULL AND NEW.out_time IS NOT NULL AND TIMEDIFF(NEW.out_time, NEW.in_time) < '07:00:00' THEN
    SET NEW.status = 'Absent';
ELSEIF NEW.in_time IS NULL AND NEW.out_time IS NULL THEN
    SET NEW.status = 'Absent';
    ELSEIF NEW.in_time IS NOT NULL AND NEW.out_time IS NULL THEN
    SET NEW.status = 'Absent';
ELSE
    SET NEW.status = 'Present';
END IF;

    
    -- Check if the status is Absent after 17:00 and update remainDay and leaveDays accordingly
    IF TIME(NOW()) > '17:00:00' AND NEW.status = 'Absent' THEN
        UPDATE remainday
        SET remainDay = remainDay - 1, leaveDays = leaveDays + 1
        WHERE employee_id = NEW.employee_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_attendance_status_update` BEFORE UPDATE ON `attendance` FOR EACH ROW BEGIN
    IF NEW.in_time IS NOT NULL THEN
        IF NEW.in_time <= (SELECT intime_config FROM config WHERE config_id = 1) THEN
            SET NEW.in_status = 'Checked In';
        ELSE
            SET NEW.in_status = 'Late';
        END IF;
    END IF;
    
    IF NEW.out_time IS NOT NULL THEN
        IF NEW.out_time < (SELECT outtime_config FROM config WHERE config_id = 1) THEN
            SET NEW.out_status = 'Early';
        ELSE
            SET NEW.out_status = 'Checked Out';
        END IF;
    END IF;
    
      IF NEW.in_time IS NOT NULL AND NEW.out_time IS NOT NULL AND TIMEDIFF(NEW.out_time, NEW.in_time) < '07:00:00' THEN
    SET NEW.status = 'Absent';
ELSEIF NEW.in_time IS NULL AND NEW.out_time IS NULL THEN
    SET NEW.status = 'Absent';
    ELSEIF NEW.in_time IS NOT NULL AND NEW.out_time IS NULL THEN
    SET NEW.status = 'Absent';
ELSE
    SET NEW.status = 'Present';
END IF;

    
    -- Check if the status is Absent after 17:00 and update remainDay and leaveDays accordingly
    IF TIME(NOW()) > '17:00:00' AND NEW.status = 'Absent' THEN
        UPDATE remainday
        SET remainDay = remainDay - 1, leaveDays = leaveDays + 1
        WHERE employee_id = NEW.employee_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(128) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `website` varchar(128) DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  KEY `employeeID` (`employee_id`),
  KEY `department` (`department_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `company_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'SGIP5','69, Trần Duy Hưng, Cầu Giấy, Hà Nội','sgip5.com@sgip5.com','0123456789','0123456789','https://www.sgip5.com/',1,1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `config_id` int NOT NULL,
  `intime_config` time DEFAULT NULL,
  `outtime_config` time DEFAULT NULL,
  `mockDay` date DEFAULT NULL,
  `BeforeMockDay_gift` int DEFAULT NULL,
  `AfterMockDay_gift` int DEFAULT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'08:00:00','17:00:00','2022-01-15',2,5);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_config_update` AFTER UPDATE ON `config` FOR EACH ROW BEGIN
    UPDATE remainday r
    JOIN employee e ON r.employee_id = e.employee_id
    SET 
      r.approvedLeaveDays = CASE WHEN YEAR(CURDATE()) - YEAR(e.hire_date) < NEW.mockDay THEN NEW.BeforeMockDay_gift ELSE NEW.AfterMockDay_gift END,
      r.config_id = NEW.config_id,
      r.yearOfWork = YEAR(CURDATE()) - YEAR(e.hire_date)
    WHERE r.employee_id = e.employee_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `dep_code` varchar(50) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Software Engineering','SE'),(2,'Digital Marketing','DM'),(3,'Bussiness Analyst','BA'),(4,'Data Science','DS'),(5,'Human Resources','HR');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependents`
--

DROP TABLE IF EXISTS `dependents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependents` (
  `dependent_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`dependent_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `dependents_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependents`
--

LOCK TABLES `dependents` WRITE;
/*!40000 ALTER TABLE `dependents` DISABLE KEYS */;
INSERT INTO `dependents` VALUES (60,1,'Nguyễn Thị Mai','2005-03-15','Con',0),(61,2,'Trần Văn An','2010-07-20','Vợ/Chồng',1),(62,3,'Phạm Thị Hằng','2008-11-10','Con',0),(63,4,'Lê Minh Tuấn','2012-05-25','Con',1),(64,5,'Hoàng Thị Thu','2011-09-30','Vợ/Chồng',0),(65,6,'Nguyễn Văn Bình','2007-04-12','Con',1),(66,7,'Trần Thị Lan','2009-01-05','Vợ/Chồng',0),(67,8,'Lê Văn Đức','2013-08-18','Con',1),(68,9,'Nguyễn Thị Nga','2010-12-20','Vợ/Chồng',0),(69,10,'Phạm Văn Hùng','2009-06-22','Con',1),(70,11,'Nguyễn Thị Hương','2012-02-17','Vợ/Chồng',0),(71,12,'Trần Văn Hải','2008-10-08','Con',1),(72,13,'Hoàng Thị Hạnh','2011-05-13','Vợ/Chồng',0),(73,14,'Lê Văn Nam','2006-07-28','Con',1),(74,15,'Nguyễn Thị Lan','2010-11-03','Vợ/Chồng',0),(75,16,'Phạm Văn Hòa','2009-03-24','Con',1),(76,17,'Trần Thị Lý','2013-09-29','Vợ/Chồng',0),(77,18,'Nguyễn Văn Đạt','2012-01-10','Con',1),(78,19,'Hoàng Thị Mai','2008-06-05','Vợ/Chồng',0),(79,20,'Lê Văn Thanh','2010-12-08','Con',1),(80,21,'Nguyễn Thị Hoa','2011-04-19','Vợ/Chồng',0),(81,22,'Trần Văn Dũng','2009-08-23','Con',1),(82,23,'Phạm Thị Hồng','2013-02-14','Vợ/Chồng',0),(83,24,'Hoàng Văn Hưng','2007-11-27','Con',1);
/*!40000 ALTER TABLE `dependents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `gender` bit(1) NOT NULL,
  `image` varchar(128) NOT NULL,
  `birth_date` date NOT NULL,
  `hire_date` date NOT NULL,
  `user_id` int DEFAULT NULL,
  `basic_salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Nguyễn Văn An','0987654321','Số 10, Đường Nguyễn Chí Thanh, Hà Nội','van.a@sgip5.com',_binary '','van_c.jpg','1990-05-15','2022-01-01',1,5000000.00),(2,'Trần Thị Be','0912345678','Số 20, Đường Lê Lợi, Hồ Chí Minh','thi.b@sgip5.com',_binary '','van_c.jpg','1993-08-25','2022-01-02',2,99999.00),(3,'Lê Văn Cường','0905123456','Số 30, Đường Trần Hưng Đạo, Đà Nẵng','van.c@sgip5.com',_binary '','van_c.jpg','1988-02-10','2022-01-03',3,88888.00),(4,'Hoàng Thị Dung','0978123456','Số 40, Đường Nguyễn Huệ, Cần Thơ','thi.d@sgip5.com',_binary '\0','thi_d.jpg','1997-11-30','2022-01-04',4,77777.00),(5,'Phạm Văn Nghĩa','0987123456','Số 50, Đường Trần Phú, Hải Phòng','van.e@sgip5.com',_binary '','van_e.jpg','1991-04-20','2022-01-05',5,66666.00),(6,'Mai Thị Lan','0945968372','Số 60, Đường Lý Tự Trọng, Cần Thơ','lan.m@sgip5.com',_binary '\0','lan_m.jpg','1986-11-30','2022-01-01',6,6300000.00),(7,'Hoàng Văn Hùng','0936152749','Số 70, Đường Ngô Quyền, Vũng Tàu','hung.h@sgip5.com',_binary '','hung_h.jpg','1991-05-18','2022-01-01',7,5100000.00),(8,'Nguyễn Thị Ngọc','0927381564','Số 80, Đường Lý Thái Tổ, Hà Nam','ngoc.nt@sgip5.com',_binary '\0','ngoc_nt.jpg','1984-08-27','2022-01-01',8,5900000.00),(9,'Vũ Văn Dũng','0918576342','Số 90, Đường Hoàng Diệu, Hải Dương','dung.v@sgip5.com',_binary '','dung_v.jpg','1987-02-14','2022-01-01',9,6400000.00),(10,'Trần Thị Thu','0909867543','Số 100, Đường Quang Trung, Huế','thu.t@sgip5.com',_binary '\0','thu_t.jpg','1993-06-28','2022-01-01',10,5300000.00),(11,'Lê Văn Quân','0997654321','Số 110, Đường Lê Duẩn, Hồ Chí Minh','quan.l@sgip5.com',_binary '','quan_l.jpg','1989-04-05','2022-01-01',11,5700000.00),(12,'Đỗ Thị Hoa','0986543210','Số 120, Đường Trần Phú, Hà Nội','hoa.d@sgip5.com',_binary '\0','hoa_d.jpg','1983-10-12','2022-01-01',12,6200000.00),(13,'Nguyễn Văn Đức','0975432109','Số 130, Đường Bà Triệu, Hải Phòng','duc.nv@sgip5.com',_binary '','duc_nv.jpg','1994-09-16','2022-01-01',13,5400000.00),(14,'Hoàng Thị Mai','0964321098','Số 140, Đường Nguyễn Văn Linh, Đà Nẵng','mai.ht@sgip5.com',_binary '\0','mai_ht.jpg','1982-11-07','2022-01-01',14,5600000.00),(15,'Trần Văn Long','0953210987','Số 150, Đường Lý Thường Kiệt, Hồ Chí Minh','long.tv@sgip5.com',_binary '','long_tv.jpg','1980-12-24','2022-01-01',15,6500000.00),(16,'Lê Thị Thu Hằng','0942109876','Số 160, Đường Trần Hưng Đạo, Hà Nội','hang.lt@sgip5.com',_binary '\0','hang_lt.jpg','1990-08-11','2022-01-01',16,5100000.00),(17,'Phạm Văn Thịnh','0931098765','Số 170, Đường Lê Lai, Hồ Chí Minh','thinh.pv@sgip5.com',_binary '','thinh_pv.jpg','1986-02-18','2022-01-01',17,5800000.00),(18,'Nguyễn Thị Thu Trang','0920987654','Số 180, Đường Nguyễn Đình Chiểu, Đà Lạt','trang.ntt@sgip5.com',_binary '\0','trang_ntt.jpg','1988-05-03','2022-01-01',18,6300000.00),(19,'Vũ Văn Tú','0919876543','Số 190, Đường Lý Thái Tổ, Nha Trang','tu.vv@sgip5.com',_binary '','tu_vv.jpg','1985-01-26','2022-01-01',19,5200000.00),(20,'Nguyễn Thị Kim Anh','0908765432','Số 200, Đường Nguyễn Huệ, Hải Phòng','anh.ntk@sgip5.com',_binary '\0','anh_ntk.jpg','1991-03-09','2022-01-01',20,5900000.00),(21,'Đinh Văn Hùng','0997654321','Số 210, Đường Trần Phú, Hà Nội','hung.dv@sgip5.com',_binary '','hung_dv.jpg','1983-07-17','2022-01-01',21,6400000.00),(22,'Trần Thị Hồng','0986543210','Số 220, Đường Lê Lợi, Hồ Chí Minh','hong.tt@sgip5.com',_binary '\0','hong_tt.jpg','1987-11-24','2022-01-01',22,5300000.00),(23,'Lê Văn Tuấn','0975432109','Số 230, Đường Nguyễn Công Trứ, Đà Nẵng','tuan.lv@sgip5.com',_binary '','tuan_lv.jpg','1989-04-30','2022-01-01',23,5700000.00),(24,'Nguyễn Văn Minh','0987654321','Số 240, Đường Nguyễn Công Trứ, Đà Nẵng','minh.nv@sgip5.com',_binary '','minh_nv.jpg','1995-10-20','2022-01-01',24,5500000.00);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_employee_update` AFTER UPDATE ON `employee` FOR EACH ROW BEGIN
    UPDATE remainday r
    SET 
      r.yearOfWork = YEAR(CURDATE()) - YEAR(NEW.hire_date)
    WHERE r.employee_id = NEW.employee_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employeedepartment`
--

DROP TABLE IF EXISTS `employeedepartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeedepartment` (
  `employee_id` int NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`employee_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employeedepartment_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `employeedepartment_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeedepartment`
--

LOCK TABLES `employeedepartment` WRITE;
/*!40000 ALTER TABLE `employeedepartment` DISABLE KEYS */;
INSERT INTO `employeedepartment` VALUES (1,1),(2,1),(3,1),(8,1),(9,1),(10,1),(13,1),(4,2),(14,2),(15,2),(16,2),(17,2),(5,3),(18,3),(19,3),(20,3),(21,3),(6,4),(22,4),(23,4),(24,4),(7,5),(11,5),(12,5);
/*!40000 ALTER TABLE `employeedepartment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `feedback_date` date DEFAULT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,5,'Về Trưởng phòng','Hay đi muộn, nói chuyện hãm','2024-03-12'),(3,5,'Về Công ty','Công ty to quá làm em đi mỏi chân','2024-03-13'),(4,2,'Về Trưởng phòng','Hay đi muộn, nói chuyện hãm','2024-03-13'),(5,2,'Về giám đốc','Không làm mà nói nhiều','2024-03-13'),(10,2,'Về Trưởng phòng','Good','2024-03-13'),(14,2,'Về Trưởng phòng','Good','2024-03-13'),(16,2,'Về Trưởng phòng','Not Good','2024-03-13'),(21,2,'Về giám đốc','Good','2024-03-13'),(30,2,'Về Trưởng phòng','Not Good','2024-03-13'),(32,2,'Về giám đốc','Good','2024-03-13'),(33,2,'Về Trưởng phòng','Not Good','2024-03-13'),(34,2,'Về Trưởng phòng','Good','2024-03-13'),(35,2,'Về Trưởng phòng','Good','2024-03-13'),(36,2,'Về Trưởng phòng','Not Good','2024-03-13');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `file_data` longblob,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance` (
  `insurance_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `insurance_company` varchar(100) DEFAULT NULL,
  `policy_number` varchar(50) DEFAULT NULL,
  `coverage_type` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `premium_amount` decimal(10,2) DEFAULT NULL,
  `deductible` decimal(10,2) DEFAULT NULL,
  `co_pay` decimal(10,2) DEFAULT NULL,
  `coverage_details` text,
  `policy_type` varchar(50) DEFAULT NULL,
  `policy_issuer` varchar(100) DEFAULT NULL,
  `beneficiary` varchar(100) DEFAULT NULL,
  `coverage_limit` decimal(15,2) DEFAULT NULL,
  `renewal_date` date DEFAULT NULL,
  PRIMARY KEY (`insurance_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `insurance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance`
--

LOCK TABLES `insurance` WRITE;
/*!40000 ALTER TABLE `insurance` DISABLE KEYS */;
INSERT INTO `insurance` VALUES (1,1,'Insurance World','POL123456','Bảo hiểm sức khỏe','2022-01-01','2023-01-01',2000000.00,500000.00,20000.00,'Phủ sóng cơ bản về sức khỏe','Bảo hiểm Sức khỏe','Insurance World','Gia đình',5000000.00,'2023-01-01'),(2,2,'SureShield','POL987654','Bảo hiểm sức khỏe','2022-02-01','2023-02-01',2500000.00,600000.00,25000.00,'Phủ sóng cơ bản','Bảo hiểm Sức khỏe','SureShield','Không người hưởng',6000000.00,'2023-02-01'),(3,3,'Insurance World','POL456789','Bảo hiểm sức khỏe','2022-03-01','2023-03-01',3000000.00,700000.00,30000.00,'Phủ sóng toàn diện','Bảo hiểm Sức khỏe','Insurance World','Con',7000000.00,'2023-03-01'),(4,4,'SureShield','POL654321','Bảo hiểm sức khỏe','2022-04-01','2023-04-01',2800000.00,550000.00,28000.00,'Phủ sóng tiêu chuẩn','Bảo hiểm Sức khỏe','SureShield','Gia đình',5500000.00,'2023-04-01'),(5,5,'Insurance World','POL789012','Bảo hiểm sức khỏe','2022-05-01','2023-05-01',3200000.00,650000.00,32000.00,'Phủ sóng nâng cao','Bảo hiểm Sức khỏe','Insurance World','Không người hưởng',6500000.00,'2023-05-01'),(6,6,'SureShield','POL234567','Bảo hiểm nhân thọ','2022-06-01','2023-06-01',3500000.00,750000.00,35000.00,'Phủ sóng nhân thọ','Bảo hiểm Nhân thọ','SureShield','Con',7500000.00,'2023-06-01'),(7,7,'Insurance World','POL890123','Bảo hiểm tai nạn','2022-07-01','2023-07-01',2600000.00,500000.00,26000.00,'Phủ sóng tai nạn','Bảo hiểm Tai nạn','Insurance World','Gia đình',5000000.00,'2023-07-01'),(8,8,'SureShield','POL345678','Bảo hiểm sức khỏe','2022-08-01','2023-08-01',2900000.00,600000.00,29000.00,'Phủ sóng bệnh nặng','Bảo hiểm Sức khỏe','SureShield','Không người hưởng',6000000.00,'2023-08-01'),(9,9,'Insurance World','POL901234','Bảo hiểm sức khỏe','2022-09-01','2023-09-01',3300000.00,700000.00,33000.00,'Phủ sóng khuyết tật','Bảo hiểm Sức khỏe','Insurance World','Con',7000000.00,'2023-09-01'),(10,10,'SureShield','POL456789','Bảo hiểm sức khỏe','2022-10-01','2023-10-01',3100000.00,650000.00,31000.00,'Phủ sóng du lịch','Bảo hiểm Sức khỏe','SureShield','Gia đình',6500000.00,'2023-10-01'),(11,11,'Insurance World','POL987654','Bảo hiểm sức khỏe','2022-11-01','2023-11-01',2700000.00,550000.00,27000.00,'Phủ sóng tài sản','Bảo hiểm Sức khỏe','Insurance World','Không người hưởng',5500000.00,'2023-11-01'),(12,12,'SureShield','POL987654','Bảo hiểm nhân thọ','2022-12-01','2023-12-01',2800000.00,500000.00,28000.00,'Phủ sóng nhân thọ','Bảo hiểm Nhân thọ','SureShield','Con',5000000.00,'2023-12-01'),(13,13,'Insurance World','POL789012','Bảo hiểm tai nạn','2023-01-01','2024-01-01',3000000.00,600000.00,30000.00,'Phủ sóng tai nạn','Bảo hiểm Tai nạn','Insurance World','Gia đình',6000000.00,'2024-01-01'),(14,14,'SureShield','POL234567','Bảo hiểm sức khỏe','2023-02-01','2024-02-01',3200000.00,650000.00,32000.00,'Phủ sóng cơ bản về sức khỏe','Bảo hiểm Sức khỏe','SureShield','Không người hưởng',6500000.00,'2024-02-01'),(15,15,'Insurance World','POL123456','Bảo hiểm nhân thọ','2023-03-01','2024-03-01',3500000.00,700000.00,35000.00,'Phủ sóng nhân thọ','Bảo hiểm Nhân thọ','Insurance World','Con',7000000.00,'2024-03-01'),(16,16,'SureShield','POL654321','Bảo hiểm sức khỏe','2023-04-01','2024-04-01',3300000.00,650000.00,33000.00,'Phủ sóng toàn diện','Bảo hiểm Sức khỏe','SureShield','Gia đình',6500000.00,'2024-04-01'),(17,17,'Insurance World','POL456789','Bảo hiểm tai nạn','2023-05-01','2024-05-01',2800000.00,550000.00,28000.00,'Phủ sóng tai nạn','Bảo hiểm Tai nạn','Insurance World','Không người hưởng',5500000.00,'2024-05-01'),(18,18,'SureShield','POL789012','Bảo hiểm sức khỏe','2023-06-01','2024-06-01',3000000.00,600000.00,30000.00,'Phủ sóng cơ bản về sức khỏe','Bảo hiểm Sức khỏe','SureShield','Con',6000000.00,'2024-06-01'),(19,19,'Insurance World','POL345678','Bảo hiểm nhân thọ','2023-07-01','2024-07-01',3200000.00,650000.00,32000.00,'Phủ sóng nhân thọ','Bảo hiểm Nhân thọ','Insurance World','Gia đình',6500000.00,'2024-07-01'),(20,20,'SureShield','POL901234','Bảo hiểm sức khỏe','2023-08-01','2024-08-01',3400000.00,700000.00,34000.00,'Phủ sóng cơ bản về sức khỏe','Bảo hiểm Sức khỏe','SureShield','Không người hưởng',7000000.00,'2024-08-01'),(21,21,'Insurance World','POL234567','Bảo hiểm tai nạn','2023-09-01','2024-09-01',2900000.00,550000.00,29000.00,'Phủ sóng tai nạn','Bảo hiểm Tai nạn','Insurance World','Con',5500000.00,'2024-09-01'),(22,22,'SureShield','POL678901','Bảo hiểm sức khỏe','2023-10-01','2024-10-01',3100000.00,600000.00,31000.00,'Phủ sóng cơ bản về sức khỏe','Bảo hiểm Sức khỏe','SureShield','Gia đình',6000000.00,'2024-10-01'),(23,23,'Insurance World','POL890123','Bảo hiểm nhân thọ','2023-11-01','2024-11-01',3300000.00,650000.00,33000.00,'Phủ sóng nhân thọ','Bảo hiểm Nhân thọ','Insurance World','Không người hưởng',6500000.00,'2024-11-01'),(24,24,'SureShield','POL567890','Bảo hiểm sức khỏe','2023-12-01','2024-12-01',3500000.00,700000.00,35000.00,'Phủ sóng cơ bản về sức khỏe','Bảo hiểm Sức khỏe','SureShield','Con',7000000.00,'2024-12-01');
/*!40000 ALTER TABLE `insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managerfile`
--

DROP TABLE IF EXISTS `managerfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managerfile` (
  `MFID` int NOT NULL AUTO_INCREMENT,
  `FID` int DEFAULT NULL,
  `file_id` int DEFAULT NULL,
  PRIMARY KEY (`MFID`),
  KEY `FID` (`FID`),
  KEY `file_id` (`file_id`),
  CONSTRAINT `managerfile_ibfk_1` FOREIGN KEY (`FID`) REFERENCES `notification` (`notification_id`),
  CONSTRAINT `managerfile_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managerfile`
--

LOCK TABLES `managerfile` WRITE;
/*!40000 ALTER TABLE `managerfile` DISABLE KEYS */;
/*!40000 ALTER TABLE `managerfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managerproject`
--

DROP TABLE IF EXISTS `managerproject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managerproject` (
  `MaID` int NOT NULL AUTO_INCREMENT,
  `ProjectID` int NOT NULL,
  `success` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`MaID`),
  KEY `managerproject_ibfk_2` (`ProjectID`),
  CONSTRAINT `managerproject_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `project` (`ProjectId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managerproject`
--

LOCK TABLES `managerproject` WRITE;
/*!40000 ALTER TABLE `managerproject` DISABLE KEYS */;
INSERT INTO `managerproject` VALUES (1,1,3);
/*!40000 ALTER TABLE `managerproject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `content` text NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `fk_message_sender` (`sender_id`),
  CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,3,'hihihi\n','2024-03-20 12:56:10'),(2,3,'hihihi\n','2024-03-20 12:56:11'),(3,3,'hihihi\n','2024-03-20 12:56:11'),(4,3,'he lo c\n','2024-03-20 13:04:06'),(5,2,'oke','2024-03-20 13:04:11'),(6,3,'hi toi la Hao','2024-03-20 13:22:55'),(7,2,'oke','2024-03-20 13:23:11'),(8,1,'fsdfsdfasdfsd','2024-03-27 14:45:23'),(9,1,'fsdfsdfasdfsd','2024-03-27 14:45:24');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `description` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `sent_date` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,1,'You have a new message','New Message','2022-01-20 10:30:00'),(2,2,'Approval for leave request','Leave Request','2022-01-21 08:45:00'),(3,3,'Reminder: Upcoming meeting','Meeting Reminder','2022-01-22 15:20:00');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `ProjectId` int NOT NULL AUTO_INCREMENT,
  `employee_id_create` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `datefrom` date DEFAULT NULL,
  `dateend` date DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`ProjectId`),
  KEY `KeyforProject_idx` (`employee_id_create`),
  CONSTRAINT `KeyforProject` FOREIGN KEY (`employee_id_create`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,3,'12','2024-11-16','2024-11-12','2');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `InsertManagerProject` AFTER INSERT ON `project` FOR EACH ROW BEGIN
    DECLARE ProjectId INT;
    SET ProjectId = NEW.ProjectId;
    INSERT INTO managerproject (ProjectId, Success)
    VALUES (ProjectId, 1); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DeleteManagerProjectTask` BEFORE DELETE ON `project` FOR EACH ROW BEGIN
    SET foreign_key_checks = 0;
 DELETE FROM tasks WHERE MaID IN (SELECT MaID FROM managerproject WHERE ProjectId = OLD.ProjectId);
 DELETE FROM managerproject WHERE ProjectId = OLD.ProjectId;
SET foreign_key_checks = 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `remainday`
--

DROP TABLE IF EXISTS `remainday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remainday` (
  `remainDay_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `yearOfWork` int DEFAULT NULL,
  `approvedLeaveDays` int DEFAULT NULL,
  `leaveDays` int DEFAULT NULL,
  `remainDay` int DEFAULT NULL,
  `config_id` int DEFAULT NULL,
  PRIMARY KEY (`remainDay_id`),
  KEY `employee_id` (`employee_id`),
  KEY `config_id` (`config_id`),
  CONSTRAINT `remainday_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `remainday_ibfk_2` FOREIGN KEY (`config_id`) REFERENCES `config` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remainday`
--

LOCK TABLES `remainday` WRITE;
/*!40000 ALTER TABLE `remainday` DISABLE KEYS */;
INSERT INTO `remainday` VALUES (1,1,2,5,0,5,1),(2,2,2,2,0,2,1),(3,3,2,8,5,3,1),(4,4,2,8,3,5,1),(5,5,2,8,4,4,1);
/*!40000 ALTER TABLE `remainday` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_remainday_leave_days` AFTER UPDATE ON `remainday` FOR EACH ROW BEGIN
    IF OLD.remainDay < NEW.remainDay THEN
        UPDATE remainday
        SET leaveDays = leaveDays - (OLD.remainDay - NEW.remainDay)
        WHERE employee_id = NEW.employee_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary` (
  `salary_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `attendance_id` int DEFAULT NULL,
  `allowance` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `bonus` decimal(10,2) DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`salary_id`),
  KEY `employee_id` (`employee_id`),
  KEY `department_id` (`department_id`),
  KEY `attendance_id` (`attendance_id`),
  KEY `FK_user_id` (`user_id`),
  CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `salary_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `salary_ibfk_3` FOREIGN KEY (`attendance_id`) REFERENCES `attendance` (`attendance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES (1,2,3,2,1000.00,1000.00,5000.00,'2024-03-01',2),(8,3,2,3,999.00,999.90,999.00,'2022-01-03',3),(9,1,1,1,99999.00,999.90,999999.00,'2022-01-01',1),(10,4,3,4,999.00,999.90,99999.00,'2022-01-04',4),(11,5,1,5,8888.00,888.80,8888.00,'2022-01-05',5);
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `TaskId` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` text,
  `TimeSuccess` date DEFAULT NULL,
  `TimeEnd` date DEFAULT NULL,
  `Success` int DEFAULT '1',
  `MaID` int DEFAULT '1',
  PRIMARY KEY (`TaskId`),
  KEY `employee_id` (`employee_id`),
  KEY `MaID_idx` (`MaID`),
  CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=598 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,3,'3','2024-11-11','2024-11-11','2024-11-11',3,1),(2,3,'3','2024-11-11','2024-11-11','2024-11-11',3,1),(3,3,'3','task đầu tiên','2024-11-11','2024-11-11',3,1);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tasks_AFTER_INSERT` AFTER INSERT ON `tasks` FOR EACH ROW BEGIN
UPDATE managerproject
    SET success = 1
    WHERE managerproject.MaID = NEW.MaID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tasks_AFTER_UPDATE` AFTER UPDATE ON `tasks` FOR EACH ROW BEGIN
 IF NEW.TimeSuccess > NEW.TimeEnd THEN
        UPDATE tasks
        SET success = 2
        WHERE TaskId = NEW.TaskId;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `type_application`
--

DROP TABLE IF EXISTS `type_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_application` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_application`
--

LOCK TABLES `type_application` WRITE;
/*!40000 ALTER TABLE `type_application` DISABLE KEYS */;
INSERT INTO `type_application` VALUES (1,'Nghỉ phép'),(2,'Đi muộn'),(3,'Về sớm'),(4,'Công tác'),(5,'Nghỉ bệnh'),(6,'Nghỉ phục vụ dân sự');
/*!40000 ALTER TABLE `type_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'admin'),(2,'user'),(3,'manager');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','5291a0858dfafff116e37dea26d5bfaf',1),(2,'employee','5291a0858dfafff116e37dea26d5bfaf',2),(3,'manager','5291a0858dfafff116e37dea26d5bfaf',3),(4,'andt204','5291a0858dfafff116e37dea26d5bfaf',3),(5,'truongnn','5291a0858dfafff116e37dea26d5bfaf',3),(6,'vyntt','5291a0858dfafff116e37dea26d5bfaf',3),(7,'minhntb','5291a0858dfafff116e37dea26d5bfaf',3),(8,'tiennv','5291a0858dfafff116e37dea26d5bfaf',2),(9,'haipkh','5291a0858dfafff116e37dea26d5bfaf',2),(10,'nguyenpb','5291a0858dfafff116e37dea26d5bfaf',2),(11,'hieult','5291a0858dfafff116e37dea26d5bfaf',2),(12,'huynh','5291a0858dfafff116e37dea26d5bfaf',2),(13,'viettq','5291a0858dfafff116e37dea26d5bfaf',2),(14,'quannm','5291a0858dfafff116e37dea26d5bfaf',2),(15,'andd123','5291a0858dfafff116e37dea26d5bfaf',2),(16,'hanv123','5291a0858dfafff116e37dea26d5bfaf',2),(17,'quynhnt','5291a0858dfafff116e37dea26d5bfaf',2),(18,'tuannq','5291a0858dfafff116e37dea26d5bfaf',2),(19,'ninhntv','5291a0858dfafff116e37dea26d5bfaf',2),(20,'anhlh123','5291a0858dfafff116e37dea26d5bfaf',2),(21,'beubb','5291a0858dfafff116e37dea26d5bfaf',2),(22,'huanhh9','5291a0858dfafff116e37dea26d5bfaf',2),(23,'longnk','5291a0858dfafff116e37dea26d5bfaf',2),(24,'khanb93','5291a0858dfafff116e37dea26d5bfaf',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'swp34'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `CheckAndUpdateManagerProjectSuccess` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `CheckAndUpdateManagerProjectSuccess` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-03-11 13:28:29' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE managerproject mp
    JOIN (
        SELECT maid
        FROM tasks
        GROUP BY maid
        HAVING SUM(CASE WHEN success <> 3 THEN 1 ELSE 0 END) = 0
    ) t ON mp.maid = t.maid
    SET mp.success = 3;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `check_update_success` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `check_update_success` ON SCHEDULE EVERY 1 MINUTE STARTS '2024-03-10 21:29:06' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE tasks
  SET success = 2
  WHERE TimeSuccess IS NULL
    AND NOW() > CAST(TimeEnd AS DATETIME) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'swp34'
--
/*!50003 DROP PROCEDURE IF EXISTS `generateDailyAttendance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generateDailyAttendance`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_image VARCHAR(128);
    DECLARE emp_department_id INT;
    DECLARE remain_id INT; -- Thêm biến này

    -- Tạo một cursor để lấy employee_id và image từ bảng employee
    DECLARE emp_cursor CURSOR FOR SELECT employee_id, image FROM employee;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN emp_cursor;

    read_loop: LOOP
        FETCH emp_cursor INTO emp_id, emp_image;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Lấy department_id của nhân viên
        SELECT department_id INTO emp_department_id FROM employeedepartment WHERE employee_id = emp_id;

        -- Thay đổi phần này để lấy remainDay_id từ bảng remainday
        SELECT remainDay_id INTO remain_id FROM remainday WHERE employee_id = emp_id;

        -- Kiểm tra xem có bản ghi điểm danh cho nhân viên trong ngày hôm nay chưa
        IF NOT EXISTS (
            SELECT 1 FROM attendance WHERE employee_id = emp_id AND date = CURDATE()
        ) THEN
            -- Thêm bản ghi điểm danh cho nhân viên nếu chưa tồn tại
            INSERT INTO attendance (employee_id, image, remainDay_id, department_id, date, in_status, out_status, status)
            VALUES (emp_id, emp_image, remain_id, emp_department_id, CURDATE(), 'Not yet', 'Not yet', 'Absent');
        END IF;
    END LOOP;

    CLOSE emp_cursor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-27 16:23:07
