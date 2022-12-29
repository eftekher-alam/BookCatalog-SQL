

---->> Call View <<----
SELECT * FROM v_TotalValueOfBook

SELECT * FROM v_BookDetails

SELECT * FROM v_AllBook

UPDATE v_AllBook   --> You can update value through a view
SET coverPrice = 555
WHERE coverPrice < 800
GO


----->> Call Function <<------

DECLARE @output INT
SELECT @output = dbo.fn_author_totalBook('eftekher')
SELECT @output AS 'Total books of Eftkeher'


SELECT * FROM dbo.fn_AuthorWiseInfo('lipi')  --It is a table valued function so that have to use SELECT statement. you can call each column of the function istead of *

SELECT * FROM dbo.fn_TagWiseBooks('Programming') -- It also a table valued function


