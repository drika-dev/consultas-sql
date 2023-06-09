SELECT Count(DISTINCT BQUESTAO.CODQUESTAO) AS 'TOTAL-QUESTOES'
FROM   SOBJETOAVALIADO (NOLOCK)
       JOIN BOBJETOAVALIADO (NOLOCK)
         ON SOBJETOAVALIADO.SEQOBJETOAVALIADO = BOBJETOAVALIADO.SEQOBJETOAVALIADO
       JOIN BHISTORICO
         ON BHISTORICO.CODCOLIGADA = SOBJETOAVALIADO.CODCOLIGADA
            AND BHISTORICO.SEQOBJETOAVALIADO = SOBJETOAVALIADO.SEQOBJETOAVALIADO
            AND BHISTORICO.SEQOBJETOAVALIADO = BOBJETOAVALIADO.SEQOBJETOAVALIADO
       JOIN BHISTRESPPROVA (NOLOCK)
         ON BHISTRESPPROVA.CODCOLIGADA = BHISTORICO.CODCOLIGADA
            AND BHISTRESPPROVA.CODPROVA = BHISTORICO.CODPROVA
            AND BHISTRESPPROVA.ID = BHISTORICO.ID
            AND BHISTRESPPROVA.CODAREA = BHISTORICO.CODAREA
            AND BHISTRESPPROVA.CODMATERIA = BHISTORICO.CODMATERIA
            AND BHISTRESPPROVA.CODQUESTAO = BHISTORICO.CODQUESTAO
       JOIN BQUESTAO (NOLOCK)
         ON BHISTORICO.CODCOLIGADA = BQUESTAO.CODCOLIGADA
            AND BHISTORICO.CODAREA = BQUESTAO.CODAREA
            AND BHISTORICO.CODMATERIA = BQUESTAO.CODMATERIA
            AND BHISTORICO.CODQUESTAO = BQUESTAO.CODQUESTAO
WHERE  BHISTORICO.CODPROVA = :CODIGOPROVA1
       AND BHISTRESPPROVA.CODRESPOSTA IS NOT NULL 
