require_relative "../lexico/lexico.rb"
class Sintatico
  def initialize(lexer)
    @lexer = lexer
    @token = nil 
  end

  def parse
    start_time = Time.now
    programa()
    end_time = Time.now
    puts "Compilado com sucesso."
    elapsed_time = end_time - start_time
    puts "Tempo de execução: #{elapsed_time} segundos"
  end

  # <programa> ➝ program <identificador>; <bloco>
   def programa #OK
      @token = obter_token
      if @token.nil? or valor_token(@token) != "program"
        log_erro(@token,"P01")
      end

      @token = obter_token
      if @token.nil? or classe_token(@token) != "ident"
        log_erro(@token,"P02")
      end

      @token = obter_token
      if @token.nil? or valor_token(@token) != ";"
        log_erro(@token,"P03")
      end
      bloco()
    end
=begin
  <bloco> [<definicao de tipos>] ➝
    [<definicao de variaveis>]
    [<definicao de sub-rotinas>]
    <comando composto>
=end
  def bloco() #OK
    @token = obter_token

    if @token != nil
      if valor_token(@token) == "type"
        def_tipos()
      end

      if @token.nil? or valor_token(@token) == "var"
        def_variaveis()
      end 

      while @token and ["procedure", "function"].include?(valor_token(@token))
        if valor_token(@token) == "procedure"
          def_procedimentos()
        end
        if valor_token(@token) == "function"
          def_funcoes()
        end
        @token = obter_token
        if @token.nil? or valor_token(@token) != ";"
          log_erro(@token,"BL01")
        end
        @token = obter_token
      end 
    end
    comando_composto()
  end

  # <definicao de tipos> ➝ type <identificador> = <tipo> {; <identificador> = <tipo>};
  def def_tipos() #OK
    @token = obter_token

    while true

      if @token.nil? or classe_token(@token) != "ident"
        log_erro(@token,"DT01")
      end

      @token = obter_token
      if @token.nil? or valor_token(@token) != "="
        log_erro(@token,"DT02") 
      end

      if @token.nil? or !tipo()
        log_erro(@token,"T02")
      end

      @token = obter_token
      if @token.nil? or valor_token(@token) != ";"
        log_erro(@token,"DT03")
      end 
      
      @token = obter_token
      if (@token.nil? or classe_token(@token) != "ident")
        break
      end
    end 
  end

  # <tipo> ➝ <identificador> | integer | boolean | double | char
  def tipo() #OK
    @token = obter_token

    return (["integer","boolean","char","double"].include?( valor_token(@token)) or classe_token(@token) == "ident")
  end 

  # 5. <definicao de variaveis> ➝ var <lista de identificadores> : <tipo> {;<lista de identificadores> : <tipo>};
  def def_variaveis #OK

    @token = obter_token
    if @token.nil? or classe_token(@token) != "ident"
      log_erro(@token,"L101")
    end

    while true
      lista_identificadores()
      if @token.nil? or valor_token(@token) != ":"
        log_erro(@token,"VR01")
      end

      if @token.nil? or !tipo()
        log_erro(@token,"T02")
      end

      @token = obter_token
      if @token.nil? or valor_token(@token) != ";"
        log_erro(@token,"B03")
      end 

      @token = obter_token
      break if (@token.nil? or classe_token(@token) != "ident")
    end 
  end

  # 6. <lista de identificadores> <identificador> {, <identificador>} ➝
  def lista_identificadores #OK

    @token = obter_token
    while !@token.nil? and (valor_token(@token) == ",")

      @token = obter_token
      if @token.nil? or classe_token(@token) != "ident"
        log_erro(@token,"L101")
      end
      @token = obter_token
    end
  end

  # 8. <definicao de procedimento> ➝ procedure <identificador> [<parametros formais>] ; <bloco>
  def def_procedimentos #OK
    @token = obter_token
    if @token.nil? or classe_token(@token) != "ident"
      log_erro(@token,"PCDR01")
    end 

    parametros_formais()
    
    if @token.nil? or valor_token(@token) != ";"
      log_erro(@token,"PCDR02")
    end
    bloco()
  end

  # 9. <definição de funcao> ➝ function <identificador> [<parametros formais>] : identificador ; <bloco>
  def def_funcoes #OK
    @token = obter_token
    if @token.nil? or classe_token(@token) != "ident"
      log_erro(@token,"FCN01")
    end 

    parametros_formais()
    
    #@token = obter_token
    if @token.nil? or valor_token(@token) != ":"
      log_erro(@token,"FCN02")
    end

    @token = obter_token
    if @token.nil? or classe_token(@token) != "ident"
      log_erro(@token,"FCN03")
    end

    @token = obter_token
    if @token.nil? or valor_token(@token) != ";"
      log_erro(@token,"FCN04")
    end
    bloco()
  end

  # *10. <parametros formais> ➝ (<lista de identificadores>: <identificador> {; <lista de identificadores>:<identificador>})
  def parametros_formais #OK
    
    @token = obter_token
    if !@token.nil? and valor_token(@token) == "("
      @token = obter_token
      if @token.nil? or classe_token(@token) != "ident"
        log_erro(@token,"PF02")
      end 

      lista_identificadores()

      if @token.nil? or valor_token(@token) != ":"
        log_erro(@token,"PF03")
      end

      @token = obter_token

      if @token.nil? or classe_token(@token) != "ident"
        log_erro(@token,"PF02")
      end

      @token = obter_token
      while !@token.nil? and valor_token(@token) == ";"
        @token = obter_token
        if @token.nil? or classe_token(@token) != "ident"
          log_erro(@token,"PF02")
        end 
        lista_identificadores()
        if @token.nil? or valor_token(@token) != ":"
          log_erro(@token,"PF02")
        end
        @token = obter_token
        if @token.nil? or classe_token(@token) != "ident"
          log_erro(@token,"PF03")
        end
        @token = obter_token
      end
      if @token.nil? or valor_token(@token) != ")"
        log_erro(@token,"PF04")
      end
      @token = obter_token
    end
  end

  # 11. <comando composto> ➝ begin <comando sem rotulo>; {<comando sem rotulo>;} end
  def comando_composto #OK
    if @token.nil? or valor_token(@token) != "begin"
      log_erro(@token,"CC01")
    end

    @token = obter_token

    while true
      comando_sem_rotulo()

      if @token.nil? or valor_token(@token) != ";"
        log_erro(@token,"CC02")
      end 

      @token = obter_token
      break if @token.nil? or valor_token(@token) == "end"
    end
  end
