filename = ARGV[0]
file = File.open(filename, "r")
entrada = file.read
$token = ""


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
                $token << i
            elsif estado_a == 2
                estado_a = estados[2]["d"]
                $token << i
            elsif estado_a == 3
                estado_a = estados[3]["d"]
                $token << i
            elsif estado_a == 4
                estado_a = estados[4]["d"]
                $token << i
            elsif estado_a == 5
                estado_a = estados[5]["d"]
                $token << i
            else
                estado_a = -1
            end
        when /[-]/
            if estado_a == 1
                estado_a = estados[1]["-"]
                $token << i
            else
                estado_a = -1
            end
        when /[,]/
            if estado_a == 2
                estado_a = estados[2][","]
                $token << i
            else
                estado_a = -1
            end
        else
            break
        end
    end

    if estado_a == 2 or estado_a == 4
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
        when /[[:alpha:]]/
            if estado_a == 1
                estado_a = estados[1]["l/L"]
                $token << i
            else
                estado_a = -1
            end 
        when (/[[:alpha:]]/ || /[[:digit:]]/)
            if estado_a == 2 
                estado_a = estados[2]["l/L/d"]
                $token << i 
            elsif estado_a == 3
                estado_a = estados[3]["l/L/d"]
                $token << i
            elsif estado_a == 4
                estado_a = estados[4]["l/L/d"]
                $token << i 
            else
                estado_a = -1
            end
        when /[_]/ || /[~]/
            if estado_a == 2
                puts estado_a
                estado_a = estados[2]["_/~"]
                $token << i
            else
                estado_a = -1
            end  
        else
            break
        end
    end

    if estado_a == 2 or estado_a == 3
        puts "Cadeia reconhecida"
    else
        puts "Cadeia não reconhecida"
    end
end

def automato_simbolos(entrada):
    estados = {
        1=> {";"=> 2,","=> 2,"."=> 2,"*"=> 2, "/"=> 2, "@"=> 2,"("=> 2, ")"=> 2,"{"=> 2,"}"=> 2,"="=> 6, "+"=> 7, ":"=> 3, ">"=> 4, "<"=> 5, ":"=> 6, "-"=> 8},
        3=> {"="=> 6},
        4=> {"="=> 6},
        5=> {"</="=> 6}, 
        8=> {"-"=> 6},
    }


    entrada.each_char do |i|
        puts estado_a
        case i
        when /[;]/
            if  
end



automato_identificador(entrada) 

puts $token