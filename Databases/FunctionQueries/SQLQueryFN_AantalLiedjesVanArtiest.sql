-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION FN_aantalLiedjesVanArtiest
(
	-- Add the parameters for the function here
	@artiestid int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @aantalLiedjes int

	-- Add the T-SQL statements to compute the return value here
	SET @aantalLiedjes = (
	SELECT
		count(*)
	FROM
		Song
	WHERE
		Song.artiestid = @artiestid
	)

	-- Return the result of the function
	RETURN @aantalLiedjes

END
GO

