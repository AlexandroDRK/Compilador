filename = ARGV[0]
file = File.open(filename, "r")
entrada = file.read
$token = ""


def automato_numerico(entrada)
    entrada.each_char do |i|
        case i
        when /[0-9]/
                $token << i
        #when 
            
        else
                puts "Cadeia não reconhecida"
        end
    end
    
end


automato_numerico(entrada) 
puts $token