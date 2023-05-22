require_relative "automatos.rb"

class Lexico
  KEYWORDS = ["def", "class", "if", "else", "end"]

  def initialize(filename)
    @file = File.open(filename,"r")
    @input = @file.read
    @tokens = []
    @estado_atual = 1
    @buffer = ""
  end

  def tokenize
    @input.chars.each do |i|
      next if i.strip.empty?
      if i.match?(/[0-9]/)
        @estado_atual = automato_numerico(i, @estado_atual,@buffer)
      elsif i.match?(/[a-zA-Z0-9]/) or i.match?(/[_~]/) 
        @estado_atual = automato_identificador(i, @estado_atual,@buffer)
      elsif i.match?(/[@\/\-*+=<>]/)
        @estado_atual = automato_simbolos(i, @estado_atual,@buffer)
      end
    end

		estados_finais = [2,4,3]
		if estados_finais.include?(@estado_atual)
			puts "Cadeia reconhecida"
		else
			puts "Cadeia não reconhecida"
		end
  end
end
  
lexer = Lexico.new("fonte.txt")
p lexer.tokenize