=begin 
  12. <comando sem rotulo> ➝ <atribuicao> 
  |<chamada de procedimento>
  |<comando condicional>
  |<comando repetitivo> 
=end
def comando_sem_rotulo #OK
  if @token.nil?
    log_erro(@token,"CSR01")
  end

  if ["read","write"].include?(valor_token(@token))
    @token = obter_token

    if !@token.nil? and valor_token(@token) != "("
      log_erro(@token,"CSR02")
    end
    chamada_procedimento()
  elsif variavel()
    @token = obter_token
    if !@token.nil? and valor_token(@token) == ":="
      atribuicao()
    elsif !@token.nil? and valor_token(@token) == "("
      chamada_procedimento()
    end  
  elsif valor_token(@token) == "if"
    comando_condicional()
  elsif valor_token(@token) == "while"
    comando_repetitivo()
  else
    log_erro(@token,"CSR02")
  end  
end

  # 13. <atribuicao> ➝ <variavel> := <expressao> 
  def atribuicao #OK
    expressao()
  end

  # 14. <chamada de procedimento> ➝ <identificador> [ (<lista de expressoes>)] 
  def chamada_procedimento #OK
    lista_expressoes()
    if @token.nil? or valor_token(@token) != ")"
      log_erro(@token,"CP01")
    end
    @token = obter_token
  end

  # **15. <comando condicional> ➝ if <expressao> then <comando sem rotulo> [else <comando sem rotulo>]
  def comando_condicional #OK
    expressao()
    if @token.nil? or valor_token(@token) != "then"
      log_erro(@token,"COND01")
    end
    @token = obter_token
    comando_sem_rotulo()
    if @token.nil? or valor_token(@token) == "else"
      @token = obter_token
      comando_sem_rotulo()
    end
  end

  # **16. <comando repetitivo> ➝ while <expressao> do <comando sem rotulo>
  def comando_repetitivo #OK
    expressao()
    #@token = obter_token
    if @token.nil? or valor_token(@token) != "do"
      log_erro(@token,"REP02")
    end
    @token = obter_token
    comando_sem_rotulo()
  end

  # 17. <lista de expressoes> ➝ <expressao> {,<expressao>} 
  def lista_expressoes #OK
    expressao()

    #@token = obter_token
    while !@token.nil? and valor_token(@token) == ","
      expressao()
      #@token = obter_token
    end
  end

  # 18. <expressao> ➝ <expressao simples> [<relacao> <expressao simples>] 
  def expressao #Ok
    expressao_simples()

    if !@token.nil? and relacao()
      expressao_simples()
    end
  end

  # 19. <relacao> ➝ =| <>| < | <= | > | >= 
  def relacao #100%
    return ["=", "<>", "<" , "<=" , ">" , ">="].include?(valor_token(@token))
  end

  # 20. <expressao simples> ➝ [+ | -] <termo> {<operador1> <termo>}
  def expressao_simples #OK
    @token = obter_token
    if !@token.nil? and ["+", "-"].include?(valor_token(@token))  
      @token = obter_token
    end

    termo()

    while !@token.nil? and operador1()
      @token = obter_token
      termo()
    end
  end

  # 21. <termo> ➝ <fator> {<operador2> <fator>} 
  def termo #OK
    fator()
    
    while !@token.nil? and operador2()
      @token = obter_token
      fator()
    end
  end

  # 22. <operador1> ➝ + | - | or 
  def operador1 #OK
    return ["+" , "-" , "or"].include?(valor_token(@token))
  end

  # 23. <operador2> ➝ * | div | and 
  def operador2 #OK
    return ["*", "div" , "and"].include?(valor_token(@token))
  end
