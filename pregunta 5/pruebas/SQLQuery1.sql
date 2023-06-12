DECLARE @cadena1 VARCHAR(50) = 'martha'
DECLARE @cadena2 VARCHAR(50) = 'marta'
DECLARE @m INT = LEN(@cadena1)
DECLARE @n INT = LEN(@cadena2)

-- Crear una tabla temporal para almacenar los cálculos de distancia
CREATE TABLE #dp (i INT, j INT, distancia INT)

-- Calcular la distancia de edición
DECLARE @i INT = 1, @j INT = 1
WHILE @i <= @m
BEGIN
    INSERT INTO #dp (i, j, distancia)
    VALUES (@i, 0, @i)
    SET @i = @i + 1
END

WHILE @j <= @n
BEGIN
    INSERT INTO #dp (i, j, distancia)
    VALUES (0, @j, @j)
    SET @j = @j + 1
END

SET @i = 1
WHILE @i <= @m
BEGIN
    SET @j = 1
    WHILE @j <= @n
    BEGIN
        IF SUBSTRING(@cadena1, @i, 1) = SUBSTRING(@cadena2, @j, 1)
        BEGIN
            INSERT INTO #dp (i, j, distancia)
            VALUES (@i, @j, (SELECT distancia FROM #dp WHERE i = @i - 1 AND j = @j - 1))
        END
        ELSE
        BEGIN
            INSERT INTO #dp (i, j, distancia)
            VALUES (@i, @j, 1 + (
                SELECT MIN(subquery.distancia)
                FROM (
                    SELECT (SELECT distancia FROM #dp WHERE i = @i - 1 AND j = @j) AS distancia,
                           (SELECT distancia FROM #dp WHERE i = @i AND j = @j - 1) AS insercion,
                           (SELECT distancia FROM #dp WHERE i = @i - 1 AND j = @j - 1) AS sustitucion
                ) AS subquery
            ))
        END

        SET @j = @j + 1
    END

    SET @i = @i + 1
END

-- Obtener la distancia mínima de la última celda de la tabla temporal
DECLARE @distancia INT = (SELECT distancia FROM #dp WHERE i = @m AND j = @n)

-- Mostrar los resultados
PRINT 'Cadena 1: ' + @cadena1
PRINT 'Cadena 2: ' + @cadena2
PRINT 'Distancia: ' + CAST(@distancia AS VARCHAR)

-- Eliminar la tabla temporal
DROP TABLE #dp