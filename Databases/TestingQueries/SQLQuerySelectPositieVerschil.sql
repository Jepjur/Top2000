USE Top2000Wiki
GO

SELECT
	lijst_jaar.positie AS [2018] 
	,(
		SELECT
			 lijst_vorig_jaar.positie
		FROM
			lijst AS lijst_vorig_jaar
		WHERE ((lijst_vorig_jaar.top2000jaar = 2018 - 1 AND
				lijst_jaar.songid = lijst_vorig_jaar.songid))
	) AS [2017]
	,(
		SELECT
			 lijst_vorig_jaar.positie - lijst_jaar.positie
		FROM
			lijst AS lijst_vorig_jaar
		WHERE ((lijst_vorig_jaar.top2000jaar = 2018 - 1 AND
				lijst_jaar.songid = lijst_vorig_jaar.songid))
	) AS [verschil]
	
FROM
	lijst AS lijst_jaar
WHERE
	lijst_jaar.top2000jaar = 2018
ORDER BY
	lijst_jaar.positie ASC