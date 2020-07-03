	DECLARE @jaar int
	SET @jaar = 2005

    -- Insert statements for procedure here
	SELECT 
		Song.titel AS Titel
		, Artiest.naam AS Artiest
		, Song.jaar AS [Uitgave jaar]
		, (SELECT
			[dbo].[FN_PositieOverJaren](song.songid)
		  ) AS [PositieOverJaren]
	FROM     
		Lijst INNER JOIN
			Song ON Lijst.songid = Song.songid INNER JOIN
			Artiest ON Song.artiestid = Artiest.Artiestid
	WHERE
		Lijst.top2000jaar = @jaar AND
		NOT Lijst.songid IN (
			SELECT 
				lijst.songid
			FROM     
				Lijst AS Lijst
			WHERE
				lijst.top2000jaar = @jaar - 1) AND
		NOT lijst.songid IN (
			SELECT 
				 lijst.songid
			FROM     
				Lijst AS Lijst
			GROUP BY 
				Lijst.songid
			HAVING
				min(lijst.top2000jaar) = @jaar)