require_relative "automatos.rb"

class Lexico
  KEYWORDS = ["def", "class", "if", "else", "end"]

  def initialize(filename)
    file = File.open(filename,"r")
    @input = file.read
    @estado_atual = 1
    @buffer = ""
    @flag_aut = 0 
  end

  def tokenize
    @input.chars.each do |i|
      #next if i.strip.empty?
      #if i.match?(/[0-9]/)
      if @flag_aut != 1
        automato_numerico(i,@buffer)
      else
      #elsif i.match?(/[a-zA-Z0-9]/) or i.match?(/[_~]/) 
        automato_identificador(i, @buffer)
      end
      #elsif i.match?(/[@\/\-*+=<>]/)
        #@estado_atual = automato_simbolos(i, @estado_atual,@buffer)
     #end
    end

		estados_finais = [2,3,4,5]
		if estados_finais.include?(@estado_atual)
			puts "Cadeia reconhecida"
		else
			puts "Cadeia não reconhecida"
		end
  end

  def limpa_lexema(lexema)
    lexema = ""
  end
end
  
lexer = Lexico.new("fonte.txt")
lexer.tokenize