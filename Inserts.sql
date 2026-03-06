USE FANHUB;
GO

PRINT 'Limpiando datos previos para permitir re-ejecución total...';

-- 1. Borramos tablas de interacción y detalles (Hijos de nivel 3)
DELETE FROM UsuarioReaccionPublicacion;
DELETE FROM Comentario;
DELETE FROM PublicacionEtiqueta;
DELETE FROM Imagen;
DELETE FROM Video;
DELETE FROM Texto;

-- 2. Borramos tablas de contenido y facturación (Hijos de nivel 2)
DELETE FROM Publicacion;
DELETE FROM Factura;
DELETE FROM Suscripcion;

-- 3. Borramos tablas de configuración de usuario y creador (Hijos de nivel 1)
DELETE FROM MetodoPago;
DELETE FROM NivelSuscripcion;
DELETE FROM Creador;

-- 4. Borramos tablas maestras y base (Padres)
DELETE FROM Usuario;
DELETE FROM Etiqueta;
DELETE FROM TipoReaccion;
DELETE FROM Categoria;

--Reseteo de ids
DBCC CHECKIDENT ('Usuario', RESEED, 0);
DBCC CHECKIDENT ('Categoria', RESEED, 0);
DBCC CHECKIDENT ('TipoReaccion', RESEED, 0);
DBCC CHECKIDENT ('Etiqueta', RESEED, 0);
DBCC CHECKIDENT ('MetodoPago', RESEED, 0);
DBCC CHECKIDENT ('NivelSuscripcion', RESEED, 0);
DBCC CHECKIDENT ('Suscripcion', RESEED, 0);
DBCC CHECKIDENT ('Factura', RESEED, 0);
DBCC CHECKIDENT ('Publicacion', RESEED, 0);
DBCC CHECKIDENT ('Comentario', RESEED, 0);
GO

PRINT 'Iniciando carga de datos de Catálogos...';

-- ==========================================
-- 1. Inserción de CATEGORÍAS
-- ==========================================
IF OBJECT_ID('Categoria', 'U') IS NOT NULL
BEGIN
    BEGIN TRY SET IDENTITY_INSERT Categoria ON; END TRY BEGIN CATCH END CATCH;

    INSERT INTO Categoria (id, nombre, descripcion) VALUES
    (1, 'Gaming', 'Transmisiones en vivo de videojuegos, eSports y speedruns.'),
    (2, 'Fitness', 'Rutinas de ejercicio, nutrición, dietas y bienestar físico.'),
    (3, 'Tecnología', 'Reseñas de gadgets, tutoriales de programación y software.'),
    (4, 'Arte Digital', 'Ilustraciones, diseño gráfico, modelado 3D y animación.'),
    (5, 'Música', 'Covers, composiciones originales, partituras y clases de instrumentos.'),
    (6, 'Cocina', 'Recetas paso a paso, técnicas culinarias y repostería.'),
    (7, 'Vlogs', 'Blogs en video sobre estilo de vida, moda y viajes alrededor del mundo.'),
    (8, 'Educación', 'Cursos, apoyo académico, idiomas y divulgación científica.'),
    (9, 'ASMR', 'Contenido auditivo y visual relajante (respuestas meridianas sensoriales).'),
    (10, 'Comedia', 'Sketches, stand-up, parodias y contenido humorístico en general.'),
    (11, 'Moda y Belleza', 'Maquillaje, cuidado de la piel, outfits y reseñas de productos.'),
    (12, 'Viajes', 'Turismo, guías de ciudades, mochileros y reseñas de hoteles.'),
    (13, 'Finanzas Personales', 'Inversiones, criptomonedas, ahorro y educación financiera.'),
    (14, 'Deportes', 'Análisis de partidos, noticias deportivas y entrevistas a atletas.'),
    (15, 'Cine y TV', 'Reseñas de películas, análisis de series y noticias de Hollywood.'),
    (16, 'Literatura', 'Reseñas de libros, clubes de lectura y consejos de escritura.'),
    (17, 'Manualidades', 'DIY, costura, carpintería y proyectos para el hogar.'),
    (18, 'Política y Noticias', 'Análisis de actualidad, debates y reportajes de investigación.'),
    (19, 'Mascotas', 'Adiestramiento canino, cuidados, acuarios y veterinaria básica.'),
    (20, 'Astrología y Esoterismo', 'Horóscopos, tarot, espiritualidad y meditación.'),
    (21, 'Cosplay', 'Creación de trajes, props, maquillaje FX y sesiones fotográficas temáticas.'),
    (22, 'Fotografía y Modelaje', 'Sesiones de fotos profesionales, detrás de cámaras y poses.'),
    (23, 'Anime y Manga', 'Reseñas, teorías, fan-fiction y discusión sobre cultura otaku.'),
    (24, 'Podcasts', 'Programas de audio, entrevistas, storytelling y charlas en formato episódico.');

    BEGIN TRY SET IDENTITY_INSERT Categoria OFF; END TRY BEGIN CATCH END CATCH;
    PRINT 'Catálogo [Categoria] insertado correctamente (24 registros).';
END
GO

-- ==========================================
-- 2. Inserción de TIPOS DE REACCIÓN
-- ==========================================
IF OBJECT_ID('TipoReaccion', 'U') IS NOT NULL
BEGIN
    BEGIN TRY SET IDENTITY_INSERT TipoReaccion ON; END TRY BEGIN CATCH END CATCH;

    INSERT INTO TipoReaccion (id, nombre, emoji_code) VALUES
    (1, 'Me gusta', '👍'),
    (2, 'Me encanta', '❤️'),
    (3, 'Me divierte', '😂'),
    (4, 'Fuego', '🔥'),
    (5, 'Me entristece', '😢'),
    (6, 'Me asombra', '😲'),
    (7, 'Me enfurece', '😡');

    BEGIN TRY SET IDENTITY_INSERT TipoReaccion OFF; END TRY BEGIN CATCH END CATCH;
    PRINT 'Catálogo [TipoReaccion] insertado correctamente (7 registros).';
END
GO

PRINT 'Carga de Catálogos finalizada exitosamente.';
GO

-- ==========================================
-- 3. Inserción de ETIQUETAS
-- ==========================================
PRINT 'Insertando 50 Etiquetas...';

INSERT INTO Etiqueta (nombre) VALUES 
('Gameplay'), ('Tutorial'), ('Review'), ('Speedrun'), ('E-Sports'), 
('Yoga'), ('HIIT'), ('Nutricion'), ('Cardio'), ('Calistenia'),
('Python'), ('Java'), ('SQL'), ('React'), ('Cybersecurity'),
('DigitalArt'), ('Procreate'), ('Blender'), ('ConceptArt'), ('AnimeArt'),
('Acoustic'), ('Rock'), ('Jazz'), ('Piano'), ('MusicProduction'),
('Vegan'), ('Baking'), ('StreetFood'), ('Keto'), ('Pasta'),
('DailyVlog'), ('Haul'), ('Storytime'), ('Aesthetic'), ('Minimalism'),
('History'), ('Science'), ('Algebra'), ('Languages'), ('Philosophy'),
('Whisper'), ('Tapping'), ('NatureSounds'), ('Relax'), ('SleepAid'),
('StandUp'), ('Parody'), ('DarkHumor'), ('Meme'), ('Prank');
GO

PRINT 'Etiquetas insertadas correctamente (50 registros).';

-- ==========================================
-- 3. Inserción de USUARIOS (Fans y Creadores)
-- ==========================================
PRINT 'Insertando primeros 100 usuarios...';

-- Limpieza para re-ejecución (borra de hijos a padres)
-- DELETE FROM UsuarioReaccionPublicacion;
-- DELETE FROM Comentario;
-- DELETE FROM MetodoPago;
-- DELETE FROM Creador;
-- DELETE FROM Usuario; 
-- GO

--=============================================
-----INSERTANDO USUARIOS Y CREADORES--------
--=============================================

INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo) VALUES
-- Posibles Creadores (IDs 1 al 25 aproximadamente)
('diego.vargas@ucv.ve', '7f6f10c7356c4e156494e8a604f7c14a', 'DiegoDev', '2026-01-01', '2001-05-15', 'Venezuela', 1),
('valen.fit@gym.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'ValenFit', '2026-01-02', '1995-03-20', 'Venezuela', 1),
('cjpacca@gaming.es', 'c33367701511b4f6020ec61ded352059', 'CJPACCA', '2026-01-03', '2006-11-07', 'Venezuela', 1),
('marta.chef@foodie.mx', '4a7d1ed414474e4033ac29ccb8653d9b', 'MartaCuisine', '2026-01-04', '1985-07-30', 'México', 1),
('Sergio.tech@code.co', '827ccb0eea8a706c4c34a16891f84e7b', 'SergioCode', '2026-01-05', '2002-07-29', 'Venezuela', 1),
('ana.asmr@relax.ar', 'e10adc3949ba59abbe56e057f20f883e', 'AnaWhispers', '2026-01-06', '1998-02-14', 'Argentina', 1),
('pedro.world@travel.cl', '21232f297a57a5a743894a0e4a801fc3', 'PedroWorld', '2026-01-07', '1980-04-22', 'Chile', 1),
('lucia.brush@art.uy', 'ee11cbb19052e40b07aac0ca060c23ee', 'LuciaBrush', '2026-01-08', '2003-09-18', 'Uruguay', 1),
('marcosAurelio.dark@nsfw.es', '96e79218965eb72c92a549dd5a330112', 'MarcosDark', '2026-01-09', '2005-03-23', 'Perú', 1),
('elena.style@moda.ve', '5d41402abc4b2a76b9719d911017c592', 'ElenaStyle', '2026-01-10', '1996-01-15', 'Venezuela', 1),
-- Fans (Gen Z, Millennials, Gen X)
('user11@gmail.com', 'hash11', 'Lurker1', '2026-01-11', '2005-05-05', 'Venezuela', 1),
('user12@outlook.com', 'hash12', 'FanGlobal', '2026-01-12', '1988-10-10', 'México', 1),
('user13@yahoo.com', 'hash13', 'OldSchool', '2026-01-13', '1975-03-15', 'España', 1),
('user14@gmail.com', 'hash14', 'TechieFan', '2026-01-14', '2002-12-20', 'Colombia', 1),
('user15@hotmail.com', 'hash15', 'GamerGirl', '2026-01-15', '1999-07-07', 'Chile', 1),
('user16@gmail.com', 'hash16', 'ArtLover', '2026-01-16', '1994-01-25', 'Argentina', 1),
('user17@ucv.ve', 'hash17', 'Ucvista1', '2026-01-17', '2001-11-30', 'Venezuela', 1),
('user18@gmail.com', 'hash18', 'FitnessFan', '2026-01-18', '1992-04-12', 'México', 1),
('user19@outlook.es', 'hash19', 'ViajeroSolitario', '2026-01-19', '1982-08-08', 'España', 1),
('user20@gmail.com', 'hash20', 'MemeMaster', '2026-01-20', '2006-02-28', 'Venezuela', 1);
GO
-- ==========================================
-- 3. Continuación de USUARIOS (IDs 21 al 100)
-- ==========================================
PRINT 'Insertando bloque de usuarios 21 al 100...';

INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo) VALUES
('luis.v@gmail.com', 'h21', 'LuisV', '2026-01-21', '1995-03-12', 'Venezuela', 1),
('maria.p@outlook.com', 'h22', 'MariaP', '2026-01-22', '1988-07-25', 'Mexico', 1),
('jorge.g@yahoo.com', 'h23', 'JorgeG', '2026-01-23', '1979-11-30', 'España', 1),
('andrea.s@gmail.com', 'h24', 'AndreaS', '2026-01-24', '2002-05-14', 'Colombia', 1),
('ChristianL.r@hotmail.com', 'h25', 'CLechiguero', '2026-01-25', '1991-01-01', 'Venezuela', 1),
('sofia.m@gmail.com', 'h26', 'SofiaM', '2026-01-26', '1999-12-12', 'Venezuela', 1),
('raul.t@ucv.ve', 'h27', 'RaulT', '2026-01-27', '2003-08-08', 'Venezuela', 1),
('elena.f@gmail.com', 'h28', 'ElenaF', '2026-01-28', '1984-04-04', 'Argentina', 1),
('pablo.d@outlook.es', 'h29', 'PabloD', '2026-01-29', '1970-10-10', 'España', 1),
('clara.z@gmail.com', 'h30', 'ClaraZ', '2026-01-30', '2005-02-02', 'Venezuela', 1),
('marcos.l@yahoo.com', 'h31', 'MarcosL', '2026-01-31', '1993-06-15', 'Mexico', 1),
('isabel.k@gmail.com', 'h32', 'IsabelK', '2026-02-01', '1989-09-09', 'Colombia', 1),
('victor.h@ucv.ve', 'h33', 'VictorH', '2026-02-02', '2001-03-03', 'Venezuela', 1),
('nora.j@gmail.com', 'h34', 'NoraJ', '2026-02-03', '1982-11-11', 'Chile', 1),
('hugo.w@outlook.com', 'h35', 'HugoW', '2026-02-04', '1978-01-20', 'España', 1),
('julia.q@gmail.com', 'h36', 'JuliaQ', '2026-02-05', '2004-12-25', 'Venezuela', 1),
('oscar.p@yahoo.es', 'h37', 'OscarP', '2026-02-06', '1990-05-05', 'Mexico', 1),
('silvia.r@gmail.com', 'h38', 'SilviaR', '2026-02-07', '1997-08-08', 'Colombia', 1),
('fabio.u@ucv.ve', 'h39', 'FabioU', '2026-02-08', '2002-10-10', 'Venezuela', 1),
('diana.y@gmail.com', 'h40', 'DianaY', '2026-02-09', '1986-02-14', 'Argentina', 1),
-- Bloque repetitivo para llenar volumen con dominios controlados
('test41@gmail.com', 'h41', 'User41', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test42@gmail.com', 'h42', 'User42', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test43@gmail.com', 'h43', 'User43', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test44@gmail.com', 'h44', 'User44', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test45@gmail.com', 'h45', 'User45', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test46@gmail.com', 'h46', 'User46', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test47@gmail.com', 'h47', 'User47', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test48@gmail.com', 'h48', 'User48', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test49@gmail.com', 'h49', 'User49', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test50@gmail.com', 'h50', 'User50', '2026-02-10', '2000-01-01', 'Venezuela', 1),
('test51@ucv.ve', 'h51', 'User51', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test52@ucv.ve', 'h52', 'User52', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test53@ucv.ve', 'h53', 'User53', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test54@ucv.ve', 'h54', 'User54', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test55@ucv.ve', 'h55', 'User55', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test56@ucv.ve', 'h56', 'User56', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test57@ucv.ve', 'h57', 'User57', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test58@ucv.ve', 'h58', 'User58', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test59@ucv.ve', 'h59', 'User59', '2026-02-11', '1995-01-01', 'Venezuela', 1),
('test60@ucv.ve', 'h60', 'User60', '2026-02-11', '1995-01-01', 'Venezuela', 1),
-- Gen X para el reporte
('old61@yahoo.com', 'h61', 'Retro61', '2026-02-12', '1970-05-20', 'España', 1),
('old62@yahoo.com', 'h62', 'Retro62', '2026-02-12', '1972-06-21', 'España', 1),
('old63@yahoo.com', 'h63', 'Retro63', '2026-02-12', '1974-07-22', 'España', 1),
('old64@yahoo.com', 'h64', 'Retro64', '2026-02-12', '1976-08-23', 'España', 1),
('old65@yahoo.com', 'h65', 'Retro65', '2026-02-12', '1978-09-24', 'España', 1),
('old66@yahoo.com', 'h66', 'Retro66', '2026-02-12', '1965-10-25', 'España', 1),
('old67@yahoo.com', 'h67', 'Retro67', '2026-02-12', '1968-11-26', 'España', 1),
('old68@yahoo.com', 'h68', 'Retro68', '2026-02-12', '1971-12-27', 'España', 1),
('old69@yahoo.com', 'h69', 'Retro69', '2026-02-12', '1973-01-28', 'España', 1),
('old70@yahoo.com', 'h70', 'Retro70', '2026-02-12', '1975-02-01', 'España', 1),
-- Relleno hasta 100
('fan81@gmail.com', 'h81', 'Fan81', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan82@gmail.com', 'h82', 'Fan82', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan83@gmail.com', 'h83', 'Fan83', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan84@gmail.com', 'h84', 'Fan84', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan85@gmail.com', 'h85', 'Fan85', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan86@gmail.com', 'h86', 'Fan86', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan87@gmail.com', 'h87', 'Fan87', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan88@gmail.com', 'h88', 'Fan88', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan89@gmail.com', 'h89', 'Fan89', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan90@gmail.com', 'h90', 'Fan90', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan91@gmail.com', 'h91', 'Fan91', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan92@gmail.com', 'h92', 'Fan92', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan93@gmail.com', 'h93', 'Fan93', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan94@gmail.com', 'h94', 'Fan94', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan95@gmail.com', 'h95', 'Fan95', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan96@gmail.com', 'h96', 'Fan96', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan97@gmail.com', 'h97', 'Fan97', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan98@gmail.com', 'h98', 'Fan98', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan99@gmail.com', 'h99', 'Fan99', '2026-02-15', '2001-01-01', 'Mexico', 1),
('fan100@gmail.com', 'h100', 'Fan100', '2026-02-15', '2001-01-01', 'Mexico', 1);
GO

-- ==========================================
-- 3. Continuación de USUARIOS (IDs 101 al 250)
-- ==========================================
PRINT 'Insertando bloque final de usuarios (101 al 250)...';

INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo) VALUES
-- Bloque 101-130: Principalmente Gen Z (>2000) y correos Gmail/UCV
('estudiante101@ucv.ve', 'pwd101', 'UcvGenZ_1', '2026-02-16', '2004-05-10', 'Venezuela', 1),
('estudiante102@ucv.ve', 'pwd102', 'UcvGenZ_2', '2026-02-16', '2005-11-20', 'Venezuela', 1),
('estudiante103@ucv.ve', 'pwd103', 'UcvGenZ_3', '2026-02-16', '2003-01-15', 'Venezuela', 1),
('estudiante104@ucv.ve', 'pwd104', 'UcvGenZ_4', '2026-02-16', '2002-08-30', 'Venezuela', 1),
('estudiante105@ucv.ve', 'pwd105', 'UcvGenZ_5', '2026-02-16', '2001-04-12', 'Venezuela', 1),
('fan.u106@gmail.com', 'pwd106', 'GamerZ_1', '2026-02-17', '2006-02-10', 'Mexico', 1),
('fan.u107@gmail.com', 'pwd107', 'GamerZ_2', '2026-02-17', '2005-09-05', 'Mexico', 1),
('fan.u108@gmail.com', 'pwd108', 'GamerZ_3', '2026-02-17', '2004-07-22', 'Colombia', 1),
('fan.u109@gmail.com', 'pwd109', 'GamerZ_4', '2026-02-17', '2003-12-01', 'Chile', 1),
('fan.u110@gmail.com', 'pwd110', 'GamerZ_5', '2026-02-17', '2002-03-18', 'Argentina', 1),
-- Bloque 111-160: Millennials (1981-2000) y correos Outlook
('mill.u111@outlook.com', 'pwd111', 'Millen_1', '2026-02-18', '1995-05-10', 'Venezuela', 1),
('mill.u112@outlook.com', 'pwd112', 'Millen_2', '2026-02-18', '1990-11-20', 'Mexico', 1),
('mill.u113@outlook.com', 'pwd113', 'Millen_3', '2026-02-18', '1985-01-15', 'España', 1),
('mill.u114@outlook.com', 'pwd114', 'Millen_4', '2026-02-18', '1982-08-30', 'Colombia', 1),
('mill.u115@outlook.com', 'pwd115', 'Millen_5', '2026-02-18', '1998-04-12', 'Chile', 1),
('mill.u116@outlook.com', 'pwd116', 'Millen_6', '2026-02-18', '1992-02-10', 'Argentina', 1),
('mill.u117@outlook.com', 'pwd117', 'Millen_7', '2026-02-18', '1988-09-05', 'Venezuela', 1),
('mill.u118@outlook.com', 'pwd118', 'Millen_8', '2026-02-18', '1984-07-22', 'Mexico', 1),
('mill.u119@outlook.com', 'pwd119', 'Millen_9', '2026-02-18', '1996-12-01', 'España', 1),
('mill.u120@outlook.com', 'pwd120', 'Millen_10', '2026-02-18', '1991-03-18', 'Colombia', 1),
-- Bloque 161-200: Mezcla para asegurar >10 por dominio (Gmail masivo)
('user161@gmail.com', 'h161', 'Nick161', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user162@gmail.com', 'h162', 'Nick162', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user163@gmail.com', 'h163', 'Nick163', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user164@gmail.com', 'h164', 'Nick164', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user165@gmail.com', 'h165', 'Nick165', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user166@gmail.com', 'h166', 'Nick166', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user167@gmail.com', 'h167', 'Nick167', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user168@gmail.com', 'h168', 'Nick168', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user169@gmail.com', 'h169', 'Nick169', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user170@gmail.com', 'h170', 'Nick170', '2026-02-19', '1990-01-01', 'Venezuela', 1),
-- Bloque 201-250: Relleno final (diversos países y edades)
('fan201@yahoo.com', 'h201', 'FanY_1', '2026-02-20', '1980-05-15', 'España', 1),
('fan202@yahoo.com', 'h202', 'FanY_2', '2026-02-20', '1975-10-20', 'España', 1),
('fan203@yahoo.com', 'h203', 'FanY_3', '2026-02-20', '1970-01-10', 'Mexico', 1),
('fan204@yahoo.com', 'h204', 'FanY_4', '2026-02-20', '1965-08-05', 'Argentina', 1),
('fan205@yahoo.com', 'h205', 'FanY_5', '2026-02-20', '1982-12-12', 'Venezuela', 1),
('extra206@gmail.com', 'h206', 'User206', '2026-02-21', '1995-01-01', 'Chile', 1),
('extra207@gmail.com', 'h207', 'User207', '2026-02-21', '1995-01-01', 'Colombia', 1),
('extra208@gmail.com', 'h208', 'User208', '2026-02-21', '1995-01-01', 'Venezuela', 1),
('extra209@gmail.com', 'h209', 'User209', '2026-02-21', '1995-01-01', 'Venezuela', 1),
('extra210@gmail.com', 'h210', 'User210', '2026-02-21', '1995-01-01', 'Venezuela', 1),
-- Completando hasta 250 con un bucle conceptual de inserts
('user211@gmail.com', 'h211', 'U211', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user212@gmail.com', 'h212', 'U212', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user213@gmail.com', 'h213', 'U213', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user214@gmail.com', 'h214', 'U214', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user215@gmail.com', 'h215', 'U215', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user216@gmail.com', 'h216', 'U216', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user217@gmail.com', 'h217', 'U217', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user218@gmail.com', 'h218', 'U218', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user219@gmail.com', 'h219', 'U219', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user220@gmail.com', 'h220', 'U220', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user221@gmail.com', 'h221', 'U221', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user222@gmail.com', 'h222', 'U222', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user223@gmail.com', 'h223', 'U223', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user224@gmail.com', 'h224', 'U224', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user225@gmail.com', 'h225', 'U225', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user226@gmail.com', 'h226', 'U226', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user227@gmail.com', 'h227', 'U227', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user228@gmail.com', 'h228', 'U228', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user229@gmail.com', 'h229', 'U229', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user230@gmail.com', 'h230', 'U230', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user231@gmail.com', 'h231', 'U231', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user232@gmail.com', 'h232', 'U232', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user233@gmail.com', 'h233', 'U233', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user234@gmail.com', 'h234', 'U234', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user235@gmail.com', 'h235', 'U235', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user236@gmail.com', 'h236', 'U236', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user237@gmail.com', 'h237', 'U237', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user238@gmail.com', 'h238', 'U238', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user239@gmail.com', 'h239', 'U239', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user240@gmail.com', 'h240', 'U240', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user241@gmail.com', 'h241', 'U241', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user242@gmail.com', 'h242', 'U242', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user243@gmail.com', 'h243', 'U243', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user244@gmail.com', 'h244', 'U244', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user245@gmail.com', 'h245', 'U245', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user246@gmail.com', 'h246', 'U246', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user247@gmail.com', 'h247', 'U247', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user248@gmail.com', 'h248', 'U248', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user249@gmail.com', 'h249', 'U249', '2026-02-22', '1990-01-01', 'Venezuela', 1),
('user250@gmail.com', 'h250', 'U250', '2026-02-22', '1990-01-01', 'Venezuela', 1);
GO

PRINT 'Insertando usuarios faltantes para completar los 250...';

INSERT INTO Usuario (email, password_hash, nickname, fecha_registro, fecha_nacimiento, pais, esta_activo) VALUES
-- Bloque 71-80 (Gen X y Millennials para balancear Reporte 8)
('old71@yahoo.com', 'h71', 'Retro71', '2026-02-12', '1977-03-15', 'España', 1),
('old72@yahoo.com', 'h72', 'Retro72', '2026-02-12', '1979-05-20', 'España', 1),
('user73@gmail.com', 'h73', 'User73', '2026-02-13', '1992-11-10', 'Venezuela', 1),
('user74@gmail.com', 'h74', 'User74', '2026-02-13', '1994-12-12', 'Venezuela', 1),
('user75@gmail.com', 'h75', 'User75', '2026-02-13', '1990-01-05', 'Mexico', 1),
('user76@gmail.com', 'h76', 'User76', '2026-02-13', '1988-08-08', 'Mexico', 1),
('user77@gmail.com', 'h77', 'User77', '2026-02-13', '1985-04-04', 'Colombia', 1),
('user78@gmail.com', 'h78', 'User78', '2026-02-13', '1983-02-02', 'Colombia', 1),
('user79@gmail.com', 'h79', 'User79', '2026-02-13', '1981-10-10', 'Chile', 1),
('user80@gmail.com', 'h80', 'User80', '2026-02-13', '1980-06-06', 'Chile', 1),

-- Bloque 121-160 (Mezcla de dominios para Reporte 3)
('mill.u121@outlook.com', 'p121', 'M_121', '2026-02-18', '1990-01-01', 'Argentina', 1),
('mill.u122@outlook.com', 'p122', 'M_122', '2026-02-18', '1991-01-01', 'Argentina', 1),
('mill.u123@outlook.com', 'p123', 'M_123', '2026-02-18', '1992-01-01', 'Venezuela', 1),
('mill.u124@outlook.com', 'p124', 'M_124', '2026-02-18', '1993-01-01', 'Venezuela', 1),
('mill.u125@outlook.com', 'p125', 'M_125', '2026-02-18', '1994-01-01', 'Mexico', 1),
('mill.u126@outlook.com', 'p126', 'M_126', '2026-02-18', '1995-01-01', 'Mexico', 1),
('mill.u127@outlook.com', 'p127', 'M_127', '2026-02-18', '1996-01-01', 'Colombia', 1),
('mill.u128@outlook.com', 'p128', 'M_128', '2026-02-18', '1997-01-01', 'Colombia', 1),
('mill.u129@outlook.com', 'p129', 'M_129', '2026-02-18', '1998-01-01', 'Chile', 1),
('mill.u130@outlook.com', 'p130', 'M_130', '2026-02-18', '1999-01-01', 'Chile', 1),
('user131@gmail.com', 'p131', 'U131', '2026-02-18', '1985-05-05', 'España', 1),
('user132@gmail.com', 'p132', 'U132', '2026-02-18', '1986-06-06', 'España', 1),
('user133@gmail.com', 'p133', 'U133', '2026-02-18', '1987-07-07', 'Venezuela', 1),
('user134@gmail.com', 'p134', 'U134', '2026-02-18', '1988-08-08', 'Venezuela', 1),
('user135@gmail.com', 'p135', 'U135', '2026-02-18', '1989-09-09', 'Mexico', 1),
('user136@gmail.com', 'p136', 'U136', '2026-02-18', '1990-10-10', 'Mexico', 1),
('user137@gmail.com', 'p137', 'U137', '2026-02-18', '1991-11-11', 'Colombia', 1),
('user138@gmail.com', 'p138', 'U138', '2026-02-18', '1992-12-12', 'Colombia', 1),
('user139@gmail.com', 'p139', 'U139', '2026-02-18', '1993-01-01', 'Chile', 1),
('user140@gmail.com', 'p140', 'U140', '2026-02-18', '1994-02-02', 'Chile', 1),
('user141@ucv.ve', 'p141', 'U141', '2026-02-18', '2001-01-01', 'Venezuela', 1),
('user142@ucv.ve', 'p142', 'U142', '2026-02-18', '2002-02-02', 'Venezuela', 1),
('user143@ucv.ve', 'p143', 'U143', '2026-02-18', '2003-03-03', 'Venezuela', 1),
('user144@ucv.ve', 'p144', 'U144', '2026-02-18', '2004-04-04', 'Venezuela', 1),
('user145@ucv.ve', 'p145', 'U145', '2026-02-18', '2005-05-05', 'Venezuela', 1),
('user146@ucv.ve', 'p146', 'U146', '2026-02-18', '2006-06-06', 'Venezuela', 1),
('user147@ucv.ve', 'p147', 'U147', '2026-02-18', '2001-07-07', 'Venezuela', 1),
('user148@ucv.ve', 'p148', 'U148', '2026-02-18', '2002-08-08', 'Venezuela', 1),
('user149@ucv.ve', 'p149', 'U149', '2026-02-18', '2003-09-09', 'Venezuela', 1),
('user150@ucv.ve', 'p150', 'U150', '2026-02-18', '2004-10-10', 'Venezuela', 1),
('extra151@gmail.com', 'p151', 'Ex151', '2026-02-18', '1995-01-01', 'Mexico', 1),
('extra152@gmail.com', 'p152', 'Ex152', '2026-02-18', '1995-01-01', 'Mexico', 1),
('extra153@gmail.com', 'p153', 'Ex153', '2026-02-18', '1995-01-01', 'Colombia', 1),
('extra154@gmail.com', 'p154', 'Ex154', '2026-02-18', '1995-01-01', 'Colombia', 1),
('extra155@gmail.com', 'p155', 'Ex155', '2026-02-18', '1995-01-01', 'Chile', 1),
('extra156@gmail.com', 'p156', 'Ex156', '2026-02-18', '1995-01-01', 'Chile', 1),
('extra157@gmail.com', 'p157', 'Ex157', '2026-02-18', '1995-01-01', 'España', 1),
('extra158@gmail.com', 'p158', 'Ex158', '2026-02-18', '1995-01-01', 'España', 1),
('extra159@gmail.com', 'p159', 'Ex159', '2026-02-18', '1995-01-01', 'Venezuela', 1),
('extra160@gmail.com', 'p160', 'Ex160', '2026-02-18', '1995-01-01', 'Venezuela', 1),

-- Bloque 171-200 (Completando volumen de dominios)
('user171@gmail.com', 'p171', 'U171', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user172@gmail.com', 'p172', 'U172', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user173@gmail.com', 'p173', 'U173', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user174@gmail.com', 'p174', 'U174', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user175@gmail.com', 'p175', 'U175', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user176@gmail.com', 'p176', 'U176', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user177@gmail.com', 'p177', 'U177', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user178@gmail.com', 'p178', 'U178', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user179@gmail.com', 'p179', 'U179', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user180@gmail.com', 'p180', 'U180', '2026-02-19', '1990-01-01', 'Venezuela', 1),
('user181@gmail.com', 'p181', 'U181', '2026-02-19', '1990-01-01', 'Mexico', 1),
('user182@gmail.com', 'p182', 'U182', '2026-02-19', '1990-01-01', 'Mexico', 1),
('user183@gmail.com', 'p183', 'U183', '2026-02-19', '1990-01-01', 'Mexico', 1),
('user184@gmail.com', 'p184', 'U184', '2026-02-19', '1990-01-01', 'Mexico', 1),
('user185@gmail.com', 'p185', 'U185', '2026-02-19', '1990-01-01', 'Mexico', 1),
('user186@gmail.com', 'p186', 'U186', '2026-02-19', '1990-01-01', 'Colombia', 1),
('user187@gmail.com', 'p187', 'U187', '2026-02-19', '1990-01-01', 'Colombia', 1),
('user188@gmail.com', 'p188', 'U188', '2026-02-19', '1990-01-01', 'Colombia', 1),
('user189@gmail.com', 'p189', 'U189', '2026-02-19', '1990-01-01', 'Colombia', 1),
('user190@gmail.com', 'p190', 'U190', '2026-02-19', '1990-01-01', 'Colombia', 1),
('user191@outlook.com', 'p191', 'U191', '2026-02-19', '1985-01-01', 'Chile', 1),
('user192@outlook.com', 'p192', 'U192', '2026-02-19', '1985-01-01', 'Chile', 1),
('user193@outlook.com', 'p193', 'U193', '2026-02-19', '1985-01-01', 'Chile', 1),
('user194@outlook.com', 'p194', 'U194', '2026-02-19', '1985-01-01', 'Chile', 1),
('user195@outlook.com', 'p195', 'U195', '2026-02-19', '1985-01-01', 'Chile', 1),
('user196@outlook.com', 'p196', 'U196', '2026-02-19', '1985-01-01', 'Argentina', 1),
('user197@outlook.com', 'p197', 'U197', '2026-02-19', '1985-01-01', 'Argentina', 1),
('user198@outlook.com', 'p198', 'U198', '2026-02-19', '1985-01-01', 'Argentina', 1),
('user199@outlook.com', 'p199', 'U199', '2026-02-19', '1985-01-01', 'Argentina', 1),
('user200@outlook.com', 'p200', 'U200', '2026-02-19', '1985-01-01', 'Argentina', 1);
GO

PRINT 'Insertando 25 Creadores (10% de la cuota)...';

INSERT INTO Creador (idUsuario, biografia, banco_nombre, banco_cuenta, es_nsfw, idCategoria) VALUES
-- Creadores Regulares (IDs 1-20)
(1, 'Especialista en SQL y bases de datos.', 'Banesco', '0134-0001-11-2222333344', 0, 3),
(2, 'Fitness Coach. Rutinas diarias.', 'Banco de Venezuela', '0102-1111-22-3333444455', 0, 2),
(3, 'Pro Player eSports.', 'BBVA', 'ES21-4444-5555-6666-7777', 0, 1),
(4, 'Recetas caseras y repostería.', 'Santander', 'MX99-8888-7777-6666-5555', 0, 6),
(5, 'Tech reviews y unboxings.', 'Bancolombia', '001-222333-44', 0, 3),
(6, 'ASMR para dormir.', 'Banco Nación', '011-999888-77', 0, 9),
(7, 'Viajes por el mundo.', 'Banco de Chile', '012-777666-55', 0, 7),
(8, 'Concept Art e Ilustración.', 'Itaú', '013-555444-33', 0, 4),
(10, 'Outfits y tendencias.', 'Mercantil', '0105-8888-99-0000111122', 0, 11),
(11, 'Análisis de actualidad.', 'Provincial', '0108-7777-66-5555444433', 0, 18),
(12, 'True Crime Podcasts.', 'Wells Fargo', '123456789', 0, 24),
(13, 'Clases de Guitarra.', 'Chase', '987654321', 0, 5),
(14, 'Adiestramiento canino.', 'BOD', '0116-4444-33-2222111100', 0, 19),
(15, 'Educación Financiera.', 'Bank of America', '555444333', 0, 13),
(17, 'Cine y Series.', 'BNC', '0191-0000-11-2222333344', 0, 15),
(18, 'Cultura Otaku.', 'Banorte', '999000888', 0, 23),
(19, 'Manualidades DIY.', 'Scotiabank', '777888999', 0, 17),
(21, 'Fotografía de retrato.', 'Bicentenario', '0175-5555-66-7777888899', 0, 22),
(22, 'Tarot y Espiritualidad.', 'Bancolombia', '444555666', 0, 20),
(24, 'Tecnología y Futuro.', 'Tesoro', '0163-1111-22-3333444455', 0, 24),

-- Creadores NSFW (Obligatorios: Mínimo 5) 
(9, 'Contenido adulto exclusivo.', 'CaixaBank', 'ES30-2222-1111-0000-9999', 1, 21),
(16, 'Cosplay NSFW profesional.', 'Deutsche Bank', 'DE12-3333-4444-5555', 1, 21),
(20, 'Arte erótico digital.', 'Bancamiga', '0172-1111-00-1111222233', 1, 4),
(23, 'Sesiones artísticas sin censura.', 'HSBC', '222333444', 1, 22),
(25, 'Modelaje alternativo NSFW.', 'Pichincha', '111222333', 1, 22);
GO

PRINT 'Insertando Métodos de Pago (IDs 1 al 50)...';

INSERT INTO MetodoPago (idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado) VALUES
(1, '4455', 'Visa', 'Diego Vargas', '2028-12-01', 1),
(2, '1122', 'MasterCard', 'Valentina Gomez', '2027-05-01', 1),
(3, '8899', 'American Express', 'Carlos Paccagnella', '2026-10-01', 1),
(4, '5566', 'Visa', 'Marta Cuisine', '2029-01-01', 1),
(5, '2233', 'MasterCard', 'Sergio Code', '2028-04-01', 1),
(6, '9900', 'Visa', 'Ana Whispers', '2027-08-01', 1),
(7, '3344', 'MasterCard', 'Pedro World', '2026-12-01', 1),
(8, '7788', 'Visa', 'Lucia Brush', '2029-03-01', 1),
(9, '1111', 'American Express', 'Marcos Dark', '2028-11-01', 1),
(10, '2222', 'Visa', 'Elena Style', '2027-02-01', 1),
(11, '3333', 'MasterCard', 'Luis V', '2026-05-01', 1),
(12, '4444', 'Visa', 'Maria P', '2029-07-01', 1),
(13, '5555', 'American Express', 'Jorge G', '2028-10-01', 1),
(14, '6666', 'MasterCard', 'Andrea S', '2027-04-01', 1),
(15, '7777', 'Visa', 'Pedro R', '2026-01-01', 1),
(16, '8888', 'MasterCard', 'Sofia M', '2029-09-01', 1),
(17, '9999', 'Visa', 'Raul T', '2028-03-01', 1),
(18, '1212', 'American Express', 'Elena F', '2027-06-01', 1),
(19, '3434', 'MasterCard', 'Pablo D', '2026-11-01', 1),
(20, '5656', 'Visa', 'Clara Z', '2029-02-01', 1),
(21, '7878', 'MasterCard', 'Marcos L', '2028-05-01', 1),
(22, '9090', 'Visa', 'Isabel K', '2027-09-01', 1),
(23, '1313', 'American Express', 'Victor H', '2026-10-01', 1),
(24, '2424', 'MasterCard', 'Nora J', '2029-12-01', 1),
(25, '3535', 'Visa', 'Hugo W', '2028-01-01', 1),
-- Usuarios Fans (IDs 26-30)
(26, '4646', 'MasterCard', 'Julia Q', '2027-03-01', 1),
(27, '5757', 'Visa', 'Oscar P', '2026-08-01', 1),
(28, '6868', 'American Express', 'Silvia R', '2029-05-01', 1),
(29, '7979', 'MasterCard', 'Fabio U', '2028-11-01', 1),
(30, '8080', 'Visa', 'Diana Y', '2027-04-01', 1);
GO

PRINT 'Insertando Métodos de Pago adicionales (IDs 31 al 80)...';

INSERT INTO MetodoPago (idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado) VALUES
-- Usuarios 31-40 (Mezcla de marcas)
(31, '1122', 'Discover', 'Marcos L', '2028-06-01', 1),
(32, '3344', 'Diners Club', 'Isabel K', '2027-09-01', 1),
(33, '5566', 'JCB', 'Victor H', '2026-03-01', 1),
(34, '7788', 'Visa', 'Nora J', '2029-11-01', 1),
(35, '9900', 'MasterCard', 'Hugo W', '2028-01-01', 1),
(36, '2211', 'American Express', 'Julia Q', '2027-12-01', 1),
(37, '4433', 'Visa', 'Oscar P', '2026-05-01', 1),
(38, '6655', 'MasterCard', 'Silvia R', '2029-08-01', 1),
(39, '8877', 'Discover', 'Fabio U', '2028-10-01', 1),
(40, '0099', 'Diners Club', 'Diana Y', '2027-02-01', 1),

-- Usuarios 41-50 (Bloque Test)
(41, '1010', 'Visa', 'User41', '2028-01-01', 1),
(42, '2020', 'MasterCard', 'User42', '2028-01-01', 1),
(43, '3030', 'JCB', 'User43', '2028-01-01', 1),
(44, '4040', 'Visa', 'User44', '2028-01-01', 1),
(45, '5050', 'MasterCard', 'User45', '2028-01-01', 1),
(46, '6060', 'American Express', 'User46', '2028-01-01', 1),
(47, '7070', 'Discover', 'User47', '2028-01-01', 1),
(48, '8080', 'Visa', 'User48', '2028-01-01', 1),
(49, '9090', 'MasterCard', 'User49', '2028-01-01', 1),
(50, '0101', 'Diners Club', 'User50', '2028-01-01', 1),

-- Usuarios 51-60 (Estudiantes UCV)
(51, '1111', 'Visa', 'User51', '2029-05-01', 1),
(52, '2222', 'MasterCard', 'User52', '2029-05-01', 1),
(53, '3333', 'JCB', 'User53', '2029-05-01', 1),
(54, '4444', 'Visa', 'User54', '2029-05-01', 1),
(55, '5555', 'MasterCard', 'User55', '2029-05-01', 1),
(56, '6666', 'Discover', 'User56', '2029-05-01', 1),
(57, '7777', 'Diners Club', 'User57', '2029-05-01', 1),
(58, '8888', 'American Express', 'User58', '2029-05-01', 1),
(59, '9999', 'Visa', 'User59', '2029-05-01', 1),
(60, '0000', 'MasterCard', 'User60', '2029-05-01', 1),

-- Usuarios 61-70 (Retro Fans)
(61, '1234', 'Visa', 'Retro61', '2027-05-20', 1),
(62, '2345', 'MasterCard', 'Retro62', '2027-06-21', 1),
(63, '3456', 'Discover', 'Retro63', '2027-07-22', 1),
(64, '4567', 'JCB', 'Retro64', '2027-08-23', 1),
(65, '5678', 'Diners Club', 'Retro65', '2027-09-24', 1),
(66, '6789', 'American Express', 'Retro66', '2027-10-25', 1),
(67, '7890', 'Visa', 'Retro67', '2027-11-26', 1),
(68, '8901', 'MasterCard', 'Retro68', '2027-12-27', 1),
(69, '9012', 'Discover', 'Retro69', '2028-01-28', 1),
(70, '0123', 'JCB', 'Retro70', '2028-02-01', 1),

-- Usuarios 71-80 (Completando cuota)
(71, '4321', 'Visa', 'Retro71', '2028-03-15', 1),
(72, '5432', 'MasterCard', 'Retro72', '2028-05-20', 1),
(73, '6543', 'American Express', 'User73', '2028-11-10', 1),
(74, '7654', 'Diners Club', 'User74', '2028-12-12', 1),
(75, '8765', 'Discover', 'User75', '2028-01-05', 1),
(76, '9876', 'JCB', 'User76', '2028-08-08', 1),
(77, '0987', 'Visa', 'User77', '2028-04-04', 1),
(78, '1098', 'MasterCard', 'User78', '2028-02-02', 1),
(79, '2109', 'Discover', 'User79', '2028-10-10', 1),
(80, '3210', 'Diners Club', 'User80', '2028-06-06', 1);
GO

PRINT 'Insertando Métodos de Pago (IDs 81 al 130)...';

INSERT INTO MetodoPago (idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado) VALUES
-- Usuarios 81-100 (Fans de México y Venezuela)
(81, '1212', 'Visa', 'Fan81', '2027-12-01', 1),
(82, '2323', 'MasterCard', 'Fan82', '2028-01-15', 1),
(83, '3434', 'Maestro', 'Fan83', '2026-06-30', 1),
(84, '4545', 'UnionPay', 'Fan84', '2029-02-10', 1),
(85, '5656', 'Visa', 'Fan85', '2027-03-20', 1),
(86, '6767', 'MasterCard', 'Fan86', '2028-04-05', 1),
(87, '7878', 'Discover', 'Fan87', '2026-09-12', 1),
(88, '8989', 'American Express', 'Fan88', '2029-05-18', 1),
(89, '9090', 'JCB', 'Fan89', '2027-11-22', 1),
(90, '0101', 'Visa', 'Fan90', '2028-07-07', 1),
(91, '1122', 'MasterCard', 'Fan91', '2026-10-30', 1),
(92, '2233', 'Diners Club', 'Fan92', '2029-01-14', 1),
(93, '3344', 'Visa', 'Fan93', '2027-08-25', 1),
(94, '4455', 'MasterCard', 'Fan94', '2028-12-10', 1),
(95, '5566', 'Discover', 'Fan95', '2026-04-04', 1),
(96, '6677', 'UnionPay', 'Fan96', '2029-06-06', 1),
(97, '7788', 'Maestro', 'Fan97', '2027-09-09', 1),
(98, '8899', 'Visa', 'Fan98', '2028-02-14', 1),
(99, '9900', 'MasterCard', 'Fan99', '2026-05-20', 1),
(100, '0011', 'American Express', 'Fan100', '2029-10-10', 1),

-- Usuarios 101-115 (Gen Z de la UCV)
(101, '1011', 'Visa', 'UcvGenZ_1', '2027-03-12', 1),
(102, '2022', 'MasterCard', 'UcvGenZ_2', '2028-11-01', 1),
(103, '3033', 'Maestro', 'UcvGenZ_3', '2026-12-15', 1),
(104, '4044', 'JCB', 'UcvGenZ_4', '2029-04-30', 1),
(105, '5055', 'Visa', 'UcvGenZ_5', '2027-08-20', 1),
(106, '6066', 'MasterCard', 'GamerZ_1', '2028-02-14', 1),
(107, '7077', 'UnionPay', 'GamerZ_2', '2026-05-05', 1),
(108, '8088', 'American Express', 'GamerZ_3', '2029-01-10', 1),
(109, '9099', 'Discover', 'GamerZ_4', '2027-07-22', 1),
(110, '0100', 'Visa', 'GamerZ_5', '2028-09-18', 1),
(111, '1112', 'MasterCard', 'Millen_1', '2026-10-10', 1),
(112, '1113', 'Maestro', 'Millen_2', '2029-03-03', 1),
(113, '1114', 'Visa', 'Millen_3', '2027-12-25', 1),
(114, '1115', 'American Express', 'Millen_4', '2028-06-06', 1),
(115, '1116', 'JCB', 'Millen_5', '2026-11-11', 1),

-- Usuarios 116-130 (Mezcla Millennials y Fans Outlook)
(116, '1161', 'Visa', 'Millen_6', '2028-04-12', 1),
(117, '1171', 'MasterCard', 'Millen_7', '2029-01-20', 1),
(118, '1181', 'Diners Club', 'Millen_8', '2027-05-05', 1),
(119, '1191', 'Discover', 'Millen_9', '2026-08-08', 1),
(120, '1201', 'UnionPay', 'Millen_10', '2029-12-01', 1),
(121, '1211', 'Visa', 'M_121', '2027-02-14', 1),
(122, '1221', 'MasterCard', 'M_122', '2028-03-03', 1),
(123, '1231', 'American Express', 'M_123', '2026-09-30', 1),
(124, '1241', 'Maestro', 'M_124', '2029-11-11', 1),
(125, '1251', 'JCB', 'M_125', '2027-06-01', 1),
(126, '1261', 'Visa', 'M_126', '2028-07-07', 1),
(127, '1271', 'MasterCard', 'M_127', '2026-05-15', 1),
(128, '1281', 'Discover', 'M_128', '2029-08-20', 1),
(129, '1291', 'UnionPay', 'M_129', '2027-10-10', 1),
(130, '1301', 'Visa', 'M_130', '2028-01-25', 1);
GO

PRINT 'Insertando bloque final de Métodos de Pago (IDs 131 al 250)...';

INSERT INTO MetodoPago (idUsuario, ultimos_4_digitos, marca, titular, fecha_expiracion, es_predeterminado) VALUES
-- Usuarios 131-150 (Mezcla Gmail y UCV)
(131, '1311', 'Visa', 'U131', '2027-04-10', 1),
(132, '1321', 'MasterCard', 'U132', '2028-05-12', 1),
(133, '1331', 'Elo', 'U133', '2026-09-15', 1),
(134, '1341', 'Hipercard', 'U134', '2029-02-20', 1),
(135, '1351', 'Visa', 'U135', '2027-08-05', 1),
(136, '1361', 'MasterCard', 'U136', '2028-01-14', 1),
(137, '1371', 'American Express', 'U137', '2026-11-30', 1),
(138, '1381', 'JCB', 'U138', '2029-03-25', 1),
(139, '1391', 'Discover', 'U139', '2027-10-10', 1),
(140, '1401', 'Visa', 'U140', '2028-06-18', 1),
(141, '1411', 'MasterCard', 'U141', '2026-04-04', 1),
(142, '1421', 'Visa', 'U142', '2029-12-25', 1),
(143, '1431', 'Maestro', 'U143', '2027-07-07', 1),
(144, '1441', 'UnionPay', 'U144', '2028-09-09', 1),
(145, '1451', 'Visa', 'U145', '2026-05-20', 1),
(146, '1461', 'MasterCard', 'U146', '2029-11-11', 1),
(147, '1471', 'American Express', 'U147', '2027-01-30', 1),
(148, '1481', 'JCB', 'U148', '2028-02-14', 1),
(149, '1491', 'Discover', 'U149', '2026-10-10', 1),
(150, '1501', 'Visa', 'U150', '2029-03-03', 1),

-- Usuarios 151-200 (Extra Gmail y Outlook)
(151, '1511', 'MasterCard', 'Ex151', '2027-08-15', 1),
(152, '1521', 'Visa', 'Ex152', '2028-09-10', 1),
(153, '1531', 'Elo', 'Ex153', '2026-12-01', 1),
(154, '1541', 'MasterCard', 'Ex154', '2029-04-20', 1),
(155, '1551', 'Visa', 'Ex155', '2027-11-11', 1),
(156, '1561', 'American Express', 'Ex156', '2028-05-05', 1),
(157, '1571', 'JCB', 'Ex157', '2026-03-30', 1),
(158, '1581', 'Discover', 'Ex158', '2029-07-22', 1),
(159, '1591', 'Visa', 'Ex159', '2027-02-10', 1),
(160, '1601', 'MasterCard', 'Ex160', '2028-01-25', 1),
(161, '1611', 'Visa', 'Nick161', '2026-10-10', 1),
(162, '1621', 'MasterCard', 'Nick162', '2029-06-06', 1),
(163, '1631', 'Elo', 'Nick163', '2027-09-09', 1),
(164, '1641', 'Hipercard', 'Nick164', '2028-12-14', 1),
(165, '1651', 'Visa', 'Nick165', '2026-05-20', 1),
(166, '1661', 'MasterCard', 'Nick166', '2029-10-10', 1),
(167, '1671', 'American Express', 'Nick167', '2027-03-12', 1),
(168, '1681', 'JCB', 'Nick168', '2028-11-01', 1),
(169, '1691', 'Discover', 'Nick169', '2026-12-15', 1),
(170, '1701', 'Visa', 'Nick170', '2029-04-30', 1),
(171, '1711', 'MasterCard', 'U171', '2027-08-20', 1),
(172, '1721', 'Visa', 'U172', '2028-02-14', 1),
(173, '1731', 'Elo', 'U173', '2026-05-05', 1),
(174, '1741', 'MasterCard', 'U174', '2029-01-10', 1),
(175, '1751', 'Visa', 'U175', '2027-07-22', 1),
(176, '1761', 'American Express', 'U176', '2028-09-18', 1),
(177, '1771', 'JCB', 'U177', '2026-10-10', 1),
(178, '1781', 'Discover', 'U178', '2029-03-03', 1),
(179, '1791', 'Visa', 'U179', '2027-12-25', 1),
(180, '1801', 'MasterCard', 'U180', '2028-06-06', 1),
(181, '1811', 'Visa', 'U181', '2026-11-11', 1),
(182, '1821', 'MasterCard', 'U182', '2029-04-12', 1),
(183, '1831', 'Elo', 'U183', '2027-01-20', 1),
(184, '1841', 'Hipercard', 'U184', '2028-05-05', 1),
(185, '1851', 'Visa', 'U185', '2026-08-08', 1),
(186, '1861', 'MasterCard', 'U186', '2029-12-01', 1),
(187, '1871', 'American Express', 'U187', '2027-02-14', 1),
(188, '1881', 'JCB', 'U188', '2028-03-03', 1),
(189, '1891', 'Discover', 'U189', '2026-09-30', 1),
(190, '1901', 'Visa', 'U190', '2029-11-11', 1),
(191, '1911', 'MasterCard', 'U191', '2027-06-01', 1),
(192, '1921', 'Visa', 'U192', '2028-07-07', 1),
(193, '1931', 'Elo', 'U193', '2026-05-15', 1),
(194, '1941', 'MasterCard', 'U194', '2029-08-20', 1),
(195, '1951', 'Visa', 'U195', '2027-10-10', 1),
(196, '1961', 'American Express', 'U196', '2028-01-25', 1),
(197, '1971', 'JCB', 'U197', '2026-03-30', 1),
(198, '1981', 'Discover', 'U198', '2029-07-22', 1),
(199, '1991', 'Visa', 'U199', '2027-02-10', 1),
(200, '2001', 'MasterCard', 'U200', '2028-01-25', 1),

-- Usuarios 201-250 (Relleno Final)
(201, '2011', 'Visa', 'FanY_1', '2027-05-15', 1),
(202, '2021', 'MasterCard', 'FanY_2', '2028-10-20', 1),
(203, '2031', 'Elo', 'FanY_3', '2026-01-10', 1),
(204, '2041', 'Hipercard', 'FanY_4', '2029-08-05', 1),
(205, '2051', 'Visa', 'FanY_5', '2027-12-12', 1),
(206, '2061', 'MasterCard', 'User206', '2028-01-01', 1),
(207, '2071', 'American Express', 'User207', '2026-01-01', 1),
(208, '2081', 'JCB', 'User208', '2029-01-01', 1),
(209, '2091', 'Discover', 'User209', '2027-01-01', 1),
(210, '2101', 'Visa', 'User210', '2028-01-01', 1),
(211, '2111', 'MasterCard', 'U211', '2027-01-01', 1),
(212, '2121', 'Visa', 'U212', '2026-01-01', 1),
(213, '2131', 'Elo', 'U213', '2029-01-01', 1),
(214, '2141', 'MasterCard', 'U214', '2027-01-01', 1),
(215, '2151', 'Visa', 'U215', '2028-01-01', 1),
(216, '2161', 'American Express', 'U216', '2026-01-01', 1),
(217, '2171', 'JCB', 'U217', '2029-01-01', 1),
(218, '2181', 'Discover', 'U218', '2027-01-01', 1),
(219, '2191', 'Visa', 'U219', '2028-01-01', 1),
(220, '2201', 'MasterCard', 'U220', '2027-01-01', 1),
(221, '2211', 'Visa', 'U221', '2026-01-01', 1),
(222, '2221', 'Elo', 'U222', '2029-01-01', 1),
(223, '2231', 'MasterCard', 'U223', '2027-01-01', 1),
(224, '2241', 'Visa', 'U224', '2028-01-01', 1),
(225, '2251', 'American Express', 'U225', '2026-01-01', 1),
(226, '2261', 'JCB', 'U226', '2029-01-01', 1),
(227, '2271', 'Discover', 'U227', '2027-01-01', 1),
(228, '2281', 'Visa', 'U228', '2028-01-01', 1),
(229, '2291', 'MasterCard', 'U229', '2027-01-01', 1),
(230, '2301', 'Visa', 'U230', '2026-01-01', 1),
(231, '2311', 'Elo', 'U231', '2029-01-01', 1),
(232, '2321', 'MasterCard', 'U232', '2027-01-01', 1),
(233, '2331', 'Visa', 'U233', '2028-01-01', 1),
(234, '2341', 'American Express', 'U234', '2026-01-01', 1),
(235, '2351', 'JCB', 'U235', '2029-01-01', 1),
(236, '2361', 'Discover', 'U236', '2027-01-01', 1),
(237, '2371', 'Visa', 'U237', '2028-01-01', 1),
(238, '2381', 'MasterCard', 'U238', '2027-01-01', 1),
(239, '2391', 'Visa', 'U239', '2026-01-01', 1),
(240, '2401', 'Elo', 'U240', '2029-01-01', 1),
(241, '2411', 'MasterCard', 'U241', '2027-01-01', 1),
(242, '2421', 'Visa', 'U242', '2028-01-01', 1),
(243, '2431', 'American Express', 'U243', '2026-01-01', 1),
(244, '2441', 'JCB', 'U244', '2029-01-01', 1),
(245, '2451', 'Discover', 'U245', '2027-01-01', 1),
(246, '2461', 'Visa', 'U246', '2028-01-01', 1),
(247, '2471', 'MasterCard', 'U247', '2027-01-01', 1),
(248, '2481', 'Visa', 'U248', '2026-01-01', 1),
(249, '2491', 'Elo', 'U249', '2029-01-01', 1),
(250, '2501', 'MasterCard', 'U250', '2027-01-01', 1);
GO

PRINT 'Insertando Niveles de Suscripción para los 25 creadores...';

-- Creador 1: DiegoDev (Tecnología)
INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, esta_activo, orden) VALUES
(1, 'Soporte Básico', 'Acceso a consultas simples sobre SQL.', 5.00, 1, 1),
(1, 'Premium Dev', 'Consultoría técnica y acceso a repositorios.', 25.00, 1, 2);

-- Creador 2: ValenFit (Fitness)
INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, esta_activo, orden) VALUES
(2, 'Rutinas Semanales', 'Videos de ejercicios guiados.', 10.00, 1, 1),
(2, 'Atleta Elite', 'Plan nutricional y seguimiento.', 45.00, 1, 2);

