----->>>> INSERT publisher <<<<-------
DECLARE @msg NVARCHAR(100)
EXEC sp_insertPublisher 'RRR Publish Ltd', 'rrr@gmail.com', @msg OUTPUT
SELECT @msg AS 'MESSAGE'
GO


----->>>> INSERT Tag <<<<-------
DECLARE @msg NVARCHAR(100)
EXEC sp_insertTag 'Self Help', @msg OUTPUT
SELECT @msg AS 'MESSAGE'
GO


----->>>> INSERT Author <<<<-------
DECLARE @msg NVARCHAR(100)
EXEC sp_insertAuthor 'Durjoy', 'durjoy@gmail.com', @msg OUTPUT
SELECT @msg AS 'MESSAGE'
GO


----->>>> INSERT Books <<<<-------
DECLARE @id INT
EXEC @id = sp_insertBook 'Advance Python', 400, '2019-04-10', 1, 2
SELECT @id AS 'INSERTED BOOK ID'
GO


----->>>> INSERT BookAuthor <<<<-------
INSERT INTO booksAuthors
VALUES
(7, 3),
(7, 4),
(8, 5),
(11, 6),
(12, 7),
(13, 8),
(14, 9),
(15, 10),
(16, 11),
(17, 5),
(18, 8),
(19, 8)
GO

----->>>> INSERT BookTags <<<<-------
BEGIN TRY 
	INSERT INTO booksTags
	VALUES
	(8, 5),
	(11, 2),
	(12, 7),
	(13, 8),
	(14, 9),
	(15, 10),
	(16, 11),
	(17, 5),
	(18, 12),
	(19, 8)
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE(),  ERROR_LINE()
END CATCH
