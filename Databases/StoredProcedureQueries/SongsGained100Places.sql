USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspSongsGained100Places]    Script Date: 7/4/2020 10:43:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <1-7-2020>
-- Description:	<Songs die meer dan 100 plaatsen zijn gestegen tov het voorgaande jaar>
-- =============================================
CREATE PROCEDURE [dbo].[uspSongsGained100Places]
	-- Add the parameters for the stored procedure here
	@year AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @year IS NULL SET @year = (SELECT MAX(top2000jaar) FROM Lijst)
    -- Insert statements for procedure here
	SELECT
		s.titel,
		a.naam,
		l.positie,
		lvj.positie AS 'vorig jaar',
		(lvj.positie - l.positie) AS 'verschil'
	FROM     
    	Song AS s 
		JOIN Artiest AS a ON s.artiestid = a.Artiestid
		JOIN Lijst AS l ON s.songid = l.songid
		JOIN (SELECT * FROM Lijst WHERE top2000jaar = @year - 1) AS lvj ON s.songid = lvj.songid
	WHERE l.top2000jaar = @year AND lvj.songid IS NOT NULL AND (lvj.positie - l.positie > 100)
	ORDER BY 5 DESC
END
