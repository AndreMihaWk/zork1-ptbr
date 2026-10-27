"PT-PARSER: adaptações do parser para o português do Brasil.

Entrada (chamadas por READ-INPUT, em gparser.zil):
- NORMALIZA-ENTRADA roda antes do LEX: tira acentos e cedilha, passa para
  minúsculas e separa pronomes com hífen (pegue-o vira pegue lo).
- AJUSTA-LEXV roda depois do LEX e reescreve a lista de palavras: abreviações
  de direção, dê/dá, dar corda, preposições de duas palavras, o de dos nomes
  compostos (caixa de correio) e as palavras que o parser compara por
  endereço (tudo, isso, depois...).

Saída: marcadores do TELL que escrevem o nome do objeto com artigo e
concordância. Objetos femininos levam FEMBIT, plurais PLURALBIT e nomes sem
artigo SEMARTIGOBIT. Ver docs/TRADUCAO.md."

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

<ROUTINE NORMALIZA-ENTRADA ("AUX" (I 2) C N)
	 <REPEAT ()
		 <COND (<G? .I <+ <GETB ,P-INBUF 1> 1>> <RETURN>)>
		 <SET C <GETB ,P-INBUF .I>>
		 <COND (<AND <G? .C 154> <L? .C 224>>
			<COND (<NOT <ZERO? <SET N <GETB ,SEM-ACENTO <- .C 155>>>>>
			       <PUTB ,P-INBUF .I .N>)>)
		       (<AND <G? .C 64> <L? .C 91>>
			<PUTB ,P-INBUF .I <+ .C 32>>)
		       (<EQUAL? .C !\->
			<SEPARA-HIFEN .I>)>
		 <SET I <+ .I 1>>>>

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

<ROUTINE PREENCHIMENTO? (W)
	 <OR <WT? .W ,PS?PREPOSITION>
	     <WT? .W ,PS?BUZZ-WORD>
	     <EQUAL? .W ,W?DIRECAO ,W?RUMO>>>

<ROUTINE AJUSTA-LEXV ("AUX" N W V (I 1))
	 <SET N <GETB ,P-LEXV ,P-LEXWORDS>>
	 <COND (<ZERO? .N> <RTRUE>)>
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

<ADD-TELL-TOKENS
	T-O *		<PRINT-ARTIGO .X <>>
	T-CO *		<PRINT-ARTIGO .X T>
	T-UM *		<PRINT-INDEFINIDO .X <>>
	T-CUM *		<PRINT-INDEFINIDO .X T>
	T-DO *		<PRINT-CONTRACAO .X "d" "de">
	T-NO *		<PRINT-CONTRACAO .X "n" "em">
	T-PELO *	<PRINT-CONTRACAO .X "pel" "por">
	T-AO *		<PRINT-AO .X>
	T-G *		<PRINT-TERMINACAO .X>
	T-ELE *		<PRINT-PRONOME .X <>>
	T-CELE *	<PRINT-PRONOME .X T>
	T-ESTA *	<PRINT-PLURAL .X "está" "estão">
	T-SER *		<PRINT-PLURAL .X "é" "são">>

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

<ROUTINE PRINT-INDEFINIDO (OBJ MAIUSCULA)
	 <COND (<NOT <FSET? .OBJ ,SEMARTIGOBIT>>
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

<ROUTINE PRINT-PLURAL (OBJ SINGULAR PLURAL)
	 <COND (<FSET? .OBJ ,PLURALBIT> <TELL .PLURAL>)
	       (T <TELL .SINGULAR>)>>
