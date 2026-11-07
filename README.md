# RetailPro — Data Analytics

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos orientado a estudiar el desempeño comercial de una empresa de productos tecnológicos.

El proyecto busca transformar los registros de ventas en información útil para comprender la evolución de la facturación, identificar los productos que generan mayor impacto y obtener métricas que ayuden a la toma de decisiones comerciales.

El desarrollo integra distintas etapas del flujo de trabajo de un analista de datos: diseño de la base de datos, consultas SQL, limpieza y transformación de información, modelado, creación de medidas y visualización.

## Herramientas utilizadas

- **SQL:** creación de la base de datos y consultas de negocio.
- **Power Query:** limpieza y transformación de datos.
- **Power BI:** modelado y visualización.
- **DAX:** creación de medidas e indicadores.
- **GitHub:** almacenamiento y documentación del proyecto.
- **IA generativa:** utilizada como copiloto para revisar código, generar documentación y proponer mejoras, siempre con validación manual posterior.

## Estructura de los scripts SQL

### Módulo 3 — Base de datos

`Modulo_3/ventas_tech_db.sql`

Crea la estructura inicial de RetailPro, incluyendo las tablas principales, claves y registros necesarios para comenzar el análisis.

### Módulo 4 — Consultas de negocio

`Modulo_4/m4_consultas_negocio.sql`

Incluye consultas para obtener métricas como:

- facturación mensual;
- cantidad de pedidos;
- ticket promedio;
- ranking de productos;
- clientes recurrentes;
- comparación de períodos.

### Módulo 5 — JOINs

`Modulo_5/m5_consultas_joins.sql`

Integra información de las distintas tablas mediante JOIN para obtener una vista enriquecida de las ventas junto con información de clientes, productos y categorías.

## Cómo ejecutar los scripts SQL

Los scripts deben ejecutarse respetando el orden de los módulos, ya que cada etapa utiliza estructuras creadas anteriormente.

1. Ejecutar `ventas_tech_db.sql` para crear la base, las tablas y los datos iniciales.
2. Ejecutar `m4_consultas_negocio.sql` para obtener las primeras métricas y análisis comerciales.
3. Ejecutar `m5_consultas_joins.sql` para combinar las tablas y generar vistas enriquecidas.

Cada archivo debe ejecutarse con el motor SQL indicado en su encabezado.

Antes de continuar con el siguiente módulo se recomienda verificar que el script anterior se haya ejecutado correctamente y que los resultados obtenidos sean coherentes con los datos cargados.

## Uso de Inteligencia Artificial

Durante el desarrollo se utilizó IA generativa como herramienta de asistencia para revisar consultas, proponer mejoras y acelerar la documentación.

Las respuestas generadas por IA no se incorporaron automáticamente al proyecto. Las sugerencias fueron revisadas y contrastadas con la estructura y los datos reales de RetailPro antes de ser aceptadas.

La responsabilidad sobre la lógica, los resultados y las decisiones finales se mantuvo en el análisis humano.
