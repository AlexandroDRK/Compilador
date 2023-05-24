require_relative "automatos.rb"

class Lexico
  KEYWORDS = ["def", "class", "if", "else", "end"]

  def initialize(filename)
    file = File.open(filename,"r")
    @input = file.read
    @estado_atual = 1
    @buffer = ""
    @fin_token = 0
  end

  def tokenize
    #@input.chars.each do |i|
    index = 0
    while index < @input.length
      i = @input[index]
      automato_numerico(i)
      automato_identificador(i) 
      if @fin_token == 1
        puts @buffer
        @fin_token = 0
        @buffer = ""
      end
      index += 1
    end
  end
end
  
lexer = Lexico.new("fonte.txt")
lexer.tokenize