CREATE PROCEDURE [dbo].[SP_LISTA_PRODUTOS]
AS
BEGIN
	SELECT
		CODIGO,
		DESCRICAO,
		VALOR,
		CATEGORIA,
		IMAGEM
	FROM PRODUTOS		
END