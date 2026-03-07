USE FANHUB;
GO

-- Usuario (id, email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo)
-- Creador (idUsuario, biografia, banco_nombre, banco_cuenta, es_nsfw, idCategoria)
-- idUsuario es PK y FK hacia Usuario.
-- Categoria (id, nombre, descripcion)
-- MetodoPago (id, idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado)
-- NivelSuscripcion (id, idCreador, nombre, descripcion, precio_actual, esta_activo, orden)
-- Suscripcion (id, idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado)
-- Estados posibles: 'Activa', 'Cancelada', 'Vencida'.
-- Factura (id, idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total)
-- Publicacion (id, idCreador, titulo, fecha_publicacion, es_publica, tipo_contenido)
-- Tipos posibles: 'VIDEO', 'TEXTO', 'IMAGEN'.
-- Video (idPublicacion, duracion_seg, resolucion, url_stream)
-- Texto (idPublicacion, contenido_html, resumen_gratuito)
-- Imagen (idPublicacion, ancho, alto, formato, alt_text, url_imagen)
-- Comentario (id, idUsuario, idPublicacion, idComentarioPadre, texto, fecha)
-- idComentarioPadre es FK recursiva (puede ser NULL).
-- TipoReaccion (id, nombre, emoji_code)
-- UsuarioReaccionPublicacion (idUsuario, idPublicacion, idTipoReaccion, fecha_reaccion)
-- Etiqueta (id, nombre)
-- PublicacionEtiqueta (idPublicacion, idEtiqueta)

-- 10. Ranking de Creadores (Reputación): Listar creadores multimedia (VIDEO/IMAGEN) que
-- nunca hayan subido contenido NSFW. El listado debe estar ordenado
-- descendentemente por su Reputación, calculada invocando a la función
-- fn_calcular_reputacion.
-- ○ Columnas a mostrar: Nickname, Total Suscriptores, Puntaje Reputación.

GO



-- 12. Tendencias (Tags): Top 3 etiquetas más usadas el último mes.
-- ○ Columnas a mostrar: Nombre Etiqueta, Cantidad Publicaciones.

GO

-- 13. Cobertura Total de Reacciones: Usuarios que han usado todos los tipos de reacción
-- del catálogo.
-- ○ Columnas a mostrar: Nickname, Total Reacciones Realizadas.

GO

-- 14. Reporte de Nómina (Liquidación): Generar el listado de pagos a realizar a los
-- creadores correspondiente al mes actual. La plataforma cobra una comisión del 20%
-- sobre el total facturado.
-- ○ Columnas a mostrar: Nombre Banco, Cuenta Bancaria, Beneficiario (Nickname),
-- Total Facturado (Bruto), Comisión FanHub, Monto a Transferir (Neto).

GO


-- 1. Clasificación de Ganancias: Listar los creadores basándose en su facturación del
-- último mes. Deben utilizar la función fn_clasificar_ingreso para determinar la etiqueta del
-- creador.

-- ○ Columnas a mostrar: Nickname, Categoria, Total Suscriptores Activos,
--   MontoFacturado, Clasificación (Retorno de la función).

WITH Creador_total_suscriptores_activosCTE AS 
(
	SELECT c.idUsuario AS id, COUNT(*) AS num_total
	FROM Usuario u
	JOIN Suscripcion s ON (u.id = s.idUsuario)
	JOIN NivelSuscripcion ns ON (ns.id = s.idNivel)
	JOIN Creador c ON (c.idUsuario = ns.idCreador)
	WHERE u.esta_activo = 1
	GROUP BY c.idUsuario
)
SELECT 
  u.nickname AS 'Nickname',
  cat.nombre AS 'Categoria',
  ct.num_total AS 'Total Suscriptores Activos',
  SUM(f.monto_total) AS 'Monto Facturado', 
  dbo.fn_clasificar_ingreso(SUM(f.monto_total)) AS 'Clasificacion'
FROM Creador c 
JOIN Categoria cat ON (cat.id = c.idCategoria)
JOIN Usuario u ON (u.id = c.idUsuario)
JOIN NivelSuscripcion ns ON (ns.idCreador = c.idUsuario)
JOIN Suscripcion s ON (s.idNivel = ns.id)
JOIN Factura f on (f.idSuscripcion = s.id)
JOIN Creador_total_suscriptores_activosCTE ct ON (c.idUsuario = ct.id)
WHERE f.fecha_emision > DATEADD(month, -1, GETDATE())
GROUP BY c.idUsuario, u.nickname, cat.nombre, ct.num_total;
GO

-- 2. Viralidad por Categoría: Mostrar la publicación con mayor puntaje de viralidad dentro
-- de cada Categoría. Puntaje = (Reacciones * 1.5) + (Comentarios * 3).
-- ○ Columnas a mostrar: Nombre Categoría, Título Publicación, Creador, Puntaje Máximo.

--REVISAR CREO QUE ESTA MAL

