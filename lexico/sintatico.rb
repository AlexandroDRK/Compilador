require_relative "./lexico.rb"
class Sintatico
  def initialize(lexer)
    @lexer = lexer
  end

  def parse
    while token = @lexer.gerar_token
      puts token
    end
  end
end


lexer = Lexico.new("fonte.txt")
parser = Sintatico.new(lexer)
parser.parse
