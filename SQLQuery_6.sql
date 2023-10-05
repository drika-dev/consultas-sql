SELECT DISTINCT SBOLSAALUNO.RA
FROM SBOLSAALUNO
LEFT JOIN SCONCESSAOBOLSA ON SBOLSAALUNO.CODCOLIGADA = SCONCESSAOBOLSA.CODCOLIGADA
    AND SBOLSAALUNO.CODBOLSA = SCONCESSAOBOLSA.CODBOLSA
    AND SBOLSAALUNO.RA = SCONCESSAOBOLSA.RA
WHERE SCONCESSAOBOLSA.RA IS NULL
    AND SBOLSAALUNO.IDPERLET = 102
    AND SBOLSAALUNO.RA IS NOT NULL
    AND SBOLSAALUNO.RA NOT IN (
        SELECT RA
        FROM SCONCESSAOBOLSA
    );