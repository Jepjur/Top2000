-- Deze query laat zien welke liedjes nieuw in de top 2000 gekomen zijn in het geselecteerde jaar.

USE Top2000Wiki
GO

DECLARE @Jaar int 
SET @Jaar = (SELECT min(lijst.top2000jaar) FROM lijst)
DECLARE @LastJaar int 
SET @LastJaar = (SELECT max(lijst.top2000jaar) FROM lijst)

SELECT 
	Lijst.positie
	, Song.titel
	, Artiest.naam
	, Song.jaar
FROM     
	Lijst INNER JOIN
        Song ON Lijst.songid = Song.songid INNER JOIN
        Artiest ON Song.artiestid = Artiest.Artiestid
WHERE
	Lijst.top2000jaar = 2018-1 AND
	lijst.songid IN (
		SELECT 
			 lijst.songid
		FROM     
			Lijst AS Lijst
		GROUP BY 
			Lijst.songid
		HAVING
			max(lijst.top2000jaar) = 2018-1)
ORDER BY
	Lijst.positie ASC