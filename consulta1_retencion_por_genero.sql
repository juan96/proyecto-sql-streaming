-- Consulta01: Analisis de engagement y retencion por genero
--Objetivo: Calcular el porcentaje de minutos reproducidos frente a la duracion total del catalogo para medir el 
--                   enganche de la audiencia.
--Area de Negocio: Estrategia de Contenido y Producto.
--Impacto: Identifica que categorias se ven completas y cuales sufren de abandono temprano para guiar furturas producciones o compras.

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

--Conclusión de Negocio: 
--El género Ciencia Ficción y la Comedia tienen una retención cercana al 100% 
--lo que significa que los usuarios los ven completos. Sin embargo, el género Terror tiene un porcentaje de retención muy bajo (menos del 20%).
--Acción recomendada: Sugiero al equipo de compras no adquirir más licencias de películas de Terror, ya que los usuarios las abandonan a los pocos minutos, y reasignar ese presupuesto a Ciencia Ficción.
