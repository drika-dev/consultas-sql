SELECT COUNT( DISTINCT SMATRICULA.RA) AS 'MATRICULADOS'
            FROM SMATRICULA
        JOIN STURMADISC
            ON STURMADISC.CODCOLIGADA = SMATRICULA.CODCOLIGADA
            AND STURMADISC.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL
            AND STURMADISC.IDTURMADISC = SMATRICULA.IDTURMADISC
            AND STURMADISC.IDPERLET = SMATRICULA.IDPERLET
        JOIN SHABILITACAOFILIAL
            ON SHABILITACAOFILIAL.CODCOLIGADA = STURMADISC.CODCOLIGADA
            AND SHABILITACAOFILIAL.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
        JOIN SMATRICPL
            ON SMATRICPL.CODCOLIGADA = SMATRICULA.CODCOLIGADA
                AND SMATRICPL.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL
                AND SMATRICPL.RA = SMATRICULA.RA
        WHERE SMATRICULA.IDPERLET = 102
        AND STURMADISC.CODTURMA LIKE 'M%'
        --AND SMATRICULA.CODSTATUS = 14
        AND SHABILITACAOFILIAL.CODCURSO = '03'
        AND SMATRICPL.CODSTATUS IN(18, 20)
        AND STURMADISC.CODTURMA IN ('MED1GDA', 'MED1DDA','MED1BDA', 'MED1ADA')