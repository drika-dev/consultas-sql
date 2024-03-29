SELECT DISTINCT
    STURMADISC.CODTURMA    AS 'CODTURMA',
    STURMADISC.CODDISC     AS 'CODDISC',
    SOCORRENCIAALUNO.RA AS 'MATRICULA',
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
    STURMADISC.IDTURMADISC AS 'IDTURMADISC',
    CONCAT('Conforme atestado em arquivo, o aluno(a) ', (SELECT PPESSOA.nome FROM PPESSOA JOIN SALUNO S ON S.CODPESSOA = PPESSOA.CODIGO WHERE S.RA = SOCORRENCIAALUNO.RA), ', terá suas faltas justificadas no período de: ', CONVERT(TEXT, SOCORRENCIAALUNO.OBSERVACOES)) AS 'OCORRENCIA'
FROM SOCORRENCIAALUNO (NOLOCK)
    JOIN SPLETIVO(NOLOCK)
    ON SPLETIVO.IDPERLET = SOCORRENCIAALUNO.IDPERLET
        AND SPLETIVO.CODCOLIGADA = SOCORRENCIAALUNO.CODCOLIGADA
    JOIN SPROFESSOR(NOLOCK)
    ON SPROFESSOR.CODCOLIGADA = SOCORRENCIAALUNO.CODCOLIGADA
        AND SPROFESSOR.CODPROF = SOCORRENCIAALUNO.CODPROF
    JOIN PPESSOA(NOLOCK)
    ON PPESSOA.CODIGO = SPROFESSOR.CODPESSOA
    JOIN SMATRICULA(NOLOCK)
    ON SMATRICULA.IDPERLET = SOCORRENCIAALUNO.IDPERLET
        AND SMATRICULA.CODCOLIGADA = SOCORRENCIAALUNO.CODCOLIGADA
    --   AND SMATRICULA.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
    JOIN STURMADISC(NOLOCK)
    ON SOCORRENCIAALUNO.IDTURMADISC = STURMADISC.IDTURMADISC
        AND SOCORRENCIAALUNO.CODCOLIGADA = STURMADISC.CODCOLIGADA
    JOIN SDISCIPLINA(NOLOCK)
    ON SDISCIPLINA.CODDISC = STURMADISC.CODDISC
        AND SDISCIPLINA.CODCOLIGADA = STURMADISC.CODCOLIGADA
    JOIN STURNO(NOLOCK)
    ON STURNO.CODCOLIGADA = STURMADISC.CODCOLIGADA
        AND STURNO.CODTURNO = STURMADISC.CODTURNO
    JOIN SHABILITACAOFILIAL (NOLOCK)
    ON SHABILITACAOFILIAL.CODCOLIGADA = STURMADISC.CODCOLIGADA
        AND SHABILITACAOFILIAL.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
    JOIN SCURSO (NOLOCK)
    ON SHABILITACAOFILIAL.CODCOLIGADA = SCURSO.CODCOLIGADA
        AND SHABILITACAOFILIAL.CODCURSO = SCURSO.CODCURSO
WHERE SOCORRENCIAALUNO.RA = '20-1-15714'
    AND SPLETIVO.CODPERLET = '2022/2'
