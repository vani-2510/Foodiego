-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: online_food
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menuId` int NOT NULL AUTO_INCREMENT,
  `restaurantId` int NOT NULL,
  `itemName` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `ratings` double DEFAULT '0',
  `isAvailable` tinyint(1) DEFAULT '1',
  `imagePath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`menuId`),
  KEY `restaurantId` (`restaurantId`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`restaurantId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Chicken Biryani','Spicy chicken dum biryani',280,4.8,1,'/images/Chicken Biryani.jpg'),(2,1,'Mutton Biryani','Traditional mutton dum biryani',350,4.7,1,'/images/Mutton Biriyani.jpg'),(3,1,'Paneer Biryani','Aromatic paneer biryani',220,4.4,1,'/images/paneer biryani.jpg'),(4,1,'Chicken 65','Crispy spicy chicken starter',240,4.6,1,'/images/chicken 65.jpg'),(5,2,'Hyderabadi Chicken Biryani','Authentic Hyderabadi biryani',260,4.8,1,'/images/Hyderabadi Chicken Biriyani.jpg'),(6,2,'Veg Biryani','Vegetable dum biryani',180,4.3,1,'/images/Veg Biriyani.jpg'),(7,2,'Chicken Fry Piece Biryani','Biryani with fried chicken pieces',290,4.7,1,'/images/Chicken Fry Piece Biriyani.jpg'),(8,3,'Chicken Curry','Spicy chicken curry',260,4.5,1,'/images/Veg Biriyani.jpg'),(9,3,'Butter Naan','Soft naan with butter',45,4.4,1,'/images/Butter Naan.jpg'),(10,3,'Paneer Butter Masala','Paneer in creamy tomato gravy',230,4.6,1,'/images/panner butter masala.jpg'),(11,4,'Chicken Burger','Grilled chicken burger',180,4.5,1,'/images/Chicken Burger.jpg'),(12,4,'Veg Burger','Vegetable patty burger',120,4.2,1,'/images/Veg Burger.jpg'),(13,4,'French Fries','Golden crispy potato fries',100,4.3,1,'/images/French Fries.jpg'),(14,5,'Margherita Pizza','Classic cheese and tomato pizza',249,4.5,1,'/images/Margherita Pizza.jpg'),(15,5,'Farmhouse Pizza','Pizza with fresh vegetables',349,4.6,1,'/images/Farmhouse Pizza.jpg'),(16,5,'Chicken Pizza','Pizza topped with chicken',399,4.7,1,'/images/Chicken Pizza.jpg'),(17,6,'Masala Dosa','Crispy dosa with potato masala',100,4.5,1,'/images/Masala Dosa.jpg'),(18,6,'Idli Sambar','Steamed idlis with sambar',70,4.3,1,'/images/Idli Sambar.jpg'),(19,7,'Veg Fried Rice','Fried rice with fresh vegetables',160,4.2,1,'/images/Veg Fried Rice.jpg'),(20,7,'Chicken Noodles','Stir-fried noodles with chicken',210,4.5,1,'/images/Chicken Noodles.jpg');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `restaurantId` int NOT NULL,
  `orderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `totalAmount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `paymentMode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `userId` (`userId`),
  KEY `restaurantId` (`restaurantId`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`restaurantId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,13,1,'2026-10-30 10:08:01',320.00,'Placed','Cash on Delivery'),(2,13,1,'2026-10-30 11:18:50',390.00,'Placed','UPI'),(3,13,1,'2026-10-30 12:03:33',320.00,'Placed','Cash on Delivery'),(4,15,1,'2026-10-31 06:53:21',320.00,'Placed','Cash on Delivery');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitem` (
  `orderItemId` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `menuId` int NOT NULL,
  `quantity` int NOT NULL,
  `totalPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`orderItemId`),
  KEY `orderId` (`orderId`),
  KEY `menuId` (`menuId`),
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `order` (`orderId`),
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES `menu` (`menuId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (1,1,1,1,280.00),(2,2,2,1,350.00),(3,3,1,1,280.00),(4,4,1,1,280.00);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `restaurantId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `rating` double DEFAULT '0',
  `cusineType` varchar(100) DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  `eta` varchar(50) DEFAULT NULL,
  `adminUserId` varchar(50) DEFAULT NULL,
  `imagePath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`restaurantId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'Meghana Foods','Marathalli','9876459854',4.5,'MultiCuisine',1,'30 mins','image','https://b.zmtcdn.com/data/pictures/1/50691/92d9b4053ef0965120828b4fa4eecc3b.jpg'),(2,'paradaise Biriyani','Whitefiled, Bengaluru','9875764987',4.3,'Indian',1,'35 min','1','https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80'),(3,'Empire Restarunt','Indiranagar, Bengaluru','9878654587',4.2,'MulitCusine',1,'1','2','https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'),(4,'A2B Adyae Ananda Bhavana','Marathalli, Bengaluru','8976986587',4.1,'South Indian',1,'20 mins','1','https://images.unsplash.com/photo-1589302168068-964664d93dc0'),(5,'Truffles','Kormangla, Bengaluru','9876569876',4.4,'American',1,'30 mins','1','https://images.unsplash.com/photo-1568901346375-23c9450c58cd'),(6,'Nagarjuna','Residency Road, Bengaluru','9087898776',4.4,'Andhra',1,'40 mins','1','https://images.unsplash.com/photo-1565299624946-b28f40a0ae38'),(7,'Meghana Foods','BTM Layout','9876568798',4.5,'Andhra',1,'40 mins','1','https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a'),(8,'Paradise Restaurant','MG Road, Bengaluru','9876501001',4.6,'Biryani',1,'25 mins','1','https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'),(9,'Pizza Palace','Indiranagar, Bengaluru','9876501002',4.3,'Pizza',1,'30 mins','1','https://images.unsplash.com/photo-1513104890138-7c749659a591'),(10,'Burger King Cafe','Koramangala, Bengaluru','9876501003',4.2,'Burgers',1,'25 mins','1','https://images.unsplash.com/photo-1568901346375-23c9450c58cd'),(11,'Dominos Pizza','Whitefield, Bengaluru','9876501004',4.4,'Pizza',1,'30 mins','1','https://images.unsplash.com/photo-1579751626657-72bc17010498'),(12,'Sushi House','HSR Layout, Bengaluru','9876501005',4.5,'Japanese',1,'40 mins','1','https://images.unsplash.com/photo-1579871494447-9811cf80d66c'),(13,'Green Leaf Kitchen','Jayanagar, Bengaluru','9876501006',4.1,'Vegetarian',1,'25 mins','1','https://images.unsplash.com/photo-1512621776951-a57141f2eefd'),(14,'Tandoori Treats','BTM Layout, Bengaluru','9876501007',4.4,'North Indian',1,'35 mins','1','https://images.unsplash.com/photo-1546833999-b9f581a1996d'),(15,'Dosa Corner','Rajajinagar, Bengaluru','9876501008',4.2,'South Indian',1,'20 mins','1','https://images.unsplash.com/photo-1668236543090-82eba5ee5976'),(16,'Wok Express','Electronic City, Bengaluru','9876501009',4,'Chinese',1,'35 mins','1','https://images.unsplash.com/photo-1563245372-f21724e3856d'),(17,'Cafe Mocha','Church Street, Bengaluru','9876501010',4.3,'Cafe',1,'20 mins','1','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085'),(18,'Andhra Spice','JP Nagar, Bengaluru','9876501011',4.5,'Andhra',1,'30 mins','1','https://images.unsplash.com/photo-1547592180-85f173990554'),(19,'Rolls & Wraps','Marathahalli, Bengaluru','9876501012',4.1,'Fast Food',1,'25 mins','1','https://images.unsplash.com/photo-1626700051175-6818013e1d4f'),(20,'Sweet Treats Bakery','Malleshwaram, Bengaluru','9876501013',4.6,'Bakery',1,'20 mins','1','https://images.unsplash.com/photo-1509440159596-0249088772ff');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'vani','vanisree\'','vani@6543','vani10@gmail.com','9876655434','teanu beauty parolur ','customer',NULL,NULL),(5,'Nireesha','Niri','Niri@24','niri2425@gmail.com','9087675654','btm layout','customer',NULL,NULL),(6,'Deepthi','Deepthi','deepthi@18','deepu18@gmail.com','7689097645','bommanahalli','customer',NULL,NULL),(7,'likitha','likki','likki@25','likki26@gmail.com','7898876798','btm layout 13th cross','customer',NULL,NULL),(8,'siddu sai','siddu','siddu@76','siddu@gmail.com','8976459834','maruthi nagar','customer',NULL,NULL),(9,'Niri','Niri','niri@24','niri24@gmail.com','7898458767','teanu beauty parlour','customer',NULL,NULL),(10,'sai','sai','sai@65','sai76@gmail.com','7865094523','marathalli','customer',NULL,NULL),(11,'Manoj','Manoj','Manoj@54','manoj65@gmail.com','9876986534','electronic city','customer',NULL,NULL),(12,'Yashwanth','Yashwanth','$2a$12$ICBldTt4QjGGIrYAP1Kay.Achse4bV/2M4aTOJe9ajKn0ly5Y66/K','Yash23@gmail.com','','Yeswanthpur, Bengaluru','CUSTOMER',NULL,NULL),(13,'Sathi','Sathi','$2a$12$Irfq1xo2mRXLCm4GPwP6y.RT2OD0Avf.WmjRb38IZ/WMrtvcDRgiG','sathi@gmail.com','7865876598','Bommanahalli, Bengaluru','CUSTOMER',NULL,NULL),(14,'Nireesha','Nireesha','$2a$12$vuEufsKQzpdWZzcBUsRkI.0AT6sa7BmOAgyvlzqMRKh32l2xJhHs.','niri24@gmail.com','9867548767','BTM Layout, Bengaluru','CUSTOMER',NULL,NULL),(15,'Lokesh','Lokesh','$2a$12$DVFIARAhc1P5jm9lnxcHVeND/sDLFELi9kDVy/f2HRubC6LqIi37e','Loku12@gmail.com','8976547698','Yeswanthpur, bengaluru','CUSTOMER',NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-13 23:42:12
