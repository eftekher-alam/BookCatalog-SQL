USE BookCatalog
GO

--------------->>>>After trigger for book logs<<<<-------------

	-- This trigger save log of book table for each record for INSERT, UPDATE AND DELETE.
	-- Each operation log will be seved into bookArchive table.

CREATE OR ALTER TRIGGER tr_book_archive
ON books
WITH ENCRYPTION
AFTER INSERT, UPDATE, DELETE		-- It trigger will execute after INSERT, UPDATE AND DELETE action on book table
AS
BEGIN
	---->> For INSERT <<----
	-- If only data exist in 'inserted' table then it indicate that it is a INSERT action 
	IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
		BEGIN TRY
			INSERT INTO booksArchive
			SELECT i.bookId, i.title, i.coverPrice, i.publishDate, i.available, i.publisherId, 'INSERT', GETDATE() 
			FROM inserted i
			PRINT 'This new data is also archived'
		END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
		END CATCH
	

	---->> For INSERT <<----
	-- If only data exist in both 'inserted' and 'deleted' table then it indicate that it is a UPDATE action 
	IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
		BEGIN TRY
			INSERT INTO booksArchive
			SELECT i.bookId, i.title, i.coverPrice, i.publishDate, i.available, i.publisherId, 'UPDATE', GETDATE() 
			FROM inserted i
			PRINT 'This update data is also archived'
		END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
		END CATCH


	---->> For INSERT <<----
	-- If only data exist in 'deleted' table then it indicate that it is a DELETE action 
	IF NOT EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
		BEGIN TRY
			INSERT INTO booksArchive
			SELECT i.bookId, i.title, i.coverPrice, i.publishDate, i.available, i.publisherId, 'DELETE', GETDATE() 
			FROM inserted i
			PRINT 'This delete data is also archived'
		END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS 'ERROR MASSAGE', ERROR_LINE() AS 'ERROR LINE'
		END CATCH
END
