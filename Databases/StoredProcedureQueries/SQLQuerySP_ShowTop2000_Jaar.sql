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
-- Create date: <19/06/2020>
-- Description:	<Shows the top 2000 from a specified year (default most recent)
--				Doesn't show mutation since last year>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[spTop2000]
	-- Add the parameters for the stored procedure here
	@jaar int = 0
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @jaar = 0 SET @jaar = (SELECT max(top2000jaar) FROM Lijst)

    -- Insert statements for procedure here
	SELECT 
		lijst_dit_jaar.positie AS POSITIE
		,( -- positieverandering sinds vorig jaar
		SELECT
			 lijst_vorig_jaar.positie - lijst_dit_jaar.positie
		FROM
			lijst AS lijst_vorig_jaar
		WHERE ((lijst_vorig_jaar.top2000jaar = @jaar - 1 AND
				lijst_dit_jaar.songid = lijst_vorig_jaar.songid))
		) AS [MUTATIE]
		, song.titel AS TITEL
		, artiest.naam AS ARTIEST
		, song.jaar AS JAAR
		,lijst_dit_jaar.top2000jaar AS geselecteerdJaar
		,lijst_dit_jaar.songid
		,Artiest.Artiestid
	FROM     
		lijst AS lijst_dit_jaar INNER JOIN
			Song ON lijst_dit_jaar.songid = song.songid INNER JOIN
			Artiest ON song.artiestid = artiest.Artiestid
	WHERE
		lijst_dit_jaar.top2000jaar = @jaar
END
