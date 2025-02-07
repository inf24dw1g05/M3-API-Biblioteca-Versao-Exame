CREATE DATABASE  IF NOT EXISTS `biblioteca_m3_recurso` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca_m3_recurso`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: biblioteca_m3_recurso
-- ------------------------------------------------------
-- Server version	8.0.40

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
USE biblioteca_m3_recurso;

-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: biblioteca_m3_recurso
-- ------------------------------------------------------
-- Server version	8.0.40

SET NAMES utf8;
SET TIME_ZONE = '+00:00';
SET UNIQUE_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET SQL_NOTES = 0;

--
-- Table structure for table `Categoria`
--

DROP TABLE IF EXISTS Categoria;
CREATE TABLE Categoria (
  id INT AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY nome (nome)
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Categoria`
--

LOCK TABLES Categoria WRITE;
INSERT INTO Categoria VALUES
  (9, 'Aventura'),
  (18, 'Drama'),
  (13, 'Fantasia'),
  (20, 'Fantasia Épica'),
  (1, 'Ficção Científica'),
  (8, 'Ficção Contemporânea'),
  (3, 'Ficção Distópica'),
  (12, 'Ficção Existencialista'),
  (7, 'Ficção Satírica'),
  (11, 'Literatura Infantil'),
  (16, 'Poesia Épica'),
  (23, 'Prosa Poética'),
  (6, 'Realismo Mágico'),
  (2, 'Romance'),
  (4, 'Romance Clássico'),
  (5, 'Romance Gótico'),
  (10, 'Romance Histórico'),
  (17, 'Suspense'),
  (22, 'Terror');
UNLOCK TABLES;

--
-- Table structure for table `Emprestimo`
--

DROP TABLE IF EXISTS Emprestimo;
CREATE TABLE Emprestimo (
  id INT AUTO_INCREMENT,
  dataEmprestimo DATE NOT NULL,
  dataDevolucao DATE NOT NULL,
  livroId INT NOT NULL,
  utilizadorId INT NOT NULL,
  PRIMARY KEY (id),
  KEY livroId (livroId),
  KEY utilizadorId (utilizadorId),
  CONSTRAINT Emprestimo_ibfk_1 FOREIGN KEY (livroId) REFERENCES Livro (id),
  CONSTRAINT Emprestimo_ibfk_2 FOREIGN KEY (utilizadorId) REFERENCES Utilizador (id),
  CONSTRAINT check_datas CHECK (dataDevolucao >= dataEmprestimo)
) ENGINE = InnoDB AUTO_INCREMENT = 35 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Emprestimo`
--

LOCK TABLES Emprestimo WRITE;
INSERT INTO Emprestimo VALUES
  (5, '2025-01-06', '2025-01-24', 30, 29),
  (6, '2025-01-11', '2025-01-25', 31, 23),
  (7, '2025-02-01', '2025-02-08', 31, 29),
  (9, '2025-01-28', '2025-02-04', 29, 29),
  (10, '2025-01-28', '2025-02-04', 26, 28),
  (11, '2025-02-01', '2025-02-08', 25, 26),
  (12, '2025-01-31', '2025-02-05', 25, 29),
  (13, '2025-01-21', '2025-01-30', 27, 28),
  (14, '2025-01-24', '2025-02-01', 33, 28),
  (15, '2025-01-31', '2025-02-06', 27, 16),
  (16, '2025-02-05', '2025-02-13', 14, 13),
  (17, '2025-01-23', '2025-01-31', 21, 24),
  (18, '2025-01-31', '2025-02-06', 12, 15),
  (19, '2025-02-05', '2025-02-08', 17, 17),
  (20, '2025-01-25', '2025-01-28', 12, 13),
  (21, '2025-01-25', '2025-01-31', 10, 16),
  (22, '2025-02-06', '2025-02-08', 16, 11),
  (23, '2025-01-26', '2025-01-29', 13, 9),
  (24, '2025-02-02', '2025-02-04', 14, 13),
  (25, '2025-02-01', '2025-02-03', 10, 8),
  (26, '2025-02-01', '2025-02-05', 15, 11),
  (27, '2025-02-01', '2025-02-04', 13, 11),
  (28, '2025-01-31', '2025-02-02', 11, 7),
  (29, '2025-02-03', '2025-02-06', 18, 8),
  (30, '2025-02-14', '2025-02-19', 10, 9),
  (31, '2025-02-02', '2025-02-05', 9, 27),
  (32, '2025-01-31', '2025-02-04', 23, 11),
  (33, '2025-01-16', '2025-01-29', 9, 6),
  (34, '2025-01-29', '2025-02-01', 18, 13);
UNLOCK TABLES;

--
-- Table structure for table `Livro`
--

DROP TABLE IF EXISTS Livro;
CREATE TABLE Livro (
  id INT AUTO_INCREMENT,
  titulo VARCHAR(200) NOT NULL,
  autor VARCHAR(100) NOT NULL,
  anoPublicacao INT DEFAULT NULL,
  categoriaId INT DEFAULT NULL,
  PRIMARY KEY (id),
  KEY categoriaId (categoriaId),
  CONSTRAINT Livro_ibfk_1 FOREIGN KEY (categoriaId) REFERENCES Categoria (id)
) ENGINE = InnoDB AUTO_INCREMENT = 34 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Livro`
--

