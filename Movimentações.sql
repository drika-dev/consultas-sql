SELECT T.CODCOLIGADA, T.CODTMV, M.NOME, T.STATUSINICIAL, M.GERAMOVAUTOPED, T.RECMODIFIEDBY, T.RECMODIFIEDON, M.RECMODIFIEDBY, M.RECMODIFIEDON
FROM TITMTMV T  
INNER JOIN TTMV M ON M.CODTMV = T.CODTMV AND M.CODCOLIGADA = T.CODCOLIGADA
AND T.CODTMV IN ('1.1.33','1.1.30', '1.1.48', '1.2.30', '1.2.10', '1.2.02','1.2.50', '1.2.69')
AND T.CODCOLIGADA = 1