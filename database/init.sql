CREATE DATABASE IF NOT EXISTS `biblioteca_m3_recurso`;
USE `biblioteca_m3_recurso`;

SET NAMES utf8;
SET CHARACTER SET utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Primeiro criar Categoria
CREATE TABLE `Categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserir dados da Categoria primeiro
INSERT INTO `Categoria` VALUES 
(9,'Aventura'),(18,'Drama'),(13,'Fantasia'),(20,'Fantasia Épica'),(1,'Ficção Científica'),
(8,'Ficção Contemporânea'),(3,'Ficção Distópica'),(12,'Ficção Existencialista'),(7,'Ficção Satírica'),
(11,'Literatura Infantil'),(16,'Poesia Épica'),(23,'Prosa Poética'),(6,'Realismo Mágico'),
(2,'Romance'),(4,'Romance Clássico'),(5,'Romance Gótico'),(10,'Romance Histórico'),(17,'Suspense'),(22,'Terror');

-- Depois criar Utilizador
CREATE TABLE `Utilizador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipoUtilizador` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserir dados do Utilizador
INSERT INTO `Utilizador` VALUES 
(1,'Rodrigo Pereira','a045580@umaia.pt',1),
(2,'Miguel','miguelcaetano868@gmail.com',1);
-- ... resto dos utilizadores ...

-- Depois criar Livro
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

-- Inserir dados do Livro
INSERT INTO `Livro` VALUES 
(4,'1984','George Orwell',1949,3);
-- ... resto dos livros ...

-- Por último criar Emprestimo
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

-- Inserir dados do Emprestimo
INSERT INTO `Emprestimo` VALUES 
(5,'2025-01-06','2025-01-24',30,29);
-- ... resto dos empréstimos ...

SET FOREIGN_KEY_CHECKS = 1;