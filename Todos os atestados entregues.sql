SELECT 
PFUNC.CHAPA
,PPESSOA.NOME
,VTIPOATESTADO.NOMETPATESTADO
,CONVERT(VARCHAR,VATESTADO.DTINICIO,103) AS INICIO_ATESTADO
,(RIGHT('0' + Cast (Floor(COALESCE (VATESTADO.HORAINICIO, 0) / 60) AS VARCHAR (8)), 2) + ':' + RIGHT('0' + Cast (Floor(COALESCE (VATESTADO.HORAINICIO, 0) % 60) AS VARCHAR (2)), 2)) as HORAINICIO
,CONVERT(VARCHAR,VATESTADO.DTFINAL,103) AS FINAL_ATESTADO
,(RIGHT('0' + Cast (Floor(COALESCE (VATESTADO.HORAFINAL, 0) / 60) AS VARCHAR (8)), 2) + ':' + RIGHT('0' + Cast (Floor(COALESCE (VATESTADO.HORAFINAL, 0) % 60) AS VARCHAR (2)), 2)) as HORAFINAL
,VATESTADO.CID	
,PSECAO.DESCRICAO       


FROM
PFUNC
	JOIN PPESSOA ON PFUNC.CODPESSOA = PPESSOA.CODIGO
	JOIN VATESTADO ON PPESSOA.CODIGO = VATESTADO.CODPESSOA
	JOIN VTIPOATESTADO ON VATESTADO.CODTPATESTADO = VTIPOATESTADO.CODTPATESTADO
    JOIN PSECAO ON PSECAO.CODIGO = PFUNC.CODSECAO
ORDER BY PFUNC.NOME