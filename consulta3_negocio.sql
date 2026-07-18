WITH Costo_Por_Genero AS (
    SELECT genero, SUM(costo_licencia) AS costo_total_licencia
    FROM contenido
    GROUP BY genero
),
Consumo_Por_Genero AS (
    SELECT c.genero, SUM(h.minutos_reproducidos) AS minutos_totales_vistos
    FROM historial_reproduccion h
    JOIN contenido c ON h.id_contenido = c.id_contenido
    GROUP BY c.genero
)
SELECT
    cg.genero AS Genero,
    cg.costo_total_licencia AS Costo_Licencia,
    IFNULL(cx.minutos_totales_vistos, 0) AS Minutos_Vistos,
    -- Calculamos el costo real que nos cuesta cada minuto reproducido
    CASE
        WHEN IFNULL(cx.minutos_totales_vistos, 0) = 0 THEN 'Sin consumo (Pérdida Total)'
        ELSE '$' || ROUND(cg.costo_total_licencia / cx.minutos_totales_vistos, 2)
    END AS Costo_Por_Minuto_Visto
FROM Costo_Por_Genero cg
LEFT JOIN Consumo_Por_Genero cx ON cg.genero = cx.genero
ORDER BY cg.costo_total_licencia / IFNULL(cx.minutos_totales_vistos, 1) ASC;