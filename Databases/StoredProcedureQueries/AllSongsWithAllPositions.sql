USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspAllSongsWithAllPositions]    Script Date: 7/4/2020 10:39:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jasper van Dijk>
-- Create date: <2-7-2020>
-- Description:	<Alle songs met hun positie is alle lijsten>
-- =============================================
CREATE PROCEDURE [dbo].[uspAllSongsWithAllPositions] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		*
	FROM (
		SELECT
			s.songid,
			s.titel,
			s.jaar,
			a.naam,
			l.positie,
			l.top2000jaar
		FROM     
    		Song AS s 
			JOIN Lijst AS l ON s.songid = l.songid
			JOIN Artiest AS a ON s.artiestid = a.Artiestid
			) AS AA
	PIVOT
	(
		MAX(positie)
		FOR [top2000jaar] IN ([1999], [2000], [2001], [2002], [2003], [2004], [2005], [2006], [2007], [2008], [2009], [2010], [2011],
						[2012], [2013], [2014], [2015], [2016], [2017], [2018], [2019])
	) AS draaierij
END
