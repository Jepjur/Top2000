USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspSongsOnSamePosition]    Script Date: 7/4/2020 10:46:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <1-7-2020>
-- Description:	<alle songs die op dezelfde plek staan als het vorige jaar>
-- =============================================
CREATE PROCEDURE [dbo].[uspSongsOnSamePosition] 
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
		l.positie
	FROM     
    	Song AS s 
		JOIN Artiest AS a ON s.artiestid = a.Artiestid
		JOIN Lijst AS l ON s.songid = l.songid
		JOIN (SELECT * FROM Lijst WHERE top2000jaar = @year -1) AS lvj ON s.songid = lvj.songid
	WHERE 
		l.top2000jaar = @year 
		AND 
		l.positie = lvj.positie
	ORDER BY 3
END
