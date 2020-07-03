-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tino Kerkhof>
-- Create date: <22 juni 2020>
-- Description:	<Laat de nummers zien die voorgoed uit de top 200 zijn, 
--				vanaf het opgegeven jaar en hun notering het jaar ervoor>
-- =============================================
CREATE OR ALTER PROCEDURE spVoorgoedUit2000 
	-- Add the parameters for the stored procedure here
	@jaar int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @jaar = 0 SET @jaar = (SELECT max(top2000jaar) FROM Lijst)

    -- Insert statements for procedure here
	SELECT 
		Song.titel
		, Artiest.naam
		, Song.jaar
		, (SELECT
			[dbo].[FN_PositieOverJaren](song.songid)
		  ) AS PositieOverJaren
	FROM     
		Lijst INNER JOIN
			Song ON Lijst.songid = Song.songid INNER JOIN
			Artiest ON Song.artiestid = Artiest.Artiestid
	WHERE
		Lijst.top2000jaar = @jaar - 1 AND
		lijst.songid IN (
			SELECT 
				 lijst.songid
			FROM     
				Lijst AS Lijst
			GROUP BY 
				Lijst.songid
			HAVING
				max(lijst.top2000jaar) = @jaar - 1)
END
GO
