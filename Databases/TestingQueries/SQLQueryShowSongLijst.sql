USE Top2000Wiki
GO

SELECT 
	song.songid
	, Song.titel
	, Artiest.naam
	, Song.jaar
FROM     
	Song INNER JOIN
		Artiest ON Song.artiestid = Artiest.Artiestid
ORDER BY 
	song.songid