SELECT 
	Song.titel
	, Artiest.naam
	, Song.jaar
	, Lijst.positie
FROM     
	Song INNER JOIN
		Artiest ON Song.artiestid = Artiest.Artiestid INNER JOIN
		Lijst ON Song.songid = Lijst.songid
WHERE
	song.artiestid = 10000 AND
	lijst.top2000jaar = 2018