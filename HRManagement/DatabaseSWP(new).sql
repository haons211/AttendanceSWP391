CREATE DATABASE  IF NOT EXISTS swp;
USE swp;
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
    application_id INT AUTO_INCREMENT NOT NULL,
  sender_id INT NOT NULL,
  type_id INT NOT NULL,
  receiver_id INT NOT NULL,
  file VARCHAR(255) NOT NULL,
  title varchar(255) NOT NULL,
  content TEXT NOT NULL,
  status VARCHAR(50) NOT NULL,
  create_date DATETIME NOT NULL,
  complete_date DATETIME,
  replyContent varchar(255)  NULL,
  
  PRIMARY KEY (`application_id`),
  KEY `type_id` (`type_id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `application_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type_application` (`type_id`),
  CONSTRAINT `application_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `application_ibfk_3` FOREIGN KEY (`receiver_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;
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
INSERT INTO `remainday` VALUES (1,1,2,5,3,2,1),(2,2,1,2,1,1,1),(3,3,3,8,4,4,1),(4,4,3,8,2,6,1),(5,5,3,8,3,5,1);
/*!40000 ALTER TABLE `remainday` ENABLE KEYS */;
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
-- Table structure for table `attendance`
--

-- Sửa lại cấu trúc của bảng attendance
DROP TABLE IF EXISTS `attendance`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tạo trigger cho bảng attendance
DELIMITER ;;
CREATE TRIGGER `update_attendance_status_insert` BEFORE INSERT ON `attendance` FOR EACH ROW
BEGIN
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
    ELSE
        SET NEW.status = 'Present';
    END IF;
    
    -- Check if the status is Absent after 17:00 and update remainDay and leaveDays accordingly
    IF TIME(NOW()) > '17:00:00' AND NEW.status = 'Absent' THEN
        UPDATE remainday
        SET remainDay = remainDay - 1, leaveDays = leaveDays + 1
        WHERE employee_id = NEW.employee_id;
    END IF;
END ;;
DELIMITER ;
DELIMITER ;;
CREATE TRIGGER `update_attendance_status_update` BEFORE UPDATE ON `attendance` FOR EACH ROW
BEGIN
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
    ELSE
        SET NEW.status = 'Present';
    END IF;
    
    -- Check if the status is Absent after 17:00 and update remainDay and leaveDays accordingly
    IF TIME(NOW()) > '17:00:00' AND NEW.status = 'Absent' THEN
        UPDATE remainday
        SET remainDay = remainDay - 1, leaveDays = leaveDays + 1
        WHERE employee_id = NEW.employee_id;
    END IF;
END ;;
DELIMITER ;



-- Cập nhật trigger cho bảng remainday
DELIMITER ;;
CREATE TRIGGER `update_remainday_leave_days` AFTER UPDATE ON `remainday` FOR EACH ROW
BEGIN
    IF OLD.remainDay < NEW.remainDay THEN
        UPDATE remainday
        SET leaveDays = leaveDays - (OLD.remainDay - NEW.remainDay)
        WHERE employee_id = NEW.employee_id;
    END IF;
END ;;
DELIMITER ;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES 
(1,1,'van_a.jpg',1,1,'2024-03-01','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(2,2,'thi_b.jpg',2,3,'2024-03-01','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(3,3,'van_c.jpg',3,2,'2024-03-01','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(4,4,'thi_d.jpg',4,3,'2024-03-01','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(5,5,'van_e.jpg',5,1,'2024-03-01','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(6,1,'van_a.jpg',1,1,'2024-03-02','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(7,2,'thi_b.jpg',2,3,'2024-03-02','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(8,3,'van_c.jpg',3,2,'2024-03-02','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(9,4,'thi_d.jpg',4,3,'2024-03-02','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(10,5,'van_e.jpg',5,1,'2024-03-02','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(11,1,'van_a.jpg',1,1,'2024-03-03','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(12,2,'thi_b.jpg',2,3,'2024-03-03','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(13,3,'van_c.jpg',3,2,'2024-03-03','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(14,4,'thi_d.jpg',4,3,'2024-03-03','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(15,5,'van_e.jpg',5,1,'2024-03-03','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(16,1,'van_a.jpg',1,1,'2024-03-04','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(17,2,'thi_b.jpg',2,3,'2024-03-04','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(18,3,'van_c.jpg',3,2,'2024-03-04','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(19,4,'thi_d.jpg',4,3,'2024-03-04','07:50:00','16:00:00','','Checked In','Checked Out','Present'),
(20,5,'van_e.jpg',5,1,'2024-03-04','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(21,1,'van_a.jpg',1,1,'2024-03-05','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(22,2,'thi_b.jpg',2,3,'2024-03-05','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(23,3,'van_c.jpg',3,2,'2024-03-05','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(24,4,'thi_d.jpg',4,3,'2024-03-05','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(25,5,'van_e.jpg',5,1,'2024-03-05','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(26,1,'van_a.jpg',1,1,'2024-03-06','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(27,2,'thi_b.jpg',2,3,'2024-03-06','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(28,3,'van_c.jpg',3,2,'2024-03-06','07:50:00','9:00:00','hehe','Checked In','Checked Out','Present'),
(29,4,'thi_d.jpg',4,3,'2024-03-06','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(30,5,'van_e.jpg',5,1,'2024-03-06','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(31,1,'van_a.jpg',1,1,'2024-03-07','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(32,2,'thi_b.jpg',2,3,'2024-03-07','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(33,3,'van_c.jpg',3,2,'2024-03-07','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(34,4,'thi_d.jpg',4,3,'2024-03-07','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(35,5,'van_e.jpg',5,1,'2024-03-07','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(36,1,'van_a.jpg',1,1,'2024-03-08','07:50:00','9:00:00','','Checked In','Checked Out','Present'),
(37,2,'thi_b.jpg',2,3,'2024-03-08','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(38,3,'van_c.jpg',3,2,'2024-03-08','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(39,4,'thi_d.jpg',4,3,'2024-03-08','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(40,5,'van_e.jpg',5,1,'2024-03-08','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(41,1,'van_a.jpg',1,1,'2024-03-09','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(42,2,'thi_b.jpg',2,3,'2024-03-09','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(43,3,'van_c.jpg',3,2,'2024-03-09','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(44,4,'thi_d.jpg',4,3,'2024-03-09','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(45,5,'van_e.jpg',5,1,'2024-03-09','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(46,1,'van_a.jpg',1,1,'2024-03-10','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(47,2,'thi_b.jpg',2,3,'2024-03-10','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(48,3,'van_c.jpg',3,2,'2024-03-10','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(49,4,'thi_d.jpg',4,3,'2024-03-10','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(50,5,'van_e.jpg',5,1,'2024-03-10','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(51,1,'van_a.jpg',1,1,'2024-03-11','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(52,2,'thi_b.jpg',2,3,'2024-03-11','07:50:00','12:00:00','','Checked In','Checked Out','Present'),
(53,3,'van_c.jpg',3,2,'2024-03-11','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(54,4,'thi_d.jpg',4,3,'2024-03-11','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(55,5,'van_e.jpg',5,1,'2024-03-11','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present'),
(56,1,'van_a.jpg',1,1,'2024-03-12','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(57,2,'thi_b.jpg',2,3,'2024-03-12','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(58,3,'van_c.jpg',3,2,'2024-03-12','07:50:00','17:00:00','hehe','Checked In','Checked Out','Present'),
(59,4,'thi_d.jpg',4,3,'2024-03-12','07:50:00','17:00:00','','Checked In','Checked Out','Present'),
(60,5,'van_e.jpg',5,1,'2024-03-12','07:50:00','17:00:00','hehehe','Checked In','Checked Out','Present')
;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT= 1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Software Engineering','SE'),(2,'Digital Marketing','DM'),(3,'Bussiness Analyst','BA');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
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
  PRIMARY KEY (`employee_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT= 1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Nguyễn Văn A','0987654321','Số 10, Đường Nguyễn Chí Thanh, Hà Nội','van.a@example.com',_binary '','van_a.jpg','1990-05-15','2022-01-01',1),(2,'Trần Thị B','0912345678','Số 20, Đường Lê Lợi, Hồ Chí Minh','thi.b@example.com',_binary '\0','thi_b.jpg','1993-08-25','2022-01-02',2),(3,'Lê Văn C','0905123456','Số 30, Đường Trần Hưng Đạo, Đà Nẵng','van.c@example.com',_binary '','van_c.jpg','1988-02-10','2022-01-03',3),(4,'Hoàng Thị D','0978123456','Số 40, Đường Nguyễn Huệ, Cần Thơ','thi.d@example.com',_binary '\0','thi_d.jpg','1997-11-30','2022-01-04',4),(5,'Phạm Văn E','0987123456','Số 50, Đường Trần Phú, Hải Phòng','van.e@example.com',_binary '','van_e.jpg','1991-04-20','2022-01-05',5);
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
INSERT INTO `employeedepartment` VALUES (1,1),(5,1),(3,2),(2,3),(4,3);
/*!40000 ALTER TABLE `employeedepartment` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
-- Table structure for table `type_application`
--

DROP TABLE IF EXISTS `type_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_application` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'adminuser','5291a0858dfafff116e37dea26d5bfaf',1),(2,'normaluser','5291a0858dfafff116e37dea26d5bfaf',2),(3,'manageruser','5291a0858dfafff116e37dea26d5bfaf',3),(4,'hoangd','5291a0858dfafff116e37dea26d5bfaf',2),(5,'phame','5291a0858dfafff116e37dea26d5bfaf',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'swp'
--

--
-- Dumping routines for database 'swp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-19 21:05:29
DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `file_data` longblob,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managerfile`
--

LOCK TABLES `managerfile` WRITE;
/*!40000 ALTER TABLE `managerfile` DISABLE KEYS */;
/*!40000 ALTER TABLE `managerfile` ENABLE KEYS */;
UNLOCK TABLES;



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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,3,'12','2024-11-16','2024-11-12','2'),(13,3,'PetShop','2024-03-01','2024-03-09','222222333333'),(14,3,'PetShop1','2024-03-13','2024-03-30','222222333333');
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

    -- Láº¥y ProjectId tá»« báº£ng project vá»«a ÄÆ°á»£c insert
    SET ProjectId = NEW.ProjectId;

    -- Insert dá»¯ liá»u vÃ o báº£ng managerproject
    INSERT INTO managerproject (ProjectId, Success)
    VALUES (ProjectId, 1); -- Giáº£ sá»­ "Success" ÄÃ£ ÄÆ°á»£c Äáº·t lÃ  giÃ¡ trá» máº·c Äá»nh 1
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
    -- Táº¡m vÃ´ hiá»u hÃ³a rÃ ng buá»c khÃ³a ngoáº¡i trÃªn cá»t ProjectId trong báº£ng managerproject
    SET foreign_key_checks = 0;

    -- XÃ³a dá»¯ liá»u tá»« báº£ng task dá»±a trÃªn cÃ¡c dÃ²ng trong báº£ng managerproject liÃªn káº¿t vá»i ProjectId sáº½ bá» xÃ³a
    DELETE FROM tasks WHERE MaID IN (SELECT MaID FROM managerproject WHERE ProjectId = OLD.ProjectId);

    -- XÃ³a dá»¯ liá»u tá»« báº£ng managerproject dá»±a trÃªn ProjectId
    DELETE FROM managerproject WHERE ProjectId = OLD.ProjectId;

    -- KÃ­ch hoáº¡t láº¡i rÃ ng buá»c khÃ³a ngoáº¡i
    SET foreign_key_checks = 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managerproject`
--

LOCK TABLES `managerproject` WRITE;
/*!40000 ALTER TABLE `managerproject` DISABLE KEYS */;
INSERT INTO `managerproject` VALUES (1,1,1),(15,13,1),(16,14,1);
/*!40000 ALTER TABLE `managerproject` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table `project`
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
) ENGINE=InnoDB AUTO_INCREMENT=591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,3,'3','2024-11-11','2024-11-11','2024-11-11',3,1),(2,3,'3','2024-11-11','2024-11-11','2024-11-11',3,1),(4,3,'3','3','2024-11-11','2024-11-11',3,1),(576,4,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi','2024-03-02','2024-03-02',3,1),(577,4,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi','2024-03-02','2024-03-02',1,1),(578,3,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi','2024-03-09','2024-03-09',3,1),(579,4,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi','2024-11-11','2024-02-09',2,1),(580,4,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi',NULL,'2024-03-09',2,15),(581,4,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi','2024-03-11','2024-03-12',3,15),(582,4,'LÃ m cÃ¡i nÃ y Äi','LÃ m cÃ¡i nÃ y Äi','2024-03-11','2024-03-12',3,15),(584,3,'Shoptaycam','LÃ m cÃ¡i nÃ y Äi','2024-03-11','2024-03-16',3,16),(585,4,'Shoptaycam','LÃ m cÃ¡i nÃ y Äi','2024-03-11','2024-03-23',3,16),(586,3,'CÆ°á»ng Nguyá»n Máº¡nh CÆ°á»ng','LÃ m cÃ¡i nÃ y Äi','2024-03-11','2024-03-16',3,16),(587,3,'Nguyen Van A','LÃ m cÃ¡i nÃ y Äi','2024-03-11','2024-03-16',3,16),(588,3,'CÆ°á»ng Nguyá»n Máº¡nh CÆ°á»ng','2222','2024-03-11','2024-03-16',3,16),(589,3,'CÆ°á»ng Nguyá»n Máº¡nh CÆ°á»ng','31312312','2024-03-11','2024-03-16',3,16),(590,4,'CÆ°á»ng Nguyá»n Máº¡nh CÆ°á»ng','LÃ m cÃ¡i nÃ y Äi',NULL,'2024-03-16',1,16);
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




---------------------------------------------------------------------

--
-- Dumping events for database 'swp'
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
-- Dumping routines for database 'swp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-11 16:12:39



DELIMITER $$

CREATE PROCEDURE generateDailyAttendance()
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
END$$


DELIMITER ;

CREATE TABLE UserCheckStatus (
    check_id int PRIMARY KEY AUTO_INCREMENT,
    employee_id int,
    CheckedIn BOOLEAN,
    CheckedOut BOOLEAN,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);


CREATE TABLE insurance (
    insurance_id INT PRIMARY KEY,
    employee_id INT,
    insurance_company VARCHAR(100),
    policy_number VARCHAR(50),
    coverage_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    premium_amount DECIMAL(10, 2),
    deductible DECIMAL(10, 2),
    co_pay DECIMAL(10, 2),
    coverage_details TEXT,
    policy_type VARCHAR(50),
    policy_issuer VARCHAR(100),
    beneficiary VARCHAR(100),
    coverage_limit DECIMAL(15, 2),
    renewal_date DATE,
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Nhập 10 thông tin vào bảng Insurance_Info
INSERT INTO insurance (insurance_id, employee_id, insurance_company, policy_number, coverage_type, start_date, end_date, premium_amount, deductible, co_pay, coverage_details, policy_type, policy_issuer, beneficiary, coverage_limit, renewal_date)
VALUES 
    (1, 1, 'ABC Insurance', 'POL001', 'Health', '2024-01-01', '2025-01-01', 1000.00, 100.00, 20.00, 'Health checkups', 'Health Insurance', 'ABC Insurance', NULL, 5000.00, '2025-01-01'),
    (2, 2, 'XYZ Insurance', 'POL002', 'Life', '2024-03-15', '2034-03-15', 500.00, NULL, NULL, 'Death Benefit', 'Life Insurance', 'XYZ Insurance', 'Family', 100000.00, '2034-03-15'),
    (3, 3, 'ABC Insurance', 'POL003', 'Accident', '2023-06-01', '2024-06-01', 800.00, 50.00, NULL, 'Medical Expense', 'Accident Insurance', 'ABC Insurance', NULL, 2000.00, '2024-06-01'),
    (4, 4, 'DEF Insurance', 'POL004', 'Health', '2023-12-01', '2024-12-01', 1200.00, 150.00, 30.00, 'Hospitalization', 'Health Insurance', 'DEF Insurance', NULL, 8000.00, '2024-12-01'),
    (5, 5, 'GHI Insurance', 'POL005', 'Health', '2024-02-01', '2025-02-01', 1100.00, 120.00, 25.00, 'Dental Care', 'Health Insurance', 'GHI Insurance', NULL, 6000.00, '2025-02-01');
    
    
    CREATE TABLE dependents (
    dependent_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    relationship VARCHAR(50),
    gender BOOLEAN, -- Sử dụng BOOLEAN để biểu diễn giới tính
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);
CREATE TABLE `message` (
                           `message_id` int NOT NULL AUTO_INCREMENT,
                           `sender_id` int NOT NULL,
                           `content` TEXT NOT NULL,
                           `timestamp` DATETIME NOT NULL,
                           PRIMARY KEY (`message_id`),
                           CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO dependents (dependent_id, employee_id, name, date_of_birth, relationship, gender)
VALUES
    (1, 1, 'Alice Doe', '1990-01-01', 'Spouse', TRUE),       
    (2, 1, 'Emma Doe', '2010-05-15', 'Child', TRUE),          
    (3, 2, 'Tom Smith', '1995-06-20', 'Spouse', FALSE),        
    (4, 3, 'Sarah Johnson', '1992-11-15', 'Spouse', TRUE),    
    (5, 3, 'Liam Johnson', '2010-09-25', 'Child', FALSE),      
    (6, 4, 'Olivia Williams', '2005-08-12', 'Child', TRUE),   
    (7, 5, 'Noah Brown', '2018-03-30', 'Child', FALSE),        
    (8, 6, 'Sophia Miller', '2002-06-18', 'Child', TRUE),     
    (9, 7, 'James Wilson', '2012-12-03', 'Child', FALSE),      
    (10, 7, 'Ava Wilson', '2015-09-10', 'Child', TRUE),      
    (11, 8, 'Emily Wilson', '2018-07-20', 'Child', TRUE),     
    (12, 8, 'Jacob Wilson', '2020-02-12', 'Child', FALSE),     
    (13, 8, 'Sophie Wilson', '2022-01-05', 'Child', TRUE),    
    (14, 9, 'Oliver Smith', '2017-10-10', 'Child', FALSE),     
    (15, 9, 'Charlotte Smith', '2019-04-25', 'Child', NULL),
    (16, 10, 'Ethan Brown', '2016-12-15', 'Child', FALSE),     
    (17, 10, 'Amelia Brown', '2018-08-20', 'Child', TRUE);
    
    

