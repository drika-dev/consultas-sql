SELECT DISTINCT SMATRICPL.CODTURMA,
                SALUNO.RA    AS 'MATRICULA DO ALUNO',
                PPESSOA.NOME AS 'NOME DO ALUNO',
                1            AS 'QUANTIDADE'
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
       JOIN PPESSOA
         ON PPESSOA.CODIGO = BHISTORICO.CODPESSOA
       JOIN SALUNO
         ON PPESSOA.CODIGO = SALUNO.CODPESSOA
       JOIN SMATRICPL
         ON SMATRICPL.CODCOLIGADA = SALUNO.CODCOLIGADA
            AND SMATRICPL.RA = SALUNO.RA
       JOIN SHABILITACAOFILIAL
         ON SHABILITACAOFILIAL.CODCOLIGADA = SMATRICPL.CODCOLIGADA
            AND SHABILITACAOFILIAL.IDHABILITACAOFILIAL = SMATRICPL.IDHABILITACAOFILIAL
       JOIN SCURSO(NOLOCK)
         ON SCURSO.CODCURSO = SHABILITACAOFILIAL.CODCURSO
            AND SCURSO.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA
       JOIN SPLETIVO(NOLOCK)
         ON SPLETIVO.CODCOLIGADA = SMATRICPL.CODCOLIGADA
            AND SPLETIVO.IDPERLET = SMATRICPL.IDPERLET
WHERE  BHISTORICO.CODPROVA = 16
       AND BHISTRESPPROVA.CODRESPOSTA IS NOT NULL
       AND SHABILITACAOFILIAL.CODFILIAL = 01
       AND SHABILITACAOFILIAL.CODCURSO = '01'
       AND SPLETIVO.CODPERLET = '2023/1'
       AND SHABILITACAOFILIAL.CODTIPOCURSO = 01
ORDER  BY 3 
