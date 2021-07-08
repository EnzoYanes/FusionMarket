-- =============================================
-- Author:		Pablo García
-- Create date: 13-05-2021
-- Description:	Retorna un paginado de productos
-- =============================================
CREATE PROCEDURE [dbo].[Products_GetProductsPaginated]
	-- Add the parameters for the stored procedure here
	@PageIndex INT,
	@PageSize INT,
	@Name VARCHAR(20) NULL,
	@CategoryId INT,
	@OrderByNameOrPrice VARCHAR(10),
	@ASCorDESC VARCHAR(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TotalRows INT

	IF(@PageIndex < 1)
	BEGIN
		SET @PageIndex = 1
	END
	SET @OrderByNameOrPrice = LOWER(@OrderByNameOrPrice);
	SET @ASCorDESC = LOWER(@ASCorDESC)
	IF(@OrderByNameOrPrice NOT IN ('name','price') OR @OrderByNameOrPrice IS NULL)
	BEGIN
		SET @OrderByNameOrPrice = 'name'
	END
	IF(@ASCorDESC NOT IN ('asc','desc') OR @ASCorDESC IS NULL)
	BEGIN
		SET @ASCorDESC = 'asc'
	END

	SELECT *
	FROM dbo.Products
	WHERE ([Name] IS NULL OR [Name] like '%'+@Name+'%') 
		AND (@CategoryId = 0 OR CategoryId = @CategoryId)
	ORDER BY 
		CASE WHEN @OrderByNameOrPrice='name' AND @ASCorDESC='asc' THEN [Name] END ASC,
		CASE WHEN @OrderByNameOrPrice='name' AND @ASCorDESC='desc' THEN [Name] END DESC,
		CASE WHEN @OrderByNameOrPrice='price' AND @ASCorDESC='asc' THEN [Price] END ASC,
		CASE WHEN @OrderByNameOrPrice='price' AND @ASCorDESC='desc' THEN [Price] END DESC
	OFFSET (@PageSize * (@PageIndex -1)) ROWS
	FETCH NEXT @PageSize ROWS ONLY

	SET @TotalRows = (SELECT COUNT(*) FROM dbo.Products WHERE [Name] like '%'+@Name+'%' AND (@CategoryId = 0 OR CategoryId = @CategoryId))

	SELECT CEILING(@TotalRows / CAST(@PageSize as FLOAT)) AS TotalPages

END