
DECLARE @songid int
SET @songid = 1000

DECLARE @jaar int
SET @jaar = (SELECT min(lijst.top2000jaar) FROM lijst)
DECLARE @lastJaar int
SET @lastJaar = (SELECT max(lijst.top2000jaar) FROM lijst)



DECLARE @positieOverJaren nvarchar(max)

WHILE @jaar <= @lastJaar
BEGIN
	SET @positieOverJaren = CONCAT_WS(',', @positieOverJaren, ISNULL(
		(SELECT
			lijst.positie
		FROM
			lijst
		WHERE
			lijst.top2000jaar = @jaar AND
			lijst.songid = @songid)
		, '')
		)
SET @jaar = @jaar + 1
END
SELECT @positieOverJaren