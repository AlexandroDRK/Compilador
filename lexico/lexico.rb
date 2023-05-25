require_relative "automatos.rb"

class Lexico
  KEYWORDS = ["def", "class", "if", "else", "end"]

  def initialize(filename)
    file = File.open(filename,"r")
    @input = file.read
    @estado_atual = 1
    @buffer = ""
    @fin_token = 0
    @estados_finais = [3,5,7,8,24]
    puts @lock_aut
    @lock_aut = 0
  end

  def tokenize
    #@input.chars.each do |i|
    index = 0
    while index < @input.length
      i = @input[index]
      automato(i)

      if @fin_token == 1
        if @estados_finais.include?(@estado_atual)
          puts @buffer
          @fin_token = 0
          @buffer = ""
        end
      end
      index += 1
    end
  end
end

lexer = Lexico.new("fonte.txt")
lexer.tokenize
