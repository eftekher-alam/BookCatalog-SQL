
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





