USE Top2000Wiki
GO

-- Songtekst
ALTER TABLE Song
ADD songtekst nvarchar(max)

-- Afbeeldingen
-- Artiest
-- we gebruiken de artiestId als filename

-- Song
ALTER TABLE Song
ADD afbeelding nvarchar(max)
-- dit is een relative adres naar een filename op de server

-- Biografie
ALTER TABLE Artiest
ADD biografie nvarchar(max)

-- Wikilink
ALTER TABLE Artiest
ADD wikilink nvarchar(max)