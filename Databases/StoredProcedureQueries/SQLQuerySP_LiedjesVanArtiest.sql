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
-- Create date: <23-06-2020>
-- Description:	<Geeft een lijst van de liedjes die van een gegeven artiest in de top 2000 staan>
-- =============================================
CREATE OR ALTER PROCEDURE spLiedjesVanArtiest
	-- Add the parameters for the stored procedure here
	@artiestid int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @artiestid = 0 SET @artiestid = (SELECT min(Artiest.Artiestid) FROM Artiest)
    -- Insert statements for procedure here
	SELECT 
		Song.titel
		, Song.jaar
	FROM     
		Song
	WHERE
		song.artiestid = @artiestid
END
GO
