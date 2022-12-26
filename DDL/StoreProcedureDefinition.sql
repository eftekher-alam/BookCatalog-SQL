USE BookCatalog
GO


------------------------>>>> TAGS PROCEDURE <<<<------------------------

--> INSERT TAG PROCEDURE <--
	-- Here we have used OUTPUT variable

CREATE OR ALTER PROCEDURE sp_insertTag      --If not exist it will create other wise alter the existing sp
(
	@tag NVARCHAR(100),			-- This is parameter
	@message NVARCHAR(100) OUTPUT -- This is output parameter
)
WITH ENCRYPTION -- It restrict user to see the defination. 'sp_helptext' won't avail to show defination.
AS
BEGIN
	BEGIN TRY
		INSERT INTO tags 
		VALUES
		(@tag)
		SET @message = @tag + ' is inserted successfully..!'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
	END CATCH	
END


EXEC sp_helptext sp_insertTag --this proce show you the definition of procedure.


--> UPDATE TAG PROCEDURE <--
CREATE OR ALTER PROCEDURE sp_UpdateTag
(
	@Id INT,
	@newTag NVARCHAR(100)
)
AS
BEGIN
	IF EXISTS( SELECT * FROM tags WHERE tagId = @Id)
		BEGIN
			UPDATE tags
			SET tag = @newTag
			WHERE tagId = @Id
		END
	ELSE
		BEGIN
			THROW 50001, 'Not a valid tag id', 1  --Throw error by using THROW keyword
		END
END



--> DELETE TAG PROCEDURE <--
	--Tags will delete even if tagid exist in other table as FK record because there is trigger that will delete the FK record
CREATE OR ALTER PROCEDURE sp_DeleteTag
(
	@id INT
)
AS
BEGIN
	BEGIN TRY
		DELETE FROM tags  
		WHERE tagId = @id
		RETURN @id
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
	END CATCH
END


------------------------>>>> BOOKS PROCEDURE <<<<------------------------


--> INSERT BOOK PROCEDURE <--
	--This will return inserted book id. As we know proc only can return a int type value
CREATE OR ALTER PROCEDURE sp_insertBook
(
	@title NVARCHAR(100),
	@coverPrice MONEY,
	@pulishDate DATE,
	@available BIT,
	@publisherId INT
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO books 
		VALUES
		(@title, @coverPrice, @pulishDate, @available, @publisherId)
		RETURN (SELECT MAX(bookId) FROM books) --It will return inserted book id
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR', ERROR_LINE() AS 'ERROR LINE NO.' 
	END CATCH
END




--> UPDATE BOOK PROCEDURE <--
CREATE OR ALTER PROCEDURE sp_UpdateBook
(
	@ID INT,
	@TITLE NVARCHAR(100),
	@COVERPRICE MONEY,
	@PUBLISHDATE DATE,
	@AVAILABLE BIT,
	@PUBLISHERID INT
)
AS
BEGIN
	BEGIN TRY
		UPDATE books
		SET 
		title = @TITLE, 
		coverPrice = @COVERPRICE, 
		publishDate = @PUBLISHDATE,
		available = @AVAILABLE,
		publisherId = @PUBLISHERID
		WHERE bookId = @ID
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR', ERROR_LINE() AS 'ERROR LINE NO.' 
	END CATCH
END




--> DELETE BOOK PROCEDURE <--
CREATE OR ALTER PROCEDURE sp_DeleteBook
(
	@id INT,
	@dtitle NVARCHAR(100) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN 
			SELECT @dtitle = title FROM books
			WHERE bookId = @id
		END
		BEGIN
			DELETE FROM books 
			WHERE bookId = @id
		END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR', ERROR_LINE() AS 'ERROR LINE NO.' 
	END CATCH
END


------------------------>>>> AUTHORS PROCEDURE <<<<------------------------


--> INSERT AUTHORS PROCEDURE <--
	-- Here we have used OUTPUT variable

CREATE OR ALTER PROCEDURE sp_insertAuthor --If not exist it will create other wise alter the existing sp
(
	@authorName NVARCHAR(100),		
	@email NVARCHAR(100),
	@message NVARCHAR(100) OUTPUT -- This is output parameter
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO authors 
		VALUES
		(@authorName, @email)
		SET @message = @authorName + ' is inserted successfully..!'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
	END CATCH	
END






--> UPDATE AUTHOR PROCEDURE <--
CREATE OR ALTER PROCEDURE sp_UpdateAuthor
(
	@Id INT,
	@authorName NVARCHAR(100),		
	@email NVARCHAR(100)
)
WITH ENCRYPTION
AS
BEGIN
	IF EXISTS( SELECT * FROM authors WHERE authorId = @Id)
		BEGIN
			UPDATE authors
			SET authorName = @authorName, email = @email
			WHERE authorId = @Id
		END
	ELSE
		BEGIN
			PRINT 'Record not found.'
		END
END






--> DELETE AUTHOR PROCEDURE <--
	--Tags will delete even if tagid exist in other table as FK record because there is trigger that will delete the FK record
CREATE OR ALTER PROCEDURE sp_DeleteAuthor
(
	@id INT
)
AS
BEGIN
	BEGIN TRY
		DELETE FROM authors  
		WHERE authorId = @id
		RETURN @id
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
	END CATCH
END



------------------------>>>> PUBLISHER PROCEDURE <<<<------------------------


--> INSERT AUTHORS PROCEDURE <--
	-- Here we have used OUTPUT variable

CREATE OR ALTER PROCEDURE sp_insertPublisher --If not exist it will create other wise alter the existing sp
(
	@publisherName NVARCHAR(100),		
	@publisherEmail NVARCHAR(100),
	@message NVARCHAR(100) OUTPUT -- This is output parameter
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO publishers 
		VALUES
		(@publisherName, @publisherEmail)
		SET @message = @publisherName + ' is inserted successfully..!'
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
	END CATCH	
END






--> UPDATE AUTHOR PROCEDURE <--
CREATE OR ALTER PROCEDURE sp_UpdatePublisher
(
	@Id INT,
	@publisherName NVARCHAR(100),		
	@publisherEmail NVARCHAR(100)
)
WITH ENCRYPTION
AS
BEGIN
	IF EXISTS( SELECT * FROM publishers WHERE publisherId = @Id)
		BEGIN
			UPDATE publishers
			SET publisherName = @publisherName, publisherEmail = @publisherEmail
			WHERE publisherId = @Id
		END
	ELSE
		BEGIN
			PRINT 'Record not found.'
		END
END






--> DELETE AUTHOR PROCEDURE <--
	--Tags will delete even if tagid exist in other table as FK record because there is trigger that will delete the FK record
CREATE OR ALTER PROCEDURE sp_DeletePublisher
(
	@id INT
)
AS
BEGIN
	BEGIN TRY
		DELETE FROM publishers  
		WHERE publisherId = @id
		RETURN @id
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
	END CATCH
END