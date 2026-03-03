USE FANHUB;
GO

-- fn_clasificar_ingreso(monto): Devuelve un NVARCHAR. 
-- Lógica: Si el monto > $1000 retorna 'Diamante', entre $500 y $1000 'Oro', y menor a $500 'Plata'.
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