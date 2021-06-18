-- =============================================
-- Author:		Pablo García
-- Create date: 13-05-2021
-- Description:	Retorna un paginado de productos
-- =============================================
CREATE PROCEDURE [dbo].[Products_GetProductsPaginated]
	-- Add the parameters for the stored procedure here
	@PageIndex INT,
	@PageSize INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(@PageIndex < 1)
	BEGIN
		SET @PageIndex = 1
	END

    SELECT *
	FROM dbo.Products
	ORDER BY [Name] ASC
	OFFSET (@PageSize * (@PageIndex -1)) ROWS
	FETCH NEXT @PageSize ROWS ONLY

	
END