-- Creador 3: CJPACCA (Gaming)
INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, esta_activo, orden) VALUES
(3, 'Fan Base', 'Insignia de suscriptor en el chat.', 4.99, 1, 1),
(3, 'Pro Gamer', 'Juega conmigo partidas clasificatorias.', 15.00, 1, 2),
(3, 'MVP Legend', 'Clases personalizadas de estrategia.', 50.00, 1, 3);

-- Creadores NSFW (IDs 9, 16, 20, 23, 25)
INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, esta_activo, orden) VALUES
(9, 'Acceso VIP', 'Contenido exclusivo sin censura.', 30.00, 1, 1),
(16, 'Cosplay Galería', 'Sesiones fotográficas completas.', 20.00, 1, 1),
(20, 'Arte Privado', 'Bocetos y dibujos digitales exclusivos.', 12.00, 1, 1),
(23, 'Sesión Artística', 'Fotos en alta resolución exclusivas.', 25.00, 1, 1),
(25, 'Modelaje VIP', 'Videos exclusivos detrás de cámaras.', 35.00, 1, 1);

-- Para el resto de los creadores (4-8, 10-15, 17-19, 21, 22, 24)
-- Insertamos un nivel estándar para cada uno
INSERT INTO NivelSuscripcion (idCreador, nombre, descripcion, precio_actual, esta_activo, orden) VALUES
(4, 'Chef Fan', 'Recetas exclusivas en PDF.', 7.99, 1, 1),
(5, 'Tech Supporter', 'Reviews antes que nadie.', 5.99, 1, 1),
(6, 'Relax VIP', 'Audios ASMR personalizados.', 8.50, 1, 1),
(7, 'Viajero Pro', 'Guías detalladas de viajes.', 12.00, 1, 1),
(8, 'Art Collector', 'Ilustraciones en alta calidad.', 10.00, 1, 1),
(10, 'Trendy Fan', 'Tips de moda exclusivos.', 9.00, 1, 1),
(11, 'Analista Político', 'Boletín de noticias semanal.', 4.99, 1, 1),
(12, 'Investigador VIP', 'Casos de crímenes sin censura.', 6.50, 1, 1),
(13, 'Músico Fan', 'Partituras y tablaturas.', 11.00, 1, 1),
(14, 'Dog Lover', 'Tips de adiestramiento avanzado.', 8.00, 1, 1),
(15, 'Inversionista Pro', 'Análisis de mercado diario.', 40.00, 1, 1),
(17, 'Cinefilo VIP', 'Críticas de estreno exclusivas.', 3.50, 1, 1),
(18, 'Otaku Elite', 'Capítulos de manga traducidos.', 6.00, 1, 1),
(19, 'Artesano VIP', 'Planos para proyectos DIY.', 7.00, 1, 1),
(21, 'Modelaje Fan', 'Detrás de cámaras de fotos.', 15.00, 1, 1),
(22, 'Tarot VIP', 'Lectura de cartas mensual.', 20.00, 1, 1),
(24, 'Podcast Listener', 'Episodios sin publicidad.', 2.99, 1, 1);
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- Suscripciones ACTIVAS (Generan facturas actuales)
(26, 1, '2026-01-10', '2026-02-10', NULL, 'Activa', 5.00), -- Fan 26 a DiegoDev
(27, 2, '2026-01-15', '2026-02-15', NULL, 'Activa', 25.00),
(28, 3, '2026-01-20', '2026-02-20', NULL, 'Activa', 10.00), -- Fan 28 a ValenFit
(29, 4, '2026-02-01', '2026-03-01', NULL, 'Activa', 45.00),
(30, 5, '2026-02-05', '2026-03-05', NULL, 'Activa', 4.99),  -- Fan 30 a CJPACCA

