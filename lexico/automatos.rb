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
        15=> {"Q"=> 14, "/"=> 15},
        17=> {"@"=> 18},
        18=> {"Q"=> 18, "\n" => 19},
        20=> {"+"=> 21},
        23=> {"+"=> 21},
        24=> {"+"=> 21},
    }

    simbolos = [";", ",", ".", "*", "/", "@", "(", ")", "{", "}"]

    case @estado_atual
    when 1
        if char.match?(/[[:digit:]]/)
            @estado_atual = estados[1]["d"]
            @buffer << char
        elsif char == "-"
            @estado_atual = estados[1]["-"]
            @buffer << char
        elsif char == "+"
            @estado_atual = estados[1]["+"]
            @buffer << char
        elsif char.match?(/[a-zA-Z]/)
            @estado_atual = estados[1]["l/L"]
            @buffer << char
        elsif char == "@"
            @estado_atual = estados[1]["@"]
        elsif char == "/"
            @estado_atual = estados[1]["/"]
        elsif char == "-"
            @estado_atual = estados[1]["-"] 
        elsif char in simbolos
            @estado_atual = estados[1]["simb"] 
        elsif char == ":" 
            @estado_atual = estados[1][":"]  
        elsif char == ">" 
            @estado_atual = estados[1][">"] 
        elsif char == "<" 
            @estado_atual = estados[1]["<"] 
        else
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 1
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
            @lock_aut = 2
        end
    when 3
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[3]["l/L/d"]
            @buffer << char
        elsif !char.match?(/[a-zA-Z0-9]/)
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 2
        end
    when 4
        if char.match?(/[a-zA-Z0-9]/)
            @estado_atual = estados[4]["l/L/d"]
            @buffer << char
        elsif !char.match?(/[a-zA-Z0-9]/)
            @estado_atual = 1
            @fin_token = 1
            @lock_aut = 2
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
    when 10
        if char == "<" 
            @estado_atual = estados[10]["<"]
        elsif
            @estado_atual = estados[10]["Q"]
        end
    when 11 
        if char == "-"
            @estado_atual = estados[11]["-"]
        elsif char != "-"
            @estado_atual = estados[11]["Q"]
        end
    when 13
        if char == "/"
            @estado_atual = estados[13]["/"] 
        end   
    when 14
        if char == "/"
            @estado_atual = estados[14]["/"]
        elsif char != "/"
            @estado_atual = estados[14]["Q"]
        end
    when 15
        if char == "/"
            @estado_atual = estados[15]["/"]
        elsif char != "/"
            @estado_atual = estados[15]["Q"]
        end
    when 17
        if char == "@"
            @estado_atual = estados[17]["@"]
        end
    when 18
        if char == "\n"
            @estado_atual = estados[18]["\n"]
            flag_coment = 1
        elsif char != "\n"
            @estado_atual = estados[18]["Q"]
        end
    when 20
        if char == "+"
            @estado_atual = estados[20]["+"]
        end
    when 22
        if char == ">"
            @estado_atual = estados[22][">"]
        elsif char == ":"
            @estado_atual = estados[22][":"]
        end
    when 23
        if char == "="
            @estado_atual = estados[23]["="]
        end
    else
        @estado_atual = 1
        @lock_aut = 1
    end
end
