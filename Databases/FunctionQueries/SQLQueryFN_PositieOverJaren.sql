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
-- Author:		<Tino Kerkhof>
-- Create date: <23-6-2020>
-- Description:	<Geeft een nvarchar die de positie over de jaren heen geeft, gescheiden met komma's>
-- =============================================
CREATE FUNCTION FN_PositieOverJaren 
(
	-- Add the parameters for the function here
	@songid int
)
RETURNS nvarchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @positieOverJaren nvarchar(max)

	-- Add the T-SQL statements to compute the return value here
	DECLARE @jaar int
	SET @jaar = (SELECT min(lijst.top2000jaar) FROM lijst)
	DECLARE @lastJaar int
	SET @lastJaar = (SELECT max(lijst.top2000jaar) FROM lijst)

	WHILE @jaar <= @lastJaar
	BEGIN
		SET @positieOverJaren = CONCAT_WS(',', @positieOverJaren, ISNULL(
			(SELECT
				lijst.positie
			FROM
				lijst
			WHERE
				lijst.top2000jaar = @jaar AND
				lijst.songid = @songid)
			, '')
			)
	SET @jaar = @jaar + 1
	END

	-- Return the result of the function
	RETURN @positieOverJaren

END
GO