-- Suscripciones CANCELADAS (Para el Reporte 4 de Churn/Retención)
(31, 1, '2026-01-01', NULL, '2026-01-15', 'Cancelada', 5.00), -- Duró 14 días
(32, 3, '2026-01-05', NULL, '2026-01-10', 'Cancelada', 10.00), -- Duró 5 días
(33, 5, '2026-01-10', NULL, '2026-01-20', 'Cancelada', 4.99),  -- Duró 10 días
(34, 7, '2026-01-01', NULL, '2026-01-30', 'Cancelada', 30.00), -- Duró 29 días (VIP Adulto)

-- Suscripciones VENCIDAS (Históricas)
(35, 2, '2025-11-01', NULL, '2025-12-01', 'Vencida', 25.00),
(36, 4, '2025-12-01', NULL, '2026-01-01', 'Vencida', 45.00),
(37, 6, '2025-10-15', NULL, '2025-11-15', 'Vencida', 15.00),

-- Intereses Cruzados (Usuario 50 suscrito a Tecnología ID:1 y Fitness ID:3)
-- Importante para el Reporte 7
(50, 1, '2026-01-01', '2026-02-01', NULL, 'Activa', 5.00),
(50, 3, '2026-01-05', '2026-02-05', NULL, 'Activa', 10.00);
GO

PRINT 'Insertando bloque de suscripciones';

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- Suscripciones Gen Z (Usuarios 51-60)
(51, 1, '2026-01-10', '2026-02-10', NULL, 'Activa', 5.00),
(52, 3, '2026-01-11', '2026-02-11', NULL, 'Activa', 10.00),
(53, 5, '2026-01-12', '2026-02-12', NULL, 'Activa', 4.99),
(54, 8, '2026-01-13', '2026-02-13', NULL, 'Activa', 30.00), -- VIP Adulto NSFW
(55, 10, '2026-01-14', '2026-02-14', NULL, 'Activa', 12.00),
(56, 12, '2026-01-15', '2026-02-15', NULL, 'Activa', 35.00),
(57, 14, '2026-01-16', '2026-02-16', NULL, 'Activa', 7.99),
(58, 16, '2026-01-17', '2026-02-17', NULL, 'Activa', 8.50),
(59, 18, '2026-01-18', '2026-02-18', NULL, 'Activa', 10.00),
(60, 20, '2026-01-19', '2026-02-19', NULL, 'Activa', 4.99),

-- Suscripciones Canceladas (Para Reporte 4: Churn)
(61, 2, '2026-01-01', NULL, '2026-01-20', 'Cancelada', 25.00),
(62, 4, '2026-01-05', NULL, '2026-01-15', 'Cancelada', 45.00),
(63, 6, '2026-01-10', NULL, '2026-01-25', 'Cancelada', 15.00),
(64, 7, '2026-01-02', NULL, '2026-01-08', 'Cancelada', 50.00),
(65, 9, '2026-01-15', NULL, '2026-01-20', 'Cancelada', 20.00),

-- Suscripciones Vencidas (Históricas para Gasto Total)
(66, 1, '2025-10-01', NULL, '2025-11-01', 'Vencida', 5.00),
(67, 3, '2025-11-01', NULL, '2025-12-01', 'Vencida', 10.00),
(68, 5, '2025-12-01', NULL, '2026-01-01', 'Vencida', 4.99),
(69, 2, '2025-09-15', NULL, '2025-10-15', 'Vencida', 25.00),
(70, 4, '2025-08-20', NULL, '2025-09-20', 'Vencida', 45.00),

-- Usuarios con Múltiples Suscripciones (Intereses Cruzados)
(75, 1, '2026-01-01', '2026-02-01', NULL, 'Activa', 5.00), -- Tecno
(75, 3, '2026-01-01', '2026-02-01', NULL, 'Activa', 10.00), -- Fitness
(80, 5, '2026-02-01', '2026-03-01', NULL, 'Activa', 4.99),
(80, 10, '2026-02-01', '2026-03-01', NULL, 'Activa', 12.00);
-- (Sigue agregando hasta completar los 100 del bloque...)
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- Estudiantes UCV (Generación Z) suscribiéndose a Tecnología y Educación
(101, 1, '2026-02-01', '2026-03-01', NULL, 'Activa', 5.00),
(102, 2, '2026-02-01', '2026-03-01', NULL, 'Activa', 25.00),
(103, 11, '2026-02-05', '2026-03-05', NULL, 'Activa', 5.99), -- Tech Supporter
(104, 17, '2026-02-10', '2026-03-10', NULL, 'Activa', 4.99), -- Analista Político
(105, 23, '2026-02-12', '2026-03-12', NULL, 'Activa', 6.00), -- Otaku Elite

