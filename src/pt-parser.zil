"PT-PARSER: adaptações do parser para o português do Brasil.

Entrada (chamadas por READ-INPUT, em gparser.zil):
- NORMALIZA-ENTRADA roda antes do LEX: tira acentos e cedilha, passa para
  minúsculas e separa pronomes com hífen (pegue-o vira pegue lo).
- AJUSTA-LEXV roda depois do LEX e reescreve a lista de palavras: abreviações
  de direção, dê/dá, dar corda, preposições de duas palavras, o de dos nomes
  compostos (caixa de correio) e as palavras que o parser compara por
  endereço (tudo, isso, depois...).

Saída: marcadores do TELL que escrevem o nome do objeto com artigo e
concordância. Objetos femininos levam FEMBIT, plurais PLURALBIT, nomes sem
artigo SEMARTIGOBIT e o que não se conta (um pouco de água) PARTITIVOBIT.
Ver docs/TRADUCAO.md."

;"Letra sem acento para cada código ZSCII de 155 a 223 (tabela Unicode
  padrão da Z-machine); 0 mantém o caractere."
<GLOBAL SEM-ACENTO
	<TABLE (BYTE)
	 !\a !\o !\u !\a !\o !\u		;"155: ä ö ü Ä Ö Ü"
	 !\s 0 0				;"161: ß » «"
	 !\e !\i !\y !\e !\i			;"164: ë ï ÿ Ë Ï"
	 !\a !\e !\i !\o !\u !\y		;"169: á é í ó ú ý"
	 !\a !\e !\i !\o !\u !\y		;"175: Á É Í Ó Ú Ý"
	 !\a !\e !\i !\o !\u			;"181: à è ì ò ù"
	 !\a !\e !\i !\o !\u			;"186: À È Ì Ò Ù"
	 !\a !\e !\i !\o !\u			;"191: â ê î ô û"
	 !\a !\e !\i !\o !\u			;"196: Â Ê Î Ô Û"
	 !\a !\a !\o !\o			;"201: å Å ø Ø"
	 !\a !\n !\o !\a !\n !\o		;"205: ã ñ õ Ã Ñ Õ"
	 0 0 !\c !\c				;"211: æ Æ ç Ç"
	 0 0 0 0 0 0 0 0 0>>			;"215: þ ð Þ Ð £ œ Œ ¡ ¿"

;"Primeiro separa os hífens (isso muda as posições), depois guarda o texto
  como foi digitado em P-INBUF-DIGITADO, e só então tira acentos e
  maiúsculas. Assim os avisos do parser repetem as palavras com acento
  (ver WORD-PRINT)."
<ROUTINE NORMALIZA-ENTRADA ("AUX" (I 2) C N)
	 <REPEAT ()
		 <COND (<G? .I <+ <GETB ,P-INBUF 1> 1>> <RETURN>)
		       (<EQUAL? <GETB ,P-INBUF .I> !\-> <SEPARA-HIFEN .I>)>
		 <SET I <+ .I 1>>>
	 <COPYT ,P-INBUF ,P-INBUF-DIGITADO <+ <GETB ,P-INBUF 1> 2>>
	 <SET I 2>
	 <REPEAT ()
		 <COND (<G? .I <+ <GETB ,P-INBUF 1> 1>> <RETURN>)>
		 <SET C <GETB ,P-INBUF .I>>
		 <COND (<AND <G? .C 154> <L? .C 224>>
			<COND (<NOT <ZERO? <SET N <GETB ,SEM-ACENTO <- .C 155>>>>>
			       <PUTB ,P-INBUF .I .N>)>)
		       (<AND <G? .C 64> <L? .C 91>>
			<PUTB ,P-INBUF .I <+ .C 32>>)>
		 <SET I <+ .I 1>>>>

;"A cópia com acento de cada buffer de entrada (P-INBUF ou OOPS-INBUF)"
<ROUTINE DIGITADO (BUF)
	 <COND (<EQUAL? .BUF ,P-INBUF> ,P-INBUF-DIGITADO)
	       (T ,OOPS-DIGITADO)>>

;"Troca o hífen por espaço. O pronome sem l (pegue-o, abra-a, pegue-os)
  ganha um l, para não ser lido como artigo: lo, la, los e las querem dizer
  isso (ver EQUIVALENTES)."
