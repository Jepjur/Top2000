USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspNewlyListed]    Script Date: 7/4/2020 10:42:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <1-7-2020>
-- Description:	<All new songs in yearlist >
-- =============================================
CREATE PROCEDURE [dbo].[uspNewlyListed] 
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
	WHERE 
		l.top2000jaar = @year 
		AND 
		l.songid NOT IN (SELECT songid FROM Lijst WHERE top2000jaar = @year - 1)
	ORDER BY 3
END