-- Suscripciones para el Reporte 7 (Intereses Cruzados: Gasto > $140)
-- Usuario 110 con múltiples suscripciones de alto valor
(110, 2, '2026-01-01', '2026-02-01', NULL, 'Activa', 25.00), -- Premium Dev
(110, 4, '2026-01-01', '2026-02-01', NULL, 'Activa', 45.00), -- Atleta Elite
(110, 7, '2026-01-01', '2026-02-01', NULL, 'Activa', 50.00), -- MVP Legend
(110, 8, '2026-01-01', '2026-02-01', NULL, 'Activa', 30.00), -- VIP Adulto

-- Suscripciones Canceladas (Usuarios 120-130) para Churn
(120, 15, '2026-01-10', NULL, '2026-01-25', 'Cancelada', 8.00),
(121, 1, '2026-01-05', NULL, '2026-01-15', 'Cancelada', 5.00),
(122, 10, '2026-01-01', NULL, '2026-01-20', 'Cancelada', 12.00),
(123, 22, '2026-01-05', NULL, '2026-01-12', 'Cancelada', 15.00),

-- Suscripciones a Creadores NSFW (Validación de Protección de Menores)
(140, 8, '2026-02-15', '2026-03-15', NULL, 'Activa', 30.00), -- Creador 9
(141, 9, '2026-02-15', '2026-03-15', NULL, 'Activa', 20.00), -- Creador 16
(142, 10, '2026-02-15', '2026-03-15', NULL, 'Activa', 12.00); -- Creador 20
GO


INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
(151, 10, '2026-02-01', '2026-03-01', NULL, 'Activa', 9.00),  -- Moda
(152, 12, '2026-02-05', '2026-03-05', NULL, 'Activa', 6.50),  -- True Crime
(153, 15, '2026-02-10', '2026-03-10', NULL, 'Activa', 40.00), -- Finanzas
(154, 20, '2026-02-15', '2026-03-15', NULL, 'Activa', 20.00), -- Tarot
(155, 25, '2026-02-20', '2026-03-20', NULL, 'Activa', 35.00), -- Modelaje NSFW

(171, 1, '2025-11-01', NULL, '2025-12-01', 'Vencida', 5.00),
(172, 3, '2025-12-01', NULL, '2026-01-01', 'Vencida', 10.00),
(173, 5, '2025-10-15', NULL, '2025-11-15', 'Vencida', 4.99),
(174, 8, '2025-12-20', NULL, '2026-01-20', 'Vencida', 30.00),

(191, 2, '2026-01-01', NULL, '2026-01-10', 'Cancelada', 25.00), -- 9 días
(192, 4, '2026-01-05', NULL, '2026-01-25', 'Cancelada', 45.00), -- 20 días
(193, 7, '2026-01-10', NULL, '2026-01-15', 'Cancelada', 50.00), -- 5 días

(200, 7, '2026-01-01', '2026-02-01', NULL, 'Activa', 50.00),
(200, 15, '2026-01-01', '2026-02-01', NULL, 'Activa', 40.00),
(200, 8, '2026-01-01', '2026-02-01', NULL, 'Activa', 30.00),
(200, 22, '2026-01-01', '2026-02-01', NULL, 'Activa', 20.00);
GO

-- Suscripciones masivas para Fans (IDs 130-250) a diversos creadores
INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
(130, 1, '2026-01-01', '2026-02-01', NULL, 'Activa', 5.00),
(131, 3, '2026-01-01', '2026-02-01', NULL, 'Activa', 10.00),
(132, 5, '2026-01-01', '2026-02-01', NULL, 'Activa', 4.99),
(133, 7, '2026-01-01', '2026-02-01', NULL, 'Activa', 50.00),
(134, 9, '2026-01-01', '2026-02-01', NULL, 'Activa', 20.00),
(135, 11, '2026-01-01', '2026-02-01', NULL, 'Activa', 5.99),
(136, 13, '2026-01-01', '2026-02-01', NULL, 'Activa', 11.00),
(137, 15, '2026-01-01', '2026-02-01', NULL, 'Activa', 40.00),
(138, 17, '2026-01-01', '2026-02-01', NULL, 'Activa', 3.50),
(139, 20, '2026-01-01', '2026-02-01', NULL, 'Activa', 20.00),

(111, 2, '2026-01-10', '2026-02-10', NULL, 'Activa', 25.00),
(112, 4, '2026-01-10', '2026-02-10', NULL, 'Activa', 45.00),
(113, 6, '2026-01-10', '2026-02-10', NULL, 'Activa', 15.00),
(114, 8, '2026-01-10', '2026-02-10', NULL, 'Activa', 30.00),
(115, 10, '2026-01-10', '2026-02-10', NULL, 'Activa', 9.00),

(210, 1, '2026-02-01', '2026-03-01', NULL, 'Activa', 5.00),
(211, 3, '2026-02-01', '2026-03-01', NULL, 'Activa', 10.00),
(212, 5, '2026-02-01', '2026-03-01', NULL, 'Activa', 4.99),
(213, 7, '2026-02-01', '2026-03-01', NULL, 'Activa', 50.00),
(214, 9, '2026-02-01', '2026-03-01', NULL, 'Activa', 20.00);
GO


INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- Usuario 1 (DiegoDev) suscribiéndose a otros creadores (Intereses Cruzados)
(1, 3, '2026-01-05', '2026-02-05', NULL, 'Activa', 10.00), -- Fitness (Nivel 3)
(1, 5, '2026-01-05', '2026-02-05', NULL, 'Activa', 4.99),  -- Gaming (Nivel 5)
(1, 15, '2026-01-05', '2026-02-05', NULL, 'Activa', 40.00), -- Finanzas (Nivel 15)

(5, 4, '2026-01-01', '2026-02-01', NULL, 'Activa', 45.00),  -- Fitness Elite
(5, 7, '2026-01-01', '2026-02-01', NULL, 'Activa', 50.00),  -- Gaming MVP
(5, 9, '2026-01-01', '2026-02-01', NULL, 'Activa', 30.00),  -- NSFW VIP
(5, 15, '2026-01-01', '2026-02-01', NULL, 'Activa', 40.00), -- Finanzas Pro

(160, 1, '2026-02-01', '2026-03-01', NULL, 'Activa', 5.00),
(161, 6, '2026-02-01', '2026-03-01', NULL, 'Activa', 15.00),
(162, 8, '2026-02-01', '2026-03-01', NULL, 'Activa', 10.00),
(163, 10, '2026-02-01', '2026-03-01', NULL, 'Activa', 9.00),
(164, 12, '2026-02-01', '2026-03-01', NULL, 'Activa', 6.50),

(165, 2, '2025-10-01', NULL, '2025-11-01', 'Vencida', 25.00),
(166, 15, '2025-09-01', NULL, '2025-10-01', 'Vencida', 40.00),
(167, 7, '2025-08-01', NULL, '2025-09-01', 'Vencida', 50.00);
GO

PRINT 'Generando Facturas del bloque';

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(1, '20260110-26', '2026-01-10', 5.00, 0.80, 5.80),
(2, '20260115-27', '2026-01-15', 25.00, 4.00, 29.00),
(3, '20260120-28', '2026-01-20', 10.00, 1.60, 11.60),
(4, '20260201-29', '2026-02-01', 45.00, 7.20, 52.20),
(13, '20260101-50', '2026-01-01', 5.00, 0.80, 5.80),
(14, '20260105-50', '2026-01-05', 10.00, 1.60, 11.60);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(15, '20260110-51', '2026-01-10', 5.00, 0.80, 5.80),
(16, '20260111-52', '2026-01-11', 10.00, 1.60, 11.60),
(17, '20260112-53', '2026-01-12', 4.99, 0.80, 5.79),
(18, '20260113-54', '2026-01-13', 30.00, 4.80, 34.80),
(35, '20260101-75', '2026-01-01', 5.00, 0.80, 5.80),
(36, '20260101-75B', '2026-01-01', 10.00, 1.60, 11.60);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
-- Facturas Usuario 110 (Asegurando cumplimiento Reporte 7)
(45, '20260101-110A', '2026-01-01', 25.00, 4.00, 29.00),
(46, '20260101-110B', '2026-01-01', 45.00, 7.20, 52.20),
(47, '20260101-110C', '2026-01-01', 50.00, 8.00, 58.00),
(48, '20260101-110D', '2026-01-01', 30.00, 4.80, 34.80),

(40, '20260201-101', '2026-02-01', 5.00, 0.80, 5.80),
(41, '20260201-102', '2026-02-01', 25.00, 4.00, 29.00);
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- Suscripciones Activas para completar volumen
(215, 2, '2026-02-01', '2026-03-01', NULL, 'Activa', 25.00),
(216, 4, '2026-02-01', '2026-03-01', NULL, 'Activa', 45.00),
(217, 6, '2026-02-01', '2026-03-01', NULL, 'Activa', 15.00),
(218, 9, '2026-02-01', '2026-03-01', NULL, 'Activa', 20.00),
(219, 12, '2026-02-01', '2026-03-01', NULL, 'Activa', 6.50),
(220, 15, '2026-02-01', '2026-03-01', NULL, 'Activa', 40.00),

-- Suscripciones Vencidas (Para historial de pagos)
(221, 1, '2025-12-01', NULL, '2026-01-01', 'Vencida', 5.00),
(222, 3, '2025-12-01', NULL, '2026-01-01', 'Vencida', 10.00),
(223, 5, '2025-12-01', NULL, '2026-01-01', 'Vencida', 4.99),
(224, 7, '2025-12-01', NULL, '2026-01-01', 'Vencida', 50.00),

-- Usuarios de relleno con suscripciones básicas
(225, 10, '2026-02-10', '2026-03-10', NULL, 'Activa', 9.00),
(226, 11, '2026-02-10', '2026-03-10', NULL, 'Activa', 4.99),
(227, 13, '2026-02-10', '2026-03-10', NULL, 'Activa', 11.00),
(228, 14, '2026-02-10', '2026-03-10', NULL, 'Activa', 8.00),
(229, 16, '2026-02-10', '2026-03-10', NULL, 'Activa', 3.50),
(230, 18, '2026-02-10', '2026-03-10', NULL, 'Activa', 6.00);
GO


INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(67, '20260101-200-67-7-3', '2026-01-01', 50.00, 8.00, 58.00),
(68, '20260101-200-68-15-15', '2026-01-01', 40.00, 6.40, 46.40),
(69, '20260101-200-69-8-9', '2026-01-01', 30.00, 4.80, 34.80),
(70, '20260101-200-70-22-22', '2026-01-01', 20.00, 3.20, 23.20),

(55, '20260201-151-55-10-10', '2026-02-01', 9.00, 1.44, 10.44),
(56, '20260205-152-56-12-12', '2026-02-05', 6.50, 1.04, 7.54);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(40, '20260201-101-40-1-1', '2026-02-01', 5.00, 0.80, 5.80),
(41, '20260201-102-41-2-1', '2026-02-01', 25.00, 4.00, 29.00),
(42, '20260205-103-42-11-5', '2026-02-05', 5.99, 0.96, 6.95),

(81, '20260110-111-81-2-1', '2026-01-10', 25.00, 4.00, 29.00),
(82, '20260110-112-82-4-2', '2026-01-10', 45.00, 7.20, 52.20),
(83, '20260110-113-83-6-3', '2026-01-10', 15.00, 2.40, 17.40);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(91, '20260201-215-91-2-1', '2026-02-01', 25.00, 4.00, 29.00),
(92, '20260201-216-92-4-2', '2026-02-01', 45.00, 7.20, 52.20),
(93, '20260201-217-93-6-3', '2026-02-01', 15.00, 2.40, 17.40),
(94, '20260201-218-94-9-16', '2026-02-01', 20.00, 3.20, 23.20),
(97, '20251201-221-97-1-1', '2025-12-01', 5.00, 0.80, 5.80),
(98, '20251201-222-98-3-2', '2025-12-01', 10.00, 1.60, 11.60);
GO


INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
-- Facturas del Usuario 5 (SergioCode) - Asegurando cumplimiento Reporte 7
(110, '20260101-5-110-4-2', '2026-01-01', 45.00, 7.20, 52.20),
(111, '20260101-5-111-7-3', '2026-01-01', 50.00, 8.00, 58.00),
(112, '20260101-5-112-9-9', '2026-01-01', 30.00, 4.80, 34.80),
(113, '20260101-5-113-15-15', '2026-01-01', 40.00, 6.40, 46.40),

(107, '20260105-1-107-3-2', '2026-01-05', 10.00, 1.60, 11.60),
(109, '20260105-1-109-15-15', '2026-01-05', 40.00, 6.40, 46.40);
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- Activas (30 registros)
(180, 1, '2026-02-05', '2026-03-05', NULL, 'Activa', 5.00),
(181, 2, '2026-02-05', '2026-03-05', NULL, 'Activa', 25.00),
(182, 3, '2026-02-05', '2026-03-05', NULL, 'Activa', 10.00),
(183, 4, '2026-02-05', '2026-03-05', NULL, 'Activa', 45.00),
(184, 5, '2026-02-05', '2026-03-05', NULL, 'Activa', 4.99),
(185, 6, '2026-02-05', '2026-03-05', NULL, 'Activa', 15.00),
(186, 7, '2026-02-05', '2026-03-05', NULL, 'Activa', 50.00),
(187, 8, '2026-02-05', '2026-03-05', NULL, 'Activa', 30.00),
(188, 9, '2026-02-05', '2026-03-05', NULL, 'Activa', 20.00),
(189, 10, '2026-02-05', '2026-03-05', NULL, 'Activa', 12.00),
(190, 11, '2026-02-05', '2026-03-05', NULL, 'Activa', 25.00),
(191, 12, '2026-02-05', '2026-03-05', NULL, 'Activa', 35.00),
(192, 13, '2026-02-05', '2026-03-05', NULL, 'Activa', 7.99),
(193, 14, '2026-02-05', '2026-03-05', NULL, 'Activa', 5.99),
(194, 15, '2026-02-05', '2026-03-05', NULL, 'Activa', 8.50),
(195, 1, '2026-02-10', '2026-03-10', NULL, 'Activa', 5.00),
(196, 2, '2026-02-10', '2026-03-10', NULL, 'Activa', 25.00),
(197, 3, '2026-02-10', '2026-03-10', NULL, 'Activa', 10.00),
(198, 4, '2026-02-10', '2026-03-10', NULL, 'Activa', 45.00),
(199, 5, '2026-02-10', '2026-03-10', NULL, 'Activa', 4.99),
(200, 6, '2026-02-10', '2026-03-10', NULL, 'Activa', 15.00),
(201, 7, '2026-02-10', '2026-03-10', NULL, 'Activa', 50.00),
(202, 8, '2026-02-10', '2026-03-10', NULL, 'Activa', 30.00),
(203, 9, '2026-02-10', '2026-03-10', NULL, 'Activa', 20.00),
(204, 10, '2026-02-10', '2026-03-10', NULL, 'Activa', 12.00),
(205, 11, '2026-02-10', '2026-03-10', NULL, 'Activa', 25.00),
(206, 12, '2026-02-10', '2026-03-10', NULL, 'Activa', 35.00),
(207, 13, '2026-02-10', '2026-03-10', NULL, 'Activa', 7.99),
(208, 14, '2026-02-10', '2026-03-10', NULL, 'Activa', 5.99),
(209, 15, '2026-02-10', '2026-03-10', NULL, 'Activa', 8.50),

-- Vencidas (10 registros)
(210, 1, '2025-08-01', NULL, '2025-09-01', 'Vencida', 5.00),
(211, 2, '2025-08-01', NULL, '2025-09-01', 'Vencida', 25.00),
(212, 3, '2025-09-01', NULL, '2025-10-01', 'Vencida', 10.00),
(213, 4, '2025-09-01', NULL, '2025-10-01', 'Vencida', 45.00),
(214, 5, '2025-10-01', NULL, '2025-11-01', 'Vencida', 4.99),
(215, 6, '2025-10-01', NULL, '2025-11-01', 'Vencida', 15.00),
(216, 7, '2025-11-01', NULL, '2025-12-01', 'Vencida', 50.00),
(217, 8, '2025-11-01', NULL, '2025-12-01', 'Vencida', 30.00),
(218, 9, '2025-12-01', NULL, '2026-01-01', 'Vencida', 20.00),
(219, 10, '2025-12-01', NULL, '2026-01-01', 'Vencida', 12.00),

