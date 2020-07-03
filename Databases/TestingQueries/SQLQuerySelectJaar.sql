USE Top2000Wiki
GO

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
	Lijst.top2000jaar = 2018
ORDER BY
	Lijst.positie ASC