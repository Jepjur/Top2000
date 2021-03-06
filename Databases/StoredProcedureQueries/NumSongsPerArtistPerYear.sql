USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspNumSongsPerArtistPerYear]    Script Date: 7/4/2020 10:43:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <1-7-2020>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uspNumSongsPerArtistPerYear] 
	-- Add the parameters for the stored procedure here
	@year AS int, @artistName AS nvarchar(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @year IS NULL SET @year = (SELECT MAX(top2000jaar) FROM Lijst)
	IF @artistName IS NULL SET @artistName = 'Normaal'
    -- Insert statements for procedure here
	SELECT            
		a.naam,
		l.top2000jaar,
		COUNT(s.titel) as 'aantal songs'
	FROM     
    	Song AS s 
		JOIN Artiest AS a ON s.artiestid = a.Artiestid
		JOIN Lijst AS l ON s.songid = l.songid
	WHERE l.top2000jaar = @year AND a.naam = @artistName
	GROUP BY a.naam, l.top2000jaar
	ORDER BY a.naam, l.top2000jaar, COUNT(s.titel)
END
