entrada = 'aaa3849'


def automato(entrada)
    entrada.each_char do |i|
        case i
        when /\A\d+\z/
                puts "aaa"
        #when 
            
        else
                puts "bbb"
        end
    end
end


automato(entrada)