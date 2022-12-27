
----->> Author wise all Information (Simple table-valued function) <<-------
	--This function will return a table
CREATE OR ALTER FUNCTION fn_AuthorWiseInfo
(
	@authorName NVARCHAR(100)
)
RETURNS TABLE
WITH ENCRYPTION
AS
RETURN
SELECT a.authorName, b.title, b.coverPrice, b.available, t.tag, p.publisherName
FROM authors a
	INNER JOIN booksAuthors ba ON ba.authorId = a.authorId
	INNER JOIN books b ON ba.bookId = b.bookId
	INNER JOIN booksTags bt ON bt.bookId = b.bookId
	INNER JOIN tags t ON t.tagId = bt.tagId
	INNER JOIN publishers p ON p.publisherId = b.publisherId
	WHERE LOWER(a.authorName) LIKE '%'+LOWER(@authorName)+'%'

--SELECT * FROM dbo.fn_AuthorWiseInfo('Eftekher')




----->> Tag wise all Information (Multi-statement table-valued function) <<-------
	--This function will return a table which table will assign from multiple table

CREATE OR ALTER FUNCTION fn_TagWiseBooks
(
	@tag NVARCHAR(100)			-- Parameter 
)
RETURNS @OutTable TABLE			-- Output table
		(
			tag NVARCHAR(100) ,
			title NVARCHAR(100),
			price MONEY,
			totalBookOfTheTag INT
		)
AS

BEGIN
	INSERT INTO @OutTable
		SELECT t.tag, b.title, b.coverPrice, 0 -- Value assigned into the table from multiple statement 
		FROM tags t
		INNER JOIN booksTags bt ON bt.tagId = t.tagId
		INNER JOIN books b ON b.bookId = bt.bookId
		WHERE LOWER(t.tag) LIKE '%'+LOWER(@tag)+'%'
	UPDATE @OutTable			-- Value assigned into the table from multiple statement 
	SET totalBookOfTheTag = (
						SELECT COUNT(*)
						FROM tags t
						INNER JOIN booksTags bt ON bt.tagId = t.tagId
						WHERE LOWER(t.tag) LIKE '%'+LOWER(@tag)+'%'
					)
	RETURN;   -- RETURN key word will be placed at the last.
END


SELECT * FROM booksTags
SELECT * FROM tags
SELECT * FROM dbo.fn_TagWiseBooks('Programming')