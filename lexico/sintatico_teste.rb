def programa
    token = gerar_token()

    if token.valor != "program"
        puts "ERRO"
    else
        token = gerar_token()
        if token.classe != "ident"
            puts "ERRO"
        else
            token = gerar_token()
            if token.valor != ";"
                puts "ERRO"
            else
                bloco()
            end
        end
    end 
end   

def bloco
    if token.valor == 'type':
        tipo()
    token = gerar_token()
    elsif token.valor == 'var':
        variavel()
    token = gerar_token()
    elsif token.valor == 'procedure':
        procedure()
    token = gerar_token()
    elsif token.valor == 'function':
        function()
    token = gerar_token()
    elsif token.valor == 'begin':
        begin()
    end
end   


def tipo
    if token.valor != "type"
        puts "ERRO"
    else
        loop do
            token = gerar_token()
            break if token.classe != "ident"
        end
    end
end