<ROUTINE SEPARA-HIFEN (I "AUX" (FIM <+ <GETB ,P-INBUF 1> 1>) K J)
	 <PUTB ,P-INBUF .I 32>
	 <SET K <+ .I 2>>
	 <COND (<AND <NOT <G? .K .FIM>> <EQUAL? <GETB ,P-INBUF .K> !\s>>
		<SET K <+ .K 1>>)>
	 <COND (<AND <L? .I .FIM>
		     <EQUAL? <GETB ,P-INBUF <+ .I 1>> !\o !\a>
		     <FIM-DE-PALAVRA? .K>
		     <L? <GETB ,P-INBUF 1> <GETB ,P-INBUF 0>>>
		<SET J <+ .FIM 1>>
		<REPEAT ()
			<COND (<L? .J <+ .I 2>> <RETURN>)>
			<PUTB ,P-INBUF .J <GETB ,P-INBUF <- .J 1>>>
			<SET J <- .J 1>>>
		<PUTB ,P-INBUF <+ .I 1> !\l>
		<PUTB ,P-INBUF 1 <+ <GETB ,P-INBUF 1> 1>>)>>

<ROUTINE FIM-DE-PALAVRA? (I)
	 <OR <G? .I <+ <GETB ,P-INBUF 1> 1>>
	     <EQUAL? <GETB ,P-INBUF .I> 32 !\. !\,>>>

"Acesso à lista de palavras (P-LEXV). As posições começam em 1."

<ROUTINE PALAVRA (I)
	 <COND (<G? .I <GETB ,P-LEXV ,P-LEXWORDS>> <RFALSE>)>
	 <GET ,P-LEXV <- <* .I 2> 1>>>

<ROUTINE TROCA-PALAVRA (I W)
	 <PUT ,P-LEXV <- <* .I 2> 1> .W>>

<ROUTINE APAGA-PALAVRA (I "AUX" (N <GETB ,P-LEXV ,P-LEXWORDS>))
	 <REPEAT ()
		 <COND (<NOT <L? .I .N>> <RETURN>)>
		 <PUT ,P-LEXV <- <* .I 2> 1> <GET ,P-LEXV <+ <* .I 2> 1>>>
		 <PUT ,P-LEXV <* .I 2> <GET ,P-LEXV <+ <* .I 2> 2>>>
		 <SET I <+ .I 1>>>
	 <PUTB ,P-LEXV ,P-LEXWORDS <- .N 1>>>

;"Palavras que o parser compara por endereço (W?ALL, W?IT...) não funcionam
  como SYNONYM; aqui elas viram a palavra original. A primeira de cada par é
  a palavra digitada; a segunda, a que o parser conhece."
<GLOBAL EQUIVALENTES
	<PLTABLE W?TUDO W?ALL W?TODOS W?ALL W?TODAS W?ALL
		 W?EXCETO W?EXCEPT W?MENOS W?EXCEPT
		 W?ISSO W?IT W?ISTO W?IT W?AQUILO W?IT
		 W?ELE W?IT W?ELA W?IT W?ELES W?IT W?ELAS W?IT
		 W?LO W?IT W?LA W?IT W?LOS W?IT W?LAS W?IT
		 W?DEPOIS W?THEN W?ENTAO W?THEN
		 W?NOVAMENTE W?AGAIN W?REPITA W?AGAIN W?OPS W?OOPS
		 W?SIM W?YES
		 W?O W?THE W?A W?THE W?OS W?THE W?AS W?THE
		 W?UM W?A W?UMA W?A W?UNS W?A W?UMAS W?A
		 W?REINICIE W?RESTART W?REINICIAR W?RESTART W?RECOMECE W?RESTART
		 W?CARREGUE W?RESTORE W?CARREGAR W?RESTORE
		 W?RESTAURE W?RESTORE W?RESTAURAR W?RESTORE
		 W?DESISTA W?QUIT W?DESISTIR W?QUIT W?FIM W?QUIT>>

<ROUTINE EQUIVALENTE (W "AUX" (I 1) (N <GET ,EQUIVALENTES 0>))
	 <REPEAT ()
		 <COND (<G? .I .N> <RETURN .W>)
		       (<EQUAL? .W <GET ,EQUIVALENTES .I>>
			<RETURN <GET ,EQUIVALENTES <+ .I 1>>>)>
		 <SET I <+ .I 2>>>>

