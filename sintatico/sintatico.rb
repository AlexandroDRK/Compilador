require_relative "../lexico/lexico.rb"
class Sintatico
  def initialize(lexer)
    @lexer = lexer
    @token = nil 
  end

  def parse
    programa()
    puts "Compilado com sucesso."
  end

  # <programa> ➝ program <identificador>; <bloco>
   def programa
      @token = obter_token
      if valor_token(@token) != "program"
        log_erro(@token,"P01")
      end

      @token = obter_token
      if classe_token(@token) != "ident"
        log_erro(@token,"P02")
      end

      @token = obter_token
      if valor_token(@token) != ";"
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
  def bloco()
    @token = obter_token

    if valor_token(@token) == "type"
      def_tipos()
    end
    if valor_token(@token) == "var"
      def_variaveis()
    end 

    while @token and ["procedure", "function"].include?(valor_token(@token))
      if valor_token(@token) == "procedure"
        def_procedimentos()
      end
      if valor_token(@token) == "function"
        def_funcoes()
      end
    end 
    #procedimento_composto()
  end

  # <definicao de tipos> ➝ type <identificador> = <tipo> {; <identificador> = <tipo>};
  def def_tipos()
    @token = obter_token

    begin

      if classe_token(@token) != "ident"
        log_erro(@token,"B01")
      end

      @token = obter_token
      if valor_token(@token) != "="
        log_erro(@token,"B02") 
      end

      tipo()

      @token = obter_token
      if valor_token(@token) != ";"
        log_erro(@token,"B03")
      end 
      
      @token = obter_token
      
    end while not (classe_token(@token) != "ident")
    @token = @token
  end

  # <tipo> <identificador> | ➝ integer | boolean | double | char
  def tipo()
    @token = obter_token
    if classe_token(@token) != "reser"
      log_erro(@token,"T01")
    end

    if !["int","boolean","char","double"].include?(valor_token(@token))
      log_erro(@token,"T02")
    end
  end 

  # 5. <definicao de variaveis> ➝ var <lista de identificadores> : <tipo> {;<lista de identificadores> : <tipo>};
  def def_variaveis
    begin
      lista_identificadores()
      if valor_token(@token) != ":"
        log_erro(@token,"VR01")
      end
      tipo()
      @token = obter_token
      if valor_token(@token) != ";"
        log_erro(@token,"B03")
      end 
    end while (classe_token(@token) != "ident")
  end

  # 6. <lista de identificadores> <identificador> {, <identificador>} ➝
  def lista_identificadores

    begin
      @token = obter_token
    end while not (classe_token(@token) != "ident")
  end

  # 8. <definicao de procedimento> ➝ procedure <identificador> [<parametros formais>] ; <bloco>
  def def_procedimentos
    @token = obter_token
    if valor_token(@token) != "procedure"
      log_erro(@token,"PCDR01")
    end 

    @token = obter_token
    if classe_token(@token) != "ident"
      log_erro(@token,"PCDR02")
    end 

    parametros_formais()
    
    @token = obter_token
    if valor_token(@token) != ";"
      log_erro(@token,"PF03")
    end
    bloco()
  end

  # 9. <definição de funcao> ➝ function <identificador> [<parametros formais>] : identificador ; <bloco>
  def def_funcoes

    @token = obter_token
    if classe_token(@token) != "ident"
      log_erro(@token,"FNC02")
    end 

    parametros_formais()

    @token = obter_token
    if valor_token(@token) != ":"
      log_erro(@token,"FNC03")
    end

    @token = obter_token
    if classe_token(@token) != "ident"
      log_erro(@token,"FNC04")
    end
    
    @token = obter_token
    if valor_token(@token) != ";"
      log_erro(@token,"FNC05")
    end

    bloco()
  end

  # *10. <parametros formais> ➝ (<lista de identificadores>: <identificador> {; <lista de identificadores>:<identificador>})
  def parametros_formais
    
    @token = obter_token
    if valor_token(@token) != "("
      log_erro(@token,"PF01")
    end

    lista_identificadores()

    if valor_token(@token) != ":"
      log_erro(@token,"PF02")
    end

    @token = obter_token
    if classe_token(@token) != "ident"
      log_erro(@token,"PF03")
    end

    @token = obter_token
    # if valor_token(@token) != ";"
    #   log_erro(@token,"PF03")
    # end 
    while valor_token(@token) == ";"
      @token = obter_token
      lista_identificadores()

      @token = obter_token
      if valor_token(@token) != ":"
        log_erro(@token,"PF02")
      end
  
      @token = obter_token
      if classe_token(@token) != "ident"
        log_erro(@token,"PF03")
      end

      @token = obter_token
      break if valor_token(@token) != ";"
    end

    if valor_token(@token) != ")"
      log_erro(@token,"PF04")
    end
  end

  # 11. <comando composto> ➝ begin <comando sem rotulo>; {<comando sem rotulo>;} end
  def comando_composto
    @token = obter_token
    if valor_token(@token) != "begin"
      log_erro(@token,"CC01")
    end

    @token = obter_token

    while comando_sem_rotulo()

      @token = obter_token
      if valor_token(@token) != ";"
        log_erro(@token,"CC02")
      end 

      @token = obter_token

      break if valor_token(@token) == "end"
    end
  end
=begin 
  12. <comando sem rotulo> ➝ <atribuicao> 
  |<chamada de procedimento>
  |<comando condicional>
  |<comando repetitivo> 