=begin 
  24. <fator> ➝ <variavel> 
      |<digito>
      |<chamada de funcao>
      |(<expressao>)
=end

  def fator() #Ok
    if @token.nil?
      log_erro(@token,"FTR01")
    end

    if classe_token(@token) == "ident"
      chamada_funcao()
    elsif !@token.nil? and classe_token(@token) == "digit"
      @token = obter_token
    elsif !@token.nil? and valor_token(@token) == "("
      expressao()
      @token = obter_token
      if @token.nil? or valor_token(@token) != ")"
        log_erro(@token,"FTR01")
      end
    end
  end

  # 25. <variavel> ➝ <identificador> 
  def variavel #200%
    return classe_token(@token) == "ident"
  end

  # 26. <chamada de funcao> ➝ <identificador> [ (<lista de expressoes>)] 
  def chamada_funcao #OK

    @token = obter_token
    if !@token.nil? and valor_token(@token) == "("
      lista_expressoes()
      @token = obter_token
      if !@token.nil? and valor_token(@token) == ")"
        log_erro(@token,"CF01")
      end
      @token = obter_token
    end
  end

  def obter_token #10000000000000000000%
    token = @lexer.gerar_token
    return token
  end

  def valor_token(token)
    return token.keys.first
  end

  def classe_token(token)
    return token.values.first
  end

  def log_erro(token,code_error)
  
    erros = {
      'P01' => "esperado a palavra reservada program.",
      'P02' => "o token deve ser do tipo identificador.",
      'P03' => "esperado um ;",
      'DT01' => "o token deve ser do tipo identificador.",
      'DT02' => "esperado um =",
      'DT03' => "esperado um ;",
      'T01' => "o token deve ser uma palavra reservada.",
      'T02' => "o token deve ser um tipo válido.",
      'PCDR01' => "o nome de uma procedure deve ser do tipo identificador.",
      'PCDR02' => "esperado ;",
      "BL01" => "esperado ;",
      "FCN01" => "o nome de uma procedure deve ser do tipo identificador.",
      "FCN02" => "esperado :",
      "FCN03" => "o token deve ser um identificador",
      "FCN04" => "esperado ;",
      "CP01" => "esperado )",
      'CC01' => "esperado begin.",
      'CC02' => "esperado ;",
      'CC03' => "esperado end",
      "CSR01" => "esperado comando sem rótulo.",
      "CSR02" => "esperado (",
      "COND01" => "esperado then",
      'LI01' => "o token deve ser do tipo identificador.",
      'PF01' => "esperado um (",
      'PF02' => "o token deve ser um indentificador",
      'PF03' => "esperado um :",
      'PF04' => "esperado um )",
      "REP02" => "esperado do",
      "FTR01" => "Fator não pode ser nulo",
      "TRM01" => "Termo não pode ser nulo",
      'R01' => "o token não é um operador relacional.",
      'OPR_101' => "o token não é um operador válido.",
      'OPR_201' => "o token não é um operador válido.",
      'V01' => "o token deve ser do tipo identificador.",
    }

    puts "Erro #{code_error} na linha #{@lexer.linha_atual} - encontrado: [#{valor_token(@token)}] - motivo: #{ erros[code_error]}"
    exit
  end
end

lexer = Lexico.new("./sintatico/fonte.txt")
parser = Sintatico.new(lexer)
parser.parse
