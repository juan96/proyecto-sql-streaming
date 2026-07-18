SELECT
    u.id_usuario,
    u.nombre AS Cliente,
    u.pais AS Pais,
    u.tipo_plan AS Plan,
    -- Si nunca ha visto nada, mostraremos un mensaje claro
    COALESCE(MAX(h.fecha_visto), 'Nunca ha visto contenido') AS Ultima_Actividad
FROM usuarios u
LEFT JOIN historial_reproduccion h ON u.id_usuario = h.id_usuario
GROUP BY u.id_usuario, u.nombre, u.pais, u.tipo_plan
HAVING Ultima_Actividad = 'Nunca ha visto contenido'
   OR Ultima_Actividad < DATE('2026-07-17', '-30 days')
ORDER BY Ultima_Actividad ASC;