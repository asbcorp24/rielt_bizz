-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: arenda
-- ------------------------------------------------------
-- Server version	5.7.33-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `landlord_id` bigint(20) unsigned DEFAULT NULL,
  `tenant_id` bigint(20) unsigned DEFAULT NULL,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `contract_body` text COLLATE utf8mb4_unicode_ci,
  `signed_pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_signed_landlord` tinyint(1) DEFAULT '0',
  `is_signed_tenant` tinyint(1) DEFAULT '0',
  `signed_at` timestamp NULL DEFAULT NULL,
  `status` enum('draft','pending_sign','active','terminated','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'draft',
  `deposit_amount` decimal(12,2) DEFAULT NULL,
  `monthly_rent` decimal(12,2) DEFAULT NULL,
  `payment_day` int(11) DEFAULT NULL,
  `payment_period` enum('month','quarter','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `termination_reason` text COLLATE utf8mb4_unicode_ci,
  `is_auto_renewal` tinyint(1) DEFAULT '0',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `landlord_id` (`landlord_id`),
  KEY `tenant_id` (`tenant_id`),
  KEY `property_id` (`property_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`landlord_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contracts_ibfk_3` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contracts_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_templates`
--

DROP TABLE IF EXISTS `data_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fields_json` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_templates`
--

LOCK TABLES `data_templates` WRITE;
/*!40000 ALTER TABLE `data_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uploaded_by` bigint(20) unsigned DEFAULT NULL,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `contract_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uploaded_by` (`uploaded_by`),
  KEY `property_id` (`property_id`),
  KEY `contract_id` (`contract_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `documents_ibfk_3` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned DEFAULT NULL,
  `receiver_id` bigint(20) unsigned DEFAULT NULL,
  `contract_id` bigint(20) unsigned DEFAULT NULL,
  `chat_type` enum('general','documents') COLLATE utf8mb4_unicode_ci DEFAULT 'general',
  `content` text COLLATE utf8mb4_unicode_ci,
  `attachment_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `contract_id` (`contract_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2019_12_14_000001_create_personal_access_tokens_table',1),(2,'2025_04_17_105644_add_expires_at_to_personal_access_tokens_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `is_read` tinyint(1) DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `p2p_confirmations`
--

DROP TABLE IF EXISTS `p2p_confirmations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `p2p_confirmations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) unsigned DEFAULT NULL,
  `receiver_id` bigint(20) unsigned DEFAULT NULL,
  `related_property_id` bigint(20) unsigned DEFAULT NULL,
  `related_contract_id` bigint(20) unsigned DEFAULT NULL,
  `action_type` enum('handover_acceptance','deposit_paid','utility_paid','damage_report','viewing_attended','contract_termination_notice') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `media_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  `signed_by_sender` tinyint(1) DEFAULT '0',
  `signed_by_receiver` tinyint(1) DEFAULT '0',
  `admin_review_required` tinyint(1) DEFAULT '0',
  `confirmed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `related_property_id` (`related_property_id`),
  KEY `related_contract_id` (`related_contract_id`),
  CONSTRAINT `p2p_confirmations_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `p2p_confirmations_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `p2p_confirmations_ibfk_3` FOREIGN KEY (`related_property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `p2p_confirmations_ibfk_4` FOREIGN KEY (`related_contract_id`) REFERENCES `contracts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `p2p_confirmations`
--

LOCK TABLES `p2p_confirmations` WRITE;
/*!40000 ALTER TABLE `p2p_confirmations` DISABLE KEYS */;
/*!40000 ALTER TABLE `p2p_confirmations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payer_id` bigint(20) unsigned DEFAULT NULL,
  `receiver_id` bigint(20) unsigned DEFAULT NULL,
  `contract_id` bigint(20) unsigned DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'RUB',
  `type` enum('rent','deposit','utility','fine') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_system` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payer_id` (`payer_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `contract_id` (`contract_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`payer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `expires_at` timestamp NULL DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',2,'auth_token','93c1b9560e0cc1dd1988bc2a6f6634a49dd6181a91d1d3301d6616f2355b4564','[\"*\"]',NULL,NULL,'2025-04-17 07:59:12','2025-04-17 07:59:12'),(2,'App\\Models\\User',2,'auth_token','8226a1f76011cbc905c1111eeac533f60db5a1da5bbd39eb1731e257e137e0d0','[\"*\"]',NULL,'2025-04-17 08:50:19','2025-04-17 08:02:46','2025-04-17 08:50:19'),(3,'App\\Models\\User',2,'auth_token','01c6482894c143d5303aa5c9d6c1152e98ebf5410b42fcd352b79ee20033d3ca','[\"*\"]',NULL,'2025-04-17 08:51:45','2025-04-17 08:49:40','2025-04-17 08:51:45'),(4,'App\\Models\\User',2,'auth_token','aef975911c1b1712f445a9694f902aa2f07909c85372fa4f6c13c9a7be43dae5','[\"*\"]',NULL,'2025-04-18 07:08:02','2025-04-18 07:04:16','2025-04-18 07:08:02'),(5,'App\\Models\\User',2,'auth_token','bb5474757cea2c14039a3a712e0e03582281d34e9f28221fb4e5aef37087a314','[\"*\"]',NULL,NULL,'2025-04-18 07:45:54','2025-04-18 07:45:54'),(6,'App\\Models\\User',2,'auth_token','8a83ef39cad8c78bc5e97b8ccac254e54b9c4b94b45aa1ec7187beb400b071d3','[\"*\"]',NULL,NULL,'2025-04-18 10:09:39','2025-04-18 10:09:39'),(7,'App\\Models\\User',2,'auth_token','1387b12f051d6514168dc02dfcdd206a718648900d58f32f894aca68db2e57c7','[\"*\"]',NULL,NULL,'2025-04-21 08:47:42','2025-04-21 08:47:42'),(8,'App\\Models\\User',2,'auth_token','5d807dc2feb0c73ba506314d09b85b91e1d6f87c4a3db05210a13bbc1e0ceb42','[\"*\"]',NULL,NULL,'2025-04-21 09:55:12','2025-04-21 09:55:12'),(9,'App\\Models\\User',2,'auth_token','ccd3604d5e63760bf7473d7d8d44ebbf880ee6a0dda76d17e23cc4ce837ebfe5','[\"*\"]',NULL,NULL,'2025-04-21 10:33:29','2025-04-21 10:33:29'),(10,'App\\Models\\User',2,'auth_token','3cc9e99251eefffebda8ecbcc533682f1fafa4c3212462f9a1b155e0916fb8ec','[\"*\"]',NULL,NULL,'2025-04-21 10:33:43','2025-04-21 10:33:43'),(11,'App\\Models\\User',2,'auth_token','ea5b7d6a84e44870263c5b52d3f32de00347ba53efe78262de52a487f3ed7abc','[\"*\"]',NULL,NULL,'2025-04-21 10:36:44','2025-04-21 10:36:44'),(12,'App\\Models\\User',2,'auth_token','4fcb36ebd4316c04984edb085a932902e2f8a1918afc851b6d3a40647338fe40','[\"*\"]',NULL,NULL,'2025-04-23 03:23:20','2025-04-23 03:23:20'),(13,'App\\Models\\User',2,'auth_token','35f2acdcc7a346a16d9920e29e0db3e54f43be1b9342c57b0e90131e141ea56b','[\"*\"]',NULL,NULL,'2025-04-23 03:23:20','2025-04-23 03:23:20'),(14,'App\\Models\\User',2,'auth_token','3c67743bb4def02b82e8dd04de2253d22d952a08dc596c3f83619f696ddde147','[\"*\"]',NULL,NULL,'2025-04-23 03:25:02','2025-04-23 03:25:02'),(15,'App\\Models\\User',2,'auth_token','4e3ba99abb2d58fa7d021cf3513cf2ece8c2964fa06cf92c4bb395971726dd07','[\"*\"]',NULL,'2025-04-23 05:19:50','2025-04-23 04:38:32','2025-04-23 05:19:50'),(16,'App\\Models\\User',2,'auth_token','c724311a732cba96bab444a802ab920063dcbb19fdeb3226688b37483d3d7ad6','[\"*\"]',NULL,'2025-04-23 05:20:29','2025-04-23 05:20:26','2025-04-23 05:20:29'),(17,'App\\Models\\User',2,'auth_token','f62451d62ee1e27fb140fa8b37deee67ccc28cbfec2342b6e7644c07afdc2536','[\"*\"]',NULL,'2025-04-23 10:04:36','2025-04-23 09:33:49','2025-04-23 10:04:36'),(18,'App\\Models\\User',2,'auth_token','78b28637d90b858fa751fff5f90a90ab328e3fdd6656dc6a0ed983d91d3da021','[\"*\"]',NULL,'2025-04-23 10:22:21','2025-04-23 10:20:51','2025-04-23 10:22:21'),(19,'App\\Models\\User',2,'auth_token','164de41fe081e94a57b00cb10dd02fe68318dc719b59bd12bdbbe0364f4ea5e7','[\"*\"]',NULL,'2025-04-24 05:55:47','2025-04-24 05:55:39','2025-04-24 05:55:47'),(20,'App\\Models\\User',2,'auth_token','cf8d820805c5cc85bb59f17813160dc57582fcf7e1abd84809724439b9a458df','[\"*\"]',NULL,'2025-04-24 09:02:26','2025-04-24 07:27:53','2025-04-24 09:02:26'),(21,'App\\Models\\User',2,'auth_token','fcbef0a392bf48e22def80fdcb6b2b06f535a31f4bcab5b7592cde3344d1ad34','[\"*\"]',NULL,'2025-04-24 10:41:20','2025-04-24 10:41:15','2025-04-24 10:41:20'),(22,'App\\Models\\User',2,'auth_token','083a390107d750267f1f3820926449d97616dbc1abc19e1111a07982b408ec3e','[\"*\"]',NULL,NULL,'2025-04-24 10:41:15','2025-04-24 10:41:15'),(23,'App\\Models\\User',2,'auth_token','7932b294d8bbfc77b0ab1bc39da18506bb4594834286b2f1763a6c235fdc4658','[\"*\"]',NULL,'2025-04-25 03:16:10','2025-04-25 03:16:04','2025-04-25 03:16:10'),(24,'App\\Models\\User',2,'auth_token','d6292f3df4b8446372f88230f2e10b7abc80f37cff09d4d0ef253571295e6e04','[\"*\"]',NULL,'2025-04-25 03:54:32','2025-04-25 03:28:34','2025-04-25 03:54:32'),(25,'App\\Models\\User',2,'auth_token','31145298f5e5eea21a1628f1e1fbd7b09e6787b7d5f2c696951587ae9f93e0d7','[\"*\"]',NULL,'2025-04-25 03:56:59','2025-04-25 03:55:24','2025-04-25 03:56:59'),(26,'App\\Models\\User',2,'auth_token','7d1f096d0cf4dad319c500aa4e99fc62bb772f565f7b02a8afad9de0039bccad','[\"*\"]',NULL,'2025-04-25 04:41:48','2025-04-25 04:41:43','2025-04-25 04:41:48'),(27,'App\\Models\\User',2,'auth_token','21cff5cda55c4a336434d121d07379f2dfcad3213155d54bd5e4d9d2218a362a','[\"*\"]',NULL,'2025-04-25 04:51:31','2025-04-25 04:43:13','2025-04-25 04:51:31'),(28,'App\\Models\\User',2,'auth_token','68aef3618bb1ebafa59373d711e16e22af8a6490769e0515c9be07bc74edee4d','[\"*\"]',NULL,'2025-04-25 04:52:23','2025-04-25 04:52:01','2025-04-25 04:52:23'),(29,'App\\Models\\User',2,'auth_token','de0271aae8d6a61d511e3a041964542ed5a72800a09ed86484cb873428621aff','[\"*\"]',NULL,'2025-04-25 04:53:50','2025-04-25 04:53:47','2025-04-25 04:53:50'),(30,'App\\Models\\User',2,'auth_token','2526e69f180c6b742f240bf059977ac743661c81f71bff94b871e7749a60ee63','[\"*\"]',NULL,'2025-04-25 04:56:13','2025-04-25 04:56:10','2025-04-25 04:56:13'),(31,'App\\Models\\User',2,'auth_token','5598cd69eabc3d0344724a4352b75b360a85ad97174134b0db856d89abcb82bf','[\"*\"]',NULL,'2025-04-25 04:56:57','2025-04-25 04:56:13','2025-04-25 04:56:57'),(32,'App\\Models\\User',2,'auth_token','cb174bb9e025bcdefa90c3ad05c1d9a456ae5c3b55380d770103c93aced51b7a','[\"*\"]',NULL,'2025-04-25 05:21:36','2025-04-25 05:20:59','2025-04-25 05:21:36'),(33,'App\\Models\\User',2,'auth_token','9fef430938947484de912a7b0ceda09232b50bb22a284bf2659d239b8092ccd0','[\"*\"]',NULL,'2025-04-25 05:24:44','2025-04-25 05:21:48','2025-04-25 05:24:44'),(34,'App\\Models\\User',2,'auth_token','991b82887ebc1d3e86b5cb934fd5b3879becfdf85fb177d9fc7db2d2e8e551d7','[\"*\"]',NULL,'2025-04-25 05:25:04','2025-04-25 05:25:01','2025-04-25 05:25:04'),(35,'App\\Models\\User',2,'auth_token','23834a179416ffa9273fda51604ee4cf11e257050b0a643dc0ef22302de9af16','[\"*\"]',NULL,'2025-04-25 05:46:11','2025-04-25 05:25:22','2025-04-25 05:46:11');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rooms` int(11) DEFAULT NULL,
  `area_m2` float DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `verified_at` timestamp NULL DEFAULT NULL,
  `verification_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gosuslugi_check_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `building_type` enum('panel','brick','monolith','wood','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `total_floors` int(11) DEFAULT NULL,
  `is_furnished` tinyint(1) DEFAULT '0',
  `has_internet` tinyint(1) DEFAULT '0',
  `can_have_pets` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,2,'ул. Пушкина, д. 10','Казань',2,54.6,0,NULL,NULL,NULL,55.79010000,49.13450000,'brick',4,9,1,1,0,'2025-04-18 07:08:02','2025-04-18 07:08:02');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_attribute_types`
--

DROP TABLE IF EXISTS `property_attribute_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_attribute_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('string','number') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min` float DEFAULT NULL,
  `max` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_attribute_types`
--

LOCK TABLES `property_attribute_types` WRITE;
/*!40000 ALTER TABLE `property_attribute_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_attribute_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_attributes`
--

DROP TABLE IF EXISTS `property_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_attributes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `attribute_type_id` bigint(20) unsigned DEFAULT NULL,
  `value_string` text COLLATE utf8mb4_unicode_ci,
  `value_number` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `attribute_type_id` (`attribute_type_id`),
  CONSTRAINT `property_attributes_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  CONSTRAINT `property_attributes_ibfk_2` FOREIGN KEY (`attribute_type_id`) REFERENCES `property_attribute_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_attributes`
--

LOCK TABLES `property_attributes` WRITE;
/*!40000 ALTER TABLE `property_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_custom_data`
--

DROP TABLE IF EXISTS `user_custom_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_custom_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `template_id` bigint(20) unsigned DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_string` text COLLATE utf8mb4_unicode_ci,
  `value_number` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `user_custom_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_custom_data_ibfk_2` FOREIGN KEY (`template_id`) REFERENCES `data_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_custom_data`
--

LOCK TABLES `user_custom_data` WRITE;
/*!40000 ALTER TABLE `user_custom_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_custom_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_scores`
--

DROP TABLE IF EXISTS `user_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_scores` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `type` enum('increase','decrease') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `score_before` int(11) DEFAULT NULL,
  `score_after` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_scores`
--

LOCK TABLES `user_scores` WRITE;
/*!40000 ALTER TABLE `user_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_verifications`
--

DROP TABLE IF EXISTS `user_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_verifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `type` enum('passport','gosuslugi','property') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `verification_data` json DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_verifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_verifications`
--

LOCK TABLES `user_verifications` WRITE;
/*!40000 ALTER TABLE `user_verifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_verifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `passport_data` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gosuslugi_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('landlord','tenant','realtor') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,NULL,NULL,NULL,'ivan@mail.ru',NULL,'$2y$10$SxevrPCFaZlmRBlzPoHr5..d/b4P34QKcMIReoqPpNMICavB6k/OW',NULL,NULL,'2025-04-17 07:19:15','2025-04-17 07:19:15',NULL),(2,'Иван','Иванов','Иванович','1234 567890','https://esia.gosuslugi.ru/user/profile','ivan@example.com','+79991234567','$2y$10$DHCvYKhzbMA5Nkc5fxLsyuxIaCFWRw/hefZrzpKm1ZXEporOmOtla','tenant',NULL,'2025-04-17 07:42:04','2025-04-17 07:42:04','Иван Иванов');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viewing_requests`
--

DROP TABLE IF EXISTS `viewing_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viewing_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `realtor_id` bigint(20) unsigned DEFAULT NULL,
  `tenant_id` bigint(20) unsigned DEFAULT NULL,
  `requested_time` timestamp NULL DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled','missed') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `realtor_id` (`realtor_id`),
  KEY `tenant_id` (`tenant_id`),
  CONSTRAINT `viewing_requests_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `viewing_requests_ibfk_2` FOREIGN KEY (`realtor_id`) REFERENCES `users` (`id`),
  CONSTRAINT `viewing_requests_ibfk_3` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viewing_requests`
--

LOCK TABLES `viewing_requests` WRITE;
/*!40000 ALTER TABLE `viewing_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `viewing_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'arenda'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-25 12:57:33