WITH Publicacion_comentariosCTE AS
(
	SELECT p.id AS id, COUNT(*) AS num_total
	FROM Publicacion p 
	JOIN Comentario c ON (c.idPublicacion = p.id)
	GROUP BY p.id
), Publicacion_reaccionesCTE AS
(
	SELECT p.id AS id, COUNT(*) AS num_total
	FROM Publicacion p 
	JOIN UsuarioReaccionPublicacion urp ON (urp.idPublicacion = p.id)
	GROUP BY p.id
)
SELECT 
  cat.nombre AS 'Nombre Categoria',
  p.titulo AS 'Titulo Publicacion',
  u.nickname AS 'Creador',
  MAX((ISNULL(pr.num_total, 0) * 1.5) + (ISNULL(pc.num_total, 0) * 3)) AS 'Puntaje Maximo'
FROM Publicacion p
JOIN Creador c ON (p.idCreador = c.idUsuario)
JOIN Categoria cat ON (c.idCategoria = cat.id)
JOIN Usuario u ON (p.idCreador = u.id)
LEFT JOIN Publicacion_reaccionesCTE pr ON (pr.id = p.id)
LEFT JOIN Publicacion_comentariosCTE pc ON (pc.id = p.id)
GROUP BY cat.id, cat.nombre, p.titulo, u.nickname
GO

-- 3. Análisis de Dominios de Correo: Contar la frecuencia de proveedores de correo. Filtrar
-- para mostrar solo los dominios con más de 10 usuarios.
-- ○ Columnas a mostrar: Dominio (ej: gmail.com), Cantidad Usuarios.

SELECT SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS 'Dominio', 
COUNT(id) AS 'Cantidad Usuarios'
FROM Usuario 
GROUP BY SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email))
HAVING COUNT(id) > 10;
GO

-- 4. Promedio de Retención (Churn): Para las suscripciones 'Canceladas', calcular el
-- promedio de días de duración. Ordenamiento: Agrupar por creador y ordenar los
-- resultados según la jerarquía del nivel (campo orden) de menor a mayor.
-- ○ Columnas a mostrar: Nickname Creador, Nombre Nivel, Promedio Días.

SELECT 
  u.nickname AS 'Nickname Creador', 
  ns.nombre AS 'Nombre Nivel', 
  AVG(DATEDIFF(DAY, s.fecha_inicio, s.fecha_fin)) AS 'Promedio Dias'
FROM Usuario u
JOIN NivelSuscripcion ns ON (ns.idCreador = u.id)
JOIN Suscripcion s ON (s.idNivel = ns.id)
WHERE s.estado IN('Cancelada')
GROUP BY 
  u.id, 
  u.nickname, 
  ns.nombre,
  ns.orden
ORDER BY ns.orden ASC;
GO

-- 5. Tiempo y Peso de Contenido (Gaming): Calcular la duración total de videos de
-- creadores "Gaming" y estimar el almacenamiento ocupado en GB. (Asumir: 1 min 4K =
-- 0.5 GB, 1 min 1080p = 0.1 GB, Otros = 0.05 GB).
-- ○ Columnas a mostrar: Nickname, Tiempo Total Formateado (ej: '12h 45m'),
--   Estimación GB.

SELECT 
  u.nickname AS 'Nickname',
  CAST(SUM(v.duracion_seg) / 3600 AS VARCHAR(10)) + 'h '
  + CAST((SUM(v.duracion_seg) % 3600) / 60 AS VARCHAR(10)) + 'm '
  + CAST((SUM(v.duracion_seg) % 60) AS VARCHAR(10)) + 's'
  AS 'Tiempo Total Formateado',
  SUM
  (
    CASE
	  WHEN v.resolucion = '4K' THEN v.duracion_seg / 60.0 * 0.5
	  WHEN v.resolucion = '1080p' THEN v.duracion_seg / 60.0 * 0.1
	  ELSE v.duracion_seg / 60.0 * 0.05
	END
  ) AS 'Estimacion GB'
FROM Creador c
JOIN Usuario u ON (u.id = c.idUsuario)
JOIN Categoria cat ON (c.idCategoria = cat.id)
JOIN Publicacion p ON (p.idCreador = c.idUsuario)
JOIN Video v ON (v.idPublicacion = p.id)
WHERE cat.nombre IN ('Gaming')
GROUP BY c.idUsuario, u.nickname;
GO


-- 6. Mapa de Calor Financiero: Calcular la facturación total por país y su participación de
-- mercado global.
-- ○ Columnas a mostrar: País, Total Facturado, Share % (ej: '15.5%').

SELECT 
  u.pais AS 'Pais', 
  SUM(f.monto_total) AS 'Total Facturado', 
  CAST(
    CAST(
	  (SUM(f.monto_total) * 100.0) / (SELECT SUM(monto_total) FROM Factura)
	  AS NUMERIC(10,2)
	) 
  AS VARCHAR(10)) + '%' AS 'Share %'
FROM Usuario u
JOIN Suscripcion s ON(s.idUsuario = u.id)
JOIN Factura f ON(f.idSuscripcion = s.id)
GROUP BY u.pais
GO

-- 7. Intereses Cruzados: Listar usuarios con suscripciones en "Tecnología" Y "Fitness" (o
-- dos categorías disjuntas) y un gasto histórico > $140 USD.
-- ○ Columnas a mostrar: Nickname Usuario, Gasto Total Histórico.

