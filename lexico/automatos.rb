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

    entrada.each_char do |i|
        puts estado_a
        case i
        when /[[a-zA-Z]]/
            if estado_a == 1
                estado_a = estados[1]["l/L"]
                
            end 
        when /[a-zA-Z0-9]/
            if estado_a == 2 
                estado_a = estados[2]["l/L/d"]
                 
            elsif estado_a == 3
                estado_a = estados[3]["l/L/d"]
                
            elsif estado_a == 4
                estado_a = estados[4]["l/L/d"]
                 
            end
        when /[_~]/
            if estado_a == 2
                puts estado_a
                estado_a = estados[2]["_/~"]
                
            end  
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

    entrada.each_char do |i|
      puts estado_a
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
automato_numerico(entrada) 
