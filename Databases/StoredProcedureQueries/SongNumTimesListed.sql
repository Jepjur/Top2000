USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspSongNumTimesListed]    Script Date: 7/4/2020 10:43:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <2-7-2020>
-- Description:	<Aantal keer dat een song is opgenomen in een Top2000>
-- =============================================
CREATE PROCEDURE [dbo].[uspSongNumTimesListed] 
	-- Add the parameters for the stored procedure here
	@songID AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @songID IS NULL SET @songID = 1106
    -- Insert statements for procedure here
		SELECT
		s.songid,
		s.titel,
		a.naam AS Artiest,
		COUNT(l.songid) AS 'Times Listed'
	FROM 
		Song AS s
		JOIN Lijst AS l on s.songid = l.songid
		JOIN Artiest AS a ON a.Artiestid = s.artiestid
	WHERE s.songid = @songID
	GROUP BY
		s.songid,
		s.titel,
		a.naam
END