SELECT 
  u.nickname AS 'Nickname Usuario', 
  SUM(f.monto_total) AS 'Gasto Total Historico'
FROM Usuario u
JOIN Suscripcion s ON(s.idUsuario = u.id)
JOIN NivelSuscripcion ns ON(ns.id = s.idNivel)
JOIN Creador c ON(c.idUsuario = ns.idCreador)
JOIN Categoria cat ON(cat.id = c.idCategoria)
JOIN Factura f ON(f.idSuscripcion = s.id)
WHERE cat.nombre IN ('Fitness', 'Tecnologia')
GROUP BY u.id, u.nickname
HAVING COUNT(DISTINCT cat.nombre) = 2 AND SUM(f.monto_total) > 140


-- 8. Generaciones: Clasificar usuarios por año de nacimiento: 'Gen Z' (>2000), 'Millennials'
-- (1981-2000), 'X' (<1981).
-- ○ Columnas a mostrar: Generación, Cantidad Usuarios Activos, Gasto Promedio Mensual.

-- ARREGLAR: GASTO PROMEDIO MENSUAL

SELECT
  CASE
	WHEN (YEAR(u.fecha_nacimiento) < 1981) THEN 'X'
	WHEN (YEAR(u.fecha_nacimiento) > 2000) THEN 'Gen Z'
	ELSE 'Millenials'
  END AS 'Generacion',
  COUNT(DISTINCT u.id) AS 'Cantidad Usuarios Activos',
  CAST(AVG(f.monto_total) AS NUMERIC(10,2)) AS 'Gasto Promedio Mensual'
FROM Usuario u
JOIN Suscripcion s ON (s.idUsuario = u.id)
JOIN Factura f ON (f.idSuscripcion = s.id)
WHERE u.esta_activo = 1
GROUP BY
  CASE
	WHEN (YEAR(u.fecha_nacimiento) < 1981) THEN 'X'
	WHEN (YEAR(u.fecha_nacimiento) > 2000) THEN 'Z'
	ELSE 'Millenials'
  END;
GO

-- 9. Creadores Polémicos: Listar Creadores con un promedio de ratio (Comentarios /
-- Reacciones) > 2.0.
-- ○ Columnas a mostrar: Nickname, Cantidad Posts Evaluados, Ratio Promedio.

WITH comentarios_creadorCTE AS 
(
  SELECT c.idUsuario AS idCreador, COUNT(c.idUsuario) AS total_comentarios
  FROM Creador c
  JOIN Publicacion p ON (p.idCreador = c.idUsuario)
  JOIN Comentario com ON (com.idPublicacion = p.id)
  GROUP BY c.idUsuario
), reacciones_creadorCTE AS 
(
  SELECT c.idUsuario AS idCreador, COUNT(c.idUsuario) AS total_reacciones
  FROM Creador c
  JOIN Publicacion p ON (p.idCreador = c.idUsuario)
  JOIN UsuarioReaccionPublicacion urp ON (urp.idPublicacion = p.id)
  GROUP BY c.idUsuario
), publicaciones_creadorCTE AS 
(
  SELECT c.idUsuario AS idCreador, COUNT(c.idUsuario) AS total_publicaciones
  FROM Creador c
  JOIN Publicacion p ON (p.idCreador = c.idUsuario)
  GROUP BY c.idUsuario
)
SELECT 
  u.nickname AS 'Nickname',
  pc.total_publicaciones AS 'Cantidad Posts Evaluados',
  ((cc.total_comentarios * 1.0) / NULLIF(rc.total_reacciones, 0)) AS 'Ratio Promedio'
FROM Creador c 
JOIN Usuario u ON (u.id = c.idUsuario)
JOIN reacciones_creadorCTE rc ON (rc.idCreador = c.idUsuario)
JOIN comentarios_creadorCTE cc ON (cc.idCreador = c.idUsuario)
JOIN publicaciones_creadorCTE pc ON(pc.idCreador = c.idUsuario)
WHERE ((cc.total_comentarios * 1.0) / NULLIF(rc.total_reacciones, 0)) > 2.0;
GO

-- 11. Usuarios "Lurkers": Usuarios con suscripción activa pero sin ninguna interacción
-- (comentario/reacción).
-- ○ Columnas a mostrar: Nickname, Fecha Última Suscripción, Monto Gastado (Estimado).

WITH usuarios_con_reaccionCTE AS 
(
	SELECT idUsuario AS id FROM Comentario
	UNION
	SELECT idUsuario AS id FROM UsuarioReaccionPublicacion
)
SELECT 
  u.nickname AS 'Nickname',
  MAX(s.fecha_inicio) AS 'Fecha Ultima Suscripcion',
  SUM(f.monto_total) AS 'Monto Gastado (Estimado)'
FROM Usuario u
JOIN Suscripcion s ON(s.idUsuario = u.id)
JOIN Factura f ON(f.idSuscripcion = s.id)
WHERE u.id NOT IN (SELECT id FROM usuarios_con_reaccionCTE) AND s.estado = 'Activa'
GROUP BY u.id, u.nickname
GO