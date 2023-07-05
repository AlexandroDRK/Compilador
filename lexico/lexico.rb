require_relative "automatos.rb"

class Lexico
  $pr = ["program", "if", "then", "else", "while", "do", "until", "repeat", "int", "double", "char", "boolean", "case","switch","end", "procedure", "function","for", "begin"]

  def initialize(filename)
    @file = File.open(filename,"r")
    @input = @file.read
    @estado_atual = 1
    @fim = false
    @input_index = 0
    @token = ""
    @token_classe = {}
    @classe = ""
    @linha_atual = 1
  end

  def gerar_token
    while @input_index < @input.length
      i = @input[@input_index]
      @input_index += 1
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
        
        if ["\n","\s","\t"].include?(i) 
          @estado_atual = 1
          @token = ''
          @fim = false
        else
          @estado_atual = 1
          @fim = false
          automato(i)
          @token = i
        end

        token_class = @token_classe.clone
        @token_classe.clear
        if @token_analisado == true
          @token_analisado = false
          return token_class
        end
      end
    end

    if !@token.empty?
      testa_estado(@estado_atual)
      if @token_analisado == true
        @token = ''
        return @token_classe
      end
      if @classe == "erro"
        print_saida(@classe,@token)
      end
    end
    nil
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
    when 19
      @classe= 'comentLinha'
      #print_saida(@classe, @token)
    when 20..24
      @classe= 'simb'
      print_saida(@classe, @token)
    when 12,16
      @classe= 'comentFim'
      #print_saida(@classe, @token)
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
      @token_analisado = true
      @token_classe[token] = classe
    when "reser"
      @token_analisado = true
      @token_classe[token] = classe
    when "digit"
      @token_analisado = true
      @token_classe[token] = classe
    when "simb"
      @token_analisado = true
      @token_classe[token] = classe
    when "comentLinha"
      puts "Comentário de uma linha: #{token}"
    when "comentInicio"
      puts "Início de Comentário: #{token}"
    when "comentFim"
      puts "Fim de Comentário: #{token}"
    when "erro"
      if !([10,11,14,15].include?(@estado_atual))
        puts "Linha: #{@linha_atual} - token #{@token} é inválido." 
        exit
      else
        puts "Linha: #{@linha_atual} - comentário sem finalização."
        exit
      end
    end
  end
end