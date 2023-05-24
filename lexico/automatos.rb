def automato_numerico(char)

    estados = {
        1=> {"d"=> 5, "-" => 6},
        5=> {"d"=> 5, ","=> 7},
        6=> {"d"=> 5},
        7=> {"d"=> 8},
        8=> {"d"=> 8},
    }

    case @estado_atual
    when 1
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[1]["d"]
            @buffer << char
        elsif char == "-"
            @estado_atual = estados[1]["-"]
            @buffer << char
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 1
        end
    when 5
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[5]["d"]
            @buffer << char

        elsif char == ","
            @estado_atual = estados[5][","]
            @buffer << char
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 1
        end
    when 6
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[6]["d"]
            @buffer << char
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 1
        end
    when 7
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[7]["d"]
            @buffer << char
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 1
        end
    when 8
        if char.match?(/[[:digit:]]/)
            @estado_atual= estados[8]["d"]
            @buffer << char
        elsif !char.match?(/[[:digit:]]/)
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 1
        end
    end
end

def automato_identificador(char)
    estados = {
        1=> {"l/L"=> 2},
        2=> {"_/~"=> 4, "l/L/d"=> 3},
        3=> {"l/L/d"=> 3},
        4=> {"l/L/d"=> 3}
    }

    #puts ("caracter:  #{char}")
    #puts ("@estado_atual: #{@estado_atual}")
    case @estado_atual
    when 1
        if char.match?(/[a-zA-Z]/)
            @estado_atual = estados[1]["l/L"]
            @buffer << char
        else
            @estado_atual = 1
            @fin_token = 1
        end
    when 2
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[2]["l/L/d"]
            @buffer << char
        elsif char == "_" or char == "~"
            @estado_atual = estados[2]["_/~"]
            @buffer << char
        else
            @estado_atual = 1
            @fin_token = 1
        end
    when 3
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[3]["l/L/d"]
            @buffer << char
        elsif !char.match?(/[a-zA-Z0-9]/)
            @estado_atual = 1
            @fin_token = 1
        end
    when 4
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[4]["l/L/d"]
            @buffer << char
        elsif !char.match?(/[a-zA-Z0-9]/)
            @estado_atual = 1
            @fin_token = 1
        end
    end
end


def automato_simbolos(entrada)
    estados = {
        1=> {[";", ",", ".", "*", "/", "@", "(", ")", "{", "}"]=> 2, "<" => 5,":"=> 3, ">" => 4, "=" => 6, "+" => 7, "-" => 8},
        3=> {"="=> 6},
        4=> {"="=> 6},
        5=> {[">","="]=> 6},
		  7=> {"+"=> 2},
        8=> {"-"=> 6}
    }

	 estado1 = [";", ",", ".", "*", "/", "@", "(", ")", "{", "}"]
	 estado5 = [">","="]


    @estado_atual = 1

    entrada.chars.each do |i|
        next if i.strip.empty?
        case i
		when *estado1
			if @estado_atual == 1
				@estado_atual = estados[1][estados[1].keys.first]
			else
				@estado_atual = -1
			end
		when /[:]/
			if @estado_atual == 1
				@estado_atual = estados[1][":"]
			else
				@estado_atual = -1
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
				@estado_atual = -1
			end
		when /[>]/
			if @estado_atual == 1
				@estado_atual = estados[1][">"]
			elsif @estado_atual == 5
				@estado_atual = estados[5][estados[5].keys.first]
			else
				@estado_atual = -1
			end
		when /[<]/
			if @estado_atual == 1
				@estado_atual = estados[1]["<"]
			else
				@estado_atual = -1
			end
		when /[+]/
			if @estado_atual == 1
				@estado_atual = estados[1]["+"]
			elsif @estado_atual == 7
				@estado_atual = estados[7]["+"]
			else
				@estado_atual = -1
			end
		when /[-]/
			if @estado_atual == 1
				@estado_atual = estados[1]["-"]
			elsif @estado_atual == 8
				@estado_atual = estados[8]["-"]
			else
				@estado_atual = -1
			end
		else
			break
		end
    end

	estados_finais = [2,3,4,5,6,7,8]
    if estados_finais.include?(@estado_atual)
        puts "Cadeia reconhecida"
    else
        puts "Cadeia não reconhecida"
    end
end

def automato_comentario(entrada)
    estados = {
        1=> {"@"=> 2, "/" => 4, "-" => 8},
        2=> {"@"=> 3},
        3=> {"Q"=> 3, "\n" => 7},
        4=> {"/"=> 5},
        5=> {"/"=> 6, "Q" => 5},
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
            if i == "@"
				@estado_atual = estados[1]["@"]
            elsif i == "/"
				@estado_atual = estados[1]["/"]
            elsif i == "-"
				@estado_atual = estados[1]["-"]
            end
        when 2
            if i == "@"
				@estado_atual = estados[2]["@"]
			elsif
				@estado_atual = 2
            end
        when 3
            if i == "\n"
				@estado_atual = estados[3]["\n"]
                flag_coment = 1
			elsif
				@estado_atual = estados[3]["Q"]
            end
        when 4
            if i == "/"
				@estado_atual = estados[4]["/"]
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
			elsif
				@estado_atual = estados[9]["Q"]
            end
        when 10
            if i == "-"
				@estado_atual = estados[10]["-"]
			elsif
				@estado_atual = estados[10]["Q"]
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

#automato_comentario(entrada)
