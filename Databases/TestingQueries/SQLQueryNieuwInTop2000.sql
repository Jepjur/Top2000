-- Deze query laat zien welke liedjes nieuw in de top 2000 gekomen zijn in het geselecteerde jaar.

USE Top2000Wiki
GO

SELECT 
	Lijst.positie 
	, Song.titel
	, Artiest.naam
	, Song.jaar
	, (SELECT
			[dbo].[FN_PositieOverJaren](song.songid)
	)
FROM     
	Lijst INNER JOIN
        Song ON Lijst.songid = Song.songid INNER JOIN
        Artiest ON Song.artiestid = Artiest.Artiestid
WHERE
	Lijst.top2000jaar = 2018 AND
	lijst.songid IN (
		SELECT 
			 lijst.songid
		FROM     
			Lijst AS Lijst
		GROUP BY 
			Lijst.songid
		HAVING
			min(lijst.top2000jaar) = 2018)
ORDER BY
	Lijst.positie ASC