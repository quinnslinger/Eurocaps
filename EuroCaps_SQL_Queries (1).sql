
-- 1. Producten met een vervaldatum binnen 30 dagen
SELECT p.ProductID, sp.Omschrijving AS SoortProduct, b.BatchCode, b.Vervaldatum
FROM Product p
INNER JOIN SoortProduct sp ON p.SoortProductID = sp.SoortProductID
INNER JOIN Batch b ON p.ProductID = b.ProductID
WHERE b.Vervaldatum BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- 2. Aantal batches per soort product
SELECT sp.Omschrijving AS SoortProduct, COUNT(b.BatchID) AS AantalBatches
FROM SoortProduct sp
INNER JOIN Product p ON sp.SoortProductID = p.SoortProductID
INNER JOIN Batch b ON p.ProductID = b.ProductID
GROUP BY sp.Omschrijving;

-- 3. inzicht in leveringen en aantalproducten
SELECT 
    l.LeveringID,
    l.LeveringDatum,
    COUNT(lr.ProductID) AS AantalRegels,
    SUM(lr.Aantal) AS TotaalAantalProducten
FROM Levering l
LEFT JOIN LeveringRegel lr ON l.LeveringID = lr.LeveringID
GROUP BY l.LeveringID, l.LeveringDatum;

-- 4. Gemiddelde productiecapaciteit per bewerkingsproces
SELECT 'Grinding' AS Proces, AVG(Capaciteit) AS GemiddeldeCapaciteit FROM Grinding
UNION
SELECT 'Filling', AVG(Capaciteit) FROM Filling
UNION
SELECT 'Packaging', AVG(Capaciteit) FROM Packaging;

-- 5. Totale output per maand (aantal gevulde producten)
SELECT DATE_FORMAT(f.F_DatumTijdStart, '%Y-%m') AS Maand, SUM(fp.Aantal) AS TotaalGevuld
FROM Filling f
INNER JOIN Filling_Product fp ON f.FillingID = fp.FillingID
GROUP BY Maand
ORDER BY Maand;