-- Canceladas (10 registros)
(220, 11, '2026-01-01', NULL, '2026-01-10', 'Cancelada', 25.00),
(221, 12, '2026-01-05', NULL, '2026-01-12', 'Cancelada', 35.00),
(222, 13, '2026-01-10', NULL, '2026-01-15', 'Cancelada', 7.99),
(223, 14, '2026-01-15', NULL, '2026-01-20', 'Cancelada', 5.99),
(224, 15, '2026-01-20', NULL, '2026-01-28', 'Cancelada', 8.50),
(225, 1, '2026-02-01', NULL, '2026-02-05', 'Cancelada', 5.00),
(226, 2, '2026-02-02', NULL, '2026-02-10', 'Cancelada', 25.00),
(227, 3, '2026-02-03', NULL, '2026-02-12', 'Cancelada', 10.00),
(228, 4, '2026-02-04', NULL, '2026-02-15', 'Cancelada', 45.00),
(229, 5, '2026-02-05', NULL, '2026-02-20', 'Cancelada', 4.99);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(122, '20260205-180-122-1-1', '2026-02-05', 5.00, 0.80, 5.80),
(123, '20260205-181-123-2-1', '2026-02-05', 25.00, 4.00, 29.00),
(124, '20260205-182-124-3-2', '2026-02-05', 10.00, 1.60, 11.60),
(125, '20260205-183-125-4-2', '2026-02-05', 45.00, 7.20, 52.20),
(126, '20260205-184-126-5-3', '2026-02-05', 4.99, 0.80, 5.79),
(127, '20260205-185-127-6-3', '2026-02-05', 15.00, 2.40, 17.40),
(128, '20260205-186-128-7-3', '2026-02-05', 50.00, 8.00, 58.00),
(129, '20260205-187-129-8-9', '2026-02-05', 30.00, 4.80, 34.80),
(130, '20260205-188-130-9-16', '2026-02-05', 20.00, 3.20, 23.20),
(131, '20260205-189-131-10-20', '2026-02-05', 12.00, 1.92, 13.92),
(132, '20260205-190-132-11-23', '2026-02-05', 25.00, 4.00, 29.00),
(133, '20260205-191-133-12-25', '2026-02-05', 35.00, 5.60, 40.60),
(134, '20260205-192-134-13-4', '2026-02-05', 7.99, 1.28, 9.27),
(135, '20260205-193-135-14-5', '2026-02-05', 5.99, 0.96, 6.95),
(136, '20260205-194-136-15-6', '2026-02-05', 8.50, 1.36, 9.86),
(137, '20260210-195-137-1-1', '2026-02-10', 5.00, 0.80, 5.80),
(138, '20260210-196-138-2-1', '2026-02-10', 25.00, 4.00, 29.00),
(139, '20260210-197-139-3-2', '2026-02-10', 10.00, 1.60, 11.60),
(140, '20260210-198-140-4-2', '2026-02-10', 45.00, 7.20, 52.20),
(141, '20260210-199-141-5-3', '2026-02-10', 4.99, 0.80, 5.79);
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- 50 Suscripciones Activas
(10, 1, '2026-02-15', '2026-03-15', NULL, 'Activa', 5.00),
(11, 2, '2026-02-15', '2026-03-15', NULL, 'Activa', 25.00),
(12, 3, '2026-02-15', '2026-03-15', NULL, 'Activa', 10.00),
(13, 4, '2026-02-15', '2026-03-15', NULL, 'Activa', 45.00),
(14, 5, '2026-02-15', '2026-03-15', NULL, 'Activa', 4.99),
(15, 6, '2026-02-15', '2026-03-15', NULL, 'Activa', 15.00),
(16, 7, '2026-02-15', '2026-03-15', NULL, 'Activa', 50.00),
(17, 8, '2026-02-15', '2026-03-15', NULL, 'Activa', 30.00),
(18, 9, '2026-02-15', '2026-03-15', NULL, 'Activa', 20.00),
(19, 10, '2026-02-15', '2026-03-15', NULL, 'Activa', 12.00),
(20, 1, '2026-02-16', '2026-03-16', NULL, 'Activa', 5.00),
(21, 2, '2026-02-16', '2026-03-16', NULL, 'Activa', 25.00),
(22, 3, '2026-02-16', '2026-03-16', NULL, 'Activa', 10.00),
(23, 4, '2026-02-16', '2026-03-16', NULL, 'Activa', 45.00),
(24, 5, '2026-02-16', '2026-03-16', NULL, 'Activa', 4.99),
(25, 6, '2026-02-16', '2026-03-16', NULL, 'Activa', 15.00),
(26, 7, '2026-02-16', '2026-03-16', NULL, 'Activa', 50.00),
(27, 8, '2026-02-16', '2026-03-16', NULL, 'Activa', 30.00),
(28, 9, '2026-02-16', '2026-03-16', NULL, 'Activa', 20.00),
(29, 10, '2026-02-16', '2026-03-16', NULL, 'Activa', 12.00),
(30, 1, '2026-02-17', '2026-03-17', NULL, 'Activa', 5.00),
(31, 2, '2026-02-17', '2026-03-17', NULL, 'Activa', 25.00),
(32, 3, '2026-02-17', '2026-03-17', NULL, 'Activa', 10.00),
(33, 4, '2026-02-17', '2026-03-17', NULL, 'Activa', 45.00),
(34, 5, '2026-02-17', '2026-03-17', NULL, 'Activa', 4.99),
(35, 6, '2026-02-17', '2026-03-17', NULL, 'Activa', 15.00),
(36, 7, '2026-02-17', '2026-03-17', NULL, 'Activa', 50.00),
(37, 8, '2026-02-17', '2026-03-17', NULL, 'Activa', 30.00),
(38, 9, '2026-02-17', '2026-03-17', NULL, 'Activa', 20.00),
(39, 10, '2026-02-17', '2026-03-17', NULL, 'Activa', 12.00),
(40, 1, '2026-02-18', '2026-03-18', NULL, 'Activa', 5.00),
(41, 2, '2026-02-18', '2026-03-18', NULL, 'Activa', 25.00),
(42, 3, '2026-02-18', '2026-03-18', NULL, 'Activa', 10.00),
(43, 4, '2026-02-18', '2026-03-18', NULL, 'Activa', 45.00),
(44, 5, '2026-02-18', '2026-03-18', NULL, 'Activa', 4.99),
(45, 6, '2026-02-18', '2026-03-18', NULL, 'Activa', 15.00),
(46, 7, '2026-02-18', '2026-03-18', NULL, 'Activa', 50.00),
(47, 8, '2026-02-18', '2026-03-18', NULL, 'Activa', 30.00),
(48, 9, '2026-02-18', '2026-03-18', NULL, 'Activa', 20.00),
(49, 10, '2026-02-18', '2026-03-18', NULL, 'Activa', 12.00),
(50, 1, '2026-02-19', '2026-03-19', NULL, 'Activa', 5.00),
(51, 2, '2026-02-19', '2026-03-19', NULL, 'Activa', 25.00),
(52, 3, '2026-02-19', '2026-03-19', NULL, 'Activa', 10.00),
(53, 4, '2026-02-19', '2026-03-19', NULL, 'Activa', 45.00),
(54, 5, '2026-02-19', '2026-03-19', NULL, 'Activa', 4.99),
(55, 6, '2026-02-19', '2026-03-19', NULL, 'Activa', 15.00),
(56, 7, '2026-02-19', '2026-03-19', NULL, 'Activa', 50.00),
(57, 8, '2026-02-19', '2026-03-19', NULL, 'Activa', 30.00),
(58, 9, '2026-02-19', '2026-03-19', NULL, 'Activa', 20.00),
(59, 10, '2026-02-19', '2026-03-19', NULL, 'Activa', 12.00),

-- 25 Suscripciones Vencidas (Histórico)
(60, 1, '2025-10-01', NULL, '2025-11-01', 'Vencida', 5.00),
(61, 2, '2025-10-01', NULL, '2025-11-01', 'Vencida', 25.00),
(62, 3, '2025-10-01', NULL, '2025-11-01', 'Vencida', 10.00),
(63, 4, '2025-10-01', NULL, '2025-11-01', 'Vencida', 45.00),
(64, 5, '2025-10-01', NULL, '2025-11-01', 'Vencida', 4.99),
(65, 6, '2025-10-01', NULL, '2025-11-01', 'Vencida', 15.00),
(66, 7, '2025-10-01', NULL, '2025-11-01', 'Vencida', 50.00),
(67, 8, '2025-10-01', NULL, '2025-11-01', 'Vencida', 30.00),
(68, 9, '2025-10-01', NULL, '2025-11-01', 'Vencida', 20.00),
(69, 10, '2025-10-01', NULL, '2025-11-01', 'Vencida', 12.00),
(70, 1, '2025-11-01', NULL, '2025-12-01', 'Vencida', 5.00),
(71, 2, '2025-11-01', NULL, '2025-12-01', 'Vencida', 25.00),
(72, 3, '2025-11-01', NULL, '2025-12-01', 'Vencida', 10.00),
(73, 4, '2025-11-01', NULL, '2025-12-01', 'Vencida', 45.00),
(74, 5, '2025-11-01', NULL, '2025-12-01', 'Vencida', 4.99),
(75, 6, '2025-11-01', NULL, '2025-12-01', 'Vencida', 15.00),
(76, 7, '2025-11-01', NULL, '2025-12-01', 'Vencida', 50.00),
(77, 8, '2025-11-01', NULL, '2025-12-01', 'Vencida', 30.00),
(78, 9, '2025-11-01', NULL, '2025-12-01', 'Vencida', 20.00),
(79, 10, '2025-11-01', NULL, '2025-12-01', 'Vencida', 12.00),
(80, 1, '2025-12-01', NULL, '2026-01-01', 'Vencida', 5.00),
(81, 2, '2025-12-01', NULL, '2026-01-01', 'Vencida', 25.00),
(82, 3, '2025-12-01', NULL, '2026-01-01', 'Vencida', 10.00),
(83, 4, '2025-12-01', NULL, '2026-01-01', 'Vencida', 45.00),
(84, 5, '2025-12-01', NULL, '2026-01-01', 'Vencida', 4.99),

-- 25 Suscripciones Canceladas (Churn de corto plazo)
(85, 6, '2026-01-05', NULL, '2026-01-12', 'Cancelada', 15.00),
(86, 7, '2026-01-05', NULL, '2026-01-15', 'Cancelada', 50.00),
(87, 8, '2026-01-05', NULL, '2026-01-20', 'Cancelada', 30.00),
(88, 9, '2026-01-05', NULL, '2026-01-25', 'Cancelada', 20.00),
(89, 10, '2026-01-05', NULL, '2026-01-30', 'Cancelada', 12.00),
(90, 1, '2026-01-10', NULL, '2026-01-18', 'Cancelada', 5.00),
(91, 2, '2026-01-10', NULL, '2026-01-19', 'Cancelada', 25.00),
(92, 3, '2026-01-10', NULL, '2026-01-22', 'Cancelada', 10.00),
(93, 4, '2026-01-10', NULL, '2026-01-25', 'Cancelada', 45.00),
(94, 5, '2026-01-10', NULL, '2026-01-28', 'Cancelada', 4.99),
(95, 6, '2026-01-15', NULL, '2026-01-20', 'Cancelada', 15.00),
(96, 7, '2026-01-15', NULL, '2026-01-25', 'Cancelada', 50.00),
(97, 8, '2026-01-15', NULL, '2026-01-28', 'Cancelada', 30.00),
(98, 9, '2026-01-15', NULL, '2026-01-30', 'Cancelada', 20.00),
(99, 10, '2026-01-15', NULL, '2026-02-01', 'Cancelada', 12.00),
(100, 1, '2026-01-20', NULL, '2026-01-25', 'Cancelada', 5.00),
(101, 2, '2026-01-20', NULL, '2026-01-30', 'Cancelada', 25.00),
(102, 3, '2026-01-20', NULL, '2026-02-05', 'Cancelada', 10.00),
(103, 4, '2026-01-20', NULL, '2026-02-10', 'Cancelada', 45.00),
(104, 5, '2026-01-20', NULL, '2026-02-15', 'Cancelada', 4.99),
(105, 6, '2026-01-25', NULL, '2026-01-30', 'Cancelada', 15.00),
(106, 7, '2026-01-25', NULL, '2026-02-05', 'Cancelada', 50.00),
(107, 8, '2026-01-25', NULL, '2026-02-10', 'Cancelada', 30.00),
(108, 9, '2026-01-25', NULL, '2026-02-15', 'Cancelada', 20.00),
(109, 10, '2026-01-25', NULL, '2026-02-20', 'Cancelada', 12.00);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(172, '20260215-10-172-1-1', '2026-02-15', 5.00, 0.80, 5.80),
(173, '20260215-11-173-2-1', '2026-02-15', 25.00, 4.00, 29.00),
(174, '20260215-12-174-3-2', '2026-02-15', 10.00, 1.60, 11.60),
(175, '20260215-13-175-4-2', '2026-02-15', 45.00, 7.20, 52.20),
(176, '20260215-14-176-5-3', '2026-02-15', 4.99, 0.80, 5.79),
(177, '20260215-15-177-6-3', '2026-02-15', 15.00, 2.40, 17.40),
(178, '20260215-16-178-7-3', '2026-02-15', 50.00, 8.00, 58.00),
(179, '20260215-17-179-8-9', '2026-02-15', 30.00, 4.80, 34.80),
(180, '20260215-18-180-9-16', '2026-02-15', 20.00, 3.20, 23.20),
(181, '20260215-19-181-10-20', '2026-02-15', 12.00, 1.92, 13.92),
(182, '20260216-20-182-1-1', '2026-02-16', 5.00, 0.80, 5.80),
(183, '20260216-21-183-2-1', '2026-02-16', 25.00, 4.00, 29.00),
(184, '20260216-22-184-3-2', '2026-02-16', 10.00, 1.60, 11.60),
(185, '20260216-23-185-4-2', '2026-02-16', 45.00, 7.20, 52.20),
(186, '20260216-24-186-5-3', '2026-02-16', 4.99, 0.80, 5.79),
(187, '20260216-25-187-6-3', '2026-02-16', 15.00, 2.40, 17.40),
(188, '20260216-26-188-7-3', '2026-02-16', 50.00, 8.00, 58.00),
(189, '20260216-27-189-8-9', '2026-02-16', 30.00, 4.80, 34.80),
(190, '20260216-28-190-9-16', '2026-02-16', 20.00, 3.20, 23.20),
(191, '20260216-29-191-10-20', '2026-02-16', 12.00, 1.92, 13.92),
(192, '20260217-30-192-1-1', '2026-02-17', 5.00, 0.80, 5.80),
(193, '20260217-31-193-2-1', '2026-02-17', 25.00, 4.00, 29.00),
(194, '20260217-32-194-3-2', '2026-02-17', 10.00, 1.60, 11.60),
(195, '20260217-33-195-4-2', '2026-02-17', 45.00, 7.20, 52.20),
(196, '20260217-34-196-5-3', '2026-02-17', 4.99, 0.80, 5.79),
(197, '20260217-35-197-6-3', '2026-02-17', 15.00, 2.40, 17.40),
(198, '20260217-36-198-7-3', '2026-02-17', 50.00, 8.00, 58.00),
(199, '20260217-37-199-8-9', '2026-02-17', 30.00, 4.80, 34.80),
(200, '20260217-38-200-9-16', '2026-02-17', 20.00, 3.20, 23.20),
(201, '20260217-39-201-10-20', '2026-02-17', 12.00, 1.92, 13.92),
(202, '20260218-40-202-1-1', '2026-02-18', 5.00, 0.80, 5.80),
(203, '20260218-41-203-2-1', '2026-02-18', 25.00, 4.00, 29.00),
(204, '20260218-42-204-3-2', '2026-02-18', 10.00, 1.60, 11.60),
(205, '20260218-43-205-4-2', '2026-02-18', 45.00, 7.20, 52.20),
(206, '20260218-44-206-5-3', '2026-02-18', 4.99, 0.80, 5.79),
(207, '20260218-45-207-6-3', '2026-02-18', 15.00, 2.40, 17.40),
(208, '20260218-46-208-7-3', '2026-02-18', 50.00, 8.00, 58.00),
(209, '20260218-47-209-8-9', '2026-02-18', 30.00, 4.80, 34.80),
(210, '20260218-48-210-9-16', '2026-02-18', 20.00, 3.20, 23.20),
(211, '20260218-49-211-10-20', '2026-02-18', 12.00, 1.92, 13.92),
(212, '20260219-50-212-1-1', '2026-02-19', 5.00, 0.80, 5.80),
(213, '20260219-51-213-2-1', '2026-02-19', 25.00, 4.00, 29.00),
(214, '20260219-52-214-3-2', '2026-02-19', 10.00, 1.60, 11.60),
(215, '20260219-53-215-4-2', '2026-02-19', 45.00, 7.20, 52.20),
(216, '20260219-54-216-5-3', '2026-02-19', 4.99, 0.80, 5.79),
(217, '20260219-55-217-6-3', '2026-02-19', 15.00, 2.40, 17.40),
(218, '20260219-56-218-7-3', '2026-02-19', 50.00, 8.00, 58.00),
(219, '20260219-57-219-8-9', '2026-02-19', 30.00, 4.80, 34.80),
(220, '20260219-58-220-9-16', '2026-02-19', 20.00, 3.20, 23.20),
(221, '20260219-59-221-10-20', '2026-02-19', 12.00, 1.92, 13.92);
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- 50 Suscripciones Activas (Usuarios 110 al 159)
(110, 1, '2026-02-20', '2026-03-20', NULL, 'Activa', 5.00),
(111, 2, '2026-02-20', '2026-03-20', NULL, 'Activa', 25.00),
(112, 3, '2026-02-20', '2026-03-20', NULL, 'Activa', 10.00),
(113, 4, '2026-02-20', '2026-03-20', NULL, 'Activa', 45.00),
(114, 5, '2026-02-20', '2026-03-20', NULL, 'Activa', 4.99),
(115, 6, '2026-02-20', '2026-03-20', NULL, 'Activa', 15.00),
(116, 7, '2026-02-20', '2026-03-20', NULL, 'Activa', 50.00),
(117, 8, '2026-02-20', '2026-03-20', NULL, 'Activa', 30.00),
(118, 9, '2026-02-20', '2026-03-20', NULL, 'Activa', 20.00),
(119, 10, '2026-02-20', '2026-03-20', NULL, 'Activa', 12.00),
(120, 1, '2026-02-21', '2026-03-21', NULL, 'Activa', 5.00),
(121, 2, '2026-02-21', '2026-03-21', NULL, 'Activa', 25.00),
(122, 3, '2026-02-21', '2026-03-21', NULL, 'Activa', 10.00),
(123, 4, '2026-02-21', '2026-03-21', NULL, 'Activa', 45.00),
(124, 5, '2026-02-21', '2026-03-21', NULL, 'Activa', 4.99),
(125, 6, '2026-02-21', '2026-03-21', NULL, 'Activa', 15.00),
(126, 7, '2026-02-21', '2026-03-21', NULL, 'Activa', 50.00),
(127, 8, '2026-02-21', '2026-03-21', NULL, 'Activa', 30.00),
(128, 9, '2026-02-21', '2026-03-21', NULL, 'Activa', 20.00),
(129, 10, '2026-02-21', '2026-03-21', NULL, 'Activa', 12.00),
(130, 1, '2026-02-22', '2026-03-22', NULL, 'Activa', 5.00),
(131, 2, '2026-02-22', '2026-03-22', NULL, 'Activa', 25.00),
(132, 3, '2026-02-22', '2026-03-22', NULL, 'Activa', 10.00),
(133, 4, '2026-02-22', '2026-03-22', NULL, 'Activa', 45.00),
(134, 5, '2026-02-22', '2026-03-22', NULL, 'Activa', 4.99),
(135, 6, '2026-02-22', '2026-03-22', NULL, 'Activa', 15.00),
(136, 7, '2026-02-22', '2026-03-22', NULL, 'Activa', 50.00),
(137, 8, '2026-02-22', '2026-03-22', NULL, 'Activa', 30.00),
(138, 9, '2026-02-22', '2026-03-22', NULL, 'Activa', 20.00),
(139, 10, '2026-02-22', '2026-03-22', NULL, 'Activa', 12.00),
(140, 1, '2026-02-23', '2026-03-23', NULL, 'Activa', 5.00),
(141, 2, '2026-02-23', '2026-03-23', NULL, 'Activa', 25.00),
(142, 3, '2026-02-23', '2026-03-23', NULL, 'Activa', 10.00),
(143, 4, '2026-02-23', '2026-03-23', NULL, 'Activa', 45.00),
(144, 5, '2026-02-23', '2026-03-23', NULL, 'Activa', 4.99),
(145, 6, '2026-02-23', '2026-03-23', NULL, 'Activa', 15.00),
(146, 7, '2026-02-23', '2026-03-23', NULL, 'Activa', 50.00),
(147, 8, '2026-02-23', '2026-03-23', NULL, 'Activa', 30.00),
(148, 9, '2026-02-23', '2026-03-23', NULL, 'Activa', 20.00),
(149, 10, '2026-02-23', '2026-03-23', NULL, 'Activa', 12.00),
(150, 1, '2026-02-24', '2026-03-24', NULL, 'Activa', 5.00),
(151, 2, '2026-02-24', '2026-03-24', NULL, 'Activa', 25.00),
(152, 3, '2026-02-24', '2026-03-24', NULL, 'Activa', 10.00),
(153, 4, '2026-02-24', '2026-03-24', NULL, 'Activa', 45.00),
(154, 5, '2026-02-24', '2026-03-24', NULL, 'Activa', 4.99),
(155, 6, '2026-02-24', '2026-03-24', NULL, 'Activa', 15.00),
(156, 7, '2026-02-24', '2026-03-24', NULL, 'Activa', 50.00),
(157, 8, '2026-02-24', '2026-03-24', NULL, 'Activa', 30.00),
(158, 9, '2026-02-24', '2026-03-24', NULL, 'Activa', 20.00),
(159, 10, '2026-02-24', '2026-03-24', NULL, 'Activa', 12.00),

