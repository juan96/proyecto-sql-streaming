SELECT
    c.genero AS Genero,
    COUNT(h.id_reproduccion) AS Total_Reproducciones,
    SUM(h.minutos_reproducidos) AS Minutos_Totales_Vistos,
    SUM(c.duracion_minutos) AS Duracion_Total_Contenido,
    -- Calculamos el porcentaje de retención real
    ROUND(
        (CAST(SUM(h.minutos_reproducidos) AS REAL) / SUM(c.duracion_minutos)) * 100,
        2
    ) AS Porcentaje_Retencion
FROM historial_reproduccion h
JOIN contenido c ON h.id_contenido = c.id_contenido
GROUP BY c.genero
ORDER BY Porcentaje_Retencion DESC;
