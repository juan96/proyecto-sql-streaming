-- Consulta 02: Alerta Preventiva de Churn (Usuarios Inactivos)
-- Objetivo: Detectar clientes con suscripción activa que no registran
--           reproducciones en los últimos 30 días o que nunca han usado la plataforma.
-- Área de Negocio: Retención de Clientes y Marketing.
-- Impacto: Proporciona una lista segmentada de usuarios en riesgo para
--          lanzar campañas dirigidas de correo o notificaciones push.


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


--Conclusión de Negocio: 
--Se detectaron usuarios en riesgo crítico de Churn. Destaca el caso de Luis Morales, quien pagó su suscripción pero registra cero minutos de uso, 
--y clientes antiguos como María Silva que no entran a la plataforma desde hace más de 40 días.
--Acción recomendada: Enviar una campaña de correo automatizada (Push Notification) a estos usuarios específicos sugiriéndoles los estrenos del mes de los géneros "Ciencia Ficción" y "Comedia", los cuales tienen la mayor tasa de retención en la plataforma.
