USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspSongsPerYear]    Script Date: 7/4/2020 10:46:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Jasper van Dijk>
-- Create date: <25-6-2020>
-- Description:    <alle songs die in een bepaald jaar zijn uitgebracht>
-- =============================================
CREATE PROCEDURE [dbo].[uspSongsPerYear]
@year AS int
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
  SET NOCOUNT ON;
  IF @year IS NULL SET @year = (SELECT MAX(top2000jaar) FROM Lijst)
-- Insert statements for procedure here
  SELECT DISTINCT
    a.naam,
    s.titel
  FROM     
    Song AS s
    JOIN Artiest AS a ON s.artiestid = a.Artiestid
  WHERE 
    s.jaar = @year
END
