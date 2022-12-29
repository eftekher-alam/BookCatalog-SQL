USE BookCatalog
GO

CREATE VIEW v_TotalValueOfBook
WITH ENCRYPTION
AS
	SELECT SUM(coverPrice) AS 'Total Value' FROM books
GO

CREATE OR ALTER VIEW v_BookDetails
AS
	SELECT b.title, b.coverPrice, t.tag, a.authorName, p.publisherName FROM books b
	LEFT JOIN booksTags bt ON bt.bookId = b.bookId
	LEFT JOIN tags t ON t.tagId = bt.tagId
	LEFT JOIN publishers p ON p.publisherId = b.bookId
	LEFT JOIN booksAuthors ba ON ba.bookId = b.bookId
	LEFT JOIN authors a ON a.authorId = ba.authorId
GO


CREATE VIEW v_AllBook
WITH SCHEMABINDING --YOU can't ALTER or DROP the table books
AS 
	SELECT title, coverPrice FROM dbo.books
GO
