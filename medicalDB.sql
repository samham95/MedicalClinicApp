-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: medicaldatabase3380.mysql.database.azure.com    Database: medicalclinicdb2
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `doctorID` int NOT NULL,
  `patientID` int DEFAULT NULL,
  `Approval` tinyint(1) DEFAULT '0',
  `reportID` int DEFAULT NULL,
  `officeID` int NOT NULL,
  `Referral` tinyint(1) DEFAULT '0',
  `AppointmentDate` date DEFAULT NULL,
  `AppointmentTime` time DEFAULT NULL,
  `PATIENT_CONFIRM` tinyint(1) DEFAULT NULL,
  `archive` tinyint(1) DEFAULT '0',
  `cancellation_reason` varchar(255) DEFAULT NULL,
  `nurseID` int DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `doctor_idx` (`doctorID`),
  KEY `patient_idx` (`patientID`),
  KEY `officeID` (`officeID`),
  KEY `reportID_foreignkey` (`reportID`),
  CONSTRAINT `APPOINTMENT_ibfk_1` FOREIGN KEY (`officeID`) REFERENCES `office` (`officeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `doctorID_FK` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`DoctorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patientID_FK` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reportID_foreignkey` FOREIGN KEY (`reportID`) REFERENCES `visit_details` (`reportID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30087 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_appointment_approval` BEFORE INSERT ON `appointment` FOR EACH ROW BEGIN
  DECLARE specialist_check varchar(20);
  SELECT DOCTOR.specialty INTO specialist_check FROM DOCTOR WHERE doctorID = NEW.doctorID;
  
IF (specialist_check NOT LIKE 'PCP') THEN
	SET NEW.referral = 0;
ELSE
	SET NEW.referral = NULL;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `modify_app` BEFORE UPDATE ON `appointment` FOR EACH ROW BEGIN
  IF NEW.appointmentDate != OLD.appointmentDate OR NEW.appointmentTime != OLD.appointmentTime THEN
    SET NEW.approval = 0, NEW.patient_confirm = NULL;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `reset_confirm` BEFORE UPDATE ON `appointment` FOR EACH ROW BEGIN
IF (NEW.PATIENT_CONFIRM = 1 AND OLD.PATIENT_CONFIRM =1 AND OLD.approval = 1 AND NEW.approval = 0) THEN
	SET NEW.PATIENT_CONFIRM = NULL;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `prevent_nurse_change` BEFORE UPDATE ON `appointment` FOR EACH ROW BEGIN
IF (NEW.nurseID != OLD.nurseID AND (OLD.nurseID IS NOT NULL OR NEW.nurseID IS NOT NULL)) THEN
	SET NEW.nurseID = OLD.nurseID;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_appointment_confirm` BEFORE UPDATE ON `appointment` FOR EACH ROW BEGIN
IF (NEW.Approval = 1 AND OLD.Approval = 0 AND (NEW.Referral = 1 OR NEW.Referral IS NULL)) THEN
	SET NEW.PATIENT_CONFIRM = 0;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `prevent_confirm_no_referral_or_approval` BEFORE UPDATE ON `appointment` FOR EACH ROW BEGIN
	IF (NEW.PATIENT_CONFIRM = 1 AND (OLD.PATIENT_CONFIRM IS NULL OR OLD.PATIENT_CONFIRM = 0) AND (OLD.approval = 0 OR OLD.Referral = 0)) THEN
		SET NEW.PATIENT_CONFIRM = NULL;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(20) NOT NULL,
  `Mname` varchar(20) DEFAULT NULL,
  `Lname` varchar(20) NOT NULL,
  `Specialty` varchar(20) DEFAULT 'PCP',
  `DOB` date DEFAULT NULL,
  `Work_email` varchar(50) DEFAULT NULL,
  `Phone_num` varchar(12) DEFAULT NULL,
  `archive` tinyint(1) NOT NULL DEFAULT '0',
  `Salary` int DEFAULT NULL,
  PRIMARY KEY (`DoctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=1032 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emergency_contact_employee`
--

DROP TABLE IF EXISTS `emergency_contact_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergency_contact_employee` (
  `fName` varchar(20) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `relation` varchar(20) DEFAULT NULL,
  `Phone_num` char(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `relationID` int DEFAULT NULL,
  `staffID` int NOT NULL,
  KEY `EMERGENCY_CONTACT_EMPLOYEE_ibfk_1` (`staffID`),
  CONSTRAINT `EMERGENCY_CONTACT_EMPLOYEE_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emergency_contact_patient`
--

DROP TABLE IF EXISTS `emergency_contact_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergency_contact_patient` (
  `fullname` varchar(50) DEFAULT NULL,
  `Relation` varchar(20) DEFAULT NULL,
  `Phone_num` char(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `patientID` int NOT NULL,
  UNIQUE KEY `patientID` (`patientID`),
  UNIQUE KEY `email` (`email`),
  KEY `EMERGENCY_CONTACT_PATIENT_ibfk_1` (`patientID`),
  CONSTRAINT `EMERGENCY_CONTACT_PATIENT_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluation` (
  `code` int NOT NULL AUTO_INCREMENT,
  `test` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance` (
  `InsuranceID` int NOT NULL AUTO_INCREMENT,
  `group_no` varchar(50) DEFAULT NULL,
  `Insurance_Name` varchar(50) DEFAULT NULL,
  `patientID` int DEFAULT NULL,
  PRIMARY KEY (`InsuranceID`),
  KEY `patientID` (`patientID`),
  CONSTRAINT `insurance_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `connect_insurance` AFTER INSERT ON `insurance` FOR EACH ROW UPDATE patients
    SET insuranceID = NEW.insuranceID
    WHERE patientID = NEW.patientID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `invoiceID` int NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) DEFAULT NULL,
  `claim` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL,
  `patientID` int DEFAULT NULL,
  `reportID` int DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`invoiceID`),
  KEY `INVOICE_ibfk_1` (`patientID`),
  KEY `reportID_fk` (`reportID`),
  CONSTRAINT `INVOICE_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reportID_fk` FOREIGN KEY (`reportID`) REFERENCES `visit_details` (`reportID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `add_invoice_due_date` BEFORE INSERT ON `invoice` FOR EACH ROW SET NEW.due_date = DATE_ADD(CURRENT_DATE(), INTERVAL 30 DAY) */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_patID` BEFORE INSERT ON `invoice` FOR EACH ROW BEGIN
    DECLARE appt_patientID INT;
    SELECT patientID INTO appt_patientID FROM appointment WHERE appointment.reportID = NEW.reportID;
    SET NEW.patientID = appt_patientID;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_patient_total` AFTER INSERT ON `invoice` FOR EACH ROW UPDATE PATIENTS
	SET balance = balance + NEW.total - NEW.claim - NEW.paid_amount
	WHERE PATIENTS.patientID = NEW.patientID */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_invoiceID` AFTER INSERT ON `invoice` FOR EACH ROW UPDATE visit_details
    SET visit_details.billingID = NEW.invoiceID
    WHERE visit_details.reportID = NEW.reportID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `username` varchar(40) NOT NULL,
  `passwrd` varchar(40) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `patientID` int DEFAULT NULL,
  `doctorID` int DEFAULT NULL,
  `nurseID` int DEFAULT NULL,
  `adminID` int DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `patientID` (`patientID`),
  KEY `doctorID` (`doctorID`),
  KEY `nurseID` (`nurseID`),
  CONSTRAINT `login_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `login_ibfk_2` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`DoctorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `login_ibfk_3` FOREIGN KEY (`nurseID`) REFERENCES `nurse` (`NID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse` (
  `NID` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(20) NOT NULL,
  `Mname` varchar(20) DEFAULT NULL,
  `Lname` varchar(20) NOT NULL,
  `Work_email` varchar(50) DEFAULT NULL,
  `pay` decimal(10,2) DEFAULT NULL,
  `officeID` int DEFAULT NULL,
  `Phone_num` varchar(20) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `archive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`NID`),
  KEY `NURSE_ibfk_1` (`officeID`),
  CONSTRAINT `NURSE_ibfk_1` FOREIGN KEY (`officeID`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2045 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `calculate_total_nurses` AFTER INSERT ON `nurse` FOR EACH ROW UPDATE office
	SET numNurses = numNurses + 1
    WHERE NEW.officeID = officeID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office` (
  `officeID` int NOT NULL,
  `officeAddress` varchar(80) DEFAULT NULL,
  `phone_num` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`officeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `PatientID` int NOT NULL AUTO_INCREMENT,
  `fName` varchar(20) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `Minitial` varchar(10) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Phone_num` char(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `balance` int DEFAULT '0',
  `insuranceID` int DEFAULT NULL,
  `doctorID` int DEFAULT NULL,
  `payment` int DEFAULT '0',
  `gender` varchar(20) DEFAULT 'other',
  `pharmacy_name` varchar(50) DEFAULT NULL,
  `pharmacy_address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `PATIENTS_ibfk_2` (`insuranceID`),
  KEY `PATIENTS_ibfk_3` (`doctorID`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`insuranceID`) REFERENCES `insurance` (`InsuranceID`),
  CONSTRAINT `PATIENTS_ibfk_3` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`DoctorID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `NDC` varchar(50) DEFAULT NULL,
  `drug_name` varchar(50) DEFAULT NULL,
  `dosage` varchar(50) DEFAULT NULL,
  `refills` int DEFAULT NULL,
  `patientID` int NOT NULL,
  `prescriptionID` int NOT NULL AUTO_INCREMENT,
  `notes` varchar(1000) DEFAULT NULL,
  `reportID` int DEFAULT NULL,
  `prescribed_date` date DEFAULT NULL,
  `doctorID` int DEFAULT NULL,
  PRIMARY KEY (`prescriptionID`),
  KEY `patientID` (`patientID`),
  KEY `doctorID` (`doctorID`),
  CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`),
  CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`DoctorID`)
) ENGINE=InnoDB AUTO_INCREMENT=5009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `set_prescription_date` BEFORE INSERT ON `prescriptions` FOR EACH ROW BEGIN
		IF NEW.prescribed_date is NULL THEN
			SET NEW.prescribed_date = current_date();
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_prescriptID` AFTER INSERT ON `prescriptions` FOR EACH ROW UPDATE visit_details
    SET visit_details.prescriptionID = NEW.prescriptionID
    WHERE NEW.reportID = visit_details.reportID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `Monday` int DEFAULT NULL,
  `Tuesday` int DEFAULT NULL,
  `Wednesday` int DEFAULT NULL,
  `Thursday` int DEFAULT NULL,
  `Friday` int DEFAULT NULL,
  `doctor` int NOT NULL,
  UNIQUE KEY `unique_doctor` (`doctor`),
  KEY `SCHEDULE_ibfk_1` (`doctor`),
  KEY `SCHEDULE_ibfk_2` (`Monday`),
  KEY `SCHEDULE_ibfk_3` (`Wednesday`),
  KEY `SCHEDULE_ibfk_4` (`Thursday`),
  KEY `SCHEDULE_ibfk_5` (`Friday`),
  KEY `SCHEDULE_ibfk_6` (`Tuesday`),
  CONSTRAINT `SCHEDULE_ibfk_1` FOREIGN KEY (`doctor`) REFERENCES `doctor` (`DoctorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SCHEDULE_ibfk_2` FOREIGN KEY (`Monday`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `SCHEDULE_ibfk_3` FOREIGN KEY (`Wednesday`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `SCHEDULE_ibfk_4` FOREIGN KEY (`Thursday`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `SCHEDULE_ibfk_5` FOREIGN KEY (`Friday`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `SCHEDULE_ibfk_6` FOREIGN KEY (`Tuesday`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `FName` varchar(20) DEFAULT NULL,
  `LName` varchar(20) DEFAULT NULL,
  `SRole` varchar(20) DEFAULT NULL,
  `Pay` varchar(20) DEFAULT NULL,
  `officeID` int DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Work_email` varchar(50) DEFAULT NULL,
  `Phone_num` varchar(12) DEFAULT NULL,
  `archive` tinyint(1) NOT NULL DEFAULT '0',
  `Salary` int DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  KEY `STAFF_ibfk_2` (`officeID`),
  CONSTRAINT `STAFF_ibfk_1` FOREIGN KEY (`officeID`) REFERENCES `office` (`officeID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `test_code` int DEFAULT NULL,
  `patientID` int DEFAULT NULL,
  `officeID` int DEFAULT NULL,
  `test_date` date DEFAULT NULL,
  `testID` int NOT NULL AUTO_INCREMENT,
  `nurseID` int DEFAULT NULL,
  `test_time` time DEFAULT NULL,
  PRIMARY KEY (`testID`),
  KEY `patientID` (`patientID`),
  KEY `officeID` (`officeID`),
  KEY `test_code` (`test_code`),
  KEY `nurseID` (`nurseID`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `patients` (`PatientID`),
  CONSTRAINT `test_ibfk_2` FOREIGN KEY (`officeID`) REFERENCES `office` (`officeID`),
  CONSTRAINT `test_ibfk_3` FOREIGN KEY (`test_code`) REFERENCES `evaluation` (`code`),
  CONSTRAINT `test_ibfk_4` FOREIGN KEY (`nurseID`) REFERENCES `nurse` (`NID`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `prevent_nurse_change_test` BEFORE UPDATE ON `test` FOR EACH ROW BEGIN
IF (NEW.nurseID != OLD.nurseID AND (OLD.nurseID IS NOT NULL OR NEW.nurseID IS NOT NULL)) THEN
	SET NEW.nurseID = OLD.nurseID;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `visit_details`
--

DROP TABLE IF EXISTS `visit_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_details` (
  `reportID` int NOT NULL AUTO_INCREMENT,
  `prescription` varchar(100) DEFAULT NULL,
  `Diagnosis` varchar(100) DEFAULT NULL,
  `appointmentID` int NOT NULL,
  `billingID` int DEFAULT NULL,
  `temperature` varchar(3) DEFAULT NULL,
  `symptoms` varchar(200) DEFAULT NULL,
  `nurseID` int DEFAULT NULL,
  `heartRate` int DEFAULT NULL,
  `furtherEval` int DEFAULT NULL,
  `prescriptionID` int DEFAULT NULL,
  `prescriptionRequired` tinyint(1) DEFAULT NULL,
  `height_inches` int DEFAULT NULL,
  `weight_lb` int DEFAULT NULL,
  `bloodPressure_sys` int DEFAULT NULL,
  `bloodPressure_dia` int DEFAULT NULL,
  PRIMARY KEY (`reportID`),
  KEY `REPORT_ibfk_2` (`appointmentID`),
  KEY `REPORT_ibfk_4` (`billingID`),
  KEY `nurseID` (`nurseID`),
  KEY `furtherEval` (`furtherEval`),
  KEY `prescriptionID` (`prescriptionID`),
  CONSTRAINT `REPORT_ibfk_2` FOREIGN KEY (`appointmentID`) REFERENCES `appointment` (`AppointmentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `REPORT_ibfk_4` FOREIGN KEY (`billingID`) REFERENCES `invoice` (`invoiceID`) ON UPDATE CASCADE,
  CONSTRAINT `visit_details_ibfk_1` FOREIGN KEY (`nurseID`) REFERENCES `nurse` (`NID`),
  CONSTRAINT `visit_details_ibfk_2` FOREIGN KEY (`furtherEval`) REFERENCES `evaluation` (`code`),
  CONSTRAINT `visit_details_ibfk_3` FOREIGN KEY (`prescriptionID`) REFERENCES `prescriptions` (`prescriptionID`)
) ENGINE=InnoDB AUTO_INCREMENT=20031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_reportID` AFTER INSERT ON `visit_details` FOR EACH ROW UPDATE appointment
    SET appointment.reportID = NEW.reportID
    WHERE appointment.appointmentID = NEW.appointmentID */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `update_test` AFTER INSERT ON `visit_details` FOR EACH ROW BEGIN
DECLARE patID int;
SELECT patientID into patID FROM appointment WHERE appointmentID = NEW.appointmentID;
    IF (NEW.furtherEval IS NOT NULL) THEN
		INSERT into test(test_code,patientID)
        VALUES (NEW.furtherEval, patID);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'medicalclinicdb2'
--

--
-- Dumping routines for database 'medicalclinicdb2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-22 17:41:14
