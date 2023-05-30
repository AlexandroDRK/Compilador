require_relative "automatos.rb"

class Lexico
  $pr = ["program", "if", "then", "else", "while", "do", "until", "repeat", "int", "double", "char", "case," "switch","end", 'procedure', "function","for", "begin"]

  def initialize(filename)
    file = File.open(filename,"r")
    @input = file.read
    @estado_atual = 1
    @fim = false
    @token = ""
    @erro = false
    @classe = ""
    @linha_atual = 1
  end

  def gerar_token
    @input.chars.each do |i|
      #next if i == " " or i == "\t"
      automato(i)

      if i == "\n"
        @linha_atual += 1
      end

      if @estado_atual == -1 
        @token << i
        testa_estado(@estado_atual)
        print_saida(@classe,@token)
      end 
      
      if @fim == true

        testa_estado(@estado_atual)

        if i == "\n" || i == ' '
          @estado_atual = 1
          @token = ''
          @fim = false
        else
          @estado_atual = 1
          @fim = false
          automato(i)
          @token = i
        end
      end
    end

    if !@token.empty?
      testa_estado(@estado_atual)
      if @classe == "erro"
        print_saida(@classe,@token)
      end
    end
  end

  def testa_estado(estado_atual)
    case estado_atual
    when 2, 3
      verifica_palavra_reservada(@token, $pr)
      print_saida(@classe, @token)
    when 5,8
      @classe= 'dig'
      print_saida(@classe, @token)
    when 6,9,13,17
      @classe= 'simb'
      print_saida(@classe, @token)
    when 14
      @classe= 'comentLinha'
      print_saida(@classe, @token)
    when 20..24
      @classe= 'simb'
      print_saida(@classe, @token)
    when 18, 21
      @classe= 'comentFim'
      print_saida(@classe, @token)
    else 
      @classe= 'erro'
    end
  end

  def verifica_palavra_reservada(token, pr)
    pr.each do |palavra|
      if token == palavra
        @classe = "reser"
        break
      else
        @classe = "ident"
      end
    end
  end

  def print_saida(classe, token)
    case classe
    when "ident"
      puts "Identificador: #{token}"
    when "reser"
      puts "Palavra Reservada: #{token}"
    when "dig"
      puts "Dígito: #{token}"
    when "simb"
      puts "Símbolo Especial: #{token}"
    when "comentLinha"
      puts "Comentário de uma linha: #{token}"
    when "comentInicio"
      puts "Início de Comentário: #{token}"
    when "comentFim"
      puts "Fim de Comentário: #{token}"
    when "erro"
      puts "Linha: #{@linha_atual} - token #{@token} não reconhecido" 
      exit
    end
  end
end

lexer = Lexico.new("fonte.txt")
lexer.gerar_token
