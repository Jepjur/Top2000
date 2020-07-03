--Artiest
CREATE INDEX IDX__Artiest_Naam
ON Artiest (naam)

--Lijst
CREATE INDEX IDX__Lijst_Songid
ON Lijst (Songid)

CREATE INDEX IDX__Lijst_top2000jaar
ON Lijst (top2000jaar)

--Song
CREATE INDEX IDX__Song_Artiestid
ON Song (artiestid)

CREATE INDEX IDX__Song_Titel
ON Song (titel)