<ROUTINE ARTIGO? (W)
	 <EQUAL? .W ,W?O ,W?A ,W?OS ,W?AS ,W?UM ,W?UMA ,W?UNS ,W?UMAS>>

;"Depois do de (pulando artigos) vem um adjetivo? Então o de faz parte do
  nome (caixa de correio, lanterna de latão) e pode sair."
<ROUTINE ADJETIVO-A-SEGUIR? (I "AUX" W)
	 <REPEAT ()
		 <SET W <PALAVRA .I>>
		 <COND (<NOT .W> <RFALSE>)
		       (<ARTIGO? .W> <SET I <+ .I 1>>)
		       (T <RETURN>)>>
	 <AND <WT? .W ,PS?ADJECTIVE> <NOT <WT? .W ,PS?PREPOSITION>>>>

;"Depois do com (pulando artigos) vem moedas ou inscrições? Então o com faz
  parte do nome (saco de couro com moedas, parede com inscrições) e não é o
  WITH; sai junto com o resto."
<ROUTINE PARTE-DO-NOME? (I "AUX" W)
	 <REPEAT ()
		 <SET W <PALAVRA .I>>
		 <COND (<NOT .W> <RFALSE>)
		       (<ARTIGO? .W> <SET I <+ .I 1>>)
		       (T <RETURN>)>>
	 <EQUAL? .W ,W?MOEDAS ,W?MOEDA ,W?INSCRICOES ,W?INSCRICAO>>

<ROUTINE PREENCHIMENTO? (W)
	 <OR <WT? .W ,PS?PREPOSITION>
	     <WT? .W ,PS?BUZZ-WORD>
	     <EQUAL? .W ,W?DIRECAO ,W?RUMO>>>

;"Palavras inglesas que o jogo ainda usa por dentro: os verbos e as
  preposições das SYNTAX, as direções por extenso e as palavras que o parser
  compara por endereço (W?ALL, W?IT...). Digitadas, valem como palavra
  desconhecida. Ficam valendo as abreviações de direção do original
  (n s e w u d ne nw se sw) e as de jogo (i g z q x)."
<GLOBAL INGLESAS
	<PLTABLE W?ABOUT W?ACROSS W?ACTIVATE W?AGAIN W?ALL W?AN W?AND W?ANSWER
		 W?APPLY W?AROUND W?AT W?ATTACK W?AWAY W?BACK W?BEHIND W?BLAST
		 W?BLOW W?BOARD W?BRIEF W?BRUSH W?BUG W?BURN W?BUT W?CHOMP W?CLIMB
		 W?CLOSE W?COMMAND W?COUNT W?CROSS W?CURSE W?CUT W?DEFLATE
		 W?DESTROY W?DIG W?DISEMBARK W?DISENCHANT W?DOWN W?DRINK W?DROP
		 W?EAST W?EAT W?ECHO W?ENCHANT W?ENTER W?EXCEPT W?EXIT
		 W?EXORCISE W?EXTINGUISH W?FILL W?FIND W?FOLLOW W?FOR W?FROM W?GIVE
		 W?HAND W?HATCH W?HELLO W?IN W?INCANT W?INVENTORY W?IT W?JUMP W?KICK
		 W?KILL W?KISS W?KNOCK W?LAND W?LAUNCH W?LEAN W?LEAVE W?LIGHT
		 W?LISTEN W?LOCK W?LOOK W?LOWER W?LUBRICATE W?MAKE W?MELT
		 W?MUMBLE W?NORTH W?ODYSSEUS W?OF W?OFF W?ON W?ONE W?OOPS W?OPEN
		 W?OUT W?OVER W?PICK W?PLAY W?PLUG W?POKE W?POUR W?PRAY W?PULL
		 W?PUMP W?PUNCTURE W?PUSH W?PUT W?QUIT W?RAISE W?RAPE W?READ
		 W?REPENT W?RESTART W?RESTORE W?RING W?ROLL W?RUB W?SAVE W?SAY
		 W?SCORE W?SCRIPT W?SEARCH W?SEND W?SHAKE W?SKIP W?SLIDE W?SMELL
		 W?SOUTH W?SPIN W?SPRAY W?SQUEEZE W?STAB W?STAND W?STAY W?STRIKE
		 W?SWIM W?SWING W?TAKE W?TALK W?TELL W?THE W?THEN W?THROW W?TIE W?TO
		 W?TREASURE W?TURN W?UNDER W?UNLOCK W?UNSCRIPT W?UNTIE W?UP W?VERBOSE
		 W?VERSION W?WAIT W?WAKE W?WALK W?WAVE W?WEAR W?WEST W?WIN W?WIND
		 W?WISH W?WITH W?Y W?YELL W?YES>>

<ROUTINE AJUSTA-LEXV ("AUX" N W V (I 1))
	 <SET N <GETB ,P-LEXV ,P-LEXWORDS>>
	 <COND (<ZERO? .N> <RTRUE>)>
	 ;"Inglês digitado vira palavra desconhecida (0)"
	 <REPEAT ()
		 <COND (<G? .I .N> <RETURN>)
		       (<INTBL? <PALAVRA .I> <REST ,INGLESAS 2> <GET ,INGLESAS 0>>
			<TROCA-PALAVRA .I 0>)>
		 <SET I <+ .I 1>>>
	 <SET I 1>
	 <SET W <PALAVRA 1>>
	 ;"de novo = again (antes da regra do dê)"
	 <COND (<AND <EQUAL? .W ,W?DE> <EQUAL? <PALAVRA 2> ,W?NOVO>>
		<TROCA-PALAVRA 1 <SET W ,W?AGAIN>>
		<APAGA-PALAVRA 2>
		<SET N <GETB ,P-LEXV ,P-LEXWORDS>>)>
	 ;"Comando de uma palavra só: abreviações que também são outras palavras"
	 <COND (<EQUAL? .N 1>
		<COND (<EQUAL? .W ,W?O> <TROCA-PALAVRA 1 ,W?OESTE>)
		      (<EQUAL? .W ,W?NO> <TROCA-PALAVRA 1 ,W?NOROESTE>)
		      (<EQUAL? .W ,W?SUBA ,W?SUBIR ,W?SOBE> <TROCA-PALAVRA 1 ,W?CIMA>)
		      (<EQUAL? .W ,W?DESCA ,W?DESCER ,W?DESCE>
		       <TROCA-PALAVRA 1 ,W?BAIXO>)
		      (T <TROCA-PALAVRA 1 <EQUIVALENTE .W>>)>
		<RTRUE>)>
	 ;"No começo, de/da são os verbos dê/dá; dê corda no X é dar corda"
	 <COND (<EQUAL? .W ,W?DE ,W?DA ,W?DAR>
		<COND (<EQUAL? <PALAVRA 2> ,W?CORDA>
		       <TROCA-PALAVRA 1 ,W?WIND>
		       <APAGA-PALAVRA 2>)
		      (T
		       <TROCA-PALAVRA 1 ,W?DAR>)>)>
	 ;"Preposições de duas palavras e expressões que só atrapalham"
	 <REPEAT ()
		 <COND (<NOT <L? .I <GETB ,P-LEXV ,P-LEXWORDS>>> <RETURN>)>
		 <SET W <PALAVRA .I>>
		 <SET V <PALAVRA <+ .I 1>>>
		 <COND (<AND <EQUAL? .W ,W?EM> <EQUAL? .V ,W?CIMA>>
			<TROCA-PALAVRA .I ,W?SOBRE>
			<APAGA-PALAVRA <+ .I 1>>)
		       (<OR <AND <EQUAL? .W ,W?EM> <EQUAL? .V ,W?VOLTA>>
			    <AND <EQUAL? .W ,W?AO> <EQUAL? .V ,W?REDOR>>>
			<APAGA-PALAVRA .I>
			<APAGA-PALAVRA .I>)
		       (<AND <G? .I 1>
			     <EQUAL? .W ,W?DE ,W?DO ,W?DA ,W?DOS ,W?DAS>
			     <ADJETIVO-A-SEGUIR? <+ .I 1>>>
			<APAGA-PALAVRA .I>)
		       (<AND <G? .I 1>
			     <EQUAL? .W ,W?COM>
			     <PARTE-DO-NOME? <+ .I 1>>>
			<APAGA-PALAVRA .I>
			<REPEAT ()
				<COND (<ARTIGO? <PALAVRA .I>> <APAGA-PALAVRA .I>)
				      (T <RETURN>)>>
			<APAGA-PALAVRA .I>)
		       (T
			<SET I <+ .I 1>>)>>
	 ;"Palavras comparadas por endereço; e no meio da frase é a conjunção"
	 <SET N <GETB ,P-LEXV ,P-LEXWORDS>>
	 <SET I 1>
	 <REPEAT ()
		 <COND (<G? .I .N> <RETURN>)>
		 <SET W <PALAVRA .I>>
		 <COND (<EQUAL? .W ,W?E> <TROCA-PALAVRA .I ,W?AND>)
		       (T <TROCA-PALAVRA .I <EQUIVALENTE .W>>)>
		 <SET I <+ .I 1>>>
	 ;"vá para o norte, siga para leste: fica só a direção.
	   olhe para cima, olhe em volta: fica só o olhe."
	 <SET W <PALAVRA .N>>
	 <SET V <WT? <PALAVRA 1> ,PS?VERB ,P1?VERB>>
	 <COND (<AND <G? .N 1>
		     <WT? .W ,PS?DIRECTION>
		     <EQUAL? .V ,ACT?WALK ,ACT?FOLLOW ,ACT?SUBIR ,ACT?DESCER ,ACT?EXIT
			     ,ACT?LOOK>>
		<SET I 2>
		<REPEAT ()
			<COND (<NOT <L? .I .N>> <RETURN>)
			      (<NOT <PREENCHIMENTO? <PALAVRA .I>>> <RTRUE>)>
			<SET I <+ .I 1>>>
		<COND (<NOT <EQUAL? .V ,ACT?LOOK>> <TROCA-PALAVRA 1 .W>)>
		<PUTB ,P-LEXV ,P-LEXWORDS 1>)>
	 <RTRUE>>

"Saída: artigos e concordância. Exemplos:
  <TELL T-CO ,PRSO \" está fechad\" T-G ,PRSO \".\" CR>   A caixa está fechada.
  <TELL \"Você deu \" T-O ,PRSO \" \" T-AO ,PRSI \".\" CR> Você deu o lanche ao ciclope."

;"Os marcadores T-O, T-CO, T-UM... são tratados pelo macro TELL do Zork
  (gmacros.zil), que chama as rotinas abaixo."

;"o, a, os, as"
<ROUTINE PRINT-TERMINACAO (OBJ)
	 <COND (<FSET? .OBJ ,FEMBIT> <PRINTC !\a>)
	       (T <PRINTC !\o>)>
	 <COND (<FSET? .OBJ ,PLURALBIT> <PRINTC !\s>)>>

<ROUTINE PRINT-ARTIGO (OBJ MAIUSCULA)
	 <COND (<NOT <FSET? .OBJ ,SEMARTIGOBIT>>
		<COND (.MAIUSCULA
		       <COND (<FSET? .OBJ ,FEMBIT> <PRINTC !\A>)
			     (T <PRINTC !\O>)>
		       <COND (<FSET? .OBJ ,PLURALBIT> <PRINTC !\s>)>)
		      (T
		       <PRINT-TERMINACAO .OBJ>)>
		<PRINTC 32>)>
	 <PRINTD .OBJ>>

;"um, uma, uns, umas; um pouco de, para o que não se conta (água)"
<ROUTINE PRINT-INDEFINIDO (OBJ MAIUSCULA)
	 <COND (<FSET? .OBJ ,PARTITIVOBIT>
		<COND (.MAIUSCULA <PRINTC !\U>) (T <PRINTC !\u>)>
		<TELL "m pouco de ">)
	       (<NOT <FSET? .OBJ ,SEMARTIGOBIT>>
		<COND (.MAIUSCULA <PRINTC !\U>) (T <PRINTC !\u>)>
		<COND (<FSET? .OBJ ,PLURALBIT>
		       <COND (<FSET? .OBJ ,FEMBIT> <TELL "mas">) (T <TELL "ns">)>)
		      (<FSET? .OBJ ,FEMBIT> <TELL "ma">)
		      (T <PRINTC !\m>)>
		<PRINTC 32>)>
	 <PRINTD .OBJ>>

;"do/da/dos/das, no/na/nos/nas, pelo/pela/pelos/pelas"
<ROUTINE PRINT-CONTRACAO (OBJ PREFIXO SEM-ARTIGO)
	 <COND (<FSET? .OBJ ,SEMARTIGOBIT> <TELL .SEM-ARTIGO>)
	       (T <TELL .PREFIXO> <PRINT-TERMINACAO .OBJ>)>
	 <PRINTC 32>
	 <PRINTD .OBJ>>

