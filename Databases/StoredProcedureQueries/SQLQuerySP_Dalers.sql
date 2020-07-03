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
-- Create date: <29-06-2020>
-- Description:	<Geeft de lijst met liedjes die van een opgegeven jaar lager stonden dan het jaar ervoor>
-- =============================================
CREATE OR ALTER PROCEDURE spDalers 
	-- Add the parameters for the stored procedure here
	@jaar int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @jaar = 0 SET @jaar = (SELECT max(top2000jaar) FROM Lijst) 

    -- Insert statements for procedure here
	SELECT
		Song.titel AS Titel
		, Artiest.naam AS Artiest
		, Song.jaar AS [Uitgave jaar]
		, (
			SELECT
				 lijst_vorig_jaar.positie
			FROM
				lijst AS lijst_vorig_jaar
			WHERE ((lijst_vorig_jaar.top2000jaar = @jaar - 1 AND
					lijst_jaar.songid = lijst_vorig_jaar.songid))
		) AS [Vorig Jaar]
		, lijst_jaar.positie AS [Dit Jaar] 
		, (
			SELECT
				 lijst_vorig_jaar.positie - lijst_jaar.positie
			FROM
				lijst AS lijst_vorig_jaar
			WHERE ((lijst_vorig_jaar.top2000jaar = @jaar - 1 AND
					lijst_jaar.songid = lijst_vorig_jaar.songid))
		) AS [Verschil]
	
	FROM
		lijst AS lijst_jaar INNER JOIN
		Song ON lijst_jaar.songid = Song.songid INNER JOIN
		Artiest ON Song.artiestid = Artiest.Artiestid
	WHERE (
		lijst_jaar.top2000jaar = @jaar AND
		(
			SELECT
				 lijst_vorig_jaar.positie - lijst_jaar.positie
			FROM
				lijst AS lijst_vorig_jaar
			WHERE ((lijst_vorig_jaar.top2000jaar = @jaar - 1 AND
					lijst_jaar.songid = lijst_vorig_jaar.songid))
		) < 0 )
END
GO