LOCK TABLES Livro WRITE;
INSERT INTO Livro VALUES
  (4, '1984', 'George Orwell', 1949, 3),
  (5, 'Dom Quixote', 'Miguel de Cervantes', 1605, 4),
  (6, 'O Monte dos Vendavais', 'Emily Brontë', 1847, 5),
  (7, 'Orgulho e Preconceito', 'Jane Austen', 1813, 2),
  (8, 'Cem Anos de Solidão', 'Gabriel García Márquez', 1967, 6),
  (9, 'O Triunfo dos Porcos', 'George Orwell', 1945, 7),
  (10, 'Uma Agulha no Palheiro', 'J.D. Salinger', 1951, 8),
  (11, 'Moby Dick', 'Herman Melville', 1851, 9),
  (12, 'Os Miseráveis', 'Victor Hugo', 1862, 10),
  (13, 'O Principezinho', 'Antoine de Saint-Exupéry', 1943, 11),
  (14, 'A Metamorfose', 'Franz Kafka', 1915, 12),
  (15, 'O Senhor dos Anéis: A Irmandade do Anel', 'J.R.R. Tolkien', 1954, 13),
  (16, 'Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 1997, 13),
  (17, 'Admirável Mundo Novo', 'Aldous Huxley', 1932, 3),
  (18, 'A Divina Comédia', 'Dante Alighieri', 1320, 16),
  (19, 'O Código Da Vinci', 'Dan Brown', 2003, 17),
  (20, 'A Rapariga que Roubava Livro', 'Markus Zusak', 2005, 18),
  (21, 'O Hobbit', 'J.R.R. Tolkien', 1937, 13),
  (
--

DROP TABLE IF EXISTS `Categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categoria`
--

LOCK TABLES `Categoria` WRITE;
/*!40000 ALTER TABLE `Categoria` DISABLE KEYS */;
INSERT INTO `Categoria` VALUES (9,'Aventura'),(18,'Drama'),(13,'Fantasia'),(20,'Fantasia Épica'),(1,'Ficção Científica'),(8,'Ficção Contemporânea'),(3,'Ficção Distópica'),(12,'Ficção Existencialista'),(7,'Ficção Satírica'),(11,'Literatura Infantil'),(16,'Poesia Épica'),(23,'Prosa Poética'),(6,'Realismo Mágico'),(2,'Romance'),(4,'Romance Clássico'),(5,'Romance Gótico'),(10,'Romance Histórico'),(17,'Suspense'),(22,'Terror');
/*!40000 ALTER TABLE `Categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Emprestimo`
--

DROP TABLE IF EXISTS `Emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Emprestimo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dataEmprestimo` date NOT NULL,
  `dataDevolucao` date NOT NULL,
  `livroId` int NOT NULL,
  `utilizadorId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `livroId` (`livroId`),
  KEY `utilizadorId` (`utilizadorId`),
  CONSTRAINT `Emprestimo_ibfk_1` FOREIGN KEY (`livroId`) REFERENCES `Livro` (`id`),
  CONSTRAINT `Emprestimo_ibfk_2` FOREIGN KEY (`utilizadorId`) REFERENCES `Utilizador` (`id`),
  CONSTRAINT `check_datas` CHECK ((`dataDevolucao` >= `dataEmprestimo`))
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emprestimo`
--

LOCK TABLES `Emprestimo` WRITE;
/*!40000 ALTER TABLE `Emprestimo` DISABLE KEYS */;
INSERT INTO `Emprestimo` VALUES (5,'2025-01-06','2025-01-24',30,29),(6,'2025-01-11','2025-01-25',31,23),(7,'2025-02-01','2025-02-08',31,29),(9,'2025-01-28','2025-02-04',29,29),(10,'2025-01-28','2025-02-04',26,28),(11,'2025-02-01','2025-02-08',25,26),(12,'2025-01-31','2025-02-05',25,29),(13,'2025-01-21','2025-01-30',27,28),(14,'2025-01-24','2025-02-01',33,28),(15,'2025-01-31','2025-02-06',27,16),(16,'2025-02-05','2025-02-13',14,13),(17,'2025-01-23','2025-01-31',21,24),(18,'2025-01-31','2025-02-06',12,15),(19,'2025-02-05','2025-02-08',17,17),(20,'2025-01-25','2025-01-28',12,13),(21,'2025-01-25','2025-01-31',10,16),(22,'2025-02-06','2025-02-08',16,11),(23,'2025-01-26','2025-01-29',13,9),(24,'2025-02-02','2025-02-04',14,13),(25,'2025-02-01','2025-02-03',10,8),(26,'2025-02-01','2025-02-05',15,11),(27,'2025-02-01','2025-02-04',13,11),(28,'2025-01-31','2025-02-02',11,7),(29,'2025-02-03','2025-02-06',18,8),(30,'2025-02-14','2025-02-19',10,9),(31,'2025-02-02','2025-02-05',9,27),(32,'2025-01-31','2025-02-04',23,11),(33,'2025-01-16','2025-01-29',9,6),(34,'2025-01-29','2025-02-01',18,13);
/*!40000 ALTER TABLE `Emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Livro`
--

DROP TABLE IF EXISTS `Livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Livro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `anoPublicacao` int DEFAULT NULL,
  `categoriaId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoriaId` (`categoriaId`),
  CONSTRAINT `Livro_ibfk_1` FOREIGN KEY (`categoriaId`) REFERENCES `Categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Livro`
--

LOCK TABLES `Livro` WRITE;
/*!40000 ALTER TABLE `Livro` DISABLE KEYS */;
INSERT INTO `Livro` VALUES (4,'1984','George Orwell',1949,3),(5,'Dom Quixote','Miguel de Cervantes',1605,4),(6,'O Monte dos Vendavais','Emily Brontë',1847,5),(7,'Orgulho e Preconceito','Jane Austen',1813,2),(8,'Cem Anos de Solidão','Gabriel García Márquez',1967,6),(9,'O Triunfo dos Porcos','George Orwell',1945,7),(10,'Uma Agulha no Palheiro','J.D. Salinger',1951,8),(11,'Moby Dick','Herman Melville',1851,9),(12,'Os Miseráveis','Victor Hugo',1862,10),(13,'O Principezinho','Antoine de Saint-Exupéry',1943,11),(14,'A Metamorfose','Franz Kafka',1915,12),(15,'O Senhor dos Anéis: A Irmandade do Anel','J.R.R. Tolkien',1954,13),(16,'Harry Potter e a Pedra Filosofal','J.K. Rowling',1997,13),(17,'Admirável Mundo Novo','Aldous Huxley',1932,3),(18,'A Divina Comédia','Dante Alighieri',1320,16),(19,'O Código Da Vinci','Dan Brown',2003,17),(20,'A Rapariga que Roubava Livro','Markus Zusak',2005,18),(21,'O Hobbit','J.R.R. Tolkien',1937,13),(22,'A Guerra dos Tronos','George R.R. Martin',1996,20),(23,'A Cor Púrpura','Alice Walker',1982,18),(24,'Drácula','Bram Stoker',1897,22),(25,'Frankenstein ou o Moderno Prometeu','Mary Shelley',1818,22),(26,'Ensaio Sobre a Cegueira','José Saramago',1995,2),(27,'O Livro do Desassossego','Fernando Pessoa',1982,23),(28,'Amor de Perdição','Camilo Castelo Branco',1862,2),(29,'Os Maias','Eça de Queirós',1888,2),(30,'Memorial do Convento','José Saramago',1982,10),(31,'Capitães da Areia','Jorge Amado',1937,2),(32,'A Arte da Guerra','Sun Tzu',-500,9),(33,'O Perfume: História de um Assassino','Patrick Süskind',1985,17);
/*!40000 ALTER TABLE `Livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Utilizador`
--

DROP TABLE IF EXISTS `Utilizador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Utilizador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipoUtilizador` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Utilizador`
--

LOCK TABLES `Utilizador` WRITE;
/*!40000 ALTER TABLE `Utilizador` DISABLE KEYS */;
INSERT INTO `Utilizador` VALUES (1,'Rodrigo Pereira','a045580@umaia.pt',1),(2,'Miguel','miguelcaetano868@gmail.com',1),(3,'Ana Silva','ana.silva@example.com',2),(4,'João Fernandes','joao.fernandes@example.com',2),(5,'Carla Sousa','carla.sousa@example.com',2),(6,'Pedro Costa','pedro.costa@example.com',2),(7,'Maria Oliveira','maria.oliveira@example.com',2),(8,'Tiago Santos','tiago.santos@example.com',2),(9,'Rita Lopes','rita.lopes@example.com',2),(10,'José Almeida','jose.almeida@example.com',2),(11,'Helena Matos','helena.matos@example.com',2),(12,'Paulo Ramos','paulo.ramos@example.com',2),(13,'Inês Marques','ines.marques@example.com',2),(14,'Diogo Martins','diogo.martins@example.com',2),(15,'Joana Nunes','joana.nunes@example.com',2),(16,'Ricardo Gomes','ricardo.gomes@example.com',2),(17,'Cláudia Carvalho','claudia.carvalho@example.com',2),(18,'André Torres','andre.torres@example.com',2),(19,'Sara Figueiredo','sara.figueiredo@example.com',2),(20,'Vítor Monteiro','vitor.monteiro@example.com',2),(21,'Marta Teixeira','marta.teixeira@example.com',2),(22,'Alexandre Rocha','alexandre.rocha@example.com',2),(23,'Beatriz Mendes','beatriz.mendes@example.com',2),(24,'Gonçalo Freitas','goncalo.freitas@example.com',2),(25,'Diana Moreira','diana.moreira@example.com',2),(26,'Fábio Pires','fabio.pires@example.com',2),(27,'Mariana Cunha','mariana.cunha@example.com',2),(28,'Nuno Barros','nuno.barros@example.com',2),(29,'Vanessa Sousa','vanessa.sousa@example.com',2),(30,'Bruno Silva','bruno.silva@example.com',2);
/*!40000 ALTER TABLE `Utilizador` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-03  8:01:22