;"ao/à/aos/às"
<ROUTINE PRINT-AO (OBJ)
	 <COND (<FSET? .OBJ ,SEMARTIGOBIT> <TELL "a">)
	       (<FSET? .OBJ ,FEMBIT> <TELL "à">)
	       (T <TELL "ao">)>
	 <COND (<AND <FSET? .OBJ ,PLURALBIT> <NOT <FSET? .OBJ ,SEMARTIGOBIT>>>
		<PRINTC !\s>)>
	 <PRINTC 32>
	 <PRINTD .OBJ>>

<ROUTINE PRINT-PRONOME (OBJ MAIUSCULA)
	 <COND (.MAIUSCULA <PRINTC !\E>) (T <PRINTC !\e>)>
	 <COND (<FSET? .OBJ ,FEMBIT> <TELL "la">) (T <TELL "le">)>
	 <COND (<FSET? .OBJ ,PLURALBIT> <PRINTC !\s>)>>

;"seu, sua, seus, suas"
<ROUTINE PRINT-POSSESSIVO (OBJ MAIUSCULA)
	 <COND (.MAIUSCULA <PRINTC !\S>) (T <PRINTC !\s>)>
	 <COND (<FSET? .OBJ ,FEMBIT> <TELL "ua">) (T <TELL "eu">)>
	 <COND (<FSET? .OBJ ,PLURALBIT> <PRINTC !\s>)>
	 <PRINTC 32>
	 <PRINTD .OBJ>>

<ROUTINE PRINT-PLURAL (OBJ SINGULAR PLURAL)
	 <COND (<FSET? .OBJ ,PLURALBIT> <TELL .PLURAL>)
	       (T <TELL .SINGULAR>)>>

"Perguntas e avisos do parser"

;"Começo da pergunta quando falta um objeto (ver SYNTAX-CHECK):
  O que você quer pegar? / Com o que você quer atacar o troll?"
<ROUTINE PERGUNTA-PREP (PREP)
	 <COND (<EQUAL? .PREP ,PR?WITH> <TELL "Com o que">)
	       (<EQUAL? .PREP ,PR?IN> <TELL "Em que">)
	       (<EQUAL? .PREP ,PR?ON> <TELL "Sobre o que">)
	       (<EQUAL? .PREP ,PR?TO> <TELL "Para quem">)
	       (<EQUAL? .PREP ,PR?FROM ,PR?OUT ,PR?OFF> <TELL "De onde">)
	       (<EQUAL? .PREP ,PR?UNDER> <TELL "Debaixo de que">)
	       (<EQUAL? .PREP ,PR?BEHIND> <TELL "Atrás de que">)
	       (<EQUAL? .PREP ,PR?AT> <TELL "Em quem">)
	       (T <TELL "O que">)>>

;"Objeto escolhido pelo próprio jogo (GWIM): (com a faca), (no barco)"
<ROUTINE PRINT-PREP-OBJ (PREP OBJ)
	 <COND (<EQUAL? .PREP ,PR?WITH> <TELL "com " T-O .OBJ>)
	       (<EQUAL? .PREP ,PR?IN ,PR?AT> <TELL T-NO .OBJ>)
	       (<EQUAL? .PREP ,PR?ON> <TELL "sobre " T-O .OBJ>)
	       (<EQUAL? .PREP ,PR?TO> <TELL "para " T-O .OBJ>)
	       (<EQUAL? .PREP ,PR?FROM ,PR?OUT ,PR?OFF> <TELL T-DO .OBJ>)
	       (<EQUAL? .PREP ,PR?UNDER> <TELL "debaixo " T-DO .OBJ>)
	       (<EQUAL? .PREP ,PR?BEHIND> <TELL "atrás " T-DO .OBJ>)
	       (T <TELL T-O .OBJ>)>>

;"Quando o jogo repete o que o jogador digitou (Você não vê a lanterna
  aqui!), ainda não sabe de qual objeto se trata nem o gênero dele. Por isso
  repete também o artigo digitado, se houver. BEG aponta para a palavra em
  P-LEXV logo depois do artigo (CLAUSE pula o artigo)."
