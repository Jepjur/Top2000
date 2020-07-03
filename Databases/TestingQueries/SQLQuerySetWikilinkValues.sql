UPDATE Artiest
SET wikilink = concat('https://nl.wikipedia.org/wiki/', REPLACE(Artiest.naam,' ', '_'))