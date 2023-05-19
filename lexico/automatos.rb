filename = ARGV[0]
file = File.open(filename, "r")
entrada = file.read


def automato_numerico(entrada)

    estados = {
        1=> {"d"=> 2, "-" => 5},
        2=> {"d"=> 2, ","=> 3},
        3=> {"d"=> 4},
        4=> {"d"=> 4},
        5=> {"d"=> 2},
    }

    estado_a = 1

    entrada.each_char do |i|
        next if i.strip.empty?
        case i
        when /[[:digit:]]/
            if estado_a == 1
                estado_a = estados[1]["d"]
                
            elsif estado_a == 2
                estado_a = estados[2]["d"]
                
            elsif estado_a == 3
                estado_a = estados[3]["d"]
                
            elsif estado_a == 4
                estado_a = estados[4]["d"]
                
            elsif estado_a == 5
                estado_a = estados[5]["d"]
                
            else
                estado_a = -1
            end
        when /[-]/
            if estado_a == 1
                estado_a = estados[1]["-"]
                
            else
                estado_a = -1
            end
        when /[,]/
            if estado_a == 2
                estado_a = estados[2][","]
                
            else
                estado_a = -1
            end
        else
            break
        end
		end

		estados_finais = [2,4]
		if estados_finais.include?(estado_a)
			puts "Cadeia reconhecida"
		else
			puts "Cadeia não reconhecida"
		end
    end

def automato_identificador(entrada)
    estados = {
        1=> {"l/L"=> 2},
        2=> {"_/~"=> 4, "l/L/d"=> 3},
        3=> {"l/L/d"=> 3},
        4=> {"l/L/d"=> 3}
    }

    estado_a = 1

    entrada.chars.each do |i|
        next if i.strip.empty?
        case estado_a
        when 1
            if i.match?(/[a-zA-Z]/)
                estado_a = estados[1]["l/L"] 
            end
        when 2
            if i.match?(/[a-zA-Z0-9]/)
                estado_a = estados[2]["l/L/d"]
            elsif i == "_" or i == "~"
                estado_a = estados[2]["_/~"] 
            end 
        when 3
            if i.match?(/[a-zA-Z0-9]/)
                estado_a = estados[3]["l/L/d"]
            elsif !i.match?(/[a-zA-Z0-9]/)
                estado_a = -1
                break
            end 
        when 4
            if i.match?(/[a-zA-Z0-9]/)
                estado_a = estados[4]["l/L/d"]
            elsif !i.match?(/[a-zA-Z0-9]/)
                estado_a = -1
                break
            end
        else
            break 
        end
    end

    estados_finais = [2,3]
    if estados_finais.include?(estado_a)
        puts "Cadeia reconhecida"
    else
        puts "Cadeia não reconhecida"
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


    estado_a = 1

    entrada.chars.each do |i|
        next if i.strip.empty?
        case i
		when *estado1
			if estado_a == 1
				estado_a = estados[1][estados[1].keys.first]
			else
				estado_a = -1
			end
		when /[:]/
			if estado_a == 1
				estado_a = estados[1][":"]
			else
				estado_a = -1
			end
		when /[=]/
			if estado_a == 1
				estado_a = estados[1]["="]
			elsif estado_a == 3
				estado_a = estados[3]["="]
			elsif estado_a == 4
				estado_a = estados[4]["="]
			elsif estado_a == 5
				estado_a = estados[5][estados[5].keys.first]
			elsif estado_a == 7
				estado_a = estados[7]["="]
			elsif estado_a == 8
				estado_a = estados[8]["="]
			else
				estado_a = -1
			end
		when /[>]/
			if estado_a == 1
				estado_a = estados[1][">"]
			elsif estado_a == 5
				estado_a = estados[5][estados[5].keys.first]
			else
				estado_a = -1
			end
		when /[<]/	
			if estado_a == 1
				estado_a = estados[1]["<"]
			else
				estado_a = -1
			end
		when /[+]/
			if estado_a == 1
				estado_a = estados[1]["+"]
			elsif estado_a == 7
				estado_a = estados[7]["+"]
			else
				estado_a = -1
			end
		when /[-]/
			if estado_a == 1
				estado_a = estados[1]["-"]
			elsif estado_a == 8
				estado_a = estados[8]["-"]
			else
				estado_a = -1
			end
		else
			break
		end 
    end 

	estados_finais = [2,3,4,5,6,7,8]
    if estados_finais.include?(estado_a)
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

    estado_a = 1

    entrada.chars.each do |i|
        next if i.strip.empty? && i != "\n"
        printa_char(i,estado_a)
        case estado_a
        when 1
            if i == "@"
				estado_a = estados[1]["@"]
            elsif i == "/"
				estado_a = estados[1]["/"]
            elsif i == "-"
				estado_a = estados[1]["-"]
            end
        when 2
            if i == "@"
				estado_a = estados[2]["@"]
			elsif 
				estado_a = 2
            end
        when 3
            if i == "\n"
				estado_a = estados[3]["\n"]
                flag_coment = 1
			elsif 
				estado_a = estados[3]["Q"]
            end
        when 4
            if i == "/"
				estado_a = estados[4]["/"]
			elsif 
				estado_a = 4
            end
        when 5
            if i == "/"
				estado_a = estados[5]["/"]
			elsif 
				estado_a = estados[5]["Q"]
            end
        when 6
            if i == "/"
				estado_a = estados[6]["/"]
                flag_coment = 1
			elsif 
				estado_a = estados[6]["Q"]
            end
        when 8
            if i == ">"
				estado_a = estados[8][">"]
			elsif 
				estado_a = 8
            end 
        when 9
            if i == "<"
				estado_a = estados[9]["<"]
			elsif 
				estado_a = estados[9]["Q"]
            end 
        when 10
            if i == "-"
				estado_a = estados[10]["-"]
			elsif 
				estado_a = estados[10]["Q"]
                flag_coment = 1
            end
        else
            break
        end     
    end

    estados_finais = [7]
    if estados_finais.include?(estado_a)
        puts "Cadeia reconhecida"
    else
        puts "Cadeia não reconhecida"
    end
end

def printa_char(char,estado)
    puts(estado.to_s << " : " << char)
end

automato_comentario(entrada) 