<ROUTINE ARTIGO-DIGITADO (BEG "AUX" ANT)
	 <COND (<AND <NOT <OR ,P-OFLAG ,P-MERGED>>
		     <NOT <EQUAL? .BEG <REST ,P-LEXV 2>>>>
		<SET ANT <BACK .BEG 4>>
		<COND (<EQUAL? <GET .ANT 0> ,W?THE ,W?A>
		       <WORD-PRINT <GETB .ANT 2> <GETB .ANT 3>>
		       <PRINTC 32>)>)>>

"Desfazer (o UNDO da V5)"

<GLOBAL PODE-DESFAZER <>>

;"Antes de rodar cada linha digitada, guarda o estado (ISAVE). Desfazer
  (V-DESFAZER) volta a ele: a execução retorna aqui, com 2, e a linha que
  tinha sido digitada é descartada. A linha desfazer não guarda nada, senão
  apagaria o estado anterior."
<ROUTINE GUARDA-DESFAZER ("AUX" R)
	 <COND (<OR <ZERO? <GETB ,P-LEXV ,P-LEXWORDS>>
		    <EQUAL? <PALAVRA 1> ,W?DESFAZER ,W?DESFACA ,W?DESFAZ>>
		<RTRUE>)>
	 <SET R <ISAVE>>
	 <COND (<EQUAL? .R 2>
		<TELL "Você desfez a última jogada." CR>
		<RFALSE>)
	       (<EQUAL? .R 1>
		<SETG PODE-DESFAZER T>)>
	 <RTRUE>>

<ROUTINE V-DESFAZER ()
	 <COND (,PODE-DESFAZER <IRESTORE>)>
	 <TELL "Não dá para desfazer agora." CR>>

;"O verbo digitado é deste (ACT?THROW...)? Serve para separar o que o
  português junta numa preposição só (no = IN e ON)."
<ROUTINE VERBO-DIGITADO? (ACT)
	 <EQUAL? <WT? <GET ,P-VTBL 0> ,PS?VERB ,P1?VERB> .ACT>>

