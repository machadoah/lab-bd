-- ESTUDO DE CASO: JOIN E FUNÇÃO DE GRUPO

-- 1.	Exibir o nome do proprietário e o nome do veiculo;
SELECT p.nm_proprietario, v.nm_veiculo 
FROM proprietario p JOIN veiculo v 
ON (p.cd_cpf_proprietario = v.cd_cpf_proprietario)

-- 2.	Exibir o CPF do proprietário, a marca do veiculo e a data do licenciamento;

        SELECT p.cd_cpf_proprietario, v.nm_marca, l.dt_licenciamento
	FROM PROPRIETARIO p, VEICULO v, LICENCIAMENTO l
	WHERE p.cd_cpf_proprietario = v.cd_cpf_proprietario AND 
l.cd_placa_veiculo = v.cd_placa_veiculo

-- 3.	Exibir a cor do veículo, a placa do veiculo e o valor do licenciamento;

	SELECT v.nm_cor, v.cd_placa_veiculo, l.vl_licenciamento 
         FROM  veiculo v, licenciamento l
         WHERE l.cd_placa_veiculo = v.cd_placa_veiculo

-- 4.	Exibir o nome do proprietário e o valor do licenciamento

	SELECT p.nm_proprietario, l.vl_licenciamento 
         FROM  veiculo v, licenciamento l, proprietário p
        WHERE p.cd_cpf_proprietario = v.cd_cpf_proprietario 
        AND l.cd_placa_veiculo = v.cd_placa_veiculo 

-- 5.	Alterar o anterior para exibir somente quando o valor estiver no intervalo de R$ 500,00 a R$ 600,00.
	
	SELECT p.nm_proprietario, l.vl_licenciamento 
         FROM  veiculo v, licenciamento l, proprietário p
        WHERE p.cd_cpf_proprietario = v.cd_cpf_proprietario 
        AND l.cd_placa_veiculo = v.cd_placa_veiculo 
GROUP BY l.vl_licenciamento BETWEEN 500 AND 600	
