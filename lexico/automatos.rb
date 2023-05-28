def automato(char)

    estados = {
        1=> {"d"=> 5, "-" => 6, "l/L"=> 2,"simb" => 24,"<" => 23, "=" => 22, "+" => 20, "/" => 13, "@" => 17,">" => 22, ":"=> 22},
        2=> {"_/~"=> 4, "l/L/d"=> 3},
        3=> {"l/L/d"=> 3},
        4=> {"l/L/d"=> 3},
        5=> {"d"=> 5, ","=> 7},
        6=> {"d"=> 5, "-" => 9, ">" => 10},
        7=> {"d"=> 8},
        8=> {"d"=> 8},
        10=> {"<" => 11, "Q" => 10},
        11=> {"-" => 12, "Q" => 10},
        13=> {"/"=> 14},
        14=> {"/"=> 15,"Q"=> 14},
        15=> {"Q"=> 14, "/"=> 16},
        17=> {"@"=> 18},
        18=> {"Q"=> 18, "\n" => 19},
        20=> {"+"=> 21},
        23=> {"+"=> 21},
        24=> {"+"=> 21},
    }

    simbolos = [";", ",", ".", "*", "(", ")", "{", "}"]

    case @estado_atual
    when 1
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[1]["d"]
            @token << char
            puts @token
        elsif char == "-"
            @estado_atual = estados[1]["-"]
            @token << char
        elsif char == "+"
            @estado_atual = estados[1]["+"]
            @token << char
        elsif char.match?(/[a-zA-Z]/)
            @estado_atual = estados[1]["l/L"]
            @token << char
        elsif char == "@"
            @estado_atual = estados[1]["@"]
            @token << char
        elsif char == "/"
            @estado_atual = estados[1]["/"]
            @token << char
        elsif char == "-"
            @estado_atual = estados[1]["-"] 
            @token << char
        elsif simbolos.include?(char)
            @estado_atual = estados[1]["simb"] 
            @token << char
        elsif char == ":" 
            @estado_atual = estados[1][":"]  
        elsif char == ">" 
            @estado_atual = estados[1][">"] 
        elsif char == "<" 
            @estado_atual = estados[1]["<"] 
        elsif char == " " or char == "\n" 
            @fim = true
        else
            puts "Linha: #{@linha_atual} - Token não reconhecido" 
            @erro = true
        end
    when 2
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[2]["l/L/d"]
            @token << char 
        elsif char == "_" or char == "~"
            @estado_atual = estados[2]["_/~"]
            @token << char   
        else
            @fim = true
        end
    when 3
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[3]["l/L/d"]
            @token << char
        elsif char == "_" or char == "~"
            puts "Linha: #{@linha_atual} - Identificador não reconhecido" 
            @estado = -1
            @fim = true
            @erro = true
        else 
            @fim = true
        end
    when 4
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[4]["l/L/d"]
            @token << char
        elsif !char.match?(/[a-zA-Z0-9]/)
            @estado_atual = 1
        end
    when 5
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[5]["d"]
            @token << char

        elsif char == ","
            @estado_atual = estados[5][","]
            @token << char
        else
            @fim = true
        end
    when 6
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[6]["d"]
            @token << char
        elsif char == "-"
            @estado_atual = estados[6]["-"]
            @token << char
        elsif char == ">"
            @estado_atual = estados[6][">"]
            @token << char
        else
            @fim = true
        end
    when 7
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[7]["d"]
            @token << char
        else
            @fim = true
        end
    when 8
        if char.match?(/[[:digit:]]/)
            @estado_atual= estados[8]["d"]
            @token << char
        elsif !char.match?(/[[:digit:]]/)
            @fim = true
        end
    when 9
        @fim = true
    when 10
        if char == "<" 
            @estado_atual = estados[10]["<"]
            @token << char
        elsif
            @estado_atual = estados[10]["Q"]
            @token << char
        end
    when 11 
        if char == "-"
            @estado_atual = estados[11]["-"]
            @token << char
        elsif char != "-"
            @estado_atual = estados[11]["Q"]
            @token << char
        end
    when 12
        @fim = true
    when 13
        if char == "/"
            @estado_atual = estados[13]["/"]
            @token << char
        else
            @fim = true
        end   
    when 14
        if char == "/"
            @estado_atual = estados[14]["/"]
            @token << char
        elsif char != "/"
            @estado_atual = estados[14]["Q"]
            @token << char
        end
    when 15
        if char == "/"
            @estado_atual = estados[15]["/"]
            @token << char
        elsif char != "/"
            @estado_atual = estados[15]["Q"]
            @token << char
        end
    when 16 
        @fim = true
    when 17
        if char == "@"
            @estado_atual = estados[17]["@"]
            @token << char
        else
            @fim = true
        end
    when 18
        if char == "\n"
            @estado_atual = estados[18]["\n"]
        elsif char != "\n"
            @estado_atual = estados[18]["Q"]
            @token << char
        end
    when 19
        @fim = true
    when 20
        if char == "+"
            @estado_atual = estados[20]["+"]
            @token << char
        else
            @fim = true
        end
    when 21
        @fim = true
    when 22
        if char == ">"
            @estado_atual = estados[22][">"]
        elsif char == ":"
            @estado_atual = estados[22][":"]
        else
            @fim = true
        end
    when 23
        if char == "="
            @estado_atual = estados[23]["="]
        else
            @fim = true
        end
    when 24
        @fim = true
    end
end

def puts_debug(char, estado_atual)
    puts "Caracter: #{char} estado atual: #{estado_atual}"
end