;"Verbo no infinitivo, pelo número do verbo (ACT?)"
<ROUTINE PRINT-INFINITIVO (V)
	 <TELL
	  <COND (<EQUAL? .V ,ACT?TAKE> "pegar")
		(<EQUAL? .V ,ACT?DROP ,ACT?LEAVE> "largar")
		(<EQUAL? .V ,ACT?PUT ,ACT?APPLY> "colocar")
		(<EQUAL? .V ,ACT?GIVE> "dar")
		(<EQUAL? .V ,ACT?OPEN> "abrir")
		(<EQUAL? .V ,ACT?CLOSE> "fechar")
		(<EQUAL? .V ,ACT?EXAMINE> "examinar")
		(<EQUAL? .V ,ACT?LOOK> "olhar")
		(<EQUAL? .V ,ACT?READ> "ler")
		(<EQUAL? .V ,ACT?ATTACK ,ACT?STAB ,ACT?STRIKE> "atacar")
		(<EQUAL? .V ,ACT?KILL> "matar")
		(<EQUAL? .V ,ACT?THROW> "jogar")
		(<EQUAL? .V ,ACT?MOVE ,ACT?ROLL ,ACT?SLIDE> "mover")
		(<EQUAL? .V ,ACT?PUSH> "empurrar")
		(<EQUAL? .V ,ACT?PULL> "puxar")
		(<EQUAL? .V ,ACT?TURN ,ACT?SPIN> "girar")
		(<EQUAL? .V ,ACT?ACTIVATE> "ligar")
		(<EQUAL? .V ,ACT?EXTINGUISH ,ACT?BLOW> "apagar")
		(<EQUAL? .V ,ACT?LIGHT> "acender")
		(<EQUAL? .V ,ACT?BURN> "queimar")
		(<EQUAL? .V ,ACT?EAT> "comer")
		(<EQUAL? .V ,ACT?DRINK> "beber")
		(<EQUAL? .V ,ACT?FILL> "encher")
		(<EQUAL? .V ,ACT?POUR> "despejar")
		(<EQUAL? .V ,ACT?CLIMB> "escalar")
		(<EQUAL? .V ,ACT?SUBIR> "subir")
		(<EQUAL? .V ,ACT?DESCER> "descer")
		(<EQUAL? .V ,ACT?ENTER> "entrar")
		(<EQUAL? .V ,ACT?EXIT> "sair")
		(<EQUAL? .V ,ACT?BOARD> "embarcar")
		(<EQUAL? .V ,ACT?DISEMBARK> "desembarcar")
		(<EQUAL? .V ,ACT?WALK> "ir")
		(<EQUAL? .V ,ACT?FOLLOW> "seguir")
		(<EQUAL? .V ,ACT?FIND ,ACT?SEARCH> "procurar")
		(<EQUAL? .V ,ACT?TIE> "amarrar")
		(<EQUAL? .V ,ACT?UNTIE> "desamarrar")
		(<EQUAL? .V ,ACT?LOCK> "trancar")
		(<EQUAL? .V ,ACT?UNLOCK> "destrancar")
		(<EQUAL? .V ,ACT?CUT> "cortar")
		(<EQUAL? .V ,ACT?DIG> "cavar")
		(<EQUAL? .V ,ACT?DESTROY ,ACT?POKE ,ACT?PUNCTURE> "quebrar")
		(<EQUAL? .V ,ACT?INFLATE ,ACT?PUMP> "inflar")
		(<EQUAL? .V ,ACT?DEFLATE> "esvaziar")
		(<EQUAL? .V ,ACT?PLUG> "consertar")
		(<EQUAL? .V ,ACT?LUBRICATE> "lubrificar")
		(<EQUAL? .V ,ACT?WAVE ,ACT?SWING> "agitar")
		(<EQUAL? .V ,ACT?RING> "tocar")
		(<EQUAL? .V ,ACT?RUB> "esfregar")
		(<EQUAL? .V ,ACT?WIND> "dar corda em")
		(<EQUAL? .V ,ACT?WEAR> "vestir")
		(<EQUAL? .V ,ACT?RAISE> "levantar")
		(<EQUAL? .V ,ACT?LOWER> "abaixar")
		(<EQUAL? .V ,ACT?SHAKE> "sacudir")
		(<EQUAL? .V ,ACT?SQUEEZE> "espremer")
		(<EQUAL? .V ,ACT?SMELL> "cheirar")
		(<EQUAL? .V ,ACT?LISTEN> "ouvir")
		(<EQUAL? .V ,ACT?KICK> "chutar")
		(<EQUAL? .V ,ACT?KISS> "beijar")
		(<EQUAL? .V ,ACT?KNOCK> "bater")
		(<EQUAL? .V ,ACT?BRUSH> "escovar")
		(<EQUAL? .V ,ACT?COUNT> "contar")
		(<EQUAL? .V ,ACT?CROSS> "atravessar")
		(<EQUAL? .V ,ACT?JUMP> "pular")
		(<EQUAL? .V ,ACT?SWIM> "nadar")
		(<EQUAL? .V ,ACT?LAUNCH> "lançar")
		(<EQUAL? .V ,ACT?MELT> "derreter")
		(<EQUAL? .V ,ACT?WAKE> "acordar")
		(<EQUAL? .V ,ACT?TELL ,ACT?TALK ,ACT?ANSWER> "falar com")
		(<EQUAL? .V ,ACT?SAY> "dizer")
		(<EQUAL? .V ,ACT?EXORCISE> "exorcizar")
		(<EQUAL? .V ,ACT?ENCHANT> "encantar")
		(<EQUAL? .V ,ACT?DISENCHANT> "desencantar")
		(<EQUAL? .V ,ACT?PLAY> "tocar")
		(<EQUAL? .V ,ACT?PICK> "forçar")
		(<EQUAL? .V ,ACT?SPRAY> "borrifar")
		(<EQUAL? .V ,ACT?HATCH> "chocar")
		(<EQUAL? .V ,ACT?MAKE> "fazer")
		(<EQUAL? .V ,ACT?SEND> "mandar buscar")
		(<EQUAL? .V ,ACT?LEAN> "apoiar")
		(<EQUAL? .V ,ACT?COMMAND> "comandar")
		(<EQUAL? .V ,ACT?HELLO> "cumprimentar")
		(<EQUAL? .V ,ACT?CURSE> "xingar")
		(<EQUAL? .V ,ACT?RAPE> "molestar")
		(<EQUAL? .V ,ACT?STAND> "levantar")
		(T "fazer")>>>
