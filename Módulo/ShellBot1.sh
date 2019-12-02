#! / bin / bash

# ------------------------------------------------- -------------------------------------------------- --------
# 	DADOS: 07 de março de 2017
# 	SCRIPT: ShellBot.sh
# 	VERSÃO: 6.0
# 	DESENVOLVIDO POR: Juliano Santos [SHAMAN]
# 	PÁGINA: http://www.shellscriptx.blogspot.com.br
# 	FANPAGE: https://www.facebook.com/shellscriptx
# 	GITHUB: https://github.com/shellscriptx
#  	CONTATO: shellscriptx@gmail.com
#
# 	DESCRIÇÃO: O ShellBot é uma API não oficial desenvolvida para facilitar a criação de
# 						bots na plataforma TELEGRAM. Constituído por uma coleção de métodos
# 						e funções que permitem ao desenvolvedor:
#
# 							* Gerenciar grupos, canais e membros.
# 							* Enviar mensagens, documentos, músicas, contatos e etc.
# 							* Enviar teclados (KeyboardMarkup e InlineKeyboard).
# 							* Obter informações sobre membros, arquivos, grupos e canais.
# 							* Para obter mais informações, consulte um artigo:
#							  
# 							https://github.com/shellscriptx/ShellBot/wiki
#
# 						O ShellBot mantém o padrão de nomenclatura dos métodos registrados
# 						API original (Telegram), assim como seus campos e valores. Os métodos
# 						códigos definidos e argumentos para executar uma chamada. Parâmetros
# 						obrigatórios retornados uma mensagem de erro caso ou argumento seja omitido.
#					
# 	NOTAS: Desenvolvido na linguagem Shell Script, utilizando ou interpretando
# 						comandos BASH e explorar ao máximo os recursos internos do mesmo,
# 						limite ou nível de dependência de pacotes externos.
# ------------------------------------------------- -------------------------------------------------- --------

[[ $ _SHELLBOT_SH_ ]] &&  return 1

se  ! awk ' BEGIN {exit ARGV [1] <4.3} '  $ {BASH_VERSINFO [0]} . $ {BASH_VERSINFO [1]} ;  então
	echo  " $ {BASH_SOURCE : - $ {0 ## * / } } : erro: requer o interpretador de comandos 'bash 4.3' ou superior. "  1> & 2
	saída 1
fi

# Informações
readonly -A _SHELLBOT _ = (
[nome] = ' ShellBot '
[keywords] = ' API do telegrama de scripts de shell '
[description] = ' API não oficial para criação de bots na plataforma Telegram. "
[versão] = ' 6.0 '
[idioma] = ' shellscript '
[shell] = $ {SHELL}
[shell_version] = $ {BASH_VERSION}
[autor] = ' Juliano Santos [SHAMAN] '
[email] = ' shellscriptx@gmail.com '
[wiki] = ' https://github.com/shellscriptx/shellbot/wiki '
[github] = ' https://github.com/shellscriptx/shellbot '
[packages] = ' curl 7.0, getopt 2.0, jq 1.5 '
)

# Verifica dependências.
enquanto  lê _pkg_ _ver_ ;  Faz
	if  comando -v $ _pkg_  & > / dev / null ;  então
		se [[ $ ( $ _pkg_ --version 2> & 1 )  = ~ [0-9] + \. [0-9] +]] ;  então
			se  ! awk ' BEGIN {exit ARGV [1] <ARGV [2]} '  $ BASH_REMATCH  $ _ver_ ;  então
				printf  " % s: erro: requer o pacote '% s% s' ou superior. \ n "  $ {_ SHELLBOT_ [nome]}  $ _pkg_  $ _ver_  1> & 2
				saída 1
			fi
		outro
			printf  " % s: erro: '% s' não foi possível obter uma versão. \ n "  $ {_ SHELLBOT_ [nome]}  $ _pkg_  1> & 2
			saída 1
		fi
	outro
		printf  " % s: erro: '% s' ou o pacote requerido está ausente. \ n "  $ {_ SHELLBOT_ [nome]}  $ _pkg_  1> & 2
		saída 1
	fi
done  <<<  " $ {_ SHELLBOT_ [packages] //, / $ '\ n'} "

# opções (bash).
shopt -s checkwinsize \
			cmdhist \
			complete_fullquote \
			expand_aliases \
			extglob \
			extquote \
			force_fignore \
			histappend \
			comentários_interativos \
			progcomp \
			promptvars \
			caminho de origem

# Desabilitar a expansão de nomes de arquivos (globbing).
set -f

