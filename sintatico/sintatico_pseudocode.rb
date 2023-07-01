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

def tipos
    if token.valor != "type"
        puts "ERRO"
    else
        token = gerar_token()
        if token.classe != "ident"
            puts "ERRO"
        else
            token = gerar_token() 
            if token.valor != '=':
                puts "ERRO"
            else  
                token = gerar_token() 
                tipo()
            end
        end
    end         
end

def tipo
    
        token = gerar_token()
        if token.classe != "ident"
            puts "ERRO"
        else
            
    end
end


loop do
    token = gerar_token()
    break if token.classe != "ident"
end

def relacao
    case token.valor
    when "="
    when "<>"
    when "<"
    when "<="
    when ">"
    when ">="   
    end
end

def operador_1
    case token.valor
    when "+"
    when "-"
    when "or"
    end
end

def operador_2
    case token.valor
    when "*"
    when "div"
    when "and"
    end
end

def variavel
    if != token.classe = "ident":
        puts "Erro"
    else
        #
    end
end