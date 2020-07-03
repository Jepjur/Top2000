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
-- Author:		<Tino KErkhof>
-- Create date: <23-06-2020>
-- Description:	<Geeft de liedjes en de positie van dat liedje van een gegeven 
--				artiest die in een gegeven jaar in de Top 2000 staan>
-- =============================================
CREATE OR ALTER PROCEDURE spLiedjesVanArtiestInJaar 
	-- Add the parameters for the stored procedure here
	@jaar int = 0
	, @artiestid int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @jaar = 0 SET @jaar = (SELECT max(top2000jaar) FROM Lijst)
	IF @artiestid = 0 SET @artiestid = (SELECT min(Artiest.Artiestid) FROM Artiest)
		-- Insert statements for procedure here
	SELECT 
		Song.titel
		, Song.jaar
		, Lijst.positie
	FROM     
		Song INNER JOIN
			Lijst ON Song.songid = Lijst.songid
	WHERE
		song.artiestid = @artiestid AND
		lijst.top2000jaar = @jaar
END
GO