-- 25 Suscripciones Vencidas (Usuarios 160 al 184)
(160, 1, '2025-07-01', NULL, '2025-08-01', 'Vencida', 5.00),
(161, 2, '2025-07-01', NULL, '2025-08-01', 'Vencida', 25.00),
(162, 3, '2025-07-01', NULL, '2025-08-01', 'Vencida', 10.00),
(163, 4, '2025-07-01', NULL, '2025-08-01', 'Vencida', 45.00),
(164, 5, '2025-07-01', NULL, '2025-08-01', 'Vencida', 4.99),
(165, 6, '2025-07-01', NULL, '2025-08-01', 'Vencida', 15.00),
(166, 7, '2025-07-01', NULL, '2025-08-01', 'Vencida', 50.00),
(167, 8, '2025-07-01', NULL, '2025-08-01', 'Vencida', 30.00),
(168, 9, '2025-07-01', NULL, '2025-08-01', 'Vencida', 20.00),
(169, 10, '2025-07-01', NULL, '2025-08-01', 'Vencida', 12.00),
(170, 1, '2025-06-01', NULL, '2025-07-01', 'Vencida', 5.00),
(171, 2, '2025-06-01', NULL, '2025-07-01', 'Vencida', 25.00),
(172, 3, '2025-06-01', NULL, '2025-07-01', 'Vencida', 10.00),
(173, 4, '2025-06-01', NULL, '2025-07-01', 'Vencida', 45.00),
(174, 5, '2025-06-01', NULL, '2025-07-01', 'Vencida', 4.99),
(175, 6, '2025-06-01', NULL, '2025-07-01', 'Vencida', 15.00),
(176, 7, '2025-06-01', NULL, '2025-07-01', 'Vencida', 50.00),
(177, 8, '2025-06-01', NULL, '2025-07-01', 'Vencida', 30.00),
(178, 9, '2025-06-01', NULL, '2025-07-01', 'Vencida', 20.00),
(179, 10, '2025-06-01', NULL, '2025-07-01', 'Vencida', 12.00),
(180, 1, '2025-05-01', NULL, '2025-06-01', 'Vencida', 5.00),
(181, 2, '2025-05-01', NULL, '2025-06-01', 'Vencida', 25.00),
(182, 3, '2025-05-01', NULL, '2025-06-01', 'Vencida', 10.00),
(183, 4, '2025-05-01', NULL, '2025-06-01', 'Vencida', 45.00),
(184, 5, '2025-05-01', NULL, '2025-06-01', 'Vencida', 4.99),

-- 25 Suscripciones Canceladas (Usuarios 185 al 209)
(185, 6, '2026-01-01', NULL, '2026-01-08', 'Cancelada', 15.00),
(186, 7, '2026-01-01', NULL, '2026-01-12', 'Cancelada', 50.00),
(187, 8, '2026-01-01', NULL, '2026-01-18', 'Cancelada', 30.00),
(188, 9, '2026-01-01', NULL, '2026-01-22', 'Cancelada', 20.00),
(189, 10, '2026-01-01', NULL, '2026-01-29', 'Cancelada', 12.00),
(190, 1, '2026-01-05', NULL, '2026-01-10', 'Cancelada', 5.00),
(191, 2, '2026-01-05', NULL, '2026-01-15', 'Cancelada', 25.00),
(192, 3, '2026-01-05', NULL, '2026-01-18', 'Cancelada', 10.00),
(193, 4, '2026-01-05', NULL, '2026-01-22', 'Cancelada', 45.00),
(194, 5, '2026-01-05', NULL, '2026-01-26', 'Cancelada', 4.99),
(195, 6, '2026-01-10', NULL, '2026-01-14', 'Cancelada', 15.00),
(196, 7, '2026-01-10', NULL, '2026-01-19', 'Cancelada', 50.00),
(197, 8, '2026-01-10', NULL, '2026-01-24', 'Cancelada', 30.00),
(198, 9, '2026-01-10', NULL, '2026-01-28', 'Cancelada', 20.00),
(199, 10, '2026-01-10', NULL, '2026-01-30', 'Cancelada', 12.00),
(200, 1, '2026-01-15', NULL, '2026-01-20', 'Cancelada', 5.00),
(201, 2, '2026-01-15', NULL, '2026-01-22', 'Cancelada', 25.00),
(202, 3, '2026-01-15', NULL, '2026-01-25', 'Cancelada', 10.00),
(203, 4, '2026-01-15', NULL, '2026-01-29', 'Cancelada', 45.00),
(204, 5, '2026-01-15', NULL, '2026-01-31', 'Cancelada', 4.99),
(205, 6, '2026-01-20', NULL, '2026-01-23', 'Cancelada', 15.00),
(206, 7, '2026-01-20', NULL, '2026-01-26', 'Cancelada', 50.00),
(207, 8, '2026-01-20', NULL, '2026-01-28', 'Cancelada', 30.00),
(208, 9, '2026-01-20', NULL, '2026-01-30', 'Cancelada', 20.00),
(209, 10, '2026-01-20', NULL, '2026-02-02', 'Cancelada', 12.00);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(272, '20260220-110-272-1-1', '2026-02-20', 5.00, 0.80, 5.80),
(273, '20260220-111-273-2-1', '2026-02-20', 25.00, 4.00, 29.00),
(274, '20260220-112-274-3-2', '2026-02-20', 10.00, 1.60, 11.60),
(275, '20260220-113-275-4-2', '2026-02-20', 45.00, 7.20, 52.20),
(276, '20260220-114-276-5-3', '2026-02-20', 4.99, 0.80, 5.79),
(277, '20260220-115-277-6-3', '2026-02-20', 15.00, 2.40, 17.40),
(278, '20260220-116-278-7-3', '2026-02-20', 50.00, 8.00, 58.00),
(279, '20260220-117-279-8-9', '2026-02-20', 30.00, 4.80, 34.80),
(280, '20260220-118-280-9-16', '2026-02-20', 20.00, 3.20, 23.20),
(281, '20260220-119-281-10-20', '2026-02-20', 12.00, 1.92, 13.92),
(282, '20260221-120-282-1-1', '2026-02-21', 5.00, 0.80, 5.80),
(283, '20260221-121-283-2-1', '2026-02-21', 25.00, 4.00, 29.00),
(284, '20260221-122-284-3-2', '2026-02-21', 10.00, 1.60, 11.60),
(285, '20260221-123-285-4-2', '2026-02-21', 45.00, 7.20, 52.20),
(286, '20260221-124-286-5-3', '2026-02-21', 4.99, 0.80, 5.79),
(287, '20260221-125-287-6-3', '2026-02-21', 15.00, 2.40, 17.40),
(288, '20260221-126-288-7-3', '2026-02-21', 50.00, 8.00, 58.00),
(289, '20260221-127-289-8-9', '2026-02-21', 30.00, 4.80, 34.80),
(290, '20260221-128-290-9-16', '2026-02-21', 20.00, 3.20, 23.20),
(291, '20260221-129-291-10-20', '2026-02-21', 12.00, 1.92, 13.92),
(292, '20260222-130-292-1-1', '2026-02-22', 5.00, 0.80, 5.80),
(293, '20260222-131-293-2-1', '2026-02-22', 25.00, 4.00, 29.00),
(294, '20260222-132-294-3-2', '2026-02-22', 10.00, 1.60, 11.60),
(295, '20260222-133-295-4-2', '2026-02-22', 45.00, 7.20, 52.20),
(296, '20260222-134-296-5-3', '2026-02-22', 4.99, 0.80, 5.79),
(297, '20260222-135-297-6-3', '2026-02-22', 15.00, 2.40, 17.40),
(298, '20260222-136-298-7-3', '2026-02-22', 50.00, 8.00, 58.00),
(299, '20260222-137-299-8-9', '2026-02-22', 30.00, 4.80, 34.80),
(300, '20260222-138-300-9-16', '2026-02-22', 20.00, 3.20, 23.20),
(301, '20260222-139-301-10-20', '2026-02-22', 12.00, 1.92, 13.92),
(302, '20260223-140-302-1-1', '2026-02-23', 5.00, 0.80, 5.80),
(303, '20260223-141-303-2-1', '2026-02-23', 25.00, 4.00, 29.00),
(304, '20260223-142-304-3-2', '2026-02-23', 10.00, 1.60, 11.60),
(305, '20260223-143-305-4-2', '2026-02-23', 45.00, 7.20, 52.20),
(306, '20260223-144-306-5-3', '2026-02-23', 4.99, 0.80, 5.79),
(307, '20260223-145-307-6-3', '2026-02-23', 15.00, 2.40, 17.40),
(308, '20260223-146-308-7-3', '2026-02-23', 50.00, 8.00, 58.00),
(309, '20260223-147-309-8-9', '2026-02-23', 30.00, 4.80, 34.80),
(310, '20260223-148-310-9-16', '2026-02-23', 20.00, 3.20, 23.20),
(311, '20260223-149-311-10-20', '2026-02-23', 12.00, 1.92, 13.92),
(312, '20260224-150-312-1-1', '2026-02-24', 5.00, 0.80, 5.80),
(313, '20260224-151-313-2-1', '2026-02-24', 25.00, 4.00, 29.00),
(314, '20260224-152-314-3-2', '2026-02-24', 10.00, 1.60, 11.60),
(315, '20260224-153-315-4-2', '2026-02-24', 45.00, 7.20, 52.20),
(316, '20260224-154-316-5-3', '2026-02-24', 4.99, 0.80, 5.79),
(317, '20260224-155-317-6-3', '2026-02-24', 15.00, 2.40, 17.40),
(318, '20260224-156-318-7-3', '2026-02-24', 50.00, 8.00, 58.00),
(319, '20260224-157-319-8-9', '2026-02-24', 30.00, 4.80, 34.80),
(320, '20260224-158-320-9-16', '2026-02-24', 20.00, 3.20, 23.20),
(321, '20260224-159-321-10-20', '2026-02-24', 12.00, 1.92, 13.92);
GO

