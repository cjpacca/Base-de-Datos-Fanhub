USE master;
GO

-- 1. Cerrar conexiones y borrar la base de datos si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'FANHUB')
BEGIN
    ALTER DATABASE FANHUB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FANHUB;
END
GO

-- 2. Crear la base de datos desde cero
CREATE DATABASE FANHUB;
GO

USE FANHUB;
GO

-- AQUÍ DEBES PEGAR TU DDL (CREATE TABLE...)
-- LUEGO TUS INSERTS

CREATE TABLE Usuario (
	id int IDENTITY(1,1) PRIMARY KEY,
	email varchar(320) NOT NULL,
	password_hash varchar(32) NOT NULL,
	nickname varchar(20) NOT NULL,
	fecha_registro DATE NOT NULL,
	fecha_nacimiento DATE NOT NULL CHECK(fecha_nacimiento <= DATEADD(year, -13, GETDATE())),
	pais varchar(56) NOT NULL,
	esta_activo BIT NOT NULL
);

CREATE TABLE Categoria (
	id int IDENTITY(1,1) PRIMARY KEY,
	nombre varchar(30) NOT NULL,
	descripcion varchar(160) NOT NULL
);

CREATE TABLE Creador (
	idUsuario int PRIMARY KEY FOREIGN KEY REFERENCES Usuario(id) ON DELETE CASCADE,
	biografia varchar(160),
	banco_nombre varchar(50) NOT NULL,
	banco_cuenta varchar(30) NOT NULL,
	es_nsfw BIT NOT NULL,
	idCategoria int NOT NULL FOREIGN KEY REFERENCES Categoria(id)
);

CREATE TABLE MetodoPago (
	id int IDENTITY(1,1) NOT NULL,
	idUsuario int NOT NULL FOREIGN KEY REFERENCES Usuario(id),
	ultimos_4_digitos varchar(4) NOT NULL,
	marca varchar(32) NOT NULL,
	titular varchar(64) NOT NULL,
	fecha_expiracion DATE NOT NULL,
	es_predeterminado BIT NOT NULL
	CONSTRAINT PK_MetodoPago PRIMARY KEY (id, idUsuario)
);

CREATE TABLE NivelSuscripcion (
	id int IDENTITY(1,1) PRIMARY KEY,
	idCreador int NOT NULL FOREIGN KEY REFERENCES Creador(idUsuario) ON DELETE CASCADE,
	nombre varchar(32) NOT NULL,
	descripcion varchar(160) NOT NULL,
	precio_actual NUMERIC(10, 2) NOT NULL CHECK(precio_actual > 0),
	esta_activo BIT NOT NULL,
	orden SMALLINT NOT NULL
);

CREATE TABLE Suscripcion (
	id int IDENTITY(1,1) PRIMARY KEY,
	idUsuario int NOT NULL FOREIGN KEY REFERENCES Usuario(id),
	idNivel int NOT NULL FOREIGN KEY REFERENCES NivelSuscripcion(id),
	fecha_inicio DATE NOT NULL,
	fecha_renovacion DATE,
	fecha_fin DATE,
	estado varchar(9) NOT NULL CHECK(estado IN('Activa', 'Cancelada', 'Vencida')),
	precio_pactado NUMERIC(10,2) NOT NULL CHECK(precio_pactado > 0)
);

CREATE TABLE Factura (
	id int IDENTITY(1,1) PRIMARY KEY,
	idSuscripcion int NOT NULL FOREIGN KEY REFERENCES Suscripcion(id),
	codigo_transaccion varchar(12) NOT NULL,
	fecha_emision DATE NOT NULL,
	sub_total NUMERIC(10, 2) NOT NULL CHECK(sub_total > 0),
	monto_impuesto NUMERIC(10,2) NOT NULL CHECK(monto_impuesto > 0),
	monto_total NUMERIC(10,2) NOT NULL CHECK(monto_total > 0)
);

CREATE TABLE Publicacion (
	id int IDENTITY(1,1) PRIMARY KEY,
	idCreador int NOT NULL FOREIGN KEY REFERENCES Creador(idUsuario),
	titulo varchar(30) NOT NULL,
	es_publica BIT NOT NULL,
	tipo_contenido varchar(6) NOT NULL CHECK(tipo_contenido IN('VIDEO', 'TEXTO', 'IMAGEN'))
);

CREATE TABLE Video (
	idPublicacion int PRIMARY KEY FOREIGN KEY REFERENCES Publicacion(id) ON DELETE CASCADE,
	duracion_seg int NOT NULL,
	resolucion varchar(9) NOT NULL CHECK(resolucion IN ('720p', '1080p', '4k')),
	url_stream varchar(128) NOT NULL
);

CREATE TABLE Texto (
	idPublicacion int PRIMARY KEY FOREIGN KEY REFERENCES Publicacion(id) ON DELETE CASCADE,
	contenido_html varchar(500) NOT NULL,
	resumen_gratuito varchar(120)
);

CREATE TABLE Imagen (
	idPublicacion int PRIMARY KEY FOREIGN KEY REFERENCES Publicacion(id) ON DELETE CASCADE,
	ancho SMALLINT NOT NULL,
	alto SMALLINT NOT NULL,
	formato varchar(3) NOT NULL,
	alt_text varchar(64),
	url_imagen varchar(124) NOT NULL
);

CREATE TABLE Comentario (
	id int IDENTITY(1,1) PRIMARY KEY,
	idUsuario int FOREIGN KEY REFERENCES Usuario(id) NOT NULL,
	idPublicacion int NOT NULL FOREIGN KEY REFERENCES Publicacion(id) ON DELETE CASCADE,
	idComentarioPadre int FOREIGN KEY REFERENCES Comentario(id),
	texto varchar(500) NOT NULL,
	fecha DATE NOT NULL
);

CREATE TABLE TipoReaccion (
	id int IDENTITY(1,1) PRIMARY KEY,
	nombre varchar(20) NOT NULL,
	emoji_code varchar(16) NOT NULL
);

CREATE TABLE UsuarioReaccionPublicacion (
	idUsuario int FOREIGN KEY REFERENCES Usuario(id),
	idPublicacion int FOREIGN KEY REFERENCES Publicacion(id),
	idTipoReaccion int NOT NULL FOREIGN KEY REFERENCES TipoReaccion(id),
	fecha_reaccion DATE NOT NULL,
	CONSTRAINT PK_UsuarioReaccionPublicacion PRIMARY KEY (idUsuario, idPublicacion)
);

CREATE TABLE Etiqueta (
	id int IDENTITY(1,1) PRIMARY KEY,
	nombre varchar(32) NOT NULL
);

CREATE TABLE PublicacionEtiqueta(
	idPublicacion int FOREIGN KEY REFERENCES Publicacion(id) ON DELETE CASCADE, 
	idEtiqueta int FOREIGN KEY REFERENCES Etiqueta(id),
	CONSTRAINT PK_PublicacionEtiqueta PRIMARY KEY (idPublicacion, idEtiqueta)
);