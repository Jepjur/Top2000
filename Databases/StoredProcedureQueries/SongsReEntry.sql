USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspSongsReEntry]    Script Date: 7/4/2020 10:46:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <2-7-2020>
-- Description:	<Re-entry : songs die weer in de lijst zijn opgenomen na 1 of meerdere jaren eruit te zijn geweest>
-- =============================================
CREATE PROCEDURE [dbo].[uspSongsReEntry] 
	-- Add the parameters for the stored procedure here
	@year AS int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @year IS NULL SET @year = (SELECT MAX(top2000jaar) FROM Lijst)
    -- Insert statements for procedure here
	SELECT
		s.songid,
		s.titel,
		a.naam,
		l.positie
	FROM     
    	Song AS s 
		JOIN Artiest AS a ON s.artiestid = a.Artiestid
		JOIN Lijst AS l ON s.songid = l.songid
	WHERE 
		l.top2000jaar = @year
		AND		
		s.songid IN (
			SELECT
				s.songid
			FROM 
				Song AS s
				JOIN Lijst AS l ON s.songid = l.songid
			WHERE 
				s.songid NOT IN (
					SELECT
						l1.songid
					FROM 
						Lijst AS l1
					JOIN Lijst As l2 ON l1.songid = l2.songid
					WHERE l1.top2000jaar = l2.top2000jaar + 1)
	GROUP BY 
		s.songid
	HAVING
		COUNT(l.top2000jaar) > 1)	

END