INSERT INTO Suscripcion (idUsuario, idNivel, fecha_inicio, fecha_renovacion, fecha_fin, estado, precio_pactado) VALUES
-- 50 Suscripciones ACTIVAS (Usuarios 160 al 209)
(160, 1, '2026-02-25', '2026-03-25', NULL, 'Activa', 5.00),
(161, 2, '2026-02-25', '2026-03-25', NULL, 'Activa', 25.00),
(162, 3, '2026-02-25', '2026-03-25', NULL, 'Activa', 10.00),
(163, 4, '2026-02-25', '2026-03-25', NULL, 'Activa', 45.00),
(164, 5, '2026-02-25', '2026-03-25', NULL, 'Activa', 4.99),
(165, 1, '2026-02-25', '2026-03-25', NULL, 'Activa', 5.00),
(166, 2, '2026-02-25', '2026-03-25', NULL, 'Activa', 25.00),
(167, 3, '2026-02-25', '2026-03-25', NULL, 'Activa', 10.00),
(168, 4, '2026-02-25', '2026-03-25', NULL, 'Activa', 45.00),
(169, 5, '2026-02-25', '2026-03-25', NULL, 'Activa', 4.99),
(170, 1, '2026-02-26', '2026-03-26', NULL, 'Activa', 5.00),
(171, 2, '2026-02-26', '2026-03-26', NULL, 'Activa', 25.00),
(172, 3, '2026-02-26', '2026-03-26', NULL, 'Activa', 10.00),
(173, 4, '2026-02-26', '2026-03-26', NULL, 'Activa', 45.00),
(174, 5, '2026-02-26', '2026-03-26', NULL, 'Activa', 4.99),
(175, 1, '2026-02-26', '2026-03-26', NULL, 'Activa', 5.00),
(176, 2, '2026-02-26', '2026-03-26', NULL, 'Activa', 25.00),
(177, 3, '2026-02-26', '2026-03-26', NULL, 'Activa', 10.00),
(178, 4, '2026-02-26', '2026-03-26', NULL, 'Activa', 45.00),
(179, 5, '2026-02-26', '2026-03-26', NULL, 'Activa', 4.99),
(180, 1, '2026-02-27', '2026-03-27', NULL, 'Activa', 5.00),
(181, 2, '2026-02-27', '2026-03-27', NULL, 'Activa', 25.00),
(182, 3, '2026-02-27', '2026-03-27', NULL, 'Activa', 10.00),
(183, 4, '2026-02-27', '2026-03-27', NULL, 'Activa', 45.00),
(184, 5, '2026-02-27', '2026-03-27', NULL, 'Activa', 4.99),
(185, 1, '2026-02-27', '2026-03-27', NULL, 'Activa', 5.00),
(186, 2, '2026-02-27', '2026-03-27', NULL, 'Activa', 25.00),
(187, 3, '2026-02-27', '2026-03-27', NULL, 'Activa', 10.00),
(188, 4, '2026-02-27', '2026-03-27', NULL, 'Activa', 45.00),
(189, 5, '2026-02-27', '2026-03-27', NULL, 'Activa', 4.99),
(190, 1, '2026-02-28', '2026-03-28', NULL, 'Activa', 5.00),
(191, 2, '2026-02-28', '2026-03-28', NULL, 'Activa', 25.00),
(192, 3, '2026-02-28', '2026-03-28', NULL, 'Activa', 10.00),
(193, 4, '2026-02-28', '2026-03-28', NULL, 'Activa', 45.00),
(194, 5, '2026-02-28', '2026-03-28', NULL, 'Activa', 4.99),
(195, 1, '2026-02-28', '2026-03-28', NULL, 'Activa', 5.00),
(196, 2, '2026-02-28', '2026-03-28', NULL, 'Activa', 25.00),
(197, 3, '2026-02-28', '2026-03-28', NULL, 'Activa', 10.00),
(198, 4, '2026-02-28', '2026-03-28', NULL, 'Activa', 45.00),
(199, 5, '2026-02-28', '2026-03-28', NULL, 'Activa', 4.99),
(200, 1, '2026-02-28', '2026-03-28', NULL, 'Activa', 5.00),
(201, 2, '2026-02-28', '2026-03-28', NULL, 'Activa', 25.00),
(202, 3, '2026-02-28', '2026-03-28', NULL, 'Activa', 10.00),
(203, 4, '2026-02-28', '2026-03-28', NULL, 'Activa', 45.00),
(204, 5, '2026-02-28', '2026-03-28', NULL, 'Activa', 4.99),
(205, 1, '2026-02-28', '2026-03-28', NULL, 'Activa', 5.00),
(206, 2, '2026-02-28', '2026-03-28', NULL, 'Activa', 25.00),
(207, 3, '2026-02-28', '2026-03-28', NULL, 'Activa', 10.00),
(208, 4, '2026-02-28', '2026-03-28', NULL, 'Activa', 45.00),
(209, 5, '2026-02-28', '2026-03-28', NULL, 'Activa', 4.99),

-- 50 Suscripciones VENCIDAS (Historial pasado, Usuarios 200 al 249)
(200, 1, '2025-04-01', NULL, '2025-05-01', 'Vencida', 5.00),
(201, 2, '2025-04-01', NULL, '2025-05-01', 'Vencida', 25.00),
(202, 3, '2025-04-01', NULL, '2025-05-01', 'Vencida', 10.00),
(203, 4, '2025-04-01', NULL, '2025-05-01', 'Vencida', 45.00),
(204, 5, '2025-04-01', NULL, '2025-05-01', 'Vencida', 4.99),
(205, 1, '2025-04-05', NULL, '2025-05-05', 'Vencida', 5.00),
(206, 2, '2025-04-05', NULL, '2025-05-05', 'Vencida', 25.00),
(207, 3, '2025-04-05', NULL, '2025-05-05', 'Vencida', 10.00),
(208, 4, '2025-04-05', NULL, '2025-05-05', 'Vencida', 45.00),
(209, 5, '2025-04-05', NULL, '2025-05-05', 'Vencida', 4.99),
(210, 1, '2025-04-10', NULL, '2025-05-10', 'Vencida', 5.00),
(211, 2, '2025-04-10', NULL, '2025-05-10', 'Vencida', 25.00),
(212, 3, '2025-04-10', NULL, '2025-05-10', 'Vencida', 10.00),
(213, 4, '2025-04-10', NULL, '2025-05-10', 'Vencida', 45.00),
(214, 5, '2025-04-10', NULL, '2025-05-10', 'Vencida', 4.99),
(215, 1, '2025-04-15', NULL, '2025-05-15', 'Vencida', 5.00),
(216, 2, '2025-04-15', NULL, '2025-05-15', 'Vencida', 25.00),
(217, 3, '2025-04-15', NULL, '2025-05-15', 'Vencida', 10.00),
(218, 4, '2025-04-15', NULL, '2025-05-15', 'Vencida', 45.00),
(219, 5, '2025-04-15', NULL, '2025-05-15', 'Vencida', 4.99),
(220, 1, '2025-04-20', NULL, '2025-05-20', 'Vencida', 5.00),
(221, 2, '2025-04-20', NULL, '2025-05-20', 'Vencida', 25.00),
(222, 3, '2025-04-20', NULL, '2025-05-20', 'Vencida', 10.00),
(223, 4, '2025-04-20', NULL, '2025-05-20', 'Vencida', 45.00),
(224, 5, '2025-04-20', NULL, '2025-05-20', 'Vencida', 4.99),
(225, 1, '2025-04-25', NULL, '2025-05-25', 'Vencida', 5.00),
(226, 2, '2025-04-25', NULL, '2025-05-25', 'Vencida', 25.00),
(227, 3, '2025-04-25', NULL, '2025-05-25', 'Vencida', 10.00),
(228, 4, '2025-04-25', NULL, '2025-05-25', 'Vencida', 45.00),
(229, 5, '2025-04-25', NULL, '2025-05-25', 'Vencida', 4.99),
(230, 1, '2025-05-01', NULL, '2025-06-01', 'Vencida', 5.00),
(231, 2, '2025-05-01', NULL, '2025-06-01', 'Vencida', 25.00),
(232, 3, '2025-05-01', NULL, '2025-06-01', 'Vencida', 10.00),
(233, 4, '2025-05-01', NULL, '2025-06-01', 'Vencida', 45.00),
(234, 5, '2025-05-01', NULL, '2025-06-01', 'Vencida', 4.99),
(235, 1, '2025-05-05', NULL, '2025-06-05', 'Vencida', 5.00),
(236, 2, '2025-05-05', NULL, '2025-06-05', 'Vencida', 25.00),
(237, 3, '2025-05-05', NULL, '2025-06-05', 'Vencida', 10.00),
(238, 4, '2025-05-05', NULL, '2025-06-05', 'Vencida', 45.00),
(239, 5, '2025-05-05', NULL, '2025-06-05', 'Vencida', 4.99),
(240, 1, '2025-05-10', NULL, '2025-06-10', 'Vencida', 5.00),
(241, 2, '2025-05-10', NULL, '2025-06-10', 'Vencida', 25.00),
(242, 3, '2025-05-10', NULL, '2025-06-10', 'Vencida', 10.00),
(243, 4, '2025-05-10', NULL, '2025-06-10', 'Vencida', 45.00),
(244, 5, '2025-05-10', NULL, '2025-06-10', 'Vencida', 4.99),
(245, 1, '2025-05-15', NULL, '2025-06-15', 'Vencida', 5.00),
(246, 2, '2025-05-15', NULL, '2025-06-15', 'Vencida', 25.00),
(247, 3, '2025-05-15', NULL, '2025-06-15', 'Vencida', 10.00),
(248, 4, '2025-05-15', NULL, '2025-06-15', 'Vencida', 45.00),
(249, 5, '2025-05-15', NULL, '2025-06-15', 'Vencida', 4.99),

-- 29 Suscripciones CANCELADAS (Usuarios 1 al 29)
(1, 1, '2026-02-01', NULL, '2026-02-05', 'Cancelada', 5.00),
(2, 2, '2026-02-01', NULL, '2026-02-06', 'Cancelada', 25.00),
(3, 3, '2026-02-01', NULL, '2026-02-07', 'Cancelada', 10.00),
(4, 4, '2026-02-01', NULL, '2026-02-08', 'Cancelada', 45.00),
(5, 5, '2026-02-01', NULL, '2026-02-09', 'Cancelada', 4.99),
(6, 1, '2026-02-02', NULL, '2026-02-10', 'Cancelada', 5.00),
(7, 2, '2026-02-02', NULL, '2026-02-11', 'Cancelada', 25.00),
(8, 3, '2026-02-02', NULL, '2026-02-12', 'Cancelada', 10.00),
(9, 4, '2026-02-02', NULL, '2026-02-13', 'Cancelada', 45.00),
(10, 5, '2026-02-02', NULL, '2026-02-14', 'Cancelada', 4.99),
(11, 1, '2026-02-03', NULL, '2026-02-15', 'Cancelada', 5.00),
(12, 2, '2026-02-03', NULL, '2026-02-16', 'Cancelada', 25.00),
(13, 3, '2026-02-03', NULL, '2026-02-17', 'Cancelada', 10.00),
(14, 4, '2026-02-03', NULL, '2026-02-18', 'Cancelada', 45.00),
(15, 5, '2026-02-03', NULL, '2026-02-19', 'Cancelada', 4.99),
(16, 1, '2026-02-04', NULL, '2026-02-20', 'Cancelada', 5.00),
(17, 2, '2026-02-04', NULL, '2026-02-21', 'Cancelada', 25.00),
(18, 3, '2026-02-04', NULL, '2026-02-22', 'Cancelada', 10.00),
(19, 4, '2026-02-04', NULL, '2026-02-23', 'Cancelada', 45.00),
(20, 5, '2026-02-04', NULL, '2026-02-24', 'Cancelada', 4.99),
(21, 1, '2026-02-05', NULL, '2026-02-25', 'Cancelada', 5.00),
(22, 2, '2026-02-05', NULL, '2026-02-26', 'Cancelada', 25.00),
(23, 3, '2026-02-05', NULL, '2026-02-27', 'Cancelada', 10.00),
(24, 4, '2026-02-05', NULL, '2026-02-28', 'Cancelada', 45.00),
(25, 5, '2026-02-05', NULL, '2026-03-01', 'Cancelada', 4.99),
(26, 1, '2026-02-06', NULL, '2026-03-02', 'Cancelada', 5.00),
(27, 2, '2026-02-06', NULL, '2026-03-03', 'Cancelada', 25.00),
(28, 3, '2026-02-06', NULL, '2026-03-04', 'Cancelada', 10.00),
(29, 4, '2026-02-06', NULL, '2026-03-05', 'Cancelada', 45.00);
GO

INSERT INTO Factura (idSuscripcion, codigo_transaccion, fecha_emision, sub_total, monto_impuesto, monto_total) VALUES
(372, '20260225-160-372-1-1', '2026-02-25', 5.00, 0.80, 5.80),
(373, '20260225-161-373-2-1', '2026-02-25', 25.00, 4.00, 29.00),
(374, '20260225-162-374-3-2', '2026-02-25', 10.00, 1.60, 11.60),
(375, '20260225-163-375-4-2', '2026-02-25', 45.00, 7.20, 52.20),
(376, '20260225-164-376-5-3', '2026-02-25', 4.99, 0.80, 5.79),
(377, '20260225-165-377-1-1', '2026-02-25', 5.00, 0.80, 5.80),
(378, '20260225-166-378-2-1', '2026-02-25', 25.00, 4.00, 29.00),
(379, '20260225-167-379-3-2', '2026-02-25', 10.00, 1.60, 11.60),
(380, '20260225-168-380-4-2', '2026-02-25', 45.00, 7.20, 52.20),
(381, '20260225-169-381-5-3', '2026-02-25', 4.99, 0.80, 5.79),
(382, '20260226-170-382-1-1', '2026-02-26', 5.00, 0.80, 5.80),
(383, '20260226-171-383-2-1', '2026-02-26', 25.00, 4.00, 29.00),
(384, '20260226-172-384-3-2', '2026-02-26', 10.00, 1.60, 11.60),
(385, '20260226-173-385-4-2', '2026-02-26', 45.00, 7.20, 52.20),
(386, '20260226-174-386-5-3', '2026-02-26', 4.99, 0.80, 5.79),
(387, '20260226-175-387-1-1', '2026-02-26', 5.00, 0.80, 5.80),
(388, '20260226-176-388-2-1', '2026-02-26', 25.00, 4.00, 29.00),
(389, '20260226-177-389-3-2', '2026-02-26', 10.00, 1.60, 11.60),
(390, '20260226-178-390-4-2', '2026-02-26', 45.00, 7.20, 52.20),
(391, '20260226-179-391-5-3', '2026-02-26', 4.99, 0.80, 5.79),
(392, '20260227-180-392-1-1', '2026-02-27', 5.00, 0.80, 5.80),
(393, '20260227-181-393-2-1', '2026-02-27', 25.00, 4.00, 29.00),
(394, '20260227-182-394-3-2', '2026-02-27', 10.00, 1.60, 11.60),
(395, '20260227-183-395-4-2', '2026-02-27', 45.00, 7.20, 52.20),
(396, '20260227-184-396-5-3', '2026-02-27', 4.99, 0.80, 5.79),
(397, '20260227-185-397-1-1', '2026-02-27', 5.00, 0.80, 5.80),
(398, '20260227-186-398-2-1', '2026-02-27', 25.00, 4.00, 29.00),
(399, '20260227-187-399-3-2', '2026-02-27', 10.00, 1.60, 11.60),
(400, '20260227-188-400-4-2', '2026-02-27', 45.00, 7.20, 52.20),
(401, '20260227-189-401-5-3', '2026-02-27', 4.99, 0.80, 5.79),
(402, '20260228-190-402-1-1', '2026-02-28', 5.00, 0.80, 5.80),
(403, '20260228-191-403-2-1', '2026-02-28', 25.00, 4.00, 29.00),
(404, '20260228-192-404-3-2', '2026-02-28', 10.00, 1.60, 11.60),
(405, '20260228-193-405-4-2', '2026-02-28', 45.00, 7.20, 52.20),
(406, '20260228-194-406-5-3', '2026-02-28', 4.99, 0.80, 5.79),
(407, '20260228-195-407-1-1', '2026-02-28', 5.00, 0.80, 5.80),
(408, '20260228-196-408-2-1', '2026-02-28', 25.00, 4.00, 29.00),
(409, '20260228-197-409-3-2', '2026-02-28', 10.00, 1.60, 11.60),
(410, '20260228-198-410-4-2', '2026-02-28', 45.00, 7.20, 52.20),
(411, '20260228-199-411-5-3', '2026-02-28', 4.99, 0.80, 5.79),
(412, '20260228-200-412-1-1', '2026-02-28', 5.00, 0.80, 5.80),
(413, '20260228-201-413-2-1', '2026-02-28', 25.00, 4.00, 29.00),
(414, '20260228-202-414-3-2', '2026-02-28', 10.00, 1.60, 11.60),
(415, '20260228-203-415-4-2', '2026-02-28', 45.00, 7.20, 52.20),
(416, '20260228-204-416-5-3', '2026-02-28', 4.99, 0.80, 5.79),
(417, '20260228-205-417-1-1', '2026-02-28', 5.00, 0.80, 5.80),
(418, '20260228-206-418-2-1', '2026-02-28', 25.00, 4.00, 29.00),
(419, '20260228-207-419-3-2', '2026-02-28', 10.00, 1.60, 11.60),
(420, '20260228-208-420-4-2', '2026-02-28', 45.00, 7.20, 52.20),
(421, '20260228-209-421-5-3', '2026-02-28', 4.99, 0.80, 5.79);
GO