USE [DB_A63478_DeechteTOP2000]
GO
/****** Object:  StoredProcedure [dbo].[uspAllArtistSongs]    Script Date: 7/4/2020 10:39:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:    <Jasper van Dijk>
-- Create date: <25-6-2020>
-- Description: <alle songs van een bepaalde artiest die ooit in de top2000 hebben gestaan>
-- =============================================
CREATE PROCEDURE [dbo].[uspAllArtistSongs]
@artist AS int 
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
  IF @artist IS NULL SET @artist = 10008 --SET Normaal as default, leek me toepasselijk
-- Insert statements for procedure here
SELECT 
  a.naam,
  s.titel,
  s.jaar AS 'Uitgebracht in'
FROM     
  Song AS s
  JOIN Artiest AS a ON s.artiestid = a.Artiestid
  WHERE a.Artiestid = @artist
END
