SELECT DISTINCT PFUNC.CHAPA,
    --PPESSOA.NOME,
    convert(varchar,  ABATFUN.DATA, 103) AS 'DATA',
    (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) AS 'BAT_ENTRADA',
    AJORHOR.BATINICIO,
     (SELECT Max(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) AS 'BAT_SAIDA',
    AJORHOR.BATFIM,
    CASE 
        WHEN (SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) 
        BETWEEN (AJORHOR.BATINICIO - APARFUN.CARENCIAATRASOAPOSCOMP) AND  (AJORHOR.BATINICIO + APARFUN.CARENCIAATRASOAPOSCOMP)
            THEN 
                CASE 
                    WHEN (SELECT Max(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) 
                    BETWEEN (AJORHOR.BATFIM - APARFUN.CARENCIAATRASOAPOSCOMP) AND  (AJORHOR.BATFIM + APARFUN.CARENCIAATRASOAPOSCOMP)
                        THEN                         
                            ( (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                            (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)) + AJORHOR.BATINICIO
                        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        --BATIDA DE ENTRADA DA JORNADA E SAIDA DA JORNADA ESTÁ DENTRO DO PRAZO                         
                    WHEN (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) 
                    NOT BETWEEN (AJORHOR.BATINICIO+APARFUN.CARENCIAATRASOAPOSCOMP) AND (AJORHOR.BATINICIO-APARFUN.CARENCIAATRASOAPOSCOMP)
                        THEN 
                            -- ENTRADA DENTRO DO PRAZO E SAIDA FORA DO PRAZO
                           CASE 
                                WHEN (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) > APARFUN.CARENCIAATRASOAPOSCOMP 
                                    THEN 
                                        (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - AJORHOR.BATFIM
                                WHEN (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) < 528-APARFUN.CARENCIAATRASOAPOSCOMP 
                                    THEN 
                                        (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - AJORHOR.BATFIM
                            END
                END
        WHEN (SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)
        NOT BETWEEN (AJORHOR.BATINICIO+APARFUN.CARENCIAATRASOAPOSCOMP) AND (AJORHOR.BATINICIO-APARFUN.CARENCIAATRASOAPOSCOMP)
            THEN 
                 CASE 
                    WHEN (SELECT Max(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) 
                    BETWEEN (AJORHOR.BATFIM - APARFUN.CARENCIAATRASOAPOSCOMP) AND  (AJORHOR.BATFIM + APARFUN.CARENCIAATRASOAPOSCOMP)
                        THEN 
                           -- BATIDA DE ENTRADA DA JORNADA ESTÁ FORA DO PRAZO DE TOLERANCIA E A SAIDA DENTRO DO PRAZO                          
                            CASE 
                                WHEN ( (AJORHOR.BATFIM) - (((SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - APARFUN.CARENCIAATRASOAPOSCOMP) 
                                + ((SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                                (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)))) < 528 THEN 
                                -- VERIFICA SE A JORNADA EXECUTADA É MENOR QUE A JORNADA QUE DEVERIA SER EXECUTADA, SE FOR MENOS IRÁ VERIFICAR SE POSSUI ABONO CADASTRADO PARA O DIA
                                    CASE 
                                        WHEN (SELECT SUM(HORAFIM) - SUM(HORAINICIO) FROM AABONFUN  WHERE CHAPA =ABATFUN.CHAPA AND DATA = ABATFUN.DATA) IS NULL THEN 
                                        -- VERIFICANDO SE O FUNCIONARIO NÃO POSSUI ABONO CADASTRADO NO DIA
                                        ((AJORHOR.BATFIM) - (((SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - APARFUN.CARENCIAATRASOAPOSCOMP) 
                                         + ((SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                                            (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA))))

                                        WHEN (SELECT SUM(HORAFIM) - SUM(HORAINICIO) FROM AABONFUN  WHERE CHAPA =ABATFUN.CHAPA AND DATA = ABATFUN.DATA) IS NOT NULL THEN
                                         -- VERIFICA SE TEM ABONO CADASTRADO PARA O DIA, SE TIVER VERIFICA QUANTOS MINUTOS FORAM ADICIONADOS E ADICIONAM NA JORNADA DE TRABALHO
                                         -- TEVE ABONO ENTÃO SEM HORAS EXTRAS
                                            CASE 
                                                -- CASO A SOMA DAS HORAS TRABALHADAS COM AS HORAS DE ABONO, FOREM MAIOR QUE A JORNADA QUE DEVERIA SER FEITA
                                                -- ENTÃO HORAS EXTRAS DO DIA == 0
                                                WHEN ( (AJORHOR.BATFIM) - (((SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - APARFUN.CARENCIAATRASOAPOSCOMP) 
                                                    + ((SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                                                    (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)))) +  
                                                    (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) >  528 THEN         
                                                00.00
                                                -- CASO A SOMA DAS HORAS TRABALHADAS COM AS HORAS DE ABONO, FOREM MENOR QUE A JORNADA QUE DEVERIA SER FEITA
                                                -- ENTÃO GERA HORAS NEGATIVAS
                                                WHEN ( (AJORHOR.BATFIM) - (((SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - APARFUN.CARENCIAATRASOAPOSCOMP) 
                                                    + ((SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                                                    (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)))) +  
                                                    (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) <  528 THEN    
                                                        ( (AJORHOR.BATFIM) - (((SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - APARFUN.CARENCIAATRASOAPOSCOMP) 
                                                        + ((SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                                                        (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA))) 
                                                        +  (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)) - 528

                                            END
                                    END                              
                                -- VERIFICA SE A JORNADA EXECUTADA É MAIOR QUE A JORNADA QUE DEVERIA TRABALHO.    
                                WHEN ( (AJORHOR.BATFIM) - (((SELECT Min(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - APARFUN.CARENCIAATRASOAPOSCOMP) 
                                + ((SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - 
                                (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)))) > 528 THEN  

                                15                           
                            END
                    WHEN (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) NOT BETWEEN (AJORHOR.BATINICIO + APARFUN.CARENCIAATRASOAPOSCOMP) AND (AJORHOR.BATINICIO-APARFUN.CARENCIAATRASOAPOSCOMP)
                        THEN 
                           -- 'entrada fora do prazo e saida fora do prazo'

                           3
                END
       ELSE
             015
    END AS 'EXTRA',
    CASE 
        WHEN (SELECT SUM(HORAFIM) - SUM(HORAINICIO) FROM AABONFUN  WHERE CHAPA = ABATFUN.CHAPA AND DATA = ABATFUN.DATA) IS NULL
            THEN 0.00
        WHEN (SELECT SUM(HORAFIM) - SUM(HORAINICIO) FROM AABONFUN  WHERE CHAPA = ABATFUN.CHAPA AND DATA = ABATFUN.DATA) IS NOT NULL
            THEN (SELECT SUM(HORAFIM) - SUM(HORAINICIO) FROM AABONFUN  WHERE CHAPA = ABATFUN.CHAPA AND DATA = ABATFUN.DATA)  
    END AS 'ABONO_DIARIO'
    /*,
    (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) AS 'BAT_INTERVALO_S',
    (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) AS 'BAT_INTERVALO_E',
     (SELECT Max(BATIDA) FROM ABATFUN A WHERE A.NATUREZA = 0 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA) - (SELECT Min(BATIDA) FROM ABATFUN A  WHERE A.NATUREZA = 1 AND A.CHAPA = ABATFUN.CHAPA AND A.DATA = ABATFUN.DATA)
*/FROM ABATFUN
    RIGHT JOIN PFUNC
        ON PFUNC.CHAPA = ABATFUN.CHAPA
    JOIN PPESSOA
        ON PPESSOA.CODIGO = PFUNC.CODPESSOA
    JOIN AJORHOR
        ON AJORHOR.CODHORARIO = PFUNC.CODHORARIO
    JOIN APARFUN    
        ON APARFUN.CODCOLIGADA = ABATFUN.CODCOLIGADA
            AND APARFUN.CHAPA = ABATFUN.CHAPA
WHERE  PFUNC.CHAPA = '700019'
    AND ABATFUN.DATA BETWEEN '2023/03/06' AND '2023/03/10'