readonly _SHELLBOT_SH_ = 1					 # Inicialização
readonly _BOT_SCRIPT_ = $ {0 ## * / } 				# Script
readonly _CURL_OPT_ = ' --silent --request ' 	# CURL (opções)

# Erros
readonly _ERR_TYPE_BOOL_ = ' tipo incompatível: support somente "true" ou "false". "
readonly _ERR_TYPE_INT_ = ' tipo incompatível: support somente inteiro. "
readonly _ERR_TYPE_FLOAT_ = ' tipo incompatível: support somente float. "
readonly _ERR_PARAM_REQUIRED_ = ' opção requerida: ver o (s) parâmetro (s) ou argumento (s) obrigatório (s) estão presentes (s). "
readonly _ERR_TOKEN_UNAUTHORIZED_ = ' não autorizado: verifique se possui permissão para utilizar o token. "
readonly _ERR_TOKEN_INVALID_ = ' token inválido: ver o número do token e tente novamente. "
readonly _ERR_BOT_ALREADY_INIT_ = ' ação não permitida: o bot já foi inicializado. "
readonly _ERR_FILE_NOT_FOUND_ = ' arquivo não encontrado: não foi possível ler o arquivo especificado. "
readonly _ERR_DIR_WRITE_DENIED_ = ' Permissão negada: não é possível gravar no diretório. "
readonly _ERR_DIR_NOT_FOUND_ = ' Não foi possível acessar: diretório não encontrado. "
readonly _ERR_FILE_DOWNLOAD_ = ' falha no download: arquivo não encontrado. "
readonly _ERR_FILE_INVALID_ID_ = ' id inválido: arquivo não encontrado. "
readonly _ERR_UNKNOWN_ = ' erro desconhecido: ocorreu uma falha inesperada. Reporte o problema ao desenvolvedor. "
readonly _ERR_SERVICE_NOT_ROOT_ = ' acesso negado: requer privilégios de root. "
readonly _ERR_SERVICE_EXISTS_ = ' erro ao criar o serviço: o nome do serviço já existe. "
readonly _ERR_SERVICE_SYSTEMD_NOT_FOUND_ = ' erro ao ativar: o sistema não possui suporte ao gerenciamento de serviços "systemd". "
readonly _ERR_SERVICE_USER_NOT_FOUND_ = ' usuário não encontrado: uma conta de usuário informada é inválida. "
readonly _ERR_VAR_NAME_ = ' variável não encontrada: o identificador é inválido ou não existe. "
readonly _ERR_FUNCTION_NOT_FOUND_ = ' função não encontrada: o identificador especificado é inválido ou não existe. "
readonly _ERR_ARG_ = ' argumento inválido: o argumento não é suportado pelo parâmetro especificado. "
readonly _ERR_RULE_ALREADY_EXISTS_ = ' falha ao definir: o nome da regra já existe. "

declarar -A _BOT_FUNCTION_LIST_
declarar -a _BOT_RULES_LIST_

Json () { obj local = $ ( jq " $ 1 "  <<<  " $ {*: 2} " ) ; obj = $ {obj # \ " } ;  echo  " $ {obj % \ " } " ; }

GetAllValues () {
	obj local = $ ( jq " [.. | select (digite == \" string \ " ou digite == \" número \ " ou digite == \" booleano \ " ) | alternando] | junte-se ( \" $ { _BOT_DELM_ / \ " / \\\" } \ " ) "  <<<  $ * )
	obj = $ {obj # \ " } ;  eco  " $ {obj % \ " } "
}

GetAllKeys () {
	chave local ; jq -r ' path (.. | select (tipo == "string" ou tipo == "número" ou tipo == "booleano")) | mapa (se tipo == "número" então. | tostring | "[ "+. +"] "else. end) | join (". ") '  <<<  $ *  | \
	enquanto  lê a tecla ;  do  echo  " $ {key // . \ [ / \ [ } " ;  feito
}

FlagConv ()
{
	local var str = $ 2

	while [[ $ str  = ~  \ $ \ { ([a-z _] +) \} ]] ;  Faz
		[[ $ {BASH_REMATCH [1]}  ==  @ ( $ {_ var_init_list_ //  / |} )]] && var = $ {BASH_REMATCH [1]} [ $ 1 ] || var = _
		str = $ {str // $ {BASH_REMATCH [0]} / $ { ! var} }
	feito

	eco  " $ str "
}

CreateLog ()
{
	local i fmt

	for  (( i = 0 ; i <  $ 1 ; i ++ )) ;  Faz
		printf -v fmt " $ _BOT_LOG_FORMAT_ "  || API MessageError

		# Suprimir erros.
		exec  5 < & 2
		exec  2 < & -

		# Bandeiras
		fmt = $ {fmt // \ { OK \} / $ {return [ok] : - $ ok } }
		fmt = $ {fmt // \ { UPDATE_ID \} / $ {update_id [$ i]} }
		fmt = $ {fmt // \ { MESSAGE_ID \} / $ {return [message_id] : - $ {message_message_id [$ i] : - $ {editor_message_message_id [$ id] : - $ {callback_query_id [$ i]} } } } }
		fmt = $ {fmt // \ { FROM_ID \} / $ {return [from_id] : - $ {message_from_id [$ i] : - $ {edited_message_from_id [$ id] : - $ {callback_query_from_id [$ i]} } } } }
		fmt = $ {fmt // \ { FROM_IS_BOT \} / $ {return [from_is_bot] : - $ {message_from_is_bot [$ i] : - $ {mensagem_ editada_from_is_bot [$ id] : - $ {callback_query_from_is_bot [$ i]} } } } }
		fmt = $ {fmt // \ { FROM_FIRST_NAME \} / $ {return [from_first_name] : - $ {message_from_first_name [$ i] : - $ {edited_message_from_first_name [$ id] : - $ {callback_query_from_first_name [$ i]} } } } }
		fmt = $ {fmt // \ { FROM_USERNAME \} / $ {return [nome_do_usuário] : - $ {message_from_username [$ i] : - $ {mensagem_de_usuário_de_usuário [$ id] : - $ {callback_query_from_username [$ i]} } } } }
		fmt = $ {fmt // \ { FROM_LANGUAGE_CODE \} / $ {message_from_language_code [$ i] : - $ {modified_message_from_language_code [$ id] : - $ {callback_query_from_language_code [$ i]} } } }
		fmt = $ {fmt // \ { CHAT_ID \} / $ {return [chat_id] : - $ {message_chat_id [$ i] : - $ {edited_message_chat_id [$ id] : - $ {callback_query_message_chat_id [$ i]} } } } }
		fmt = $ {fmt // \ { CHAT_TITLE \} / $ {return [chat_title] : - $ {message_chat_title [$ i] : - $ {edited_message_chat_title [$ id] : - $ {callback_query_message_chat_title [$ i]} } } } }
		fmt = $ {fmt // \ { CHAT_TYPE \} / $ {return [chat_type] : - $ {message_chat_type [$ i] : - $ {editor_message_chat_type [$ id] : - $ {callback_query_message_chat_type [$ i]} } } } }
		fmt = $ {fmt // \ { MESSAGE_DATE \} / $ {return [date] : - $ {message_date [$ i] : - $ {edit_message_date [$ id] : - $ {callback_query_message_date [$ i]} } } } }
		fmt = $ {fmt // \ { MESSAGE_TEXT \} / $ {return [texto] : - $ {message_text [$ i] : - $ {edited_message_text [$ id] : - $ {callback_query_message_text [$ i]} } } } }
		fmt = $ {fmt // \ { ENTITIES_TYPE \} / $ {return [entity_type] : - $ {message_entities_type [$ i] : - $ {edited_message_entities_type [$ id] : - $ {callback_query_data [$ i]} } } } }
		fmt = $ {fmt // \ { BOT_TOKEN \} / $ {_ BOT_INFO_ [0]} }
		fmt = $ {fmt // \ { BOT_ID \} / $ {_ BOT_INFO_ [1]} }
		fmt = $ {fmt // \ { BOT_FIRST_NAME \} / $ {_ BOT_INFO_ [2]} }
		fmt = $ {fmt // \ { BOT_USERNAME \} / $ {_ BOT_INFO_ [3]} }
		fmt = $ {fmt // \ { BASENAME \} / $ _BOT_SCRIPT_ }
		fmt = $ {fmt // \ { METHOD \} / $ {FUNCNAME [2] / main / ShellBot.getUpdates} }
		fmt = $ {fmt // \ { RETURN \} / $ (GetAllValues $ { *: 2} )}

		exec  2 < & 5

		# log
		[[ $ fmt ]] && { echo  " $ fmt "  >>  " $ _BOT_LOG_FILE_ "  || API MessageError ; }
	feito

	retornar  $?
}

MethodReturn ()
{
	# Retorno
	case  $ _BOT_TYPE_RETURN_  in
		json) echo  " $ * " ;;
		valor) GetAllValues $ * ;;
		mapa)
			chave local val obj
			declarar -Ag return = () || API MessageError

			para  obj  em  $ ( GetAllKeys $ * ) ;  Faz
				chave = $ {obj // [0-9 \ [\]] / }
				chave = $ { resultado da chave # .}
				chave = $ {chave // . / _}

				val = $ ( Json " . $ obj "  $ * )
				
				[[ $ {return [$ key]} ]] && return [ $ key ] + = $ {_ BOT_DELM _} $ {val}  || return [ $ key ] = $ val
				[[ $ _BOT_MONITOR_ ]] &&  printf  " [% s]: retorne [% s] = '% s' \ n "  " $ {FUNCNAME [1]} "  " $ key "  " $ val "
			feito
			;;
	esac
	
	[[ $ _BOT_LOG_FILE_ ]] && CreateLog 1 $ *  &
	[[ $ ( jq -r ' .ok '  <<<  $ * )  ==  verdadeiro ]]

	retornar  $?
}

MessageError ()
{
	# Variáveis ​​locais
	local err_message err_param err_line err_func assert ind
	
	# Uma variável 'BASH_LINENO' é útil e armazena o número da linha onde foi expandida.
	# Quando chamar dentro de um subshell, passa a ser instanciado como um array, armazenando diversos
	# valores onde cada índice refere-se a um shell / subshell. Como essas características se aplicam a uma variável
	# 'FUNCNAME', onde é armazenado ou nome da função em que foi chamada.
	
	# Item ou índice de função na hierarquia de chamada.
	[[ $ {FUNCNAME [1]}  == CheckArgType]] && ind = 2 || ind = 1
	err_line = $ {BASH_LINENO [$ ind]} 	# linha
	err_func = $ {FUNCNAME [$ ind]} 		# função
	
	# Tipo de ocorrência.
	# TG - Erro externo retornado pelo núcleo do telegrama.
	# API - Erro interno criado pela API do ShellBot.
	caso  $ 1  em
		TG)
			# arquivo Json
			err_param = " $ ( Json ' .error_code '  $ { *: 2} ) "
			err_message = " $ ( Json ' .description '  $ { *: 2} ) "
			;;
		API)
			err_param = " $ {3 : - -} : $ {4 : - -} "
			err_message = " $ 2 "
			assert = 1
			;;
	esac

	# Imprime erro
	printf  " % s: erro: linha% s:% s:% s:% s \ n " 	\
							" $ {_ BOT_SCRIPT_} " 	\
							" $ {err_line : - -} "  	\
							" $ {err_func : - -} "  	\
							" $ {err_param : - -} "  	\
							" $ {err_message : - $ _ERR_UNKNOWN_ } "  1> & 2 

	# Finaliza o script / thread em caso de erro interno, caso contrário retorna 1
	[[ $ assert ]] &&  exit 1 ||  retorno 1
}

CheckArgType () {

	ctype local = " $ 1 "
	parâmetro local = " $ 2 "
	valor local = " $ 3 "

	# CheckArgType recebe os dados da função de chamada e verificação
	# o dado recebido com o tipo suportado pelo parâmetro.
	# É retornado '0' para o sucesso, caso contrário uma mensagem
	# de erro é retornado e o script / thread é finalizado com status '1'.
	case  $ ctype  in
		usuário) id " $ value "  e > / dev / null										 || API MessageError " $ _ERR_SERVICE_USER_NOT_FOUND_ "  " $ param "  " $ value " ;;
		func) [[ $ ( digite -t " $ valor " )  ==  função 						]]  	|| API MessageError " $ _ERR_FUNCTION_NOT_FOUND_ "  " $ param "  " $ value " ; ;
		var) [[-v $ valor  											]] 	 || API MessageError " $ _ERR_VAR_NAME_ "  " $ param "  " $ value " ;;
		int) [[ $ value  = ~ ^ - ? [0-9] + $]] 	 || API MessageError " $ _ERR_TYPE_INT_ "  " $ param "  " $ value " ;;
		flutuar) [[ $ value  = ~ ^ - ? [0-9] + \. [0-9] + $]] 	 || API MessageError " $ _ERR_TYPE_FLOAT_ "  " $ param "  " $ value " ;;
		bool) [[ $ value  = ~ ^ (true | false) $]] 	 || API MessageError " $ _ERR_TYPE_BOOL_ "  " $ param "  " $ value " ;;
		token) [[ $ value  = ~ ^ [0-9] +: [a-zA-Z0-9 _-] + $]] 	 || API MessageError " $ _ERR_TOKEN_INVALID_ "  " $ param "  " $ value " ;;
		arquivo) [[ $ value  = ~ ^ @ &&  !  -f  $ {value # @ }  						]] 	 && API MessageError " $ _ERR_FILE_NOT_FOUND_ "  " $ param "  " $ value " ;;
		tipo de mídia) [[ $ value  ==  @ (animação | documento | áudio | foto | vídeo)]]	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		return) [[ $ value  ==  @ (json | mapa | valor)]] 	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		parsemode) [[ $ value  ==  @ (remarcação | html)]] 	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		ponto) [[ $ value  ==  @ (testa | olhos | boca | queixo)]] 	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		cmd) [[ $ value  = ~ ^ / [a-zA-Z0-9 _] + $]] 	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		flag) [[ $ value  = ~ ^ [a-zA-Z0-9 _] + $]] 	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		ação) [[ $ value  ==  @ (digitando | upload_photo)]] 	 ||
					[[ $ value  ==  @ (vídeo_de_regravamento | vídeo_de_arquivo)]] 	 ||
					[[ $ value  ==  @ (record_audio | upload_audio)]] 	 ||
					[[ $ value  ==  @ (upload_document | find_location)]] 	 ||
					[[ $ value  ==  @ (record_video_note | upload_video_note)]] 	 || API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		itime) [[ $ value  = ~ ^ ([01] [0-9] | 2 [0-3]): [0-5] [0-9] - ([01] [0-9] | 2 [ 0-3]): [0-5] [0-9] $]] \
																				|| API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
		idate) [[ $ value  = ~ ^ (0 [1-9] | [12] [0-9] | 3 [01]) / (0 [1-9] | 1 [0-2]) / ([ 0-9] {4,}) - (0 [1-9] | [12] [0-9] | 3 [01]) / (0 [1-9] | 1 [0-2]) / ( [0-9] {4,}) $]] \
																				|| API MessageError " $ _ERR_ARG_ "  " $ param "  " $ value " ;;
    esac

	retornar 0
}

FlushOffset ()
{    
	sid sid local jq_obj

	enquanto  : ;  Faz
		jq_obj = $ ( ShellBot.getUpdates --limit 100 --offset $ ( ShellBot.OffsetNext ) - timeout 5 )
		mapfile -t update_id <<  ( jq -r ' .result |. [] | .update_id '  <<<  $ jq_obj )
		[[ $ update_id ]] ||  quebrar
		sid = $ {sid : - $ {update_id [0]} }
		eid = $ {update_id [-1]}
	feito
	
	eco  " $ {sid : - 0} | $ {eid : - 0} "
	não definido _FLUSH_OFFSET_

	retornar 0
}

CreateUnitService ()
{
	serviço local = $ {1 % . * } .service
	local ok = ' \ 033 [0; 32m [OK] \ 033 [0; m '
	falha local = ' \ 033 [0; 31m [FALHA] \ 033 [0; m '
	
	(( UID ==  0 ))  || API MessageError " $ _ERR_SERVICE_NOT_ROOT_ "

	# O modo 'service' requer que o sistema de gerenciamento de processos 'systemd'
	# esteja presente para que a unidade de destino esteja vinculada ao serviço.
	se  ! qual systemctl & > / dev / null ;  então
		API MessageError " $ _ERR_SERVICE_SYSTEMD_NOT_FOUND_ " ;  fi


	# Se o serviço existe.
	teste -e / lib / systemd / system / $ service  && \
	API MessageError " $ _ERR_SERVICE_EXISTS_ "  " $ service "

	# Gerando como configurações do alvo.
	cat > / lib / systemd / system / $ service  <<  _eof
[Unidade]
Descrição = $ 1 - (SHELLBOT)
Depois = network-online.target
[Serviço]
Usuário = $ 2
WorkingDirectory = $ PWD
ExecStart = / bin / bash $ 1
ExecReload = / bin / kill -HUP \ $ MAINPID
ExecStop = / bin / kill -KILL \ $ MAINPID
KillMode = processo
Reiniciar = em falha
RestartPreventExitStatus = 255
Tipo = simples
[Instalar]
WantedBy = multi-user.target
_eof

	[[ $?  -eq 0]] && {	
		
		printf  ' % s foi criado com sucesso !! \ n '  $ service	
		eco -n " Habilitando ... "
 		systemctl ativa  $ service  & > / dev / null &&  echo -e $ ok  || \
		{ eco -e $ falha ; API MessageError ; }

		sed -i -r ' /^\s*ShellBot.init\s/s/\s--?(s(ervice)?|u(ser)?\s+\w+)\b//g '  " $ 1 "
		systemctl daemon-reload

		eco -n " Iniciando ... "
		systemctl start $ service  & > / dev / null && {
		
			eco -e $ ok
			systemctl status $ service
			echo -e " \ nTambém: sudo systemctl {iniciar | parar | reiniciar | recarregar | status} $ service "
		
		} ||  eco -e $ falha
	
	} || API MessageError

	saída 0
}

# Inicialização ou bot, definindo sua API e _TOKEN_.
ShellBot.init ()
{
	# Verifica se o bot já foi inicializado.
	[[ $ _SHELLBOT_INIT_ ]] && API MessageError " $ _ERR_BOT_ALREADY_INIT_ "
	
	local enable_service user_unit _jq_bot_info method_return delm ret logfmt
	
	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
						 --opções ' t: mfsu: l: o: r: d: ' \
- token das 						 opções :
										monitor,
										rubor,
										serviço,
										do utilizador:,
										arquivo de log:,
										log_format :,
										Retorna:,
										delimitador: ' \
    					 - " $ @ " )
    
	# Definir os parâmetros posicionais
	eval  set - " $ param "
   
	enquanto  :
    	Faz
			caso  $ 1  em
				-t | --token)
	    			Token CheckArgType " $ 1 "  " $ 2 "
	    			declare -gr _TOKEN_ = $ 2 												# TOKEN
	    			declare -gr _API_TELEGRAM_ = " https://api.telegram.org/bot $ _TOKEN_ " 	# API
	    			turno 2
	   				;;
	   			-m | --monitor)
					# Ativa modo monitor
	   				declare -gr _BOT_MONITOR_ = 1
	   				mudança
	   				;;
				-f | --flush)
					# Defina uma liberação FLAG para o método 'ShellBot.getUpdates'. Se ativado, faz com que
					# o método Obtenha apenas como atualizações disponíveis, ignorando uma extração dos
					# objetos JSON e a inicialização das variáveis.
					declare -x _FLUSH_OFFSET_ = 1
					mudança
					;;
				-s | --serviço)
					enable_service = 1
					mudança
					;;
				-u | --user)
					Usuário CheckArgType " $ 1 "  " $ 2 "
					user_unit = $ 2
					turno 2
					;;
				-l | --log_file)
					declare -gr _BOT_LOG_FILE_ = $ 2
					turno 2
					;;
				-o | --log_format)
					logfmt = $ 2
					turno 2
					;;
				-r | --retorno)
					CheckArgType retorna  " $ 1 "  " $ 2 "
					ret = $ 2
					turno 2
					;;
				-d | --delimitador)
					delm = $ 2
					turno 2
					;;
	   			-)
	   				mudança
	   				quebrar
	   				;;
	   		esac
	   	feito
  
	# Parâmetro obrigatório.	
	[[ $ _TOKEN_ ]] 							 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --token] "
	[[ $ user_unit  &&  !  $ enable_service ]] 	 && API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --service] " 
	[[ $ enable_service ]] 					 && CreateUnitService " $ _BOT_SCRIPT_ "  " $ {user_unit : - $ USER } "
		   
    # Um método simples para testar ou token de autenticação do seu bot.
    # Não requer parâmetros. Retorna informações básicas sobre o bot em forma de um objeto Usuário.
    ShellBot.getMe ()
    {
    	# Chama o método getMe passando o endereço da API, seguido do nome do método.
    	jq_obj local = $ ( enrolar $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {FUNCNAME # * .} )

    	_jq_bot_info = $ jq_obj

		# Verificação do status do retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    }

   	ShellBot.getMe & > / dev / null || API MessageError " $ _ERR_TOKEN_UNAUTHORIZED_ "  ' [-t, --token] '
	
	# Salva como informações do bot.
	declare -gr _BOT_INFO _ = (
		[0] = $ _TOKEN_
		[1] = $ ( Json ' .result.id '  $ _jq_bot_info )
		[2] = $ ( Json ' .result.first_name '  $ _jq_bot_info )
		[3] = $ ( Json ' .result.username '  $ _jq_bot_info )
	)

	# Configuração. (padrão)
	declare -gr _BOT_LOG_FORMAT_ = $ {logfmt : -% ( % d /% m /% Y % H :% M :% S) T :  \ { BASENAME \} :  \ { BOT_USERNAME \} :  \ { UPDATE_ID \} :  \ { MÉTODO \} :  \ { FROM_USERNAME \} :  \ { MESSAGE_TEXT \} }
	declare -gr _BOT_TYPE_RETURN_ = $ {ret : - value}
	declare -gr _BOT_DELM_ = $ {delm : - |}
	declare -gr _SHELLBOT_INIT_ = 1
	
    # SHELLBOT (FUNÇÕES)
	# Inicializa como funções para chamadas aos métodos da API do telegrama.
	ShellBot.ListUpdates () { echo  $ { ! update_id [@]} ; }
	ShellBot.TotalUpdates () { echo  $ { # update_id [@]} ; }
	ShellBot.OffsetEnd () { deslocamento local -i = $ {update_id [@] : -1} ; eco  $ offset ; }
	ShellBot.OffsetNext () { echo  $ (( $ {update_id [@] : -1} + 1 )) ; }
   	
	ShellBot.token () { echo  " $ {_ BOT_INFO_ [0]} " ; }
	ShellBot.id () { echo  " $ {_ BOT_INFO_ [1]} " ; }
	ShellBot.first_name () { echo  " $ {_ BOT_INFO_ [2]} " ; }
	ShellBot.username () { echo  " $ {_ BOT_INFO_ [3]} " ; }
  
    ShellBot.regHandleFunction ()
    {
    	 função  local callback_data manipula args
    
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' f: a: d: ' \
								--longoptions	 ' function :,
												args :,
												callback_data: ' \
								- " $ @ " )
    
		eval  set - " $ param "
    		
		enquanto  :
		Faz
   			caso  $ 1  em
   				-f | --função)
					CheckArgType func " $ 1 "  " $ 2 "
   					function = $ 2
   					turno 2
   					;;
    			-a | --args)
   					args = $ 2
   					turno 2
   					;;
   				-d | --callback_data)
   					callback_data = $ {2 // | / \\ |}
   					turno 2
   					;;
   				-)
   					mudança
   					quebrar
   					;;
   			esac
   		feito

		[[ $ função ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-f, --function] "
   		[[ $ callback_data ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-d, --callback_data] "
   
   		_BOT_FUNCTION_LIST_ [ $ callback_data ] + = " $ function  $ args | "

   		retornar 0
    }
    
    ShellBot.watchHandle ()
    {
    	local  	callback_data func func_handle \
    			param = $ ( getopt --name " $ FUNCNAME " \
								--opções ' d ' \
								--longoptions ' callback_data ' \
								- " $ @ " )
    
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-d | --callback_data)
    				turno 2
    				callback_data = $ 1
    				;;
    			* )
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# O parâmetro callback_data é parcial, ou seja, Se manipular para válido, os elementos
    	# serão selecionados. Caso contrário, a função é finalizada.
    	[[ $ callback_data ]] ||  retorno 1
   	
		enquanto  lê -d ' | ' func ;  do  $ func
		done  <<<  $ {_ BOT_FUNCTION_LIST _ [$ callback_data]}
    
    	# retorno
    	retornar 0
    }
    
    ShellBot.getWebhookInfo ()
    {
    	# Variável local
    	jq_obj local
	
    	# Chama o método getMe passando o endereço da API, seguido do nome do método.
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .} )
    	
    	# Verificação do status do retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
    }
    
    ShellBot.deleteWebhook ()
    {
    	# Variável local
    	jq_obj local
	
    	# Chama o método getMe passando o endereço da API, seguido do nome do método.
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} )
    	
    	# Verificação do status do retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
    }
    
    ShellBot.setWebhook ()
    {
    	certificado de URL local max_connections allowed_updates jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' u: c: m: a: ' \
- url das 							 opções :
    										certificado:,
    										max_connections :,
    										allowed_updates: ' \
    						 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-u | --url)
    				url = $ 2
    				turno 2
    				;;
    			-c | --certificate)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				certificado = $ 2
    				turno 2
    				;;
    			-m | --max_connections)
    				CheckArgType int " $ 1 "  " $ 2 "
    				max_connections = $ 2
    				turno 2
    				;;
    			-a | --allowed_updates)
    				allowed_updates = $ 2
    				turno 2
    				;;
    			-)
    				mudança 
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ url ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --url] "
    
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {url : + -d url = " $ url " } \
									$ {certificate : + -d certificate = " $ certificate " } \
									$ {max_connections : + -d max_connections = " $ max_connections " } \
									$ {allowed_updates : + -d allowed_updates = " $ allowed_updates " } )
    
    	# Teste ou retorno do método.
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	# Status
    	retornar  $?
    }	
    
    ShellBot.setChatPhoto ()
    {
    	foto chat_id local jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: p: ' \
							 --longoptions ' chat_id:, foto: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-p | --photo)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				photo = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ foto ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-p, --photo] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
 									$ {photo : + -F photo = " $ photo " } )
    
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    }
    
    ShellBot.deleteChatPhoto ()
    {
    	local chat_id jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
							 --longoptions ' chat_id: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
		# Status
    	retornar  $?
    
    }
    
    ShellBot.setChatTitle ()
    {
    	
    	título local do chat_id jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: t: ' \
							 --longoptions ' chat_id:, title: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-t | --title)
    				title = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ title ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --title] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
 									$ {title : + -d title = " $ title " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
		# Status
    	retornar  $?
    }
    
    
    ShellBot.setChatDescription ()
    {
    	
    	descrição chat_id local jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: d: ' \
							 --longoptions ' chat_id:, description: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-d | --description)
    				description = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ description ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-d, --description] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
 									$ {description : + -d description = " $ description " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    }
    
    ShellBot.pinChatMessage ()
    {
    	
    	chat_id local message_id disable_notification jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: m: n: ' \
							 --longoptions ' chat_id :,
											message_id :,
    										disable_notification: ' \
    						 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-m | --message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				message_id = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;	
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
 									$ {message_id : + -d message_id = " $ message_id " } \
 									$ {disable_notification : + -d disable_notification = " $ disable_notification " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    }
    
    ShellBot.unpinChatMessage ()
    {
    	local chat_id jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
							 --longoptions ' chat_id: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    }
    
    ShellBot.restrictChatMember ()
    {
    	local 	chat_id user_id até a data can_send_messages \
    			can_send_media_messages can_send_other_messages \
    			can_add_web_page_previews jq_obj
    
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: u: d: s: m: o: w: ' \
    						 --longoptions ' chat_id :,
    										ID do usuário:,
    										até_data :,
    										can_send_messages :,
    										can_send_media_messages :,
    										can_send_other_messages :,
    										can_add_web_page_previews: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				user_id = $ 2
    				turno 2
    				;;
    			-d | --until_date)
    				CheckArgType int " $ 1 "  " $ 2 "
    				até_data = $ 2
    				turno 2
    				;;
    			-s | --can_send_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_send_messages = $ 2
    				turno 2
    				;;
    			-m | --can_send_media_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_send_media_messages = $ 2
    				turno 2
    				;;
    			-o | --can_send_other_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_send_other_messages = $ 2
    				turno 2
    				;;
    			-w | --can_add_web_page_previews)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_add_web_page_previews = $ 2
    				turno 2
    				;;				
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --user_id] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {user_id : + -d user_id = " $ user_id " } \
									$ {till_date_ : + -d till_date = " $ till_date " } \
									$ {can_send_messages : + -d can_send_messages = " $ can_send_messages " } \
									$ {can_send_media_messages : + -d can_send_media_messages = " $ can_send_media_messages " } \
									$ {can_send_other_messages : + -d can_send_other_messages = " $ can_send_other_messages " } \
									$ {can_add_web_page_previews : + -d can_add_web_page_previews = " $ can_add_web_page_previews " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    	
    }
    
    
    ShellBot.promoteChatMember ()
    {
    		chat_id local user_id can_change_info can_post_messages \
    			can_edit_messages can_delete_messages can_invite_users \
    			can_restrict_members can_pin_messages can_promote_members \
				jq_obj
    
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: u: i: p: e: d: v: r: f: m: ' \
							 --longoptions ' chat_id :,
    										ID do usuário:,
    										can_change_info :,
    										can_post_messages :,
    										can_edit_messages :,
    										can_delete_messages :,
    										can_invite_users :,
    										can_restrict_members :,
    										can_pin_messages :,
    										can_promote_members: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				user_id = $ 2
    				turno 2
    				;;
    			-i | --can_change_info)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_change_info = $ 2
    				turno 2
    				;;
    			-p | --can_post_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_post_messages = $ 2
    				turno 2
    				;;
    			-e | --can_edit_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_edit_messages = $ 2
    				turno 2
    				;;
    			-d | --can_delete_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_delete_messages = $ 2
    				turno 2
    				;;
    			-v | --can_invite_users)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_invite_users = $ 2
    				turno 2
    				;;
    			-r | --can_restrict_members)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_restrict_members = $ 2
    				turno 2
    				;;
    			-f | --can_pin_messages)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_pin_messages = $ 2
    				turno 2
    				;;	
    			-m | --can_promote_members)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				can_promote_members = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --user_id] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {user_id : + -d user_id = " $ user_id " } \
									$ {can_change_info : + -d can_change_info = " $ can_change_info " } \
									$ {can_post_messages : + -d can_post_messages = " $ can_post_messages " } \
									$ {can_edit_messages : + -d can_edit_messages = " $ can_edit_messages " } \
									$ {can_delete_messages : + -d can_delete_messages = " $ can_delete_messages " } \
									$ {can_invite_users : + -d can_invite_users = " $ can_invite_users " } \
									$ {can_restrict_members : + -d can_restrict_members = " $ can_restrict_members " } \
									$ {can_pin_messages : + -d can_pin_messages = " $ can_pin_messages " } \
									$ {can_promote_members : + -d can_promote_members = " $ can_promote_members " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    }
    
    ShellBot.exportChatInviteLink ()
    {
    	local chat_id jq_obj
    
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
							 --longoptions ' chat_id: ' \
							 - " $ @ " )
    	
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    	
    	# Teste ou retorno do método.
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    		
    	# Status
    	retornar  $?
    }
    
    ShellBot.sendVideoNote ()
    {
    	duração do chat_id local video_note duração disable_notification \
    			reply_to_message_id reply_markup jq_obj
    
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: v: t: l: n: r: k: ' \
							 --longoptions ' chat_id :,
    										video_note :,
    										duração:,
    										comprimento:,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-v | --video_note)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				video_note = $ 2
    				turno 2
    				;;
    			-t | --duração)
    				CheckArgType int " $ 1 "  " $ 2 "
    				duration = $ 2
    				turno 2
    				;;
    			-l | --length)
    				CheckArgType int " $ 1 "  " $ 2 "
    				length = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]]		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ video_note ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-v, --video_note] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {video_note : + -F video_note = " $ video_note " } \
									$ {duration : + -F duration = " $ duration " } \
									$ {length : + -F length = " $ length " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
									$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Teste ou retorno do método.
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	# Status
    	retornar  $?
    }
    
    
    ShellBot.InlineKeyboardButton ()
    {
         	__botão local __line __text __url __callback_data \
                __switch_inline_query __switch_inline_query_current_chat
    
        __param local = $ ( getopt --name " $ FUNCNAME " \
							 	- opções ' b: l: t: u: c: q: s: ' \
							 	--longoptions ' botão :,
												linha:,
												texto:,
												url :,
												callback_data :,
												switch_inline_query :,
												switch_inline_query_chat: ' \
							 	- " $ @ " )
    
    	eval  set - " $ __ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-b | --botão)
    				# Ponteiro que recebe o endereço de "button" com as definições
    				# da configuração do botão inserido.
					CheckArgType var " $ 1 "  " $ 2 "
    				__botão = $ 2
    				turno 2
    				;;
    			-l | --line)
    				CheckArgType int " $ 1 "  " $ 2 "
					__line = $ (( $ 2 - 1 ))
    				turno 2
    				;;
    			-t | --text)
					__text = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-u | --url)
    				__url = $ 2
    				turno 2
    				;;
    			-c | --callback_data)
    				__callback_data = $ 2
    				turno 2
    				;;
    			-q | --switch_inline_query)
    				__switch_inline_query = $ 2
    				turno 2
    				;;
    			-s | --switch_inline_query_current_chat)
    				__switch_inline_query_current_chat = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	[ botão [ $ __ ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-b, --button] "
    	[[ $ __ text ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --text] "
    	[[ $ __ callback_data ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --callback_data] "
    	[[ $ __ line ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-l, --line] "
    	
		__botão = botão $ __ [ linha $ __ ]

		botão  printf -v $ __ " botão $ { ! __ # [} "
		botão  printf -v $ __ " $ { ! __button % ]} "
		
		printf -v $ __ button  ' % s {"text": "% s", "callback_data": "% s", "url": "% s", "switch_inline_query": "% s", "switch_inline_query_current_chat": " % s "} '  	\
							" $ { ! __botão : + $ { ! __botão} ,} " 																									\
							" $ {__ text} " 																														\
							" $ {__ callback_data} " 																											\
							" $ {__ url} " 																														\
							" $ {__ switch_inline_query} " 																										\
							" $ {__ switch_inline_query_current_chat} "

		botão  printf -v $ __ " " [ $ { ! __botão} ] ""

    	retornar  $?
    }
    
    ShellBot.InlineKeyboardMarkup ()
    {
    	teclado __ local __

        __param local = $ ( getopt --name " $ FUNCNAME " \
							 	--opções ' b: ' \
							 	--longoptions ' button: ' \
							 	- " $ @ " )
    
    	eval  set - " $ __ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-b | --botão)
    				# Ponteiro que recebe ou endereço da variável "teclado" com as configurações
    				# de configuração do botão inserido.
					CheckArgType var " $ 1 "  " $ 2 "
    				__button = " $ 2 "
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[ botão [ $ __ ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-b, --button] "
    
		__button = botão $ __ [@]

		printf -v __keyboard ' % s, '  " $ { ! __botão} "
		printf -v __keyboard " $ {__ keyboard % ,} "

    	# Construa uma estrutura de objetos + teclado de matriz, defina os valores e salve como configurações.
    	# Por padrão todos os valores são 'false' até que seja definido.
		printf  ' {"inline_keyboard": [% s]} '  " $ {__ keyboard} "
    
		retornar  $?
    }
    
    ShellBot.answerCallbackQuery ()
    {
    	local callback_query_id texto show_alert url cache_time jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: t: s: u: e: ' \
    						 --longoptions ' callback_query_id :,
    										texto:,
    										show_alert :,
    										url :,
    										cache_time: ' \
    						 - " $ @ " )
    
    
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --callback_query_id)
    				callback_query_id = $ 2
    				turno 2
    				;;
    			-t | --text)
					texto = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-s | --show_alert)
    				# boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				show_alert = $ 2
    				turno 2
    				;;
    			-u | --url)
    				url = $ 2
    				turno 2
    				;;
    			-e | --cache_time)
    				# inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				cache_time = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ callback_query_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --callback_query_id] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {callback_query_id : + -d callback_query_id = " $ callback_query_id " } \
									$ {text : + -d text = " $ text " } \
									$ {show_alert : + -d show_alert = " $ show_alert " } \
									$ {url : + -d url = " $ url " } \
									$ {cache_time : + -d cache_time = " $ cache_time " } )
    
		MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    }
    
    # Cria objeto que representa um teclado personalizado com opções de resposta
    ShellBot.ReplyKeyboardMarkup ()
    {
    	# Variáveis ​​locais
    	__botão local __resize_keyboard __on_time_keyboard __selective __keyboard
    	
    	# Lê os parâmetros da função.
    	__param local = $ ( getopt --name " $ FUNCNAME " \
							 	--opções ' b: r: t: s: ' \
    						 	--longoptions ' botão :,
    										resize_keyboard :,
    										one_time_keyboard :,
    										seletivo: ' \
    						 	- " $ @ " )
    	
    	# Transforma os parâmetros da função em parâmetros posicionais
    	#
    	# Exemplo:
    	# 	--param1 arg1 --param2 arg2 --param3 arg3 ...
    	#  		$ 1 $ 2 $ 3
    	eval  set - " $ __ param "
    	
    	# Aguarda leitura dos parâmetros
    	enquanto  :
    	Faz
    		# Lê o parâmetro da primeira posição "$ 1"; Se for um parâmetro válido,
    		# salva o valor do argumento na posição '$ 2' e desloca duas posições à esquerda (shift 2); Repete o processo
    		# até que o valor de '$ 1' seja igual '-' e finalize o loop.
    		caso  $ 1  em
    			-b | --botão)
					CheckArgType var " $ 1 "  " $ 2 "
    				__botão = $ 2
    				turno 2
    				;;
    			-r | --resize_keyboard)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				__resize_keyboard = $ 2
    				turno 2
    				;;
    			-t | --one_time_keyboard)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				__on_time_keyboard = $ 2
    				turno 2
    				;;
    			-s | --seletivo)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				__selective = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Imprime mensagem de erro se o parâmetro obrigatório para omitido.
    	[ botão [ $ __ ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-b, --button] "
		
		__button = botão $ __ [@]

		printf -v __keyboard ' % s, '  " $ { ! __botão} "
		printf -v __keyboard " $ {__ keyboard % ,} "

    	# Construa uma estrutura de objetos + teclado de matriz, defina os valores e salve como configurações.
    	# Por padrão todos os valores são 'false' até que seja definido.
		printf  ' {"teclado": [% s], "resize_keyboard":% s, "one_time_keyboard":% s, "seletivo":% s} ' 	\
				" $ {__ keyboard} " 																			\
				" $ {__ resize_keyboard : - false} "  															\
				" $ {__ on_time_keyboard : - false} " 															\
				" $ {__ seletivo : - falso} "

    	# status
    	retornar  $?
    }

	ShellBot.KeyboardButton ()
	{
		local __text __contato __localização __botão __line

		__param local = $ ( getopt --name " $ FUNCNAME " 	\
								--opções ' b: l: t: c: o: ' 	\
								--longoptions ' botão :,
												linha:,
												texto:,
												request_contact :,
												request_location: ' \
								- " $ @ " )
	
		eval  set - " $ __ param "
	
		enquanto  :
		Faz
			caso  $ 1  em
				-b | --botão)
					CheckArgType var " $ 1 "  " $ 2 "
					__botão = $ 2
					turno 2
					;;
				-l | --line)
					CheckArgType int " $ 1 "  " $ 2 "
					__line = $ (( $ 2 - 1 ))
					turno 2
					;;
				-t | --text)
					__text = $ 2
					turno 2
					;;
				-c | --request_contact)
					Boole CheckArgType " $ 1 "  " $ 2 "
					__contato = R $ 2
					turno 2
					;;
				-o | --request_location)
					Boole CheckArgType " $ 1 "  " $ 2 "
					__localização = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

    	[ botão [ $ __ ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-b, --button] "
    	[[ $ __ text ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --text] "
    	[[ $ __ line ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-l, --line] "
    
		__botão = botão $ __ [ linha $ __ ]

		botão  printf -v $ __ " botão $ { ! __ # [} "
		botão  printf -v $ __ " $ { ! __button % ]} "
		
		botão  printf -v $ __ ' % s {"texto": "% s", "request_contact":% s, "request_location":% s} '  	\
							" $ { ! __botão : + $ { ! __botão} ,} " 										\
							" $ {__ text} " 															\
							" $ {__ contact : - false} " 												\
							" $ {__ location : - false} "

		botão  printf -v $ __ " " [ $ { ! __botão} ] ""

    	retornar  $?
	}
	
	ShellBot.ForceReply ()
	{
		seletivo local

		parâmetro local = $ ( getopt --name " $ FUNCNAME "  			\
								--opções ' : '  				\
								--opções ' seletivas: '  	\
								- " $ @ " )

		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-s | --seletivo)
					Boole CheckArgType " $ 1 "  " $ 2 "
					seletivo = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		printf  ' {"force_reply": verdadeiro, "seletivo":% s} '  $ {seletivo : - falso}

		retornar  $?
	}

	ShellBot.ReplyKeyboardRemove ()
	{
		seletivo local

		parâmetro local = $ ( getopt --name " $ FUNCNAME "  			\
								--opções ' : '  				\
								--opções ' seletivas: '  	\
								- " $ @ " )

		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-s | --seletivo)
					Boole CheckArgType " $ 1 "  " $ 2 "
					seletivo = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		printf  ' {"remove_keyboard": verdadeiro, "seletivo":% s} '  $ {seletivo : - falso}

		retornar  $?
	}

    # Envia mensagens
    ShellBot.sendMessage ()
    {
    	# Variáveis ​​locais
    	texto do chat_id local parse_mode disable_web_page_preview
		local desativar_notificação reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: t: p: w: n: r: k: ' \
							 --longoptions ' chat_id :,
    										texto:,
    										parse_mode :,
    										disable_web_page_preview :,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-t | --text)
					texto = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-p | --parse_mode)
    				# Tipo: "markdown" ou "html"
    				Modo de verificação CheckArgType " $ 1 "  " $ 2 "
    				parse_mode = $ 2
    				turno 2
    				;;
    			-w | --disable_web_page_preview)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_web_page_preview = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	# Parâmetros obrigatórios.
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ text ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --text] "
    
    	# Chama o método da API, usando o comando request especificado; Os parâmetros
    	# e valores são passados ​​no form e lidos pelo método. O retorno do método é redirecionado para o arquivo 'update.Json'.
    	# Variáveis ​​com valores nulos são ignorados e consequentemente os parâmetros omitidos.
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {text : + -d text = " $ text " } \
									$ {parse_mode : + -d parse_mode = " $ parse_mode " } \
									$ {disable_web_page_preview : + -d disable_web_page_preview = " $ disable_web_page_preview " } \
									$ {disable_notification : + -d disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -d reply_to_message_id = " $ reply_to_message_id " } \
									$ {reply_markup : + -d reply_markup = " $ reply_markup " } )
   
    	# Teste ou retorno do método.
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	# Status
    	retornar  $?
    }
    
    # Função para recuperar mensagens de qualquer tipo.
    ShellBot.forwardMessage ()
    {
    	# Variáveis ​​locais
    	chat_id local form_chat_id desativar_notificação message_id jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: f: n: m: ' \
    						 --longoptions ' chat_id :,
    										from_chat_id :,
    										desativar notificação:,
    										message_id: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = " $ 2 "
    				turno 2
    				;;
    			-f | --de_chat_id)
    				from_chat_id = " $ 2 "
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = " $ 2 "
    				turno 2
    				;;
    			-m | --message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				message_id = " $ 2 "
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios.
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ from_chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-f, --from_chat_id] "
    	[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
    
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {from_chat_id : + -d from_chat_id = " $ from_chat_id " } \
									$ {disable_notification : + -d disable_notification = " $ disable_notification " } \
									$ {message_id : + -d message_id = " $ message_id " } )
    	
    	# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# status
    	retornar  $?
    }
    
    # Utilize essa função para enviar fotos.
    ShellBot.sendPhoto ()
    {
    	# Variáveis ​​locais
    	local chat_id foto legenda desativar_notificação reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: p: t: n: r: k: ' \
    						 --longoptions ' chat_id :,
    										foto:,
    										rubrica:,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-p | --photo)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				photo = $ 2
    				turno 2
    				;;
    			-t | --caption)
    				# Limite máximo de caracteres: 200
					legenda = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ foto ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-p, --photo] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {photo : + -F photo = " $ photo " } \
									$ {caption : + -F caption = " $ caption " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
									$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    	
    	# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }
    
    # Utilize essa função para enviar arquivos de áudio.
    ShellBot.sendAudio ()
    {
    	# Variáveis ​​locais
    	chat_id local legenda de áudio duração intérprete título disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: a: t: d: e: i: n: r: k ' \
    						 --longoptions ' chat_id :,
    										áudio :,
    										rubrica:,
    										duração:,
    										artista:,
    										título:,
    										desativar notificação:,
    										reply_to_message_id :,	
    										reply_markup: ' \
    						 - " $ @ " )
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-a | --audio)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				audio = $ 2
    				turno 2
    				;;
    			-t | --caption)
					legenda = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-d | --duração)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				duration = $ 2
    				turno 2
    				;;
    			-e | --performer)
    				executante = $ 2
    				turno 2
    				;;
    			-i | --title)
    				title = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ audio ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-a, --audio] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {audio : + -F audio = " $ audio " } \
									$ {caption : + -F caption = " $ caption " } \
									$ {duration : + -F duration = " $ duration " } \
									$ {artista : + -F artista = " $ artista " } \
									$ {title : + -F title = " $ title " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
									$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    		
    }
    
    # Utilize essa função para enviar documentos.
    ShellBot.sendDocument ()
    {
    	# Variáveis ​​locais
    	local do chat_id legenda do documento disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: d: t: n: r: k: ' \
    						 --longoptions ' chat_id :,
											documento:,
    										rubrica:,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-d | --documento)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				document = $ 2
    				turno 2
    				;;
    			-t | --caption)
					legenda = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-n | --disable_notification)
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ document ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-d, --document] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {document : + -F document = " $ document " } \
									$ {caption : + -F caption = " $ caption " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
									$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    	
    }
    
    # Utilize essa função para enviat stickers
    ShellBot.sendSticker ()
    {
    	# Variáveis ​​locais
    	etiqueta do chat_id local desativar_notificação reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: s: n: r: k: ' \
    						 --longoptions ' chat_id :,
    										adesivo :,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-s | --ticker)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				sticker = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ adesivo ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --sticker] "
    
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {adesivo : + -F adesivo = " $ adesivo " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
									$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }
   
	ShellBot.getStickerSet ()
	{
		nome local jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' n: ' \
							 --longoptions ' name: ' \
							 - " $ @ " )
		
		# parâmetros posicionais
		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-n | --name)
					name = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
    	
		[[ $ name ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-n, --name] "
    	
		jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .}  $ {name : + nome -d = " $ name " } )
    
		# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
	} 
	
	ShellBot.uploadStickerFile ()
	{
		user_id local png_sticker jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' u: s: ' \
							 --long_options ' user_id :,
											png_sticker: ' \
							 - " $ @ " )
		
		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
					user_id = $ 2
					turno 2
					;;
				-s | --png_sticker)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					png_sticker = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
				esac
		feito

		[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
		[[ $ png_sticker ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --png_sticker] "
    	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {user_id : + -F user_id = " $ user_id " } \
									$ {png_sticker : + -F png_sticker = " $ png_sticker " } )
    	
		# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
					
	}

	ShellBot.setStickerPositionInSet ()
	{
		posição local do adesivo jq_obj

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' s: p: ' \
- adesivo das 							 opções :
											posição: ' \
							 - " $ @ " )
		
		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-s | --ticker)
					sticker = $ 2
					turno 2
					;;
				-p | --position)
					CheckArgType int " $ 1 "  " $ 2 "
					position = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
		
		[[ $ adesivo ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --sticker] "
		[[ posição $ ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-p, --position] "
    	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {adesivo : + -d adesivo = " $ adesivo " } \
									$ {position : + -d position = " $ position " } )
    	
		# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
		# Status
    	retornar  $?
				
	}
	
	ShellBot.deleteStickerFromSet ()
	{
		adesivo local jq_obj

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' : ' \
							 --longoptions ' sticker: ' \
							 - " $ @ " )
		
		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-s | --ticker)
					sticker = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
		
		[[ $ adesivo ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --sticker] "
    	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .}  $ {adesivo : + -d adesivo = " $ adesivo " } )
    	
		# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
		# Status
    	retornar  $?
				
	}
	
	ShellBot.stickerMaskPosition ()
	{

		ponto local x_shift y_shift scale zoom
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' p: x: y: s: z: ' \
- ponto das 							 opções :
											x_shift :,
											y_shift :,
											escala:,
											zoom: ' \
							 - " $ @ " )

		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-p | --point)
					Ponto CheckArgType " $ 1 "  " $ 2 "
					point = $ 2
					turno 2
					;;
				-x | --x_shift)
					Carro alegórico CheckArgType " $ 1 "  " $ 2 "
					x_shift = $ 2
					turno 2
					;;
				-y | --y_shift)
					Carro alegórico CheckArgType " $ 1 "  " $ 2 "
					y_shift = $ 2
					turno 2
					;;
				-s | --scale)
					Carro alegórico CheckArgType " $ 1 "  " $ 2 "
					scale = $ 2
					turno 2
					;;
				-z | --zoom)
					Carro alegórico CheckArgType " $ 1 "  " $ 2 "
					zoom = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
		
		[[ $ point ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-p, --point] "
		[[ $ x_shift ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-x, --x_shift] "
		[[ $ y_shift ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-y, --y_shift] "
		[[ $ scale ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --scale] "
		[[ $ zoom ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-z, --zoom] "
		
		cat <<  _EOF
{"point": "$ point", "x_shift": $ x_shift, "y_shift": $ y_shift, "scale": $ scale, "zoom": $ zoom}
_EOF

	retornar 0

	}

	ShellBot.createNewStickerSet ()
	{
		nome_do_usuário local nome título png_sticker emojis contains_masks mask_position jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' u: n: t: s: e: c: m: ' \
							 --long_options ' user_id :,
											nome:,
											título:,
											png_sticker :,
											emojis :,
											contains_mask :,
											mask_position: ' \
							 - " $ @ " )

		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-u | --user_id)
					CheckArgType int " $ 1 "  " $ 2 "
					user_id = $ 2
					turno 2
					;;
				-n | --name)
					name = $ 2
					turno 2
					;;
				-t | --title)
					title = $ 2
					turno 2
					;;
				-s | --png_sticker)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					png_sticker = $ 2
					turno 2
					;;
				-e | --emojis)
					emojis = $ 2
					turno 2
					;;
				-c | --contains_masks)
    				Boole CheckArgType " $ 1 "  " $ 2 "
					contains_masks = $ 2
					turno 2
					;;
				-m | --mask_position)
					mask_position = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
		
		[[ $ user_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
		[[ $ name ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-n, --name] "
		[[ $ title ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --title] "
		[[ $ png_sticker ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --png_sticker] "
		[[ $ emojis ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-e, --emojis] "
	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {user_id : + -F user_id = " $ user_id " } \
									$ {name : + -F name = " $ name " } \
									$ {title : + -F title = " $ title " } \
									$ {png_sticker : + -F png_sticker = " $ png_sticker " } \
									$ {emojis : + -F emojis = " $ emojis " } \
									$ {contains_masks : + -F contains_masks = " $ contains_masks " } \
									$ {mask_position : + -F mask_position = " $ mask_position " } )
    	
		# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
		# Status
    	retornar  $?
			
	}
	
	ShellBot.addStickerToSet ()
	{
		nome do usuário_id local png_sticker emojis mask_position jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' u: n: s: e: m: ' \
							 --long_options ' user_id :,
											nome:,
											png_sticker :,
											emojis :,
											mask_position: ' \
							 - " $ @ " )

		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-u | --user_id)
					CheckArgType int " $ 1 "  " $ 2 "
					user_id = $ 2
					turno 2
					;;
				-n | --name)
					name = $ 2
					turno 2
					;;
				-s | --png_sticker)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					png_sticker = $ 2
					turno 2
					;;
				-e | --emojis)
					emojis = $ 2
					turno 2
					;;
				-m | --mask_position)
					mask_position = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
		
		[[ $ user_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
		[[ $ name ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-n, --name] "
		[[ $ png_sticker ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --png_sticker] "
		[[ $ emojis ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-e, --emojis] "
	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {user_id : + -F user_id = " $ user_id " } \
									$ {name : + -F name = " $ name " } \
									$ {png_sticker : + -F png_sticker = " $ png_sticker " } \
									$ {emojis : + -F emojis = " $ emojis " } \
									$ {mask_position : + -F mask_position = " $ mask_position " } )
    	
		# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
		# Status
    	retornar  $?
			
	}

    # Função para enviar arquivos de vídeo.
    ShellBot.sendVideo ()
    {
    	# Variáveis ​​locais
    	chat_id local duração do vídeo largura altura legenda desativar_notificação \
				reply_to_message_id reply_markup jq_obj suporta_streaming
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: v: d: w: h: t: n: r: k: s: ' \
							 --longoptions ' chat_id :,
    										vídeo:,
    										duração:,
    										largura:,
    										altura:,
    										rubrica:,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup :,
											apoia_streaming: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-v | --video)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				video = $ 2
    				turno 2
    				;;
    			-d | --duração)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				duration = $ 2
    				turno 2
    				;;
    			-w | --width)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				width = $ 2
    				turno 2
    				;;
    			-h | --height)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				height = $ 2
    				turno 2
    				;;
    			-t | --caption)
					legenda = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
				-s | --supports_streaming)
    				Boole CheckArgType " $ 1 "  " $ 2 "
					apoia_streaming = $ 2
					turno 2
					;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios.
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ video ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-v, --video] "
    
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {video : + -F video = " $ video " } \
									$ {duration : + -F duration = " $ duration " } \
									$ {width : + -F width = " $ width " } \
									$ {height : + -F height = " $ height " } \
									$ {caption : + -F caption = " $ caption " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
    								$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } \
									$ {support_streaming : + -F apoia_streaming = " $ suporta_streaming " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    	
    }
    
    # Função para enviar áudio.
    ShellBot.sendVoice ()
    {
    	# Variáveis ​​locais
    	duração da legenda de voz do chat_id local disable_notification reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: v: t: d: n: r: k: ' \
    						 --longoptions ' chat_id :,
    										voz:,
    										rubrica:,
    										duração:,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-v | --voice)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
    				voz = $ 2
    				turno 2
    				;;
    			-t | --caption)
					legenda = $ ( eco -e " $ 2 " )
    				turno 2
    				;;
    			-d | --duração)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				duration = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios.
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ voz ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-v, --voice] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
    								$ {voice : + -F voice = " $ voice " } \
    								$ {caption : + -F caption = " $ caption " } \
    								$ {duration : + -F duration = " $ duration " } \
    								$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
    								$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    	
    }
    
    # Função usada para enviar uma localidade usando coordenadas de latitude e longitude.
    ShellBot.sendLocation ()
    {
    	# Variáveis ​​locais
    	chat_id local latitude longitude live_period
		local desativar_notificação reply_to_message_id reply_markup jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: l: g: p: n: r: k: ' \
    						 --longoptions ' chat_id :,
    										latitude:,
    										longitude:,
											live_period :,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-l | --latitude)
    				# Tipo: flutuador
    				Carro alegórico CheckArgType " $ 1 "  " $ 2 "
    				latitude = $ 2
    				turno 2
    				;;
    			-g | - longitude)
    				# Tipo: flutuador
    				Carro alegórico CheckArgType " $ 1 "  " $ 2 "
    				longitude = $ 2
    				turno 2
    				;;
				-p | --live_period)
    				CheckArgType int " $ 1 "  " $ 2 "
					live_period = $ 2
					turno 2
					;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ latitude ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-l, --latitude] "
    	[[ $ longitude ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-g, --longitude] "
    			
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
    								$ {latitude : + -F latitude = " $ latitude " } \
    								$ {longitude : + -F longitude = " $ longitude " } \
									$ {live_period : + -F live_period = " $ live_period " } \
    								$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
    								$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    	
    }
    
    # Função utlizada para enviar detalhes de um local.
    ShellBot.sendVenue ()
    {
    	# Variáveis ​​locais
    	chat_id local latitude longitude título endereço foursquare_id desativar_notificação reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: l: g: i: a: f: n: r: k: ' \
    						 --longoptions ' chat_id :,
    										latitude:,
    										longitude:,
    										título:,
    										endereço:,
    										foursquare_id :,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-l | --latitude)
    				# Tipo: flutuador
    				Carro alegórico CheckArgType " $ 1 "  " $ 2 "
    				latitude = $ 2
    				turno 2
    				;;
    			-g | - longitude)
    				# Tipo: flutuador
    				Carro alegórico CheckArgType " $ 1 "  " $ 2 "
    				longitude = $ 2
    				turno 2
    				;;
    			-i | --title)
    				title = $ 2
    				turno 2
    				;;
    			-a | - endereço)
    				address = $ 2
    				turno 2
    				;;
    			-f | --foursquare_id)
    				foursquare_id = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
    		esac
    	feito
    			
    	# Parâmetros obrigatórios.
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ latitude ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-l, --latitude] "
    	[[ $ longitude ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-g, --longitude] "
    	[[ $ title ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-i, --title] "
    	[[ endereço $ ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-a, --address] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
    								$ {latitude : + -F latitude = " $ latitude " } \
    								$ {longitude : + -F longitude = " $ longitude " } \
    								$ {title : + -F title = " $ title " } \
    								$ {address : + -F address = " $ address " } \
    								$ {foursquare_id : + -F foursquare_id = " $ foursquare_id " } \
    								$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
    								$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }
    
    # Utilize essa função para enviar um contato + número
    ShellBot.sendContact ()
    {
    	# Variáveis ​​locais
    	chat_id local phone_number first_name last_name disable_notification reply_to_message_id reply_markup jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: p: f: l: n: r: k: ' \
    						 --longoptions ' chat_id :,
    										número de telefone:,
    										primeiro nome:,
    										último nome:,
    										desativar notificação:,
    										reply_to_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-p | --phone_number)
    				phone_number = $ 2
    				turno 2
    				;;
    			-f | --primeiro_nome)
    				first_name = $ 2
    				turno 2
    				;;
    			-l | --último nome)
    				last_name = $ 2
    				turno 2
    				;;
    			-n | --disable_notification)
    				# Tipo: boolean
    				Boole CheckArgType " $ 1 "  " $ 2 "
    				disable_notification = $ 2
    				turno 2
    				;;
    			-r | --reply_to_message_id)
    				# Tipo: inteiro
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
    				;;
    			-k | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios.	
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ phone_number ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-p, --phone_number] "
    	[[ $ first_name ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-f, --first_name] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
    								$ {phone_number : + -F phone_number = " $ phone_number " } \
    								$ {first_name : + -F first_name = " $ first_name " } \
    								$ {last_name : + -F last_name = " $ last_name " } \
    								$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
    								$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }
    
    # Envia uma ação para bot.
    ShellBot.sendChatAction ()
    {
    	# Variáveis ​​locais
    	ação local chat_id jq_obj
    	
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: a: ' \
    						 --longoptions ' chat_id :,
    										ação: ' \
    						 - " $ @ " )
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-a | --action)
    				Ação CheckArgType " $ 1 "  " $ 2 "
    				ação = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
    		esac
    	feito
    
    	# Parâmetros obrigatórios.		
    	[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ ação ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-a, --action] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {action : + -d action = " $ action " } )
    	
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }
    
    # Utilize essa função para obter como fotos de um usuário determinado.
    ShellBot.getUserProfilePhotos ()
    {
    	# Variáveis ​​locais
    	limite de deslocamento local user_id ind último índice máximo de item total jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' u: o: l: ' \
    						 --long_options ' user_id :,
    										deslocamento :,
    										limite: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    	
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				user_id = $ 2
    				turno 2
    				;;
    			-o | --offset)
    				CheckArgType int " $ 1 "  " $ 2 "
    				deslocamento = $ 2
    				turno 2
    				;;
    			-l | --limit)
    				CheckArgType int " $ 1 "  " $ 2 "
    				limite = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios.
    	[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
    	
    	# Chama o método
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .} \
									$ {user_id : + -d user_id = " $ user_id " } \
									$ {offset : + -d offset = " $ offset " } \
									$ {limit : + -d limit = " $ limit " } )
  
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	# Status
    	retornar  $?
    }
    
    # Função para listar informações do arquivo especificado.
    ShellBot.getFile ()
    {
    	# Variáveis ​​locais
    	local file_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' f: ' \
    						 --longoptions ' file_id: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-f | --_file_id)
    				file_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parâmetros obrigatórios.
    	[[ $ file_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-f, --file_id] "
    	
    	# Chama o método.
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .}  $ {file_id : + -d file_id = " $ file_id " } )
    
    	# Teste ou retorno do método.
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }		
    
    # Essa função permite ao usuário conversar ou canal. (somente recrutas)
    ShellBot.kickChatMember ()
    {
    	# Variáveis ​​locais
    	local chat_id user_id até a data jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: u: d: ' \
    						 --longoptions ' chat_id :,
    										ID do usuário:,
    										até_data: ' \
    						 - " $ @ " )
    
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	# Trata os parâmetros
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				user_id = $ 2
    				turno 2
    				;;
    			-d | --until_date)
    				CheckArgType int " $ 1 "  " $ 2 "
    				até_data = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	# Parametros obrigatórios.
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
    	
    	# Chama o método
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {user_id : + -d user_id = " $ user_id " } \
    								$ {till_date : + -d till_date = " $ till_date " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
    }
    
    # Utilize essa função para remover ou bot do grupo ou canal.
    ShellBot.leaveChat ()
    {
    	# Variáveis ​​locais
    	local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
    						 --longoptions ' chat_id: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    	
    }
    
    ShellBot.unbanChatMember ()
    {
    	local chat_id user_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: u: ' \
    						 --longoptions ' chat_id :,
    										ID do usuário: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				user_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {user_id : + -d user_id = " $ user_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    }
    
    ShellBot.getChat ()
    {
    	# Variáveis ​​locais
    	local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
    						 --longoptions ' chat_id: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	# Status
    	retornar  $?
    }
    
    ShellBot.getChatAdministrators ()
    {
    	índice total de chaves local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
    						 --longoptions ' chat_id: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status	
    	retornar  $?
    }
    
    ShellBot.getChatMembersCount ()
    {
    	local chat_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: ' \
    						 --longoptions ' chat_id: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    }
    
    ShellBot.getChatMember ()
    {
    	# Variáveis ​​locais
    	local chat_id user_id jq_obj
    
    	# Lê os parâmetros da função
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: u: ' \
    						 --longoptions ' chat_id :,
    						 				ID do usuário: ' \
    						 - " $ @ " )
    
    	
    	# Definir os parâmetros posicionais
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-c | --chat_id)
    				chat_id = $ 2
    				turno 2
    				;;
    			-u | --user_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				user_id = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
    				;;
    		esac
    	feito
    	
    	[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ user_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --user_id] "
    	
    	jq_obj = $ ( onda $ _CURL_OPT_ GET $ _API_TELEGRAM_ / $ {funcname # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {user_id : + -d user_id = " $ user_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
    }
    
    ShellBot.editMessageText ()
    {
    	chat_id local message_id inline_message_id text parse_mode disable_web_page_preview reply_markup jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: m: i: t: p: w: r: ' \
    						 --longoptions ' chat_id :,
    										message_id :,
    										inline_message_id :,
    										texto:,
    										parse_mode :,
    										disable_web_page_preview :,
    										reply_markup: ' \
    						 - " $ @ " )
    	
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    			caso  $ 1  em
    				-c | --chat_id)
    					chat_id = $ 2
    					turno 2
    					;;
    				-m | --message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					message_id = $ 2
    					turno 2
    					;;
    				-i | --inline_message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					inline_message_id = $ 2
    					turno 2
    					;;
    				-t | --text)
						texto = $ ( eco -e " $ 2 " )
    					turno 2
    					;;
    				-p | --parse_mode)
    					Modo de verificação CheckArgType " $ 1 "  " $ 2 "
    					parse_mode = $ 2
    					turno 2
    					;;
    				-w | --disable_web_page_preview)
    					Boole CheckArgType " $ 1 "  " $ 2 "
    					disable_web_page_preview = $ 2
    					turno 2
    					;;
    				-r | --reply_markup)
    					reply_markup = $ 2
    					turno 2
    					;;
    				-)
    					mudança
    					quebrar
						;;
    			esac
    	feito
    	
    	[[ $ text ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --text] "
		[[ $ Inline_message_id ]] &&  unset chat_id message_id || {
			[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
			[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
		}
    	
    
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {message_id : + -d message_id = " $ message_id " } \
    								$ {inline_message_id : + -d inline_message_id = " $ inline_message_id " } \
    								$ {text : + -d text = " $ text " } \
    								$ {parse_mode : + -d parse_mode = " $ parse_mode " } \
    								$ {disable_web_page_preview : + -d disable_web_page_preview = " $ disable_web_page_preview " } \
    								$ {reply_markup : + -d reply_markup = " $ reply_markup " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
    	
    }
    
    ShellBot.editMessageCaption ()
    {
    	local chat_id message_id legenda inline_message_id legenda reply_markup jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 - opções ' c: m: i: t: r: ' \
    						 --longoptions ' chat_id :,
    										message_id :,
    										inline_message_id :,
    										rubrica:,
    										reply_markup: ' \
    						 - " $ @ " )
    	
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    			caso  $ 1  em
    				-c | --chat_id)
    					chat_id = $ 2
    					turno 2
    					;;
    				-m | --message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					message_id = $ 2
    					turno 2
    					;;
    				-i | --inline_message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					inline_message_id = $ 2
    					turno 2
    					;;
    				-t | --caption)
						legenda = $ ( eco -e " $ 2 " )
    					turno 2
    					;;
    				-r | --reply_markup)
    					reply_markup = $ 2
    					turno 2
    					;;
    				-)
    					mudança
    					quebrar
						;;
    			esac
    	feito
    				
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
    	
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {message_id : + -d message_id = " $ message_id " } \
    								$ {inline_message_id : + -d inline_message_id = " $ inline_message_id " } \
    								$ {legenda : + -d legenda = " $ legenda " } \
    								$ {reply_markup : + -d reply_markup = " $ reply_markup " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
    	
    }
    
    ShellBot.editMessageReplyMarkup ()
    {
    	local chat_id message_id inline_message_id reply_markup jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: m: i: r: ' \
    						 --longoptions ' chat_id :,
    										message_id :,
    										inline_message_id :,
    										reply_markup: ' \
    						 - " $ @ " )
    	
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    			caso  $ 1  em
    				-c | --chat_id)
    					chat_id = $ 2
    					turno 2
    					;;
    				-m | --message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					message_id = $ 2
    					turno 2
    					;;
    				-i | --inline_message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					inline_message_id = $ 2
    					turno 2
    					;;
    				-r | --reply_markup)
    					reply_markup = $ 2
    					turno 2
    					;;
    				-)
    					mudança
    					quebrar
						;;
    			esac
    	feito
		
		[[ $ Inline_message_id ]] &&  unset chat_id message_id || {
			[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
			[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
		}
    
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {message_id : + -d message_id = " $ message_id " } \
     								$ {inline_message_id : + -d inline_message_id = " $ inline_message_id " } \
    								$ {reply_markup : + -d reply_markup = " $ reply_markup " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
    	
    }
    
    ShellBot.deleteMessage ()
    {
    	local chat_id message_id jq_obj
    	
    	parâmetro local = $ ( getopt --name " $ FUNCNAME " \
							 --opções ' c: m: ' \
    						 --longoptions ' chat_id :,
    										message_id: ' \
    						 - " $ @ " )
    	
    	eval  set - " $ param "
    
    	enquanto  :
    	Faz
    			caso  $ 1  em
    				-c | --chat_id)
    					chat_id = $ 2
    					turno 2
    					;;
    				-m | --message_id)
    					CheckArgType int " $ 1 "  " $ 2 "
    					message_id = $ 2
    					turno 2
    					;;
    				-)
    					mudança
    					quebrar
						;;
    			esac
    	feito
    	
    	[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
    	[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
    
    	jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
    								$ {message_id : + -d message_id = " $ message_id " } )
    
    	# Verifica se ocorreram erros durante a chamada do método	
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
    
    }
   
	ShellBot.downloadFile () {
	
		diretório local do caminho do arquivo
		uri local = " https://api.telegram.org/file/bot $ _TOKEN_ "

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' f: d: ' \
								--longoptions ' file_path :,
												dir: ' \
								- " $ @ " )
		
		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-f | --file_path)
					file_path = $ 2
					turno 2
					;;
				-d | --dir)
					[[ -d  $ 2 ]] && {
						[[ -w  $ 2 ]] || API MessageError " $ _ERR_DIR_WRITE_DENIED_ "  " $ 1 "  " $ 2 "
					} || API MessageError " $ _ERR_DIR_NOT_FOUND_ "  " $ 1 "  " $ 2 "
					dir = $ {2 % / }
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ $ file_path ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-f, --file_path] "
		[[ $ dir ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-d, --dir] "

		dir = $ ( mktemp -u --tmpdir = " $ dir "  " ficheiro $ ( data +% d% M% Y% H% H% S ) -XXXXX $ {ext : . + $ ext } " )
		wget " $ uri / $ file_path " -O " $ dir "  e > / dev / null || API MessageError " $ _ERR_FILE_DOWNLOAD_ "  " $ file_path "
				
		retornar  $?
	}

	ShellBot.editMessageLiveLocation ()
	{
		chat_id local message_id inline_message_id
		longitude da latitude local reply_markup jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' c: m: i: l: g: r: ' \
								--longoptions ' chat_id :,
												message_id :,
												inline_message_id :,
												latitude:,
												longitude:,
												reply_markup: ' \
								- " $ @ " )
		
		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-m | --message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
					message_id = $ 2
					turno 2
					;;
    			-i | --inline_message_id)
					CheckArgType int " $ 1 "  " $ 2 "
					inline_message_id = $ 2
					turno 2
					;;
    			-l | --latitude)
    				# Tipo: flutuador
    				Carro alegórico CheckArgType " $ 1 "  " $ 2 "
    				latitude = $ 2
    				turno 2
    				;;
    			-g | - longitude)
    				# Tipo: flutuador
    				Carro alegórico CheckArgType " $ 1 "  " $ 2 "
    				longitude = $ 2
    				turno 2
    				;;
    			-r | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
			esac
		feito
	
		[[ $ Inline_message_id ]] &&  unset chat_id message_id || {
			[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
			[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
		}
    	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {message_id : + -d message_id = " $ message_id " } \
									$ {inline_message_id : + -d inline_message_id = " $ inline_message_id " } \
    								$ {latitude : + -d latitude = " $ latitude " } \
    								$ {longitude : + -d longitude = " $ longitude " } \
    								$ {reply_markup : + -d reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
	}	

	ShellBot.stopMessageLiveLocation ()
	{
		local chat_id message_id inline_message_id reply_markup jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' c: m: i: r: ' \
								--longoptions ' chat_id :,
												message_id :,
												inline_message_id :,
												reply_markup: ' \
								- " $ @ " )
		
		eval  set - " $ param "

		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-m | --message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
					message_id = $ 2
					turno 2
					;;
    			-i | --inline_message_id)
					CheckArgType int " $ 1 "  " $ 2 "
					inline_message_id = $ 2
					turno 2
					;;
    			-r | --reply_markup)
    				reply_markup = $ 2
    				turno 2
    				;;
    			-)
    				mudança
    				quebrar
					;;
			esac
		feito
	
		[[ $ Inline_message_id ]] &&  unset chat_id message_id || {
			[[ $ chat_id ]] 		 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
			[[ $ message_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --message_id] "
		}
    	
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {message_id : + -d message_id = " $ message_id " } \
									$ {inline_message_id : + -d inline_message_id = " $ inline_message_id " } \
    								$ {reply_markup : + -d reply_markup = " $ reply_markup " } )
    
    	# Teste de retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	retornar  $?
	}

	ShellBot.setChatStickerSet ()
	{
		local chat_id sticker_set_name jq_obj

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' c: s: ' \
								--longoptions ' chat_id :,
												sticker_set_name: ' \
								- " $ @ " )
		
		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-s | --sticker_set_name)
					sticker_set_name = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ $ chat_id ]] 			 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
		[[ $ sticker_set_name ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, - --sticker_set_name] "
		
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -d chat_id = " $ chat_id " } \
									$ {sticker_set_name : + -d sticker_set_name = " $ sticker_set_name " } )
		
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
		retornar  $?
	}

	ShellBot.deleteChatStickerSet ()
	{
		local chat_id jq_obj

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' c: ' \
								--longoptions ' chat_id: ' \
								- " $ @ " )
		
		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
		
		jq_obj = $ ( onda $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {funcname # * .}  $ {chat_id : + -d chat_id = " $ chat_id " } )
		
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    	
    	retornar  $?
	}
	
	ShellBot.inputMedia ()
	{
		__type local __input __media __caption __parse_mode __thumb __width
		local __height __duração __supports_streaming __performer __título

		__param local = $ ( getopt --name " $ FUNCNAME " \
								--options ' t: i: m: c: p: b: W: H: d: s: f: e: ' \
								--longoptions ' type :,
												entrada:,
												meios de comunicação:,
												rubrica:,
												parse_mode :,
												polegar:,
												witdh :,
												altura:,
												duração:,
												suporta_streaming :,
												artista:,
												title: ' \
								- " $ @ " )
	
	
		eval  set - " $ __ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-t | --type)
					Tipo de mídia CheckArgType " $ 1 "  " $ 2 "
					__type = $ 2
					turno 2
					;;
				-i | --input)
					CheckArgType var " $ 1 "  " $ 2 "
					__input = US $ 2
					turno 2
					;;
				-m | --media)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					__media = $ 2
					turno 2
					;;
				-c | --caption)
					__caption = $ ( eco -e " $ 2 " )
					turno 2
					;;
				-p | --parse_mode)
					Modo de verificação CheckArgType " $ 1 "  " $ 2 "
					__parse_mode = $ 2
					turno 2
					;;
				-b | --thumb)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					__thumb = $ 2
					turno 2
					;;
				-w | --width)
					CheckArgType int " $ 1 "  " $ 2 "
					__width = $ 2
					turno 2
					;;
				-h | --height)
					CheckArgType int " $ 1 "  " $ 2 "
					__height = $ 2
					turno 2
					;;
				-d | --duração)
					CheckArgType int " $ 1 "  " $ 2 "
					__duração = $ 2
					turno 2
					;;
				-s | --supports_streaming)
					Boole CheckArgType " $ 1 "  " $ 2 "
					__supports_streaming = $ 2
					turno 2
					;;
				-f | --performer)
					__performer = $ 2
					turno 2
					;;
				-e | --title)
					__title = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ tipo $ __ ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-t, --type] "
		[[ entrada $ __ ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-i, --input] "
		[[ $ __ mídia ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --media] "

		local -n __input
		
    	__input = " $ {__ input : + $ __ input ,} { \" type \ " : \" $ __ type \ " , "
		__input + = " \" media \ " : \" $ __ media \ " "
		__input + = " $ {__ legenda : +, \" legenda \ " : \" $ __ legenda \ " } "
		__input + = " $ {__ parse_mode : +, \" parse_mode \ " : \" $ __ parse_mode \ " } "
		__input + = " $ {__ thumb : +, \" thumb \ " : \" $ __ thumb \ " } "
		__input + = " $ {__ width : +, \" width \ " : \" $ __ width \ " } "
		__input + = " $ {__ height : +, \" height \ " : \" $ __ height \ " } "
		__input + = " $ {__ duration : +, \" duration \ " : \" $ __ duration \ " } "
		__input + = " $ {__ supports_streaming : +, \" supports_streaming \ " : $ __ supports_streaming } "
		__input + = " $ {__ artista : +, \" artista \ " : \" $ __ artista \ " } "
		__input + = " $ {__ title : +, \" title \ " : \" $ __ title \ " } } "

		retornar  $?
	}

	ShellBot.sendMediaGroup ()
	{
		mídia de chat_id local desativar_notificação reply_to_message_id jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								- opções ' c: m: n: r: ' \
								--longoptions ' chat_id :,
												meios de comunicação:,
												desativar notificação:,
												reply_to_message_id: ' \
								- " $ @ " )
	
		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-m | --media)
					mídia = [ $ 2 ]
					turno 2
					;;
				-n | --disable_notification)
    				Boole CheckArgType " $ 1 "  " $ 2 "
					disable_notification = $ 2
					turno 2
					;;
				-r | --reply_to_message_id)
    				CheckArgType int " $ 1 "  " $ 2 "
    				reply_to_message_id = $ 2
    				turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ $ chat_id ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
		[[ $ media ]] 	 || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --media] "
		
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
    								$ {media : + -F media = " $ media " } \
    								$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
    								$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } )
    
		# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
	}

	ShellBot.editMessageMedia ()
	{
		local chat_id message_id inline_message_id media reply_markup jq_obj

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								- opções ' c: i: n: m: k: ' \
								--longoptions	 ' chat_id :,
												message_id :,
												inline_message_id :,
												meios de comunicação:,
												reply_markup: ' 	\
								- " $ @ " )

		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-i | --message_id)
					CheckArgType int " $ 1 "  " $ 2 "
					message_id = $ 2
					turno 2
					;;
				-n | --inline_message_id)
					CheckArgType int " $ 1 "  " $ 2 "
					inline_message_id = $ 2
					turno 2
					;;
				-m | --media)
					media = $ 2
					turno 2
					;;
				-k | --reply_markup)
					reply_markup = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ $ inline_message_id ]] || {
			[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
			[[ $ message_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-i, --message_id] "
		}
		
		[[ $ media ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-m, --media] "
		
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {message_id : + -F message_id = " $ message_id " } \
									$ {inline_message_id : + -F inline_message_id = " $ inline_message_id " } \
    								$ {media : + -F media = " $ media " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } )   
		 
		# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
	}

	ShellBot.sendAnimation ()
	{
		animação chat_id local duração largura altura
		legenda do dedo local parse_mode disable_notification
		local reply_to_message_id reply_markup jq_obj
		
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								- opções ' c: a: d: w: h: b: o: p: n: r: k: ' \
								--longoptions ' chat_id :,
												animação:,
												duração:,
												largura:,
												altura:,
												polegar:,
												rubrica:,
												parse_mode :,
												desativar notificação:,
												reply_to_message_id :,
												reply_markup: ' \
								- " $ @ " )
		
		eval  set - " $ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-c | --chat_id)
					chat_id = $ 2
					turno 2
					;;
				-a | --animação)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					animação = $ 2
					turno 2
					;;
				-d | --duração)
					CheckArgType int " $ 1 "  " $ 2 "
					duartion = $ 2
					turno 2
					;;
				-w | --width)
					CheckArgType int " $ 1 "  " $ 2 "
					width = $ 2
					turno 2
					;;
				-h | --height)
					CheckArgType int " $ 1 "  " $ 2 "
					height = $ 2
					turno 2
					;;
				-b | --thumb)
					Arquivo CheckArgType " $ 1 "  " $ 2 "
					thumb = $ 2
					turno 2
					;;
				-o | --caption)
					legenda = $ ( eco -e " $ 2 " )
					turno 2
					;;
				-p | --parse_mode)
					Modo de verificação CheckArgType " $ 1 "  " $ 2 "
					parse_mode = $ 2
					turno 2
					;;
				-n | --disable_notification)
					Boole CheckArgType " $ 1 "  " $ 2 "
					disable_notification = $ 2
					turno 2
					;;
				-r | --reply_to_message_id)
					CheckArgType int " $ 1 "  " $ 2 "
					reply_to_message_id = $ 2
					turno 2
					;;
				-k | --reply_markup)
					reply_markup = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito

		[[ $ chat_id ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-c, --chat_id] "
		[[ $ animação ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-a, --animation] "
		
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
									$ {chat_id : + -F chat_id = " $ chat_id " } \
									$ {animation : + -F animation = " $ animation " } \
									$ {duration : + -F duration = " $ duration " } \
									$ {width : + -F width = " $ width " } \
									$ {height : + -F height = " $ height " } \
									$ {thumb : + -F thumb = " $ thumb " } \
									$ {caption : + -F caption = " $ caption " } \
									$ {parse_mode : + -F parse_mode = " $ parse_mode " } \
									$ {disable_notification : + -F disable_notification = " $ disable_notification " } \
									$ {reply_to_message_id : + -F reply_to_message_id = " $ reply_to_message_id " } \
    								$ {reply_markup : + -F reply_markup = " $ reply_markup " } )   
		 
		# Retorno do método
    	MethodReturn $ jq_obj  || MessageError TG $ jq_obj
    
    	# Status
    	retornar  $?
	}

	ShellBot.setMessageRules ()
	{
		comando de ação local user_id nome de usuário chat_id
		locais chat_type tempo message_id linguagem data
		texto is_bot local entity_type file_type
		local query_data query_id query_text send_message
		regra exec local chat_member mime_type num_args
		local action_args dia da semana user_status chat_name
		local message_status reply_message rule_name parse_mode
		local forward_message reply_markup continue

		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--options ' s: a: z: c: i: U: H: v: y: l: m: b: t: n: p: p: q: r: g: o: e: d: w: j: x: ' \
								--longoptions	 ' name :,
												açao:,
												action_args :,
												comando:,
												ID do usuário:,
												nome de usuário :,
												chat_id :,
												nome no chat:,
												chat_type :,
												language_code :,
												message_id :,
												is_bot :,
												texto:,
												entitie_type :,
												tipo de arquivo:,
												mime_type :,
												query_data :,
												query_id :,
												chat_member :,
												num_args :,
												Tempo:,
												encontro:,
												dia da semana :,
												status do usuário:,
												message_status :,
												exec :,
												bot_reply_message :,
												bot_send_message :,
												bot_forward_message :,
												bot_reply_markup :,
												bot_parse_mode :,
												continue ' \
								- " $ @ " )
		
		eval  set - " $ param "
	
		enquanto  :
		Faz
			caso  $ 1  em
				-s | --name)
					Sinalizador CheckArgType " $ 1 "  " $ 2 "
					rule_name = $ 2
					turno 2
					;;
				-a | --action)
					CheckArgType func " $ 1 "  " $ 2 "
					ação = $ 2
					turno 2
					;;
				-z | --action_args)
					action_args = $ {2 // \\ / \\\\ }
					action_args = $ {action_args // | / \\ |}
					turno 2
					;;
				-c | --command)
					CheckArgType cmd " $ 1 "  " $ 2 "
					command = $ {command : + $ command ,} $ {2}
					turno 2
					;;
				-i | --user_id)
					user_id = $ {user_id : + $ user_id ,} $ {2 // | / \\ |}
					turno 2
					;;
				-u | --username)
					nome de usuário = $ {nome de usuário : + $ nome de usuário ,} $ {2 // | / \\ |}
					turno 2
					;;
				-h | --chat_id)
					chat_id = $ {chat_id : + $ chat_id ,} $ {2 // | / \\ |}
					turno 2
					;;
				-v | --chat_name)
					chat_name = $ {chat_name : + $ chat_name ,} $ {2 // | / \\ |}
					turno 2
					;;
				-y | --chat_type)
					chat_type = $ {chat_type : + $ chat_type ,} $ {2 // | / \\ |}
					turno 2
					;;
				-e | --time)
					CheckArgType itime " $ 1 "  " $ 2 "
					time = $ {time : + $ time ,} $ {2}
					turno 2
					;;
				-d | --data)
					CheckArgType idate " $ 1 "  " $ 2 "
					date = $ {date : + $ date ,} $ {2}
					turno 2
					;;
				-l | --laguage_code)
					idioma = $ {idioma : + $ idioma ,} $ {2 // | / \\ |}
					turno 2
					;;
				-m | --message_id)
					message_id = $ {message_id : + $ message_id ,} $ {2 // | / \\ |}
					turno 2
					;;
				-b | --is_bot)
					is_bot = $ {is_bot : + $ is_bot ,} $ {2 // | / \\ |}
					turno 2
					;;
				-t | --text)
					texto = $ {2 // | / \\ |}
					turno 2
					;;
				-n | --entitie_type)
					entity_type = $ {entity_type : + $ entity_type ,} $ {2 // | / \\ |}
					turno 2
					;;
				-f | --file_type)
					file_type = $ {file_type : + $ file_type ,} $ {2 // | / \\ |}
					turno 2
					;;
				-p | --mime_type)
					mime_type = $ {mime_type : + $ mime_type ,} $ {2 // | / \\ |}
					turno 2
					;;
				-q | --query_data)
					query_data = $ {query_data : + $ query_data ,} $ {2 // | / \\ |}
					turno 2
					;;
				-r | --query_id)
					query_id = $ {query_id : + $ query_id ,} $ {2 // | / \\ |}
					turno 2
					;;
				-g | --chat_member)
					chat_member = $ {chat_member : + $ chat_member ,} $ {2 // | / \\ |}
					turno 2
					;;
				-o | --num_args)
					num_args = $ {num_args : + $ num_args ,} $ {2 // | / \\ |}
					turno 2
					;;
				-w | --weekday)
					dia da semana = $ {dia da semana : + $ dia da semana ,} $ {2 // | / \\ |}
					turno 2
					;;
				-j | --user_status)
					user_status = $ {user_status : + $ user_status ,} $ {2 // | / \\ |}
					turno 2
					;;
				-x | --message_status)
					message_status = $ {message_status : + $ message_status ,} $ {2 // | / \\ |}
					turno 2
					;;
				--bot_reply_message)
					reply_message = $ {2 // \\ / \\\\ }
					reply_message = $ {reply_message // | / \\ |}
					turno 2
					;;
				--bot_send_message)
					send_message = $ {2 // \\ / \\\\ }
					send_message = $ {send_message // | / \\ |}
					turno 2
					;;
				--bot_forward_message)
					forward_message = $ {forward_message : + $ forward_message ,} $ {2 // | / \\ |}
					turno 2
					;;
				--bot_reply_markup)
					reply_markup = $ {2 // \\ / \\\\ }
					reply_markup = $ {reply_markup // | / \\ |}
					turno 2
					;;
				--bot_parse_mode)
					parse_mode = $ {2 // | / \\ |}
					turno 2
					;;
				--exec)
					exec = $ {2 // \\ / \\\\ }
					exec = $ {exec // | / \\ |}
					turno 2
					;;
				--continuar)
					continue = true
					mudança
					;;
				-)
					mudança
					quebrar
					;;
			esac
		feito
		
		[[ $ rule_name ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-s, --name] "

		para  regra  em  " $ {_ BOT_RULES_LIST _ [@]} " ;  Faz
			IFS = ' | '  leia _ _ regra _ <<<  $ regra
			[[ $ rule  ==  $ rule_name ]] && API MessageError " $ _ERR_RULE_ALREADY_EXISTS_ "  " [-s, --name] "  " $ rule_name "
		feito

		_BOT_RULES_LIST _ + = ( " $ {BASH_SOURCE [1] ## * / } | $ {BASH_LINENO} | $ {rule_name} | $ {action} | $ {action_args} | $ {exec} | $ {message_id : - + any} | $ {is_bot : - + qualquer} | $ {comando : - + qualquer} | $ {user_id : - + any} | $ {nome de usuário : - + qualquer} | $ {chat_id : - + qualquer} | $ {chat_name : - + qualquer} | $ {chat_type : - + qualquer}| $ {idioma : - + qualquer} | $ {text} | $ {entity_type : - + qualquer} | $ {file_type : - + qualquer} | $ {mime_type : - + qualquer} | $ {query_id : - + qualquer} | $ {query_data : - + qualquer} | $ {chat_member : - + qualquer} | $ {num_args : - + qualquer} | $ {time : - + qualquer} | $ {data : - + qualquer} | $ {dia da semana : - + qualquer} | $ {user_status: - + qualquer} | $ {message_status : - + qualquer} | $ {reply_message} | $ {send_message} | $ {forward_message} | $ {reply_markup} | $ {parse_mode} | $ {continue} " )
	
		retornar  $?
	}

	ShellBot.manageRules ()
	{
		local __uid __rule __action __comando __user_id __username
		local __message_id __is_bot __text __entities_type __file_type
		__chat_id local __chat_type __language __time __date __botcmd
		local __err __tm __stime __time __ctime __mime_type __semanal
		local __dt __sdate __edate __cdate __query_data __query_id
		local __chat_member __mem __ent __type __num_args __args
		local __action_args __user_status __status __out __reply_message
		local __rule_name __rule_line __rule_source __chat_name __fwid
		local __reply_markup __send_message __forward_message __parse_mode
		__stdout local __buffer __exec __continuar

		local __u_message_text __u_message_id __u_message_from_is_bot
		local __u_message_from_id __u_message_from_username __msgstatus __argpos
		local __u_message_from_language_code __u_message_chat_id __message_status
		local __u_message_chat_type __u_message_date __u_message_entities_type
		local __u_message_mime_type

		 	__param local = $ ( getopt --name " $ FUNCNAME " \
									--opções ' u: ' \
									--longoptions ' update_id: ' \
									- " $ @ " )

				
		eval  set - " $ __ param "
		
		enquanto  :
		Faz
			caso  $ 1  em
				-u | --update_id)
					CheckArgType int " $ 1 "  " $ 2 "
					__uid = $ 2
					turno 2
					;;
				-)
					mudança
					quebrar
					;;
			esac			
		feito
		
		[[ $ __ uid ]] || API MessageError " $ _ERR_PARAM_REQUIRED_ "  " [-u, --update_id] "

		# Definir uma lista de regras (somente leitura)
		somente leitura _BOT_RULES_LIST_

		# Regras
		para  __rule  em  " $ {_ BOT_RULES_LIST _ [@]} " ;  Faz

			IFS = ' | '  leia 	__rule_source \
							__rule_line \
							__nome da regra \
							__açao \
							__action_args \
							__exec \
							__message_id \
							__is_bot \
							__comando \
							__ID do usuário \
							__username \
							__chat_id \
							__nome no chat \
							__chat_type \
							__língua \
							__text \
							__entities_type \
							__tipo de arquivo \
							__mime_type \
							__query_id \
							__query_data \
							__chat_member \
							__num_args \
							__Tempo \
							__encontro \
							__dias úteis \
							__status do usuário \
							__message_status \
							__responder à mensagem \
							__enviar mensagem \
							__encaminhar mensagem \
							__reply_markup \
							__parse_mode \
							__continuar			 <<<  $ __ regra
		
				__u_message_text = $ {message_text [$ __ uid] : - $ {editor_message_text [$ __ uid] : - $ {callback_query_message_text [$ __ uid]} } }
				__u_message_id = $ {message_message_id [$ __ uid] : - $ {editor_message_message_id [$ __ uid] : - $ {callback_query_message_message_id [$ __ uid]} } }
				__u_message_from_is_bot = $ {message_from_is_bot [$ __ uid] : - $ {editor_message_from_is_bot [$ __ uid] : - $ {callback_query_from_is_bot [$ __ uid]} } }
				__u_message_from_id = $ {message_from_id [$ __ uid] : - $ {editor_message_from_id [$ __ uid] : - $ {callback_query_from_id [$ __ uid]} } }}
				__u_message_from_username = $ {message_from_username [$ __ uid] : - $ {editor_message_from_username [$ __ uid] : - $ {callback_query_from_username [$ __ uid]} } }
				__u_message_from_language_code = $ {message_from_language_code [$ __ uid] : - $ {modified_message_from_language_code [$ __ uid] : - $ {callback_query_from_language_code [$ __ uid]} } }
				__u_message_chat_id = $ {message_chat_id [$ __ uid] : - $ {editor_message_chat_id [$ __ uid] : - $ {callback_query_message_chat_id [$ __ uid]} } }
				__u_message_chat_username = $ {message_chat_username [$ __ uid] : - $ {editor_message_chat_username [$ __ uid] : - $ {callback_query_message_chat_username [$ __ uid]} } }
				__u_message_chat_type = $ {message_chat_type [$ __ uid] : - $ {editor_message_chat_type [$ __ uid] : - $ {callback_query_message_chat_type [$ __ uid]} } }
				__u_message_date = $ {message_date [$ __ uid] : - $ {editor_message_edit_date [$ __ uid] : - $ {callback_query_message_date [$ __ uid]} } }
				__u_message_entities_type = $ {message_entities_type [$ __ uid] : - $ {editor_message_entities_type [$ __ uid] : - $ {callback_query_message_entities_type [$ __ uid]} } }
				__u_message_mime_type = $ {message_document_mime_type [$ __ uid] : - $ {message_video_mime_type [$ __ uid] : - $ {message_audio_mime_type [$ __ uid] : - $ {message_voice_mime_type [$ __ uid]} } } }
	
				IFS = '  '  read -ra __args <<<  $ __ u_message_text
			
				[[ $ __ num_args 			== + qualquer || 	$ { # __args [@]} 							==  @ ( $ {__ num_args // , / |} )]]	 &&
				[[ comando $ __ 			== + qualquer	 || 	$ {__ u_message_text %%  * } 					==  @ ( comando $ {__ // , / |} ) ? (@ $ {_ BOT_INFO_ [3]} )]]	 &&
				[[ $ __ message_id  		== + qualquer	 || 	$ __ u_message_id  						==  @ ( $ {__ message_id // , / |} )]] 	 &&
				[[ $ __ is_bot  			== + qualquer || 	$ __ u_message_from_is_bot 				==  @ ( $ {__ is_bot // , / |} )]]	 &&
				[[ $ __ user_id 			== + qualquer || 	$ __ u_message_from_id 					==  @ ( $ {__ user_id // , / |} )]]	 &&
				[[ $ __ nome de usuário 			== + qualquer || 	$ __ u_message_from_username 				==  @ ( $ {__ nome de usuário // , / |} )]]	 &&
				[[ $ __ idioma 			== + qualquer	 || 	$ __ u_message_from_language_code 			==  @ ( $ {__ language // , / |} )]]	 &&
				[[ $ __ chat_id 			== + qualquer	 || 	$ __ u_message_chat_id 					==  @ ( $ {__ chat_id // , / |} )]] 	 &&
				[[ $ __ chat_name 			== + qualquer	 || 	$ __ u_message_chat_username 				==  @ ( $ {__ chat_name // , / |} )]] 	 &&
				[[ $ __ chat_type 			== + qualquer	 || 	$ __ u_message_chat_type 					==  @ ( $ {__ chat_type // , / |} )]]	 &&
				[[ !  $ __ texto 					|| 	$ __ u_message_text 						= ~  $ __ text 									]]	 &&
				[[ $ __ mime_type 			== + qualquer	 || 	$ __ u_message_mime_type 					==  @ ( $ {__ mime_type // , / | |} )]]	 &&
				[[ $ __ query_id 			== + qualquer	 || 	$ {callback_query_id [$ __ uid]} 			==  @ ( $ {__ query_id // , / | |} )]]	 &&
				[[ $ __ query_data 		== + qualquer	 || 	$ {callback_query_data [$ __ uid]} 			==  @ ( $ {__ query_data // , / | |} )]]	 &&
				[[ $ __ dia da semana 			== + qualquer	 ||  	$ ( printf ' % (% u) T '  $ __ u_message_date ) 	 ==  @ ( $ {__ dia da semana // , / | |) )]]	 ||  continuar
			
				para  __msgstatus  em  $ {__ message_status // , / } ;  Faz
					[[ $ __ msgstatus  == + qualquer]]	 ||
					[[ $ __ msgstatus  == afixado		 &&  $ {message_pinned_message_message_id [$ __ uid]}  	]] 	 ||
					[[ $ __ msgstatus  == editado 		 &&  $ {managed_message_message_id [$ __ uid]} 				]] 	 ||
					[[ $ __ msgstatus  == encaminhado	 &&  $ {message_forward_from_id [$ __ uid]} 				]]]	 ||
					[[ $ __ msgstatus  == reply		 &&  $ {message_reply_to_message_message_id [$ __ uid]} 	]] 	 ||
					[[ $ __ msgstatus  == retorno de chamada		 &&  $ {callback_query_message_message_id [$ __ uid]} 		]]]	 &&  break
				feito
				
				(( $? ))  &&  continue

				para  __ent  em  $ {__ entity_type // , / } ;  Faz
					[[ $ __ ent  == + qualquer]]	 ||
					[[ $ __ ent  ==  @ ( $ {__ u_message_entities_type // $ _BOT_DELM_ / |} )]] 	 &&  break
				feito

				(( $? ))  &&  continue
	
				para  __mem  em  $ {__ chat_member // , / } ;  Faz
					[[ $ __ mem  == + qualquer]] ||
					[[ $ __ mem  == novo 	 &&  $ {message_new_chat_member_id [$ __ uid]}  	]] ||
					[[ $ __ mem  == saiu 	 &&  $ {message_left_chat_member_id [$ __ uid]}  	]]] &&  break
				feito
			
				(( $? ))  &&  continue

				para  __type  em  $ {__ file_type // , / } ;  Faz
					[[ $ __ tipo  == + qualquer]] 	 ||
					[[ $ __ type  == document 	 &&  $ {message_document_file_id [$ __ uid]} 	&&  	!  $ {message_document_thumb_file_id [$ __ uid]} 	]] 	 ||
					[[ $ __ type  == gif 		 &&  $ {message_document_file_id [$ __ uid]}   && 	$ {message_document_thumb_file_id [$ __ uid]} 	]] 	 ||
					[[ $ __ tipo  == foto		 &&  $ {message_photo_file_id [$ __ uid]}  													]] 	 ||
					[[ $ __ type  == sticker 	 &&  $ {message_sticker_file_id [$ __ uid]}  													]]	 ||
					[[ $ __ type  == video		 &&  $ {message_video_file_id [$ __ uid]}  													]]	 ||
					[[ $ __ type  == audio		 &&  $ {message_audio_file_id [$ __ uid]}  													]]	 ||
					[[ $ __ type  == voice		 &&  $ {message_voice_file_id [$ __ uid]}  													]]	 ||
					[[ $ __ type  == contact	 &&  $ {message_contact_user_id [$ __ uid]}  													]]	 ||
					[[ $ __ type  == local	 &&  $ {message_location_latitude [$ __ uid]} 													]]]	 &&  break
				feito
					
				(( $? ))  &&  continue

				para  __tm  em  $ {__ time // , / } ;  Faz
					IFS = ' - '  leia __stime __time <<<  $ __ tm
					printf -v __ctime ' % (% H:% M) T '  $ __ u_message_date

					[[ $ __ time 	== + qualquer]]				 ||
					[[ $ __ ctime  ==  @ ( $ __ stime | $ __ etime )]] 				 ||
					[[ $ __ ctime  >  $ __ stime  &&  $ __ ctime  <  $ __ etime ]]	 &&  break
				feito
					
				(( $? ))  &&  continue
	
				para  __dt  em  $ {__ date // , / } ;  Faz

					IFS = ' - '  lê __sdate __edate <<<  $ __ dt
					IFS = ' / '  lê -a __sdate <<<  $ __ sdate
					IFS = ' / '  read -a __edate <<<  $ __ edate
					
					__sdate = $ {__ sdate [2]} / $ {__ sdate [1]} / $ {__ sdate [0]}
					__edate = $ {__ edate [2]} / $ {__ edate [1]} / $ {__ edate [0]}

					printf -v __cdate ' % (% Y /% m /% d) T '  $ __ u_message_date
					
					[[ $ __ data 	== + qualquer]] 	 ||
					[[ $ __ cdate  ==  @ ( $ __ sdate | $ __ edate )]] 	 ||
					[[ $ __ cdate  >  $ __ sdate  &&  $ __ cdate  <  $ __ edate  	]]	 &&  break
				feito

				(( $? ))  &&  continue
	
				if [[ $ __ user_status  ! = + any]] ;  então
					case  $ _BOT_TYPE_RETURN_  in
						valor)
							__out = $ ( ShellBot.getChatMember --chat_id $ __ u_message_chat_id \
															--user_id $ __ u_message_from_id  2> / dev / null )
							
							IFS = $ _BOT_DELM_  lê -a __out <<<  $ __ out
							[[ $ {__ fora [2]}  ==  verdadeiro ]]
							__status = $ {__ fora [$ (($?? 6: 5))]}
							;;
						json)
							__out = $ ( ShellBot.getChatMember --chat_id $ __ u_message_chat_id \
															--user_id $ __ u_message_from_id  2> / dev / null )
							
							__status = $ ( saída Json ' .result.status '  $ __ )
							;;
						mapa)	
							ShellBot.getChatMember --chat_id $ __ u_message_chat_id \
													--user_id $ __ u_message_from_id  & > / dev / null

							__status = $ {return [status]}
							;;
					esac
					[[ $ __ status  ==  @ ( $ {__ user_status // , / |} )]]	 ||  continuar
				fi
				
				# Monitor
				[[ $ _BOT_MONITOR_ ]]	 &&  	printf  ' [% s]:% s:% s:% s:% s:% s:% s:% s:% s:% s:% s:% s:% s \ n ' 		\
											" $ {FUNCNAME} " 												\
											" $ (( __uid + 1 )) " 												\
											" $ ( printf ' % (% d /% m /% Y% H:% M:% S) T '  $ {__ u_message_date} ) " 		\
											" $ {__ u_message_chat_type} " 									\
											" $ {__ u_message_chat_username : - -} " 							\
											" $ {__ u_message_from_username : - -} " 							\
											" $ {__ rule_source} " 											\
											" $ {__ rule_line} " 											\
											" $ {__ rule_name} "  											\
											" $ {__ ação : - -} " 											\
											" $ {__ exec : - -} "
			
				# Log	
				[[ $ _BOT_LOG_FILE_ ]] 	 && 	printf  ' % s:% s:% s:% s:% s:% s:% s \ n ' 						\
										 	" $ ( printf ' % (% d /% m /% Y% H:% M:% S) T ' ) " 							\
									 	 	" $ {FUNCNAME} " 												\
										 	" $ {__ rule_source} " 											\
										 	" $ {__ rule_line} " 											\
										 	" $ {__ rule_name} " 											\
											" $ {__ ação : - -} " 											\
											" $ {__ exec : - -} "												 >>  " $ _BOT_LOG_FILE_ "

				[[ $ __ reply_message ]] && ShellBot.sendMessage --chat_id $ __ u_message_chat_id 							\
																--reply_to_message_id $ __ u_message_id  					\
																--text " $ ( FlagConv $ __ uid  " $ __ reply_message " ) " 			\
																$ {__ reply_markup : + - reply_markup " $ __ reply_markup " } 		\
																$ {__ parse_mode : + - parse_mode $ __ parse_mode } 				& > / dev / null
				
				[[ $ __ send_message ]] && ShellBot.sendMessage --chat_id $ __ u_message_chat_id 							\
																--text " $ ( FlagConv $ __ uid  " $ __ send_message " ) "  			\
																$ {__ reply_markup : + - reply_markup " $ __ reply_markup " } 		\
																$ {__ parse_mode : + - parse_mode $ __ parse_mode } 				& > / dev / null
				
				para  __fwid  em  $ {__ forward_message // , / } ;  Faz
					ShellBot.forwardMessage --chat_id $ __ fwid 					\
												--from_chat_id $ __ u_message_chat_id \
												--message_id $ __ u_message_id 		& > / dev / null
				feito

				# Chama a função passando pelos argumentos posicionais. (se existir)
				$ {__ ação : + $ __ ação  $ {__ action_args : - $ {__ args [*]} } }
		
				# Executa uma linha de comando e salva ou retorna.
				__stdout = $ {__ exec : + $ (conjunto - $ {__ args [*]} ; eval $ (FlagConv $ __ uid  " $ __ exec " ) 2> & 1)}

				while [[ $ __ stdout ]] ;  Faz
					# Salva no buffer os primeiros 4096 caracteres.
					read -rN 4096 __buffer <<<  $ __ stdout
					
					# Envia o buffer.
					ShellBot.sendMessage --chat_id $ __ u_message_chat_id  			\
											--reply_to_message_id $ __ u_message_id 	\
											--text " $ __ buffer "						 e > / dev / null

					# Descarta os caracteres lidos.
					__stdout = $ {__ stdout : 4096}
				feito 

				$ {__ continue : - retorne 0}
		feito

		retorno 1
	}

    ShellBot.getUpdates ()
    {
    	total_keys local limite de tempo limite permitido_updates jq_obj
		veterinário local val var obj bar oldv

		# Definir os parâmetros da função
		parâmetro local = $ ( getopt --name " $ FUNCNAME " \
								--opções ' o: l: t: a: ' \
- offset de 								opções :
												limite:,
												tempo esgotado:,
												allowed_updates: ' \
								- " $ @ " )
    
		eval  set - " $ param "

    	enquanto  :
    	Faz
    		caso  $ 1  em
    			-o | --offset)
    				CheckArgType int " $ 1 "  " $ 2 "
    				deslocamento = $ 2
    				turno 2
    				;;
    			-l | --limit)
    				CheckArgType int " $ 1 "  " $ 2 "
    				limite = $ 2
    				turno 2
    				;;
    			-t | --timeout)
    				CheckArgType int " $ 1 "  " $ 2 "
    				tempo limite = $ 2
    				turno 2
    				;;
    			-a | --allowed_updates)
    				allowed_updates = $ 2
    				turno 2
    				;;
    			-)
    				# Se não houver mais parâmetros
    				mudança 
    				quebrar
    				;;
    		esac
    	feito
    	
		# Seta os parâmetros
		jq_obj = $ ( enrolar $ _CURL_OPT_ POST $ _API_TELEGRAM_ / $ {FUNCNAME # * .} \
								$ {offset : + -d offset = " $ offset " } \
								$ {limit : + -d limit = " $ limit " } \
								$ {timeout : + -d timeout = " $ timeout " } \
								$ {allowed_updates : + -d allowed_updates = " $ allowed_updates " } )


		# Limpa as variáveis ​​inicializadas.
		unset  $ _var_init_list_ _var_init_list_
	
    	[[ $ ( jq -r ' .result | length '  <<<  $ jq_obj )  -eq 0]] &&  return 0
		[[ $ _FLUSH_OFFSET_ ]] && { echo  " $ jq_obj " ;  retornar 0 ; } # flush

		if [[ $ _BOT_MONITOR_ ]] ;  então
			printf -v bar ' =%. s ' {1..50}
			printf  " $ bar \ nDados:% (% d /% m /% Y% T) T \ n "
			printf  ' Script:% s \ nBot (nome):% s \ nBot (usuário):% s \ nBot (id):% s \ n '  	\
					" $ {_ BOT_SCRIPT_} "  												\
					" $ {_ BOT_INFO_ [2]} "  												\
					" $ {_ BOT_INFO_ [3]} "  												\
					" $ {_ BOT_INFO_ [1]} "
		fi

		para  obj  em  $ ( GetAllKeys $ jq_obj ) ;  Faz
	
			[[ $ obj  = ~ [0-9] +]]
			veterinário = $ {BASH_REMATCH : - 0}
			
			var = $ {obj // [0-9 \ [\]] / }
			var = $ {var # result.}
			var = $ {var // . / _}
	
			declarar -g $ var
			local -n byref = $ var  # ponteiro
						
			val = $ ( Json " . $ obj "  $ jq_obj )
			byref [ $ vet ] + = $ {byref [$ vet] : + $ _BOT_DELM_ } $ {val}

			if [[ $ _BOT_MONITOR_ ]] ;  então
				[[ $ vet  -ne  $ {oldv : - -1} ]] &&  printf  " $ bar \ nMensagem:% d \ n $ bar \ n "  $ (( veterinário + 1 ))
				printf  " [% s]:% s = '% s' \ n "  " $ FUNCNAME "  " $ var "  " $ val "
				oldv = $ veterinário
			fi
	
			unset -n byref
			[[ $ var  ! =  @ ( $ {_ var_init_list_ //  / |} )]] && _var_init_list_ = $ {_ var_init_list_ : + $ _var_init_list_ } $ {var}
		feito
	
		# Log (segmento)	
		[[ $ _BOT_LOG_FILE_ ]] && CreateLog $ { # update_id [@]}  $ jq_obj  &
	
   		 # Status
   	 	retornar  $?
	}
   
	# Bot métodos (somente leitura)
	readonly  -f ShellBot.token \
				ShellBot.id \
				ShellBot.username \
				ShellBot.first_name \
				ShellBot.regHandleFunction \
				ShellBot.watchHandle \
				ShellBot.ListUpdates \
				ShellBot.TotalUpdates \
				ShellBot.OffsetEnd \
				ShellBot.OffsetNext \
				ShellBot.getMe \
				ShellBot.getWebhookInfo \
				ShellBot.deleteWebhook \
				ShellBot.setWebhook \
				ShellBot.init \
				ShellBot.ReplyKeyboardMarkup \
				ShellBot.ForceReply \
				ShellBot.ReplyKeyboardRemove \
				ShellBot.KeyboardButton \
				ShellBot.sendMessage \
				ShellBot.forwardMessage \
				ShellBot.sendPhoto \
				ShellBot.sendAudio \
				ShellBot.sendDocument \
				ShellBot.sendSticker \
				ShellBot.sendVideo \
				ShellBot.sendVideoNote \
				ShellBot.sendVoice \
				ShellBot.sendLocation \
				ShellBot.sendVenue \
				ShellBot.sendContact \
				ShellBot.sendChatAction \
				ShellBot.getUserProfilePhotos \
				ShellBot.getFile \
				ShellBot.kickChatMember \
				ShellBot.leaveChat \
				ShellBot.unbanChatMember \
				ShellBot.getChat \
				ShellBot.getChatAdministrators \
				ShellBot.getChatMembersCount \
				ShellBot.getChatMember \
				ShellBot.editMessageText \
				ShellBot.editMessageCaption \
				ShellBot.editMessageReplyMarkup \
				ShellBot.InlineKeyboardMarkup \
				ShellBot.InlineKeyboardButton \
				ShellBot.answerCallbackQuery \
				ShellBot.deleteMessage \
				ShellBot.exportChatInviteLink \
				ShellBot.setChatPhoto \
				ShellBot.deleteChatPhoto \
				ShellBot.setChatTitle \
				ShellBot.setChatDescription \
				ShellBot.pinChatMessage \
				ShellBot.unpinChatMessage \
				ShellBot.promoteChatMember \
				ShellBot.restrictChatMember \
				ShellBot.getStickerSet \
				ShellBot.uploadStickerFile \
				ShellBot.createNewStickerSet \
				ShellBot.addStickerToSet \
				ShellBot.setStickerPositionInSet \
				ShellBot.deleteStickerFromSet \
				ShellBot.stickerMaskPosition \
				ShellBot.downloadFile \
				ShellBot.editMessageLiveLocation \
				ShellBot.stopMessageLiveLocation \
				ShellBot.setChatStickerSet \
				ShellBot.deleteChatStickerSet \
				ShellBot.sendMediaGroup \
				ShellBot.editMessageMedia \
				ShellBot.inputMedia \
				ShellBot.sendAnimation \
				ShellBot.setMessageRules \
				ShellBot.manageRules \
				ShellBot.getUpdates

   	# Retorna objetos
	printf  ' % s |% s |% s |% s \ n ' 	" $ {_ BOT_INFO_ [1]} " \
							" $ {_ BOT_INFO_ [2]} " \
							" $ {_ BOT_INFO_ [3]} " \
							" $ {_ FLUSH_OFFSET_ : + $ (FlushOffset)} "

	# status
   	retornar 0
}

# Funções (somente leitura)
readonly  -f MessageError \
			Json \
			FlushOffset \
			CreateUnitService \
			GetAllKeys \
			GetAllValues ​​\
			MethodReturn \
			CheckArgType \
			CreateLog \
			FlagConv

# / * SHELLBOT * /
