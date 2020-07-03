USE Top2000Wiki
GO

DECLARE @jaar int
SET @jaar = (SELECT min(lijst.top2000jaar) FROM lijst)
DECLARE @lastJaar int
SET @lastJaar = (SELECT max(lijst.top2000jaar) FROM lijst)

DECLARE @sql nvarchar(max)
SET @sql = '
	SELECT 
		Song.titel
		, Artiest.naam
		, Song.jaar'

		WHILE @jaar <= @lastJaar
		BEGIN
		SET @sql = concat(@sql,
		', (
			SELECT
				lijst.positie
			FROM
				lijst
			WHERE
				lijst.top2000jaar = ', @jaar, 'AND
				lijst.songid = song.songid) AS [', @jaar, '] 
		')
		SET @jaar = @jaar + 1
		END
	SET @sql = concat(@sql, 
	'FROM     
		Song INNER JOIN
			Artiest ON Song.artiestid = Artiest.Artiestid
	ORDER BY
		Artiest.naam
		')

EXEC sp_executesql @sql
