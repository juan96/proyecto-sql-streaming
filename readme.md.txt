# 🎬 Análisis de Retención y ROI en Plataforma de Streaming
**Proyecto Portafolio #1 | SQL con SQLite**

## 📌 Objetivo del Proyecto
Este proyecto simula el análisis de datos de una plataforma de streaming (tipo Netflix) para resolver tres problemas críticos de negocio: la deserción de clientes (Churn), la retención por género de contenido y la eficiencia financiera del catálogo (ROI).

---

## 📊 Estructura de Datos
La base de datos relacional consta de 4 tablas optimizadas con integridad referencial (`ON DELETE CASCADE`):
- `usuarios`: Datos demográficos y nivel de suscripción.
- `contenido`: Catálogo de títulos, géneros y costos de licenciamiento.
- `historial_reproduccion`: Registro de eventos de consumo en minutos.
- `pagos`: Transacciones de ingresos mensuales.

---

## 🔍 Preguntas de Negocio Resueltas (KPIs)

### 1. Análisis de Engagement por Género
Identifica qué categorías retienen a la audiencia y cuáles sufren de abandono temprano.
*   **Insight Clave:** Ciencia Ficción y Comedia logran retenciones cercanas al 100%. El género de Terror sufre una caída drástica, con abandonos antes del 20% de la duración total.

### 2. Alerta Preventiva de Churn (Usuarios Inactivos)
Segmentación de clientes con suscripción activa pero sin actividad en los últimos 30 días.
*   **Insight Clave:** Se detectaron usuarios críticos (como Luis Morales) que pagan planes Premium pero registran 0 minutos de consumo, requiriendo intervención inmediata de marketing.

### 3. Eficiencia de Costo por Minuto Visto (ROI)
Evaluación del costo de licencias frente al consumo real mediante CTEs (Common Table Expressions).
*   **Insight Clave:** El género Drama resulta ineficiente ($133.33 USD por minuto visto), mientras que Comedia es el más rentable ($28.00 USD por minuto visto).

---

## 🛠️ Tecnologías Utilizadas
- **Motor de Base de Datos:** SQLite 3
- **Conceptos SQL Demostrados:** `LEFT JOIN`, CTEs (`WITH`), Funciones de Agregación (`SUM`, `COUNT`), Casos Condicionales (`CASE WHEN`), Formateo de fechas y casting de tipos de datos.
