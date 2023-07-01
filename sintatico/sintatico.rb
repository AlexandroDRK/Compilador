require_relative "../lexico/lexico.rb"
class Sintatico
  def initialize(lexer)
    @lexer = lexer
  end

  def parse
    token = obter_token
    if valor_token(token) != "program"
      puts "Token #{token} incorreto 1"
    end

    token = obter_token
    if classe_token(token) != "ident"
      puts token
      puts "Token #{token} incorreto 2"
    end

    token = obter_token
    if valor_token(token) != ";"
      puts "Token #{token} incorreto 3"
    end
    bloco()
  end

  def bloco()
    token = obter_token

    if valor_token(token) == "type"
      def_tipos()
    end
    if valor_token(token) == "var"
      def_variaveis()
    end 
    
  end

  def def_tipos()
    token = obter_token

    begin

      if classe_token(token) != "ident"
        puts "Token #{token} incorreto"
      end

      token = obter_token
      if valor_token(token) != "="
        puts "Token #{token} incorreto"
      end

      tipo()

      token = obter_token
      if valor_token(token) != ";"
        puts "Token #{token} incorreto"
      end 
      if !@lexer.last_token
        token = obter_token
      end
    end while not (classe_token(token) != "ident")
    @token = token
  end

  def tipo()
    token = obter_token
    if classe_token(token) != "reser"
      puts "Token #{token} incorreto 2"
    end

    if !["int","boolean","char","double"].include?(valor_token(token))
      puts "Tipo inválido"
    end

  end 

  def def_variaveis
    tipo()
  end

  def obter_token
    token = @lexer.gerar_token
    if token == nil
      exit
    end
    return token
  end

  def valor_token(token)
    return token.keys.first
  end

  def classe_token(token)
    return token.values.first
  end
end



lexer = Lexico.new("fonte.txt")
parser = Sintatico.new(lexer)
parser.parse
