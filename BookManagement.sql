USE [master]
GO

/****** Object:  Database [BookManagement]    Script Date: 22/09/2020 23:55:35 ******/
CREATE DATABASE [BookManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BookManagement.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BookManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BookManagement_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [BookManagement] SET COMPATIBILITY_LEVEL = 120
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [BookManagement] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [BookManagement] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [BookManagement] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [BookManagement] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [BookManagement] SET ARITHABORT OFF 
GO

ALTER DATABASE [BookManagement] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [BookManagement] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [BookManagement] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [BookManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [BookManagement] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [BookManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [BookManagement] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [BookManagement] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [BookManagement] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [BookManagement] SET  DISABLE_BROKER 
GO

ALTER DATABASE [BookManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [BookManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [BookManagement] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [BookManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [BookManagement] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [BookManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [BookManagement] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [BookManagement] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [BookManagement] SET  MULTI_USER 
GO

ALTER DATABASE [BookManagement] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [BookManagement] SET DB_CHAINING OFF 
GO

ALTER DATABASE [BookManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [BookManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [BookManagement] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [BookManagement] SET  READ_WRITE 
GO

CREATE TABLE Role(
	id int IDENTITY NOT NULL,
	name varchar(250)
);

CREATE TABLE UserInfo(
	id int IDENTITY NOT NULL,
	email varchar(250) NOT NULL,
	password varchar(250) NOT NULL,
	firstName nvarchar(250),
	lastName nvarchar(250),
	enabled int NOT NULL,
	avatar varchar(250),
	role_id int NOT NULL
);

CREATE TABLE Book(
	id int IDENTITY NOT NULL,
	title nvarchar(250) NOT NULL,
	author nvarchar(250) NOT NULL,
	description nvarchar(250),
	created_at date NOT NULL,
	updated_at date NOT NULL,
	image varchar(250),
	enable int NOT NULL,
	user_id int NOT NULL
);

CREATE TABLE FavoriteBook(
	book_id int NOT NULL,
	user_id int NOT NULL,
	created_at date NOT NULL
);

INSERT INTO Role(name) VALUES('admin','user','guest')

INSERT INTO UserInfo(email, password, firstName, lastName, enabled, avatar, role_id)
VALUES	('thainguyen@gmail.com', '123456', 'Thai', 'Nguyen', 1, 'thai-nguyen-5648466661.jpg', 1),
		('phiho@gmail.com', '123456', 'Phi', 'Ho', 1, 'phi-ho-4105315313.jpg', 2),
		('dungpham@gmail.com', '123456', 'Dung', 'Pham', 1, 'dung-pham-5612032547.jpg', 2)
  
INSERT INTO Book(title, author, description, created_at, updated_at, image, enabled, user_id)
VALUES	('Truyện Kiều', 'Nguyễn Du', 'Truyện Kiều là một tác phẩm nổi tiếng của đại thi hào Nguyễn Du', '2020-09-25', '2020-09-26', 'truyen-kieu-2461287941.jpg', 1, 1),
		('Nam Quốc Sơn Hà', 'Lý Thường Kiệt', 'Bản Tuyên ngôn độc lập đầu tiên của Đại Việt', '2020-09-24', '2020-09-26', 'nam-quoc-son-ha-3621489657.jpg', 1, 2),
		('Làm giàu', 'Jack Ma', 'Chia sẻ bí quyết thành đạt trong kinh doanh', '2020-09-23', '2020-09-27', 'lam-giau-4512587416.jpg', 1, 2)
  
INSERT INTO FavoriteBook(book_id, user_id, created_at)
VALUES	(1, 1, '2020-09-26'),
		(2, 1, '2020-09-26'),
		(2, 2, '2020-09-26')
