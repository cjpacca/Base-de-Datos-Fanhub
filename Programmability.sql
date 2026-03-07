USE FANHUB;
GO

--1. fn_calcular_impuesto(monto): Recibe un monto decimal. Devuelve el impuesto calculado
--   (asumir 16% o el valor que prefieran, pero debe ser parametrizable o constante).
CREATE OR ALTER FUNCTION fn_calcular_impuesto (@monto_v NUMERIC)
RETURNS NUMERIC(10, 2)
AS
BEGIN
    DECLARE @porcentaje_impuesto NUMERIC(10,2);
    SET @porcentaje_impuesto = 0.16;

    RETURN @monto_v * @porcentaje_impuesto;
END;
GO

-- 2. fn_clasificar_ingreso(monto): Devuelve un NVARCHAR. 
--    Lógica: Si el monto > $1000 retorna 'Diamante', entre $500 y $1000 'Oro', y menor a $500 'Plata'.
CREATE OR ALTER FUNCTION fn_clasificar_ingreso (@monto_v NUMERIC)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @clasificacion NVARCHAR(10);

    IF @monto_v > 1000
    BEGIN
        SET @clasificacion = 'Diamante'; 
    END
    ELSE IF @monto_v < 500
    BEGIN
        SET @clasificacion = 'Plata';
    END
    ELSE
    BEGIN
        SET @clasificacion = 'Oro';
    END

    RETURN @clasificacion;
END;
GO

-- 3. fn_calcular_reputacion(idCreador): Devuelve un DECIMAL (0-100).
--    ○ Fórmula sugerida: (Total Suscriptores * 0.5) + (Total Reacciones Último Mes * 0.1) +
--    (Antigüedad Meses * 2). Tope máximo de 100 puntos.
CREATE OR ALTER FUNCTION fn_calcular_reputacion (@idCreador_v INT)
RETURNS NUMERIC(10, 2)
AS
BEGIN
    DECLARE @reputacion NUMERIC(10,2)



    IF @reputacion > 100 
    BEGIN
        RETURN 100.0
    END
    
    ELSE IF @reputacion < 0 
    BEGIN
        RETURN 0.0
    END
    
    ELSE
    BEGIN 
        RETURN @reputacion;
    END
    RETURN 0.0;
END;
GO