SELECT 
    nota_id,
    fornecedor,
    for_cnpj,
    transportadora,
    nome_motorista,
    rg_motorista,
    porteiro,
    valor_nota,
    numero_nota,
    data_emissao_nota,
    data_entrada_nota,
    devolvida,
    status_fiscal,
   status_almox,
   codcoligada,
   codfilial,
  data_proc_almox
FROM 
    dbo.notafiscal
where  numero_nota = '33130'
