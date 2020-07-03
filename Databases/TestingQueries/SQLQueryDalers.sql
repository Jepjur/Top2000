USE Top2000Wiki
GO

SELECT
	Song.titel AS Titel
	, Artiest.naam AS Artiest
	, Song.jaar AS [Uitgave jaar]
	, (
		SELECT
			 lijst_vorig_jaar.positie
		FROM
			lijst AS lijst_vorig_jaar
		WHERE ((lijst_vorig_jaar.top2000jaar = 2018 - 1 AND
				lijst_jaar.songid = lijst_vorig_jaar.songid))
	) AS [2017]
	, lijst_jaar.positie AS [2018] 
	, (
		SELECT
			 lijst_vorig_jaar.positie - lijst_jaar.positie
		FROM
			lijst AS lijst_vorig_jaar
		WHERE ((lijst_vorig_jaar.top2000jaar = 2018 - 1 AND
				lijst_jaar.songid = lijst_vorig_jaar.songid))
	) AS [Verschil]
	
FROM
	lijst AS lijst_jaar INNER JOIN
	Song ON lijst_jaar.songid = Song.songid INNER JOIN
	Artiest ON Song.artiestid = Artiest.Artiestid
WHERE (
	lijst_jaar.top2000jaar = 2018 AND
	(
		SELECT
			 lijst_vorig_jaar.positie - lijst_jaar.positie
		FROM
			lijst AS lijst_vorig_jaar
		WHERE ((lijst_vorig_jaar.top2000jaar = 2018 - 1 AND
				lijst_jaar.songid = lijst_vorig_jaar.songid))
	) < 0 )
ORDER BY
	lijst_jaar.positie ASC