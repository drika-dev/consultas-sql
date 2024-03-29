SELECT DISTINCT STURMADISC.CODTURMA    AS 'CODTURMA',
                STURMADISC.CODDISC     AS 'CODDISC',
                SDISCIPLINA.NOME       AS 'NOME_DISCIPLINA',
                STURMADISC.CODTURNO    AS 'CODTURNO',
                STURNO.NOME            AS 'TURNO',
                SCURSO.NOME            AS 'NOME CURSO',
                SPLETIVO.CODPERLET     AS 'SEMESTRE',
                CASE
                  WHEN Substring (STURMADISC.CODTURMA, 3, 1) LIKE 'A' THEN 'ALFA'
                  WHEN Substring (STURMADISC.CODTURMA, 3, 1) LIKE 'G' THEN 'GAMA'
                  WHEN Substring (STURMADISC.CODTURMA, 3, 1) LIKE 'B' THEN 'BETA'
                  WHEN Substring (STURMADISC.CODTURMA, 3, 1) LIKE 'D' THEN 'DELTA'
                  ELSE '-'
                END                    AS 'SERIE',
                PPESSOA.NOME           AS 'NOME_PROFESSOR',
                SMATRICULA.RA          AS 'MATRICULA',
                STURMADISC.IDTURMADISC AS 'IDTURMADISC'
FROM   STURMADISC (NOLOCK)
       JOIN SDISCIPLINA(NOLOCK)
         ON SDISCIPLINA.CODDISC = STURMADISC.CODDISC
            AND SDISCIPLINA.CODCOLIGADA = STURMADISC.CODCOLIGADA
       JOIN SHABILITACAOFILIAL (NOLOCK)
         ON SHABILITACAOFILIAL.CODCOLIGADA = STURMADISC.CODCOLIGADA
            AND SHABILITACAOFILIAL.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
       JOIN SCURSO (NOLOCK)
         ON SHABILITACAOFILIAL.CODCOLIGADA = SCURSO.CODCOLIGADA
            AND SHABILITACAOFILIAL.CODCURSO = SCURSO.CODCURSO
       JOIN STURNO(NOLOCK)
         ON STURNO.CODCOLIGADA = STURMADISC.CODCOLIGADA
            AND STURNO.CODTURNO = STURMADISC.CODTURNO
       JOIN SPLETIVO(NOLOCK)
         ON SPLETIVO.IDPERLET = STURMADISC.IDPERLET
            AND SPLETIVO.CODCOLIGADA = STURMADISC.CODCOLIGADA
       JOIN SPROFESSORTURMA(NOLOCK)
         ON SPROFESSORTURMA.CODCOLIGADA = STURMADISC.CODCOLIGADA
            AND SPROFESSORTURMA.IDTURMADISC = STURMADISC.IDTURMADISC
       JOIN SPROFESSOR(NOLOCK)
         ON SPROFESSORTURMA.CODPROF = SPROFESSOR.CODPROF
            AND SPROFESSORTURMA.CODCOLIGADA = SPROFESSOR.CODCOLIGADA
       JOIN PPESSOA(NOLOCK)
         ON PPESSOA.CODIGO = SPROFESSOR.CODPESSOA
       JOIN SMATRICULA(NOLOCK)
         ON SMATRICULA.IDPERLET = STURMADISC.IDPERLET
            AND SMATRICULA.CODCOLIGADA = STURMADISC.CODCOLIGADA
            AND SMATRICULA.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
WHERE  STURMADISC.CODTURMA = 'SIS7ANA'
       AND SPLETIVO.CODPERLET = '2023/2'
       AND STURMADISC.CODFILIAL = 01
       AND SMATRICULA.RA = '20-2-15909' 
