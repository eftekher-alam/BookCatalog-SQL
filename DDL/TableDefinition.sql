CREATE DATABASE BookCatalog
GO

USE BookCatalog
GO

CREATE TABLE authors
(
	authorId INT IDENTITY(1, 1) PRIMARY KEY,
	authorName VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL
)
GO

--Make email column as UNIQUE by ALTER statement.
ALTER TABLE authors
ADD CONSTRAINT U_email UNIQUE(email)
GO


CREATE TABLE tags
(
	tagId INT IDENTITY(1,1) PRIMARY KEY,
	tag VARCHAR(100) NOT NULL
)
GO


CREATE TABLE publishers
(
	publisherId INT IDENTITY(1, 1) PRIMARY KEY,
	publisherName VARCHAR(100) NOT NULL,
	publisherEmail VARCHAR(100) NOT NULL
)
GO

--Make publisherEmail column as UNIQUE by ALTER statement.
ALTER TABLE publishers
ADD CONSTRAINT u_publisherEmail UNIQUE(publisherEmail)
GO


CREATE TABLE books
(
	bookId INT IDENTITY(1, 1) PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	coverPrice MONEY NOT NULL,
	publishDate DATE NOT NULL,
	available BIT DEFAULT 0,
	publisherId INT REFERENCES publishers(publisherId) NOT NULL
)
GO

CREATE TABLE booksTags
(
	bookId INT REFERENCES books(bookId) NOT NULL,
	tagId INT REFERENCES tags(tagId) NOT NULL,
	PRIMARY KEY(bookId, tagId)
)
GO

CREATE TABLE booksAuthors
(
	bookId INT REFERENCES books(bookId) NOT NULL,
	authorId INT REFERENCES authors(authorId) NOT NULL,
	PRIMARY KEY(bookId, authorId)
)
GO


CREATE TABLE booksArchive
(
	bookArchiveId INT  IDENTITY(1, 1) PRIMARY KEY,
	bookId INT,
	title VARCHAR(100) NOT NULL,
	coverPrice MONEY NOT NULL,
	publishDate DATE NOT NULL,
	available BIT DEFAULT 0,
	publisherId INT NOT NULL,
	actions VARCHAR(10) NOT NULL,
	dateTime DATETIME DEFAULT GETDATE()
)
GO
