-- 1) Wie hoch ist der durchschnittliche Lagerbestand aller Biere (der Wert soll den Namen Durch-
-- schnittslagerbestand erhalten)?
SELECT rname, AVG(anlager) FROM sortiment GROUP BY rname;
-- 2) Welche Besucher (Name,Vorname, Strasse) wohnen an einer Strasse, deren Bezeichnung das
-- Wort ‚bach‘ enthält? Untersuchen Sie auch die Resultate, die Sie mit ,Bach‘, ‚BACH‘ etc. erhal-
SELECT Name, Vorname, Strasse FROM Besucher WHERE Strasse LIKE '%bach%' OR Strasse LIKE '%Bach%';
-- ten. Sehen Sie hier allenfalls ein Problem?
-- 3) An welchen Strassen gibt es mindestens drei Restaurants (GROUP BY verwenden)?
SELECT Strasse, COUNT(Name) FROM Restaurant GROUP BY Strasse HAVING COUNT(Name) >= 3;
-- 4) Bilden Sie das Kreuzprodukt der Tabellen Restaurant und Besucher (mit und ohne CROSS JOIN).
-- Wieviele Tupel enthält das Resultat? Warum? Wozu könnte eine solche Abfrage nützlich sein?
SELECT * FROM Restaurant CROSS JOIN Besucher; -- (66 rows)
SELECT * FROM Restaurant, Besucher; -- (66 rows)
-- 5) Gesucht ist eine Liste von Besuchern mit Name, Vorname und der Anzahl Restaurantbesuche
-- pro Woche (= Frequenz). Falls ein Besucher nie Gast ist, soll er auf der Liste mit einer Anzahl
-- Besuche von 0 erscheinen. Verwenden Sie dazu einen OUTER JOIN. Optional: Lösung ohne
-- JOIN.
-- SELECT Name, Vorname, Bname, BVorname, CASE
-- WHEN EXISTS (SELECT DISTINCT Name,Vorname,Bname,Bvorname FROM Gast INNER JOIN Besucher ON Name=BName AND Vorname=Bvorname) THEN (SELECT Frequenz FROM Gast WHERE Name=BName AND Vorname=Bvorname)
-- ELSE 0
-- END
-- FROM Besucher INNER JOIN Gast on Name=BName AND Vorname=BVorname;

SELECT Name,Vorname, Frequenz FROM Gast OUTER JOIN Besucher ON Bname=Name AND BVorname=Vorname;

SELECT Bname,Bvorname, Frequenz FROM Gast;
SELECT Name,Vorname FROM Besucher;

-- 6) Gesucht ist eine Liste der Hersteller von Biersorten zusammen mit der Anzahl Biersorten, die
-- sie produzieren und der Anzahl verschiedener dabei verwendeter Grundstoffe.
-- 7) Welche Biersorten sind von allen mit derselben Note bewertet worden (Hinweis: das bedeutet,
-- dass kleinste Note = grösste Note)?
-- 8) Gesucht ist eine Liste von Restaurants mit ihrem Namen, ihrem Suppenpreis, sowie dem durch-
-- schnittlichen Suppenpreis aller Restaurants derselben Strasse.
-- 9) Gesucht ist eine Liste von Restaurants und Biersorten, von denen sie am meisten an Lager
-- haben.
-- 10) Gesucht sind die Strassen, an denen es mehr Restaurants gibt als Besucher.
-- 11) Gesucht ist eine Liste der Strassen von Besuchern, deren Vornamen den Buchstaben “p“ ent-
-- hält und die in Restaurants verkehren mit einem Suppenpreis zwischen 3 und 5
-- 12) Gesucht ist die Anzahl verschiedener Besucher des Restaurant Löwen.






-- Side tracking
-- SELECT * FROM lieblingsbier WHERE lieblingsbierx.ANZ=(SELECT MAX(A) FROM B)
-- l.bewertung <= (SELECT min(lz.bewertung) FROM lieblingsbier lz WHERE l1.name = l2.name AND l1.vorname = l2.vorname);
