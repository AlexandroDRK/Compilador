def automato_simbolos(char)
    estados = {
        1=> {[";", ",", ".", "*", "/", "@", "(", ")", "{", "}"]=> 2, , ">" => 4, "=" => 6, "+" => 7, "-" => 8},
        3=> {"="=> 6},
        4=> {"="=> 6},
        5=> {[">","="]=> 6},
    
        8=> {"-"=> 6}
    }

    puts ("caracter:  #{char}")
    puts ("@estado_atual: #{@estado_atual}")

    estado1 = [";", ",", ".", "*", "/", "@", "(", ")", "{", "}"]
    estado5 = [">","="]

    case char
    when *estado1
        
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    when /[:]/
        if @estado_atual == 1
            @estado_atual = estados[1][":"]
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    when /[=]/
        if @estado_atual == 1
            @estado_atual = estados[1]["="]
        elsif @estado_atual == 3
            @estado_atual = estados[3]["="]
        elsif @estado_atual == 4
            @estado_atual = estados[4]["="]
        elsif @estado_atual == 5
            @estado_atual = estados[5][estados[5].keys.first]
        elsif @estado_atual == 7
            @estado_atual = estados[7]["="]
        elsif @estado_atual == 8
            @estado_atual = estados[8]["="]
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    when /[>]/
        if @estado_atual == 1
            @estado_atual = estados[1][">"]
        elsif @estado_atual == 5
            @estado_atual = estados[5][estados[5].keys.first]
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    when /[<]/
       
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    when /[+]/
        
        elsif @estado_atual == 7
            @estado_atual = estados[7]["+"]
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    when /[-]/
        if @estado_atual == 1
            @estado_atual = estados[1]["-"]
        elsif @estado_atual == 8
            @estado_atual = estados[8]["-"]
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 3
        end
    end
end

def automato_comentario(entrada)
    estados = {
        1=> {"@"=> 2, "/" => 4, "-" => 8},
        
        3=> {"Q"=> 3, "\n" => 7},
        4=> {"/"=> 5},
        , "Q" => 5},
        6=> {"/"=> 7, "Q" => 5},
        8=> {">" => 9},
        9=> {"Q" => 9, "<" => 10},
        10=> {"-" => 7, "Q" => 9},
    }

    @estado_atual = 1

    entrada.chars.each do |i|
        next if i.strip.empty? && i != "\n"
        printa_char(i,@estado_atual)
        case @estado_atual
        when 1
            
            end
        when 2
            
			elsif
				@estado_atual = 2
            end
        when 3
            
        when 4
            
			elsif
				@estado_atual = 4
            end
        when 5
            if i == "/"
				@estado_atual = estados[5]["/"]
			elsif
				@estado_atual = estados[5]["Q"]
            end
        when 6
            if i == "/"
				@estado_atual = estados[6]["/"]
                flag_coment = 1
			elsif
				@estado_atual = estados[6]["Q"]
            end
        when 8
            if i == ">"
				@estado_atual = estados[8][">"]
			elsif
				@estado_atual = 8
            end
        when 9
            if i == "<"
				@estado_atual = estados[9]["<"]
			
        when 10
            if i == "-"
				
			
            end
        else
            break
        end
    end

    estados_finais = [7]
    if estados_finais.include?(@estado_atual)
        puts "Cadeia reconhecida"
    else
        puts "Cadeia não reconhecida"
    end
end

def printa_char(char,estado)
    puts(estado.to_s << " : " << char)
end