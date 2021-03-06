USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspAllArtistSongsPertop2000Year]    Script Date: 7/4/2020 10:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <1-7-2020>
-- Description:	<Alle songs van een artiest in een bepaald top2000jaar>
-- LET OP : gaat op artiestID niet op artiestNAAM
-- =============================================
CREATE PROCEDURE [dbo].[uspAllArtistSongsPertop2000Year] 
	-- Add the parameters for the stored procedure here
	@year AS int, @artistID AS int 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @artistID IS NULL SET @artistID = 10008
	IF @year IS NULL SET @year = (SELECT MAX(top2000jaar) FROM Lijst)
    -- Insert statements for procedure here
	SELECT 
	  a.naam,
	  s.titel,
	  l.top2000jaar
	FROM     
	  Song AS s
	  JOIN Artiest AS a ON s.artiestid = a.Artiestid
	  JOIN Lijst AS l ON s.songid = l.songid
	  WHERE a.Artiestid = @artistID AND l.top2000jaar = @year
END
