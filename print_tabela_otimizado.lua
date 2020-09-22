--[[Esta função ira detectar quantas meta-tabelas existem dentro da tabela principal]]
function numero_de_tabelas(tabela, tabela_de_formato, funcao_a_ser_repitida)
	local formato = tabela_de_formato
--ele repete em ordem de ter certeza que ele ira ter certeza que a meta-tabela existe e que ela não esta apenas depois do primeiro item.
  for index in ipairs(tabela) do
    -- ira quebrar o loop assim parando no momento que uma meta-tabela não for encontrada
    if type(tabela[index]) ~= type(tabela) then
      table.insert(formato, 0)
    -- assim a função ira se repetir até encontrar um limite chamando a si mesma
    else
			funcao_a_ser_repitida(tabela[index], formato, funcao_a_ser_repitida)
			table.insert(formato, 0)
		end
  end
  -- retorna a quantidade de interaçoes atraves do len de uma tabela que é atualizada toda interação
  return #formato
end

--ira repetir e gerar formato as tabelas e meta-tabelas que tenham meta-tabelas em si mesmas, e caso tenham meta tabelas e conteudo no meio ele ira armazenar o contgeudo e continuar a gerar forma para as meta-tabelas

function loopar(tabela, parte, func_atual)
	local concatenar1 = "["
	local concatenar2 = "]"
	local func = concatenar1
  --ira checar a tabela/meta-tabela atual e navegar por todo seu conteudo
  for item in ipairs(tabela) do
    --checa se é uma meta-tabela ou não, caso não ela salva o valor, caso sim, ela chama a prosima função a ser executada (ela mesma, ou o printar)
    if type(tabela[item]) ~= type(tabela) then
			 func = func .. tabela[item] .. ", "
		else
			func = func .. parte[func_atual](tabela[item],parte ,func_atual + 1) .. ", "
		end
	end
	local func_final = string.sub(func, 1, string.len(func) - 2)
	func = func_final .. concatenar2
	return func
end

--contra o fluxo de interaçoes e quantas vezes essas interaçoes devem acontecer
function print_tabela(tabela_alvo)
	local funcoes = {loopar}
	local funcoes_nessesarias = {}
	local len_da_tabela = numero_de_tabelas(tabela_alvo, {}, numero_de_tabelas)
  --ao checar o numero de meta-tabelas e ele insere uma função para lista de funçoes que devem ser executadas adicionando sempre a printar no final antes de quebrar o loop
    while len_da_tabela > 1 do

				table.insert(funcoes_nessesarias, funcoes[1])

			len_da_tabela = len_da_tabela - 1
		end
	local resposta = loopar(tabela_alvo, funcoes_nessesarias, 1)
	print(resposta)
end