=end
  def comando_sem_rotulo
    if variavel()
      @token = obter_token
      if valor_token(@token) == ":="
        atribuicao()
      elsif valor_token(@token) == "("
        chamada_procedimento()
      end 
    end   

    @token = obter_token
    if valor_token(@token) == "if"
     comando_condicional()
    elsif valor_token(@token) == "while"
      comando_repetitivo()
    end
  end    

  # 13. <atribuicao> ➝ <variavel> := <expressao> 
  def atribuicao
    expressao()
  end

  # 14. <chamada de procedimento> ➝ <identificador> [ (<lista de expressoes>)] 
  def chamada_procedimento
    if classe_token(@token) != "ident"
      log_erro(@token,"CF01")
    end

    @token = obter_token
    if valor_token(@token) == "("
      while true
        lista_expressoes()
        @token = obter_token
        break if valor_token(@token) == ")"
      end
    end
  end

  # **15. <comando condicional> ➝ if <expressao> then <comando sem rotulo> [else <comando sem rotulo>]
  def comando_condicional
    expressao()
    @token = obter_token
    if valor_token(@token) != "then"
      log_erro(@token,"COND02")
    end
    @token = obter_token
    comando_sem_rotulo()
    if valor_token(@token) == "else"
      log_erro(@token,"COND02")
    end
  end

  # **16. <comando repetitivo> ➝ while <expressao> do <comando sem rotulo>
  def comando_repetitivo
    expressao()
    @token = obter_token
    if valor_token(@token) != "do"
      log_erro(@token,"REP02")
    end
    comando_sem_rotulo()
  end

  # 17. <lista de expressoes> ➝ <expressao> {,<expressao>} 
  def lista_expressoes
    expressao()

    @token = obter_token
    while valor_token(@token) == ","
      expressao()
      @token = obter_token
      break if valor_token(@token) != ","
    end
  end

  # 18. <expressao> ➝ <expressao simples> [<relacao> <expressao simples>] 
  def expressao
    expressao_simples()

    if relacao()
      expressao_simples()
    end
  end

  # 19. <relacao> ➝ =| <>| < | <= | > | >= 
  def relacao
    @token = obter_token
    if ["=", "<>", "<" , "<=" , ">" , ">="].include?(valor_token(@token))
      log_erro(@token,"R01")
    else 
      return true
    end
  end

  # 20. <expressao simples> ➝ [+ | -] <termo> {<operador1> <termo>}
  def expressao_simples
    @token = obter_token
    if ["+", "-"].include?(valor_token(@token))  
      @token = obter_token
    end
    termo()

    while operador1()
      @token = obter_token
      termo()
      @token = obter_token
      break if !operador1()
    end
  end

  # 21. <termo> ➝ <fator> {<operador2> <fator>} 
  def termo
    fator()
    @token = obter_token
    while operador2()
      @token = obter_token
      fator()
      @token = obter_token
      break if !operador2()
    end
  end

  # 22. <operador1> ➝ + | - | or 
  def operador1
    @token = obter_token
    if !["+" , "-" , "or"].include?(valor_token(@token))
      log_erro(@token,"1OPR01")
    else
      return true
    end
  end

  # 23. <operador2> ➝ * | div | and 
  def operador2
    @token = obter_token
    if !["*", "div" , "and"].include?(valor_token(@token))
      log_erro(@token,"2OPR01")
    end
  end
=begin 
  24. <fator> ➝ <variavel> 
      |<digito>
      |<chamada de funcao>
      |(<expressao>)
=end

  def fator()
    if variavel()
      return true
    elsif classe_token(@token) == "digit"
      return true
    elsif classe_token(@token) == "ident"
      chamada_funcao()
    else 
      expressao()
    end
  end

  # 25. <variavel> ➝ <identificador> 
  def variavel
    return classe_token(@token) != "ident"
  end

  # 26. <chamada de funcao> ➝ <identificador> [ (<lista de expressoes>)] 
  def chamada_funcao
    if classe_token(@token) != "ident"
      log_erro(@token,"CF01")
    end

    @token = obter_token
    if valor_token(@token) == "("
      while true
        lista_expressoes()
        @token = obter_token
        break if valor_token(@token) == ")"
      end
    end
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

  def log_erro(token,code_error)
  
    erros = {
      'P01' => "esperado a palavra reservada program.",
      'P02' => "o token deve ser do tipo identificador.",
      'P03' => "esperado um ;",
      'B01' => "o token deve ser do tipo identificador.",
      'B02' => "esperado um =",
      'B03' => "esperado um ;",
      'T01' => "o token deve ser uma palavra reservada.",
      'T02' => "o token deve ser um tipo válido.",
      'LI01' => "o token deve ser do tipo identificador.",
      'PF01' => "esperado um :",
      'PF02' => "o token deve ser do tipo identificador.",
      'PF03' => "esperado um ;",
      'R01' => "o token não é um operador relacional.",
      '1OPR01' => "o token não é um operador válido.",
      '2OPR01' => "o token não é um operador válido.",
      'V01' => "o token deve ser do tipo identificador.",
    }

    puts "Código de erro #{code_error} - @token incorreto: #{@token} - motivo: #{ erros[code_error]}"
    exit
  end
end

lexer = Lexico.new("sintatico/fonte.txt")
parser = Sintatico.new(lexer)
parser.parse
