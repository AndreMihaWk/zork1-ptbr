 			"Arquivo genérico de VERBOS da
			    Trilogia ZORK,
		       iniciado em 25/7/83 por SEM"

^L

"Funções de verbos para os comandos do jogo"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Descrições completas." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Descrições breves." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Descrições superbreves." CR>>

;"V-DIAGNOSE is in ACTIONS.ZIL"

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "Você está de mãos vazias." CR>)>>

<ROUTINE FINISH ("AUX" WRD)
	 <V-SCORE>
	 <REPEAT ()
		 <CRLF>
		 <TELL
"Você gostaria de recomeçar o jogo do início, carregar uma posição
salva ou encerrar esta sessão de jogo?|
(Digite REINICIAR, CARREGAR ou DESISTIR):|
>">
		 <READ-INPUT>
		 <SET WRD <GET ,P-LEXV 1>>
		 <COND (<EQUAL? .WRD ,W?RESTART>
			<RESTART>
			<TELL "Falhou." CR>)
		       (<EQUAL? .WRD ,W?RESTORE>
			<COND (<RESTORE>
			       <TELL "Ok." CR>)
			      (T
			       <TELL "Falhou." CR>)>)
		       (<EQUAL? .WRD ,W?QUIT ,W?Q>
			<QUIT>)>>>

<ROUTINE V-QUIT ("AUX" SCOR)
	 <V-SCORE>
	 <TELL 
"Você deseja sair do jogo? (S para sim): ">
	 <COND (<YES?>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Você deseja recomeçar? (S para sim): ">
	 <COND (<YES?>
		<TELL "Recomeçando." CR>
		<RESTART>
		<TELL "Falhou." CR>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Falhou." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Falhou." CR>)>>

;"V-SCORE is in ACTIONS.ZIL"

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Aqui começa uma transcrição da interação com" CR>
	<V-VERSION>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Aqui termina a transcrição da interação com" CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	%<COND (<==? ,ZORK-NUMBER 1>
		'<TELL "ZORK I: O Grande Império Subterrâneo|
Ficção interativa da Infocom - uma história de fantasia|
Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986">)
	       (<==? ,ZORK-NUMBER 2>
		'<TELL "ZORK II: O Mago de Frobozz|
Ficção interativa da Infocom - uma história de fantasia|
Copyright (c) 1981, 1982, 1983, 1986">)
	       (<==? ,ZORK-NUMBER 3>
		'<TELL "ZORK III: O Dungeon Master|
Ficção interativa da Infocom - uma história de fantasia|
Copyright 1982, 1983, 1984, 1986">)>
	<TELL " Infocom, Inc. Todos os direitos reservados." CR>
	<TELL "ZORK é uma marca registrada da Infocom, Inc.|
Versão ">
	<PRINTN <BAND <GET 0 1> *3777*>>
	<TELL " / Número de série ">
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> 23>
		       <RETURN>)
		      (T
		       <PRINTC <GETB 0 .CNT>>)>>
	<CRLF>>

<ROUTINE V-VERIFY ()
	 <TELL "Verificando o disco..." CR>
	 <COND (<VERIFY>
		<TELL "O disco está correto." CR>)
	       (T
		<TELL CR "** Falha no disco **" CR>)>>

<ROUTINE V-COMMAND-FILE ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Chamada ilegal a #RND." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-RECORD ()
	 <DIROUT 4>
	 <RTRUE>>

<ROUTINE V-UNRECORD ()
	 <DIROUT -4>
	 <RTRUE>>

^L

"Funções dos verbos de verdade"

<ROUTINE V-ADVENT ()
	 <TELL "Uma voz cavernosa diz: \"Tolo.\"" CR>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND %<COND (<==? ,ZORK-NUMBER 1>
			      '(<L? <GETP ,PRSO ,P?STRENGTH> 0>
		                <TELL T-CO ,PRSO " " T-SER ,PRSO " acordad" T-G ,PRSO " bruscamente." CR>
		                <AWAKEN ,PRSO>))
			     (T
			      '(<NULL-F> <RTRUE>))>
		      (T
		       <TELL
T-CELE ,PRSO " já " T-ESTA ,PRSO " bem acordad" T-G ,PRSO ", ou você não reparou..." CR>)>)
	       (T
		<TELL T-CO ,PRSO " não " T-ESTA ,PRSO " dormindo." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Ninguém parece estar esperando sua resposta." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-ATTACK ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL
"Já conheci gente estranha, mas lutar contra " T-UM ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL
"Atacar " T-O ,PRSO " de mãos vazias é suicídio." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "Você nem está segurando " T-O ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"Atacar " T-O ,PRSO " com " T-UM ,PRSI " é suicídio." CR>)
	       (T
	        %<COND (<==? ,ZORK-NUMBER 1>
			'<HERO-BLOW>)
		       (T
			'<TELL "Você não pode." CR>)>)>>

<ROUTINE V-BACK ()
	 <TELL "Desculpe, minha memória é fraca. Diga uma direção, por favor." CR>>

<ROUTINE V-BLAST ()
	 <TELL "Você não vai explodir nada só com palavras." CR>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,WATER-CHANNEL ,TM-SEAT ,LAKE>
		         <RFALSE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <IN? ,PRSO ,HERE>>
		       <TELL
"Ponha " T-O ,PRSO " no chão antes de embarcar." CR>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "Você já está " T-NO .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"Você tem alguma teoria sobre como embarcar em " T-UM ,PRSO ", por acaso?" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL "Agora você está " T-NO ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE V-BRUSH ()
	 <TELL "Se você quiser, mas só Deus sabe por quê." CR>>

<ROUTINE V-BUG ()
	 <TELL
"Bug? Num programa perfeito como este? Jamais! (Cof, cof)." CR>>

<ROUTINE TELL-NO-PRSI ()
	 <TELL "Você não disse com o quê!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL-NO-PRSI>)
	       (<FLAMING? ,PRSI>
	        <RFALSE>)
	       (T
	        <TELL "Com " T-UM ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND %<COND (<==? ,ZORK-NUMBER 2>
		       '(<EQUAL? <LOC ,PRSO> ,RECEPTACLE>
		         <BALLOON-BURN>
		         <RTRUE>))
		      (T
		       '(<NULL-F> <RFALSE>))>
	       (<FSET? ,PRSO ,BURNBIT>
		<COND (<OR <IN? ,PRSO ,WINNER>
			   <IN? ,WINNER ,PRSO>>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "O fogo toma conta " T-DO ,PRSO>
		       <TELL
". Infelizmente, você estava ">
		       <COND (<IN? ,WINNER ,PRSO>
			      <TELL "dentro d" T-ELE ,PRSO>)
			     (T <TELL "com " T-ELE ,PRSO " na mão">)>
		       <JIGS-UP " naquele momento.">)
		      (T
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL
"O fogo consome " T-O ,PRSO " por completo." CR>)>)
	       (T
		<TELL "Você não pode queimar " T-UM ,PRSO "." CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "Que absurdo!" CR>>

<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?DOWN ,PRSO>>

<ROUTINE V-CLIMB-FOO ()
	 %<COND (<==? ,ZORK-NUMBER 3>
		 '<V-CLIMB-UP <COND (<EQUAL? ,PRSO ,ROPE ,GLOBAL-ROPE>
				     ,P?DOWN)
				    (T ,P?UP)>
			      T>)
		(ELSE
		 '<V-CLIMB-UP ,P?UP ,PRSO>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		%<COND (<==? ,ZORK-NUMBER 3>
			'<V-CLIMB-UP ,P?UP T>)
		       (ELSE
			'<PERFORM ,V?BOARD ,PRSO>)>
		<RTRUE>)
	       (T
		<TELL "Você não consegue subir " T-NO ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)
	 <COND (<AND .OBJ <NOT <EQUAL? ,PRSO ,ROOMS>>>
		<SET OBJ ,PRSO>)>
	 <COND (<SET TX <GETPT ,HERE .DIR>>
		<COND (.OBJ
		       <SET X <PTSIZE .TX>>
		       <COND (<OR <EQUAL? .X ,NEXIT>
				  <AND <EQUAL? .X ,CEXIT ,DEXIT ,UEXIT>
				       <NOT <GLOBAL-IN? ,PRSO <GET .TX ,REXIT>>>>> ;"V5"
			      <TELL "Não dá para ">
			      <COND (<==? .DIR ,P?UP>
				     <TELL "subir">)
				    (T <TELL "descer">)>
			      <TELL " " T-PELO .OBJ "." CR>
			      <RTRUE>)>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<AND .OBJ
		     <ZMEMQ ,W?PAREDE
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Escalar as paredes não adianta nada." CR>)
	       (%<COND (<==? ,ZORK-NUMBER 1>
			'<AND <NOT <EQUAL? ,HERE ,PATH>>
			      <EQUAL? .OBJ <> ,TREE>
			      <GLOBAL-IN? ,TREE ,HERE>>)
		       (ELSE '<NULL-F>)>
		<TELL "Não há árvores para escalar aqui." CR>
		<RTRUE>)
	       (<EQUAL? .OBJ <> ,ROOMS>
		<TELL "Você não pode ir por aí." CR>)
	       (T
	        <TELL "Você não pode fazer isso!" CR>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "Você precisa me explicar como se faz isso com " T-UM ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Você fechou " T-O ,PRSO "." CR>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "Agora está um breu total." CR>)>
		       <RTRUE>)
		      (T
	 	       <TELL T-CO ,PRSO " já " T-ESTA ,PRSO " fechad" T-G ,PRSO "." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL T-CO ,PRSO " agora " T-ESTA ,PRSO " fechad" T-G ,PRSO "." CR>)
		      (T
	 	       <TELL T-CO ,PRSO " já " T-ESTA ,PRSO " fechad" T-G ,PRSO "." CR>)>)
	       (T
		<TELL "Você não pode fechar isso." CR>)>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL T-CO ,PRSO " não " T-ESTA ,PRSO " prestando a menor atenção." CR>)
	       (T
		<TELL "Você não pode falar com isso!" CR>)>>

<ROUTINE V-COUNT ()
	 <COND (<EQUAL? ,PRSO ,BLESSINGS>
	 	<TELL "Bem, para começar, você está jogando Zork..." CR>)
	       (T
		<TELL "Você perdeu o juízo." CR>)>>

<ROUTINE V-CROSS ()
	 <TELL "Você não pode atravessar isso!" CR>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Insultos desse tipo não vão ajudar em nada." CR>)
		      (T
		       <TELL "Que maluquice!" CR>)>)
	       (T
		<TELL
"Que linguajar, num estabelecimento fino como este!" CR>)>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<COND (<IN? ,WINNER ,PRSO>
		       <TELL
"Não é uma ideia brilhante, ainda mais com você aí dentro." CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "Com grande perícia no manejo " T-DO ,PRSI ", você reduz " T-O ,PRSO
" a inúmeros pedacinhos, que o vento leva embora." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"O \"gume\" de " T-UM ,PRSI " deixa muito a desejar." CR>)
	       (T
		<TELL "Que ideia estranha, cortar " T-O ,PRSO "..." CR>)>>

<ROUTINE V-DEFLATE ()
	 <TELL "Ah, faça-me o favor!" CR>>

<ROUTINE V-DIG ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,HANDS>)>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<EQUAL? ,PRSI ,SHOVEL>
			 <TELL "Não há motivo para cavar aqui." CR>
			 <RTRUE>)>)
		(ELSE T)>
	 <COND (<FSET? ,PRSI ,TOOLBIT>
		<TELL "Cavar com " T-O ,PRSI " é lento e tedioso." CR>)
	       (T
		<TELL "Cavar com " T-UM ,PRSI " é bobagem." CR>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <EQUAL? ,PRSO ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL "Você não está dentro disso!" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<TELL "Você está de pé outra vez." CR>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"Você percebe que sair aqui seria fatal." CR>
		<RFATAL>)>>

<ROUTINE V-DISENCHANT ()
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<NOT <IN? ,PRSO ,HERE>>
		         <RTRUE>)
	                (<OR <EQUAL? ,SPELL-USED ,W?FEEBLE ,W?FUMBLE ,W?FEAR>
		          <EQUAL? ,SPELL-USED ,W?FREEZE ,W?FALL ,W?FERMENT>
		          <EQUAL? ,SPELL-USED ,W?FIERCE ,W?FENCE ,W?FANTASIZE>>
		          <COND (<FSET? ,PRSO ,ACTORBIT>
		                 <COND (<EQUAL? ,SPELL-USED ,W?FEEBLE>
			                <TELL
T-CO ,PRSO " já não " T-ESTA ,PRSO " tão frac" T-G ,PRSO "." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FUMBLE>
			                <TELL
T-CO ,PRSO " já não " T-ESTA ,PRSO " tão desajeitad" T-G ,PRSO "." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FEAR>
			                <TELL
T-CO ,PRSO " já não " T-ESTA ,PRSO " com medo." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FREEZE>
			                <TELL
T-CO ,PRSO " já " T-ESTA ,PRSO " se mexendo de novo." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FERMENT>
			                <TELL
T-CO ,PRSO " já não " T-ESTA ,PRSO " cambaleando." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FIERCE>
			                <TELL
T-CO ,PRSO " agora " T-ESTA ,PRSO " mais calm" T-G ,PRSO "." CR>)>)>)
	                        (<EQUAL? ,SPELL-USED ,W?FLOAT>
		                 <TELL
T-CO ,PRSO " " T-ESTA ,PRSO " de volta ao chão." CR>)
	                        (<EQUAL? ,SPELL-USED ,W?FUDGE>
		                 <TELL "O cheiro doce se dissipou." CR>)>)
		(T
		 '<TELL "Nada acontece." CR>)>>

<ROUTINE V-DRINK ()
	 <V-EAT>>

<ROUTINE V-DRINK-FROM ()
	 <TELL "Que coisa peculiar!" CR>>

<ROUTINE PRE-DROP ()
	 <COND (<AND ,PRSI <VERBO-DIGITADO? ,ACT?POUR>
		     <NOT <FSET? ,PRSI ,CONTBIT>>>
		;"PT: despeje a água no sino é despejar sobre ele (no é IN e ON)"
		<PERFORM ,V?POUR-ON ,PRSO ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Você largou " T-O ,PRSO "." CR>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 <COND (<SET EAT? <FSET? ,PRSO ,FOODBIT>>
		<COND (<AND <NOT <IN? ,PRSO ,WINNER>>
			    <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		       <TELL "Você não está segurando isso." CR>)
		      (<VERB? DRINK>
		       <TELL "Como você pretende beber isso?">)
		      (T
		       <TELL "Muito obrigado. Caiu muito bem.">
		       <REMOVE-CAREFULLY ,PRSO>)>
		<CRLF>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<SET DRINK? T>
		<SET NOBJ <LOC ,PRSO>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <GLOBAL-IN? ,GLOBAL-WATER ,HERE>
			   <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		       <HIT-SPOT>)
		      (<OR <NOT .NOBJ>
			   <NOT <ACCESSIBLE? .NOBJ>>>
		       <TELL
"Não há água aqui." CR>)
		      (<AND <ACCESSIBLE? .NOBJ>
			    <NOT <IN? .NOBJ ,WINNER>>>
		       <TELL
"Primeiro você precisa estar segurando " T-O .NOBJ "." CR>)
		      (<NOT <FSET? .NOBJ ,OPENBIT>>
		       <TELL
"Primeiro você vai ter que abrir " T-O .NOBJ "." CR>)
		      (T
		       <HIT-SPOT>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL
"Duvido que seu estômago se dê bem com " T-O ,PRSO "." CR>)>>

<ROUTINE HIT-SPOT ()
	 <COND (<AND <EQUAL? ,PRSO ,WATER>
		     <NOT <GLOBAL-IN? ,GLOBAL-WATER ,HERE>>>
		<REMOVE-CAREFULLY ,PRSO>)>
	 <TELL
"Muito obrigado. Eu estava com bastante sede (de tanto falar,
provavelmente)." CR>>

<ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT) 
	 #DECL ((LST) <PRIMTYPE VECTOR> (MAX CNT ECH) FIX)
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
	                 <SET LST <REST 
				   ,P-LEXV
				   <* <GETB ,P-LEXV ,P-LEXWORDS> ,P-WORDLEN>>>
	                 <SET MAX <- <+ <GETB .LST 0> <GETB .LST 1>> 1>>
	                 <REPEAT ()
		            <COND (<G? <SET ECH <+ .ECH 1>> 2>
			           <TELL "..." CR>
				   <RETURN>)
			          (T
			           <SET CNT <- <GETB .LST 1> 1>>
			           <REPEAT ()
				      <COND (<G? <SET CNT <+ .CNT 1>> .MAX>
					     <RETURN>)
					    (T
					     <PRINTC <GETB ,P-INBUF-DIGITADO .CNT>>)>> ;"PT"
			           <TELL " ">)>>)
			(T <TELL "eco eco ..." CR>)>)
		(T
		 '<TELL "eco eco ..." CR>)>>

<ROUTINE V-ENCHANT ()
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,WAND-ON <SETG SPELL-VICTIM ,WAND-ON>)>)
       (T
	'<NULL-F>)>
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,SPELL-VICTIM
		<COND (<NOT ,SPELL-USED>
		       <TELL "Você precisa ser mais específico." CR>
		       <RTRUE>)>
		<COND (<OR <EQUAL? ,SPELL-USED ,W?FEEBLE ,W?FUMBLE ,W?FEAR>
			   <EQUAL? ,SPELL-USED ,W?FREEZE ,W?FALL ,W?FERMENT>
			   <EQUAL? ,SPELL-USED ,W?FIERCE ,W?FENCE ,W?FANTASIZE>>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"A varinha para de brilhar, mas não há nenhum outro efeito visível." CR>)
			     (T
			      <TELL
"Isso pode ter feito alguma coisa, mas é difícil dizer, tratando-se de " T-UM ,PRSO "." CR>)>)
		      ;(<EQUAL? ,SPELL-USED ,W?FIREPROOF>
		       <RTRUE>)
		      (<EQUAL? ,SPELL-USED ,W?FUDGE>
		       <TELL
"Um forte cheiro de chocolate toma conta do ambiente." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FLUORESCE>
		       <FSET ,PRSO ,LIGHTBIT>
		       <FSET ,PRSO ,ONBIT>
		       <SETG LIT T>
		       <TELL
T-CO ,PRSO " agora " T-ESTA ,PRSO " brilhando." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FILCH>
		       <SETG SPELL-HANDLED? T>
		       <COND (<FSET? ,PRSO ,TAKEBIT>
			      <MOVE ,PRSO ,WINNER>
			      <SCORE-OBJ ,PRSO>
			      <TELL "Você afanou " T-O ,PRSO "!" CR>)
			     (ELSE
			      <TELL "Você não pode afanar " T-O ,PRSO "!" CR>)>)
		      (<AND <EQUAL? ,SPELL-USED ,W?FLOAT>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <COND (<AND <EQUAL? ,SPELL-VICTIM ,COLLAR>
				   <IN? ,COLLAR ,CERBERUS>>
			      <SETG SPELL-VICTIM ,CERBERUS>)>
		       <TELL
T-CO ,PRSO " agora " T-ESTA ,PRSO " flutuando serenamente no ar." CR>)
		      (<AND <EQUAL? ,SPELL-USED ,W?FRY>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <SETG SPELL-HANDLED? T>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "Puf! Não sobra nada " T-DO ,PRSO " além de uma nuvem de fumaça." CR>)
		      (ELSE
		       <SETG SPELL-VICTIM <>>
		       <TELL
"A varinha para de brilhar, mas não há nenhum outro efeito aparente." CR>)>)
	       (ELSE
		<SETG SPELL-VICTIM <>>
		<TELL "Nada acontece." CR>)>)
       (T
	'<V-DISENCHANT>)>>

<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)
	 <COND (<EQUAL? .OBJ ,P-IT-OBJECT>
		<SETG P-IT-OBJECT <>>)>
	 <SET OLIT ,LIT>
	 <REMOVE .OBJ>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT <EQUAL? .OLIT ,LIT>>>
		<TELL "Você fica no escuro..." CR>)>
	 T>

<ROUTINE V-ENTER ()
	<DO-WALK ,P?IN>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (T
		<TELL "Você não vê nada de especial " T-NO ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<AND <EQUAL? ,PRSO <> ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<AND ,PRSO <IN? ,WINNER ,PRSO>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (ELSE
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-EXORCISE ()
	 <TELL "Que ideia bizarra!" CR>>

<ROUTINE PRE-FILL ("AUX" TX)
	 <COND (<NOT ,PRSI>
		<SET TX <GETPT ,HERE ,P?GLOBAL>>
		<COND (<AND .TX <ZMEMQ ,GLOBAL-WATER .TX <- </ <PTSIZE .TX> 2> 1>>>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		       <RTRUE>)
		      (<IN? ,WATER <LOC ,WINNER>>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "Não há com o que enchê-l" T-G ,PRSO "." CR>
		       <RTRUE>)>)>
	 <COND (<EQUAL? ,PRSI ,WATER>
		<RFALSE>)
	       (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		       <RTRUE>)
		      (<IN? ,WATER <LOC ,WINNER>>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "Não há nada aqui para enchê-l" T-G ,PRSO "." CR>)>)
	       (T
		<TELL "Você pode até saber como fazer isso, mas eu não sei." CR>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS ,LUNGS>
		<TELL
"A menos de dois metros da sua cabeça, supondo que você não tenha
esquecido isso em algum lugar." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "Você está por aqui, em algum lugar..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "Você encontrou " T-O ,PRSO "." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL T-CELE ,PRSO " " T-ESTA ,PRSO " com você." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL T-CELE ,PRSO " " T-ESTA ,PRSO " bem aqui." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL T-CO .L " " T-ESTA .L " com " T-ELE ,PRSO "." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL T-CELE ,PRSO " " T-ESTA ,PRSO " " T-NO .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL T-CELE ,PRSO " " T-ESTA ,PRSO " dentro " T-DO .L "." CR>)
	       (T
		<TELL "Não faço a menor ideia." CR>)>>

<ROUTINE V-FOLLOW ()
	 <TELL "Você pirou!" CR>>

<ROUTINE V-FROBOZZ ()
	 <TELL
"A Corporação FROBOZZ criou esta masmorra, é dona dela e a administra." CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"Falar é fácil, mas você nem tem " T-O ,PRSO "." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "Você não pode dar " T-UM ,PRSO " para " T-UM ,PRSI "!" CR>)
	       (T
		<TELL T-CO ,PRSI " recusa educadamente." CR>)>>

<ROUTINE V-HATCH ()
	 <TELL "Que bizarro!" CR>>

<GLOBAL HS 0> ;"counts occurences of HELLO, SAILOR"

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
T-CO ,PRSO " inclina a cabeça para você, em sinal de saudação." CR>)
		      (T
		       <TELL
"Todo mundo sabe que só esquizofrênicos dizem \"Olá\" para "
T-UM ,PRSO "." CR>)>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE V-INCANT ()
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,SPELL-USED
		<TELL "Nada acontece." CR>)
	       (,WAND-ON
		<SETG SPELL-VICTIM ,WAND-ON>
		<SETG SPELL-USED <GET ,P-LEXV ,P-CONT>>
		<TELL "A varinha brilha com muita força por um instante." CR>
		<ENABLE <QUEUE I-SPELL <+ 10 <RANDOM 10>>>>
		<SETG WAND-ON <>>
		<PERFORM ,V?ENCHANT ,SPELL-VICTIM>)
	       (T
		<TELL
"O encantamento ecoa baixinho, mas nada mais acontece." CR>)>)
       (T
	'<TELL
"O encantamento ecoa baixinho, mas nada mais acontece." CR>)>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-INFLATE ()
	 <TELL "Como você pretende inflar isso?" CR>>

<ROUTINE V-KICK () <HACK-HACK "Chutar ">>

<ROUTINE V-KISS ()
	 <TELL "Prefiro beijar um porco." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Não tem ninguém em casa." CR>)
	       (T
		<TELL "Para que bater em " T-UM ,PRSO "?" CR>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL T-CO ,PRSO " já " T-ESTA ,PRSO " apagad" T-G ,PRSO "." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL T-CO ,PRSO " agora " T-ESTA ,PRSO " apagad" T-G ,PRSO "." CR>
		       <COND (<NOT ,LIT>
			      <TELL "Agora está um breu total." CR>)>)>)
	       (T
		<TELL "Você não pode desligar isso." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL T-CO ,PRSO " já " T-ESTA ,PRSO " aces" T-G ,PRSO "." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL T-CO ,PRSO " agora " T-ESTA ,PRSO " aces" T-G ,PRSO "." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (<FSET? ,PRSO ,BURNBIT>
		<TELL
"Se você quer pôr fogo " T-NO ,PRSO ", é só dizer." CR>)
	       (T
		<TELL "Você não pode ligar isso." CR>)>
	 <RTRUE>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "Não dá para lançar isso só dizendo \"lance\"!" CR>)
	       (T
		<TELL "Isso é bem esquisito." CR>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Cansou?" CR>>

<ROUTINE V-LEAP ("AUX" TX S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
T-CO ,PRSO " " T-SER ,PRSO " grande demais para você pular por cima." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "Isso seria um belo truque." CR>)>)
	       (<SET TX <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .TX>>
		<COND (<OR <EQUAL? .S ,NEXIT> ;"V5: eram 2 e 4 fixos"
       			   <AND <EQUAL? .S ,CEXIT>
				<NOT <VALUE <GETB .TX ,CEXITFLAG>>>>>
		       <TELL
"Este não era um lugar muito seguro para tentar pular." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      %<COND (<==? ,ZORK-NUMBER 1>
			      '(<EQUAL? ,HERE ,UP-A-TREE>
		                <TELL
"Num ato de ousadia incomum, você consegue cair de pé sem
se matar." CR CR>
		                <DO-WALK ,P?DOWN>
		                <RTRUE>))
			     (T '(<NULL-F> T))>
		      (T
		       <V-SKIP>)>)
	       (T
		<V-SKIP>)>>

<GLOBAL JUMPLOSS
	<LTABLE 0
	       "Devia ter olhado antes de pular."
	       "Nos filmes, sua vida estaria passando diante dos seus olhos."
	       "Gerônimo...">>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
	 <TELL "Você não ouve nenhum som vindo " T-DO ,PRSO "." CR>>

<ROUTINE V-LOCK ()
	 <TELL "Isso não parece funcionar." CR>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "Não há nada atrás " T-DO ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
T-CO ,PRSO " " T-ESTA ,PRSO " abert" T-G ,PRSO ", mas não sei dizer o que há do outro lado.">)
		      (T
		       <TELL T-CO ,PRSO " " T-ESTA ,PRSO " fechad" T-G ,PRSO ".">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Não há nada de especial para ver." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<FSET? ,PRSO ,SURFACEBIT>
				       <TELL
"Não há nada sobre " T-O ,PRSO "." CR>))
				    (ELSE '(<NULL-F> <RTRUE>))>
			     (T
			      <TELL T-CO ,PRSO " " T-ESTA ,PRSO " vazi" T-G ,PRSO "." CR>)>)
		      (T
		       <TELL T-CO ,PRSO " " T-ESTA ,PRSO " fechad" T-G ,PRSO "." CR>)>)
	       (T
		<TELL "Você não pode olhar dentro de " T-UM ,PRSO "." CR>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Olhar em cima de " T-UM ,PRSO "???" CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "Não há nada além de poeira ali." CR>>

<ROUTINE V-LOWER () <HACK-HACK "Brincar assim com ">>

<ROUTINE V-MAKE ()
    	<TELL "Você não pode fazer isso." CR>>

<ROUTINE V-MELT ()
	 <TELL "Não está claro se dá para derreter " T-UM ,PRSO "." CR>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Você não é um malabarista tão habilidoso assim." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Mover " T-O ,PRSO " não revela nada." CR>)
	       (T
		<TELL "Você não consegue mover " T-O ,PRSO "." CR>)>>

<ROUTINE V-MUMBLE ()
	 <TELL "Você vai ter que falar mais alto se quiser que eu ouça!" CR>>

<ROUTINE PRE-MUNG ()
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,BEAM>
		         <RFALSE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<OR <NOT ,PRSI>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<TELL "Tentar destruir " T-O ,PRSO " com ">
		<COND (<NOT ,PRSI>
		       <TELL "as próprias mãos">)
		      (T
		       <TELL T-UM ,PRSI>)>
		<TELL " é inútil." CR>)>>

<ROUTINE V-MUNG ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Boa tentativa." CR>)>>

<ROUTINE V-ODYSSEUS ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<AND <EQUAL? ,HERE ,CYCLOPS-ROOM>
			      <IN? ,CYCLOPS ,HERE>
			      <NOT ,CYCLOPS-FLAG>>
		         <DISABLE <INT I-CYCLOPS>>
		         <SETG CYCLOPS-FLAG T>
		         <TELL 
"O ciclope, ao ouvir o nome do inimigo mortal de seu pai, foge da sala
derrubando a parede do lado leste." CR>
		        <SETG MAGIC-FLAG T>
		        <FCLEAR ,CYCLOPS ,FIGHTBIT>
		        <REMOVE-CAREFULLY ,CYCLOPS>))
		      (T
		       '(<NULL-F> T))>
	       (T
		<TELL "Ele não era um marinheiro?" CR>)>>

<ROUTINE V-OIL ()
	 <TELL "Aposto que você também põe espinafre no tanque de gasolina." CR>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL T-CO ,PRSO " já " T-ESTA ,PRSO " abert" T-G ,PRSO "." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Você abriu " T-O ,PRSO "." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <NOT <FSET? .F ,TOUCHBIT>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "Você abriu " T-O ,PRSO "." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Ao abrir " T-O ,PRSO ", você encontra ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL T-CO ,PRSO " já " T-ESTA ,PRSO " abert" T-G ,PRSO "." CR>)
		      (T
		       <TELL "Você abriu " T-O ,PRSO "." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T
		<TELL
"Você precisa me explicar como se faz isso com " T-UM ,PRSO "." CR>)>>

<ROUTINE V-OVERBOARD ("AUX" LOCN)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,PRSI ,TEETH>
			 <COND (<FSET? <SET LOCN <LOC ,WINNER>> ,VEHBIT>
				<MOVE ,PRSO <LOC .LOCN>>
				<TELL "Ó de bordo -- " D ,PRSO " ao mar!" CR>)
			       (T
				<TELL "Você não está dentro de nada!" CR>)>))
		      (T '(<NULL-F> T))>
	       (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?THROW ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Hein?" CR>)>>

<ROUTINE V-PICK () <TELL "Você não pode arrombar isso." CR>>

<ROUTINE V-PLAY ()
    <COND (<FSET? ,PRSO ,ACTORBIT>
	   <TELL
"Você se envolve tanto no papel " T-DO ,PRSO " que acaba
se matando, como " T-ELE ,PRSO " talvez tivesse feito!" CR>
	   <JIGS-UP "">)
	  (ELSE <TELL "Que bobagem!" CR>)>>

<ROUTINE V-PLUG ()
	 <TELL "Isso não tem efeito nenhum." CR>>

<ROUTINE V-POUR-ON ()
	 <COND (<EQUAL? ,PRSO ,WATER>
		<REMOVE-CAREFULLY ,PRSO>
	        <COND (<FLAMING? ,PRSI>
		       <TELL "A água apaga " T-O ,PRSI "." CR>
		       %<COND (<==? ,ZORK-NUMBER 2>
			       '<COND (<EQUAL? ,PRSI ,BINF-FLAG>
				       <SETG BINF-FLAG <>>)>)
			      (ELSE '<NULL-F>)>
		       <FCLEAR ,PRSI ,ONBIT>
		       <FCLEAR ,PRSI ,FLAMEBIT>)
	              (T
		       <TELL
"A água escorre " T-PELO ,PRSI ", cai no chão e evapora." CR>)>)
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,PRSO ,PUTTY>
			 <PERFORM ,V?PUT ,PUTTY ,PRSI>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Você não pode derramar isso." CR>)>>

<ROUTINE V-PRAY ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,SOUTH-TEMPLE>
		         <GOTO ,FOREST-1>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL
"Se você rezar bastante, suas preces podem ser atendidas." CR>)>>

<ROUTINE V-PUMP ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<AND ,PRSI <NOT <EQUAL? ,PRSI ,PUMP>>>
		         <TELL "Encher isso com " T-UM ,PRSI "?" CR>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<IN? ,PUMP ,WINNER>
		         <PERFORM ,V?INFLATE ,PRSO ,PUMP>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Não está nada claro como." CR>)>>

<ROUTINE V-PUSH () <HACK-HACK "Empurrar ">>

<ROUTINE V-PUSH-TO ()
	 <TELL "Você não pode empurrar coisas até isso." CR>>

<ROUTINE PRE-PUT ()
	 ;"PT: no é IN e ON. Jogue a faca no troll é jogar nele, não colocar
	   a faca dentro dele."
	 <COND (<AND <VERB? PUT> <VERBO-DIGITADO? ,ACT?THROW>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?THROW ,PRSO ,PRSI>
		<RTRUE>)>
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,SHORT-POLE>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (T
		<PRE-GIVE>)>> ;"That's easy for you to say..."

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "Você não pode fazer isso." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL T-CO ,PRSI " não " T-ESTA ,PRSI " abert" T-G ,PRSI "." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "Como você pretende fazer isso?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL T-CO ,PRSO " já " T-ESTA ,PRSO " " T-NO ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "Não há espaço." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<TELL "Você não tem " T-O ,PRSO "." CR>
		<RTRUE>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<TELL "Você colocou " T-O ,PRSO " " T-NO ,PRSI "." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "Esse esconderijo é óbvio demais." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "Não há uma superfície adequada " T-NO ,PRSI "." CR>)>>

<ROUTINE V-PUT-UNDER ()
	 <TELL "Você não pode fazer isso." CR>>

<ROUTINE V-RAISE ()
	 <V-LOWER>>

<ROUTINE V-RAPE ()
	 <TELL "Que ideia (aham!) estranha." CR>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "É impossível ler no escuro." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "E como alguém olha através de " T-UM ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "E como alguém lê " T-UM ,PRSO "?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-READ-PAGE ()
	 <PERFORM ,V?READ ,PRSO>
	 <RTRUE>>

<ROUTINE V-REPENT ()
	 <TELL "Pode muito bem ser tarde demais!" CR>>

<ROUTINE V-REPLY ()
	 <TELL "Duvido que isso interesse " T-AO ,PRSO "." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RING ()
	 <TELL "Como, exatamente, você pretende tocar isso?" CR>>

<ROUTINE V-RUB () <HACK-HACK "Ficar apalpando ">>

<ROUTINE V-SAY ("AUX" V)
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<OR ,SPELL-USED ,WAND-ON>
		         <PERFORM ,V?INCANT>
		         <RTRUE>)>)
		(<==? ,ZORK-NUMBER 3>
		 '<COND (<AND <FSET? ,FRONT-DOOR ,TOUCHBIT>
		              <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?FROTZ>
		              <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?OZMOO>>
		         <SETG P-CONT <>>
		         <COND (<EQUAL? ,HERE ,MSTAIRS>
		                <CRLF>
		                <GOTO ,FRONT-DOOR>)
		               (T
		                <TELL "Nada acontece." CR>)>
		                <RTRUE>)>)
		(T
		 '<COND (<NOT ,P-CONT>
			 <TELL "Dizer o quê?" CR>
			 <RTRUE>)>)>
	 <SETG QUOTE-FLAG <>>
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "Você precisa falar diretamente com " T-O .V "." CR>
		<SETG P-CONT <>>)
	       (<NOT <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>>
	        <SETG P-CONT <>>
		<TELL
"Falar sozinho é sinal de colapso mental iminente." CR>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <TELL "Você não encontra nada de incomum." CR>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Por que você mandaria chamar " T-O ,PRSO "?" CR>)
	       (T
		<TELL "Isso é totalmente inenviável." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "Ora bolas!" CR>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Isso não parece ter efeito nenhum." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "Se não dá para pegar, não dá para chacoalhar!" CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <SHAKE-LOOP>
			      <TELL "O conteúdo " T-DO ,PRSO " se derrama ">
	                      <COND (%<COND (<==? ,ZORK-NUMBER 3>
					     '<FSET? ,HERE ,NONLANDBIT>)
					    (ELSE
					     '<NOT <FSET? ,HERE ,RLANDBIT>>)>
		                     <TELL "e desaparece">)
	                            (T
		                     <TELL "no chão">)>
	                      <TELL "." CR>)
			     (T
			      <TELL "Você sacudiu " T-O ,PRSO "." CR>)>)
		      (T
		       <COND (<FIRST? ,PRSO>
			      <TELL
"Parece que há alguma coisa dentro " T-DO ,PRSO "." CR>)
			     (T
			      <TELL "Pelo som, " T-O ,PRSO " " T-ESTA ,PRSO " vazi" T-G ,PRSO "." CR>)>)>)
	       (T
		<TELL "Você sacudiu " T-O ,PRSO "." CR>)>>

<ROUTINE SHAKE-LOOP ("AUX" X)
	 <REPEAT ()
		 <COND (<SET X <FIRST? ,PRSO>>
			<FSET .X ,TOUCHBIT>
			<MOVE .X
			      %<COND (<==? ,ZORK-NUMBER 1>
				      '<COND (<EQUAL? ,HERE ,UP-A-TREE>
				              ,PATH)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>)
				     (<==? ,ZORK-NUMBER 2>
				      '<COND (<EQUAL? .X ,WATER>
				              ,PSEUDO-OBJECT)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>)
				     (T
				      '<COND (<EQUAL? ,HERE ,ON-LAKE>
					      ,IN-LAKE)
					     (T
					      ,HERE)>)>>)
		       (T
			<RETURN>)>>>

<ROUTINE V-SKIP ()
	 <TELL <PICK-ONE ,WHEEEEE> CR>>

<GLOBAL WHEEEEE
	<LTABLE 0 "Muito bem. Agora você pode ir para a segunda série."
	       "Está se divertindo?"
	       "Uhuuuuuuuuu!!!!!"
	       "Quer que eu aplauda?">>

<ROUTINE V-SMELL ()
	 <TELL "Tem cheiro de " D ,PRSO "." CR>>

<ROUTINE V-SPIN ()
	 <TELL "Você não pode girar isso!" CR>>

<ROUTINE V-SPRAY ()
	 <V-SQUEEZE>>

<ROUTINE V-SQUEEZE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Isso não faz sentido para " T-O ,PRSO ".">)
	       (T
		<TELL "Que coisa singularmente inútil.">)>
	 <CRLF>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-STAB ("AUX" W)
	 <COND (<SET W <FIND-WEAPON ,WINNER>>
		<PERFORM ,V?ATTACK ,PRSO .W>
		<RTRUE>)
	       (T
		<TELL
"Por acaso você pretende esfaquear " T-O ,PRSO " com o dedo mindinho?" CR>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "Você já está de pé, eu acho." CR>)>>

<ROUTINE V-STAY ()
	 <TELL "Você vai se perder sem mim!" CR>>

<ROUTINE V-STRIKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"Como você não é versado em combate corpo a corpo, é melhor atacar "
T-O ,PRSO " com uma arma." CR>)
	       (T
		<PERFORM ,V?LAMP-ON ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND %<COND (<OR <==? ,ZORK-NUMBER 1>
			   <==? ,ZORK-NUMBER 2>>
		       '(<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		         <TELL "Normalmente não é permitido nadar ">
		         <COND (<NOT <EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>>
	                        <TELL T-NO ,PRSO ".">)
		               (T
		                <TELL "na masmorra.">)>
		         <CRLF>))
		      (T
		       '(<EQUAL? ,HERE ,ON-LAKE ,IN-LAKE>
		         <TELL "O que você pensa que está fazendo?" CR>))>
	       %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,HERE ,FLATHEAD-OCEAN>
		         <TELL
"Entre as pedras e as ondas, você não duraria um minuto!" CR>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (T
		<TELL "Vá tomar banho!" CR>)>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Vupt!" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "Você já está usando " T-O ,PRSO "." CR>)
		      (T
		       <TELL "Você já está com isso!" CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL
"Você não alcança algo que está dentro de um recipiente fechado." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSI ,GROUND>
		       <SETG PRSI <>>
		       <RFALSE>)>
		%<COND (<==? ,ZORK-NUMBER 2>
			'<COND (<EQUAL? ,PRSO ,DOOR-KEEPER>
				<SETG PRSI <>>
				<RFALSE>)>)
		       (ELSE
			'<NULL-F>)>
		<COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL T-CO ,PRSO " não " T-ESTA ,PRSO " " T-NO ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "Você está dentro d" T-ELE ,PRSO "!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "Agora você está usando " T-O ,PRSO "." CR>)
		      (T
		       <TELL "Você pegou " T-O ,PRSO "." CR>)>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL T-CO ,PRSO " ">
		       <PRINT-PLURAL ,PRSO "fica" "ficam">
		       <TELL
" em silêncio por um instante, talvez achando que você devia
reler o manual." CR>)>)
	       (T
		<TELL "Você não pode falar com " T-O ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)
	#DECL ((OBJ) <OR OBJECT FALSE> (M) <PRIMTYPE VECTOR>)
	<COND (<AND <FSET? ,PRSO ,DOORBIT>
		    <SET M <OTHER-SIDE ,PRSO>>>
	       <DO-WALK .M>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <FSET? ,PRSO ,VEHBIT>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<OR .OBJ <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       %<COND (<==? ,ZORK-NUMBER 2>
		       '<COND (<AND ,SCOL-ROOM
				   <OR .OBJ <EQUAL? ,PRSO ,CURTAIN>>>
			      <SCOL-GO .OBJ>
			      <RTRUE>)
			     (<AND <EQUAL? ,HERE ,DEPOSITORY>
				   <EQUAL? ,PRSO ,SNWL>
				   ,SCOL-ROOM>
			      <SCOL-GO .OBJ>
			      <RTRUE>)
			     (<AND <EQUAL? ,HERE ,SCOL-ACTIVE>
				   <EQUAL? ,PRSO 
					   <GET <SET M <GET-WALL ,HERE>> 1>>>
			      <SETG SCOL-ROOM <GET .M 2>>
			      <SETG PRSO <GETP ,PRSO ,P?SIZE>>
			      <COND (.OBJ <SCOL-OBJ .OBJ 0 ,DEPOSITORY>)
				    (T
				     <SCOL-THROUGH 0 ,DEPOSITORY>)>
			      <RTRUE>)
			     (<EQUAL? ,PRSO ,CURTAIN>
			      <TELL
"Você não consegue atravessar a cortina além da metade." CR>
			      <RTRUE>)>)
		      (ELSE '<NULL-F>)>
	       <TELL
"Você bate com a cabeça contra " T-O ,PRSO " ao tentar essa proeza." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "Isso exigiria um belo contorcionismo!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<EQUAL? ,PRSI ,ME>
		       <TELL
"Que arremesso fantástico! " T-CO ,PRSO>
		       <SETG WINNER ,PLAYER>
		       <JIGS-UP " acerta você em cheio na cabeça. Normalmente,
isso não causaria grande estrago, mas, por um incrível azar, você cai
para trás tentando se esquivar e quebra o pescoço, pois a justiça é rápida e
misericordiosa no Grande Império Subterrâneo.">)
		      (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		       <TELL
T-CO ,PRSI " se abaixa, e " T-O ,PRSO " passa voando e se espatifa no chão."
CR>)
		      (T <TELL "Você jogou " T-O ,PRSO "." CR>)>)
	       (ELSE <TELL "Hein?" CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "Você não pode jogar nada de cima disso!" CR>>

<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,WINNER>
		<TELL "Você não pode amarrar nada em si mesmo." CR>)
	       (T
		<TELL "Você não pode amarrar " T-O ,PRSO " nisso." CR>)>>

<ROUTINE V-TIE-UP ()
	 <TELL "Com isso você jamais conseguiria amarrá-l" T-G ,PRSO "!" CR>>

<ROUTINE V-TREASURE ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,NORTH-TEMPLE>
		         <GOTO ,TREASURE-ROOM>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,TREASURE-ROOM>
		         <GOTO ,NORTH-TEMPLE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Nada acontece." CR>)>>

<ROUTINE PRE-TURN ()
	 %<COND (<==? ,ZORK-NUMBER 3>
		 '<COND (<AND <EQUAL? ,PRSI <> ,ROOMS>
			      <EQUAL? ,PRSO ,DIAL ,TM-DIAL ,T-BAR>>
			 <TELL
"Você deveria girar " T-O ,PRSO " para alguma posição." CR>
			 <RTRUE>)>)
		(ELSE T)>
	 <COND (%<COND (<==? ,ZORK-NUMBER 1>
			'<AND <EQUAL? ,PRSI <> ,ROOMS>
			      <NOT <EQUAL? ,PRSO ,BOOK>>>)
		       (ELSE
			'<EQUAL? ,PRSI <> ,ROOMS>)>
		<TELL "Parece que só as mãos não bastam." CR>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "Você não pode girar isso!" CR>)>>

<ROUTINE V-TURN ()
	 <TELL "Isso não tem efeito nenhum." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <TELL "Isso não pode ser amarrado, então também não pode ser desamarrado!" CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "O tempo passa..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GET .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<AND <EQUAL? ,HERE ,CP> ,CP-MOVED>
		                       <RTRUE>))
				    (T
				     '(<NULL-F> <RFALSE>))>
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GET .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "Você não pode ir por aí." CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GET .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GET .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL T-CO .OBJ " " T-ESTA .OBJ " fechad" T-G .OBJ "." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT>
		     <PROB 80>
		     <EQUAL? ,WINNER ,ADVENTURER>
		     <NOT <FSET? ,HERE ,NONLANDBIT>>>
		<COND (,SPRAYED?
		       <TELL
"Há ruídos estranhos na escuridão, e não há saída nessa
direção." CR>
		       <RFATAL>)
		      %<COND (<==? ,ZORK-NUMBER 3>
			      '(<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		                <JIGS-UP
"Ah, não! Você entrou num covil de grues famintos, e é hora do jantar!">))
			     (T
			      '(<NULL-F>
				<RFALSE>))>
		      (T
		       <JIGS-UP
"Ah, não! Você caminhou direto para as presas salivantes de um grue à espreita!">)>)
	       (T
		<TELL "Você não pode ir por aí." CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Use os pontos cardeais para se mover." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL T-CELE ,PRSO " " T-ESTA ,PRSO " aqui!" CR>)
	       (T
		<TELL "Você precisa indicar uma direção!" CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Acenar com ">>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "Você não pode vestir " T-O ,PRSO "." CR>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-WIN ()
	 <TELL "Naturalmente!" CR>>

<ROUTINE V-WIND ()
	 <TELL "Você não pode dar corda em " T-UM ,PRSO "." CR>>

<ROUTINE V-WISH ()
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<PERFORM ,V?MAKE ,WISH>)
		(T
		 '<TELL "Com sorte, seu desejo vai se realizar." CR>)>>

<ROUTINE V-YELL () <TELL "Aaaarrrrgggghhhh!" CR>>

<ROUTINE V-ZORK () <TELL "Às suas ordens!" CR>>

^L

"Rotinas associadas aos verbos"

"Descrições"

<GLOBAL LIT <>>

<GLOBAL SPRAYED? <>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "Está um breu total.">
		<COND (<NOT ,SPRAYED?>
		       <TELL " É provável que você seja devorado por um grue.">)>
		<CRLF>
		%<COND (<==? ,ZORK-NUMBER 3>
			'<COND (<EQUAL? ,HERE ,DARK-2>
		                <TELL
"O chão continua subindo, afastando-se do lago. Você mal consegue
perceber uma luz fraca vindo do leste." CR>)>)
		       (T
			'<NULL-F>)>
		<RFALSE>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<FSET? ,HERE ,MAZEBIT>
		         <FCLEAR ,HERE ,TOUCHBIT>)>)
		(T
		 '<NULL-F>)>
	 <COND (<IN? ,HERE ,ROOMS>
		;"Was <TELL D ,HERE CR>"
		<TELL D ,HERE>
		<COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
		       <TELL ", " T-NO .AV>)>
		<CRLF>)>
	 <COND (%<COND (<==? ,ZORK-NUMBER 2>
			'<OR .LOOK? <NOT ,SUPER-BRIEF> <EQUAL? ,HERE ,ZORK3>>)
		       (ELSE
			'<OR .LOOK? <NOT ,SUPER-BRIEF>>)>
		<SET AV <LOC ,WINNER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TELL "Só morcegos enxergam no escuro. E você não é um deles." CR>)>>

"DESCRIBE-OBJECT -- recebe o objeto e um sinalizador. Se o sinalizador for
verdadeiro, escreve a descrição longa (fdesc ou ldesc); senão, a curta."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "Há " T-UM .OBJ " aqui">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (aces" T-G .OBJ ")">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL T-CUM .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (aces" T-G .OBJ ")">)
		      (<AND <FSET? .OBJ ,WEARBIT>
			    <IN? .OBJ ,WINNER>>
		       <TELL " (vestid" T-G .OBJ ")">)>)>
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<AND <EQUAL? .OBJ ,SPELL-VICTIM>
		              <EQUAL? ,SPELL-USED ,W?FLOAT>>
		         <TELL " (flutuando no ar)">)>)
		(T
		 '<NULL-F>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (fora " T-DO .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <COND (<NOT .N> <TELL " e ">)
				     (T <TELL ", ">)>)>
			<TELL T-UM .F>
			<COND (<AND <NOT .IT?> <NOT .TWO?>>
			       <SET IT? .F>)
			      (ELSE
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? SHIT AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <SET SHIT T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND %<COND (<==? ,ZORK-NUMBER 2>
				      '(<NOT .Y>
					<COND (<AND <0? .LEVEL>
						    <==? ,SPELL? ,S-FANTASIZE>
						    <PROB 20>>
					       <TELL "Há "
						     <PICK-ONE ,FANTASIES>
						     " aqui." CR>
					       <SET 1ST? <>>)>
					<RETURN>))
				     (ELSE
				      '(<NOT .Y>
					<RETURN>))>
			      (<EQUAL? .Y .AV> <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      <SET SHIT <>>
				      ;<SET 1ST? <>>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <COND (<PRINT-CONT .Y .V? 0>
					     <SET 1ST? <>>)>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <COND (<L? .LEVEL 0> <SET LEVEL 0>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .Y .V? .LEVEL>
			       <SET LEVEL <- .LEVEL 1>> ;"not in Zork III")>)>
		 <SET Y <NEXT? .Y>>>
	 <COND (<AND .1ST? .SHIT> <RFALSE>) (T <RTRUE>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? .OBJ ,TROPHY-CASE>
		         <TELL
"Sua coleção de tesouros consiste em:" CR>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<EQUAL? .OBJ ,WINNER>
		<TELL "Você está carregando:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Em cima " T-DO .OBJ " há: " CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL T-CO .OBJ " " T-ESTA .OBJ " segurando: " CR>)
		      (T
		       <TELL "Dentro " T-DO .OBJ " há:" CR>)>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

"Pontuação"

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL BASE-SCORE 0>

<GLOBAL WON-FLAG <>>

<ROUTINE SCORE-UPD (NUM)
	 <SETG BASE-SCORE <+ ,BASE-SCORE .NUM>>
	 <SETG SCORE <+ ,SCORE .NUM>>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<AND <EQUAL? ,SCORE 350>
		              <NOT ,WON-FLAG>>
		         <SETG WON-FLAG T>
		         <FCLEAR ,MAP ,INVISIBLE>
		         <FCLEAR ,WEST-OF-HOUSE ,TOUCHBIT>
		         <TELL
"Uma voz quase inaudível sussurra em seu ouvido: \"Procure em seus tesouros
o segredo final.\"" CR>)>)
		(T
		 '<NULL-F>)>
	 T>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
	 <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		<SCORE-UPD .TEMP>
		<PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ-INPUT>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y ,W?S> ;"PT: sim (vira yes) ou s"
		<RTRUE>)
	       (T
		<RFALSE>)>>

"Morte"

<GLOBAL DEAD <>>

<GLOBAL DEATHS 0>

<GLOBAL LUCKY 1>

;"JIGS-UP is in ACTIONS.ZIL"

;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

;"KILL-INTERRUPTS is in ACTIONS.ZIL"

"Manipulação de objetos"

<GLOBAL FUMBLE-NUMBER 7>

<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(,DEAD
		         <COND (.VB
				<TELL
"Sua mão atravessa o objeto." CR>)>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       %<COND (<==? ,ZORK-NUMBER 2>
		       '(<AND <EQUAL? ,PRSO ,SPELL-VICTIM>
		              <EQUAL? ,SPELL-USED ,W?FLOAT ,W?FREEZE>>
		         <COND (<EQUAL? ,SPELL-USED ,W?FLOAT>
		                <TELL
"Você não alcança. " T-CELE ,PRSO " " T-ESTA ,PRSO " flutuando acima da sua cabeça." CR>)
		               (T
		                <TELL "Parece que " T-ELE ,PRSO " " T-ESTA ,PRSO " pregad" T-G ,PRSO " no lugar." CR>)>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		;"Kludge for parser calling itake"
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Sua carga está pesada demais">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL", ainda mais no seu estado.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <VERB? TAKE>
		     <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL
"Você já está segurando coisas demais!" CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FCLEAR ,PRSO ,NDESCBIT>
		<FSET ,PRSO ,TOUCHBIT>
		%<COND (<==? ,ZORK-NUMBER 2>
			'<COND (<EQUAL? ,SPELL? ,S-FILCH>
		                <COND (<RIPOFF ,PRSO ,WIZARD-CASE>
			               <TELL
"Assim que você toca " T-O ,PRSO ", " T-ELE ,PRSO " desaparece!" CR>
			               <RFALSE>)>)>)
		       (T
			'<NULL-F>)>
		%<COND (<OR <==? ,ZORK-NUMBER 1>
			    <==? ,ZORK-NUMBER 2>>
			'<SCORE-OBJ ,PRSO>)
		       (T
			'<NULL-F>)>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "Você não está carregando " T-O ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL T-CO ,PRSO " " T-ESTA ,PRSO " fechad" T-G ,PRSO "." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

"Diversos"

;"V5: salas e objetos ocupam uma palavra nas saídas, então os tamanhos e
  deslocamentos mudam. REXIT, DEXITOBJ, CEXITSTR e DEXITSTR são índices de
  palavra (GET); CEXITFLAG é índice de byte (GETB)."
<CONSTANT REXIT 0>
<CONSTANT UEXIT 2>
<CONSTANT NEXIT 3>
<CONSTANT FEXIT 4>
<CONSTANT CEXIT 5>
<CONSTANT DEXIT 6>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 4>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 2>

<GLOBAL INDENTS
	<TABLE (PURE)
	       ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

<ROUTINE HACK-HACK (STR)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS>
		     <VERB? WAVE RAISE LOWER>>
		<TELL T-CO ,PRSO " não " T-ESTA ,PRSO " aqui!" CR>)
	       (T
		<TELL .STR T-O ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 0
	 " não parece adiantar."
	 " não ajuda muito."
	 " não tem efeito nenhum.">>

<ROUTINE NO-GO-TELL (AV WLOC)
	 <COND (.AV
		<TELL "Você não pode ir até lá de " D .WLOC ".">)
	       (T
		<TELL "Você não pode ir até lá sem um veículo.">)>
	 <CRLF>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT OHERE)
	 <SET OLIT ,LIT>
	 <SET OHERE ,HERE>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<AND <NOT .LB>
		     <NOT .AV>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <NOT .LB>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <FSET? ,HERE ,RLANDBIT>
		     .LB
		     .AV
		     <NOT <EQUAL? .AV ,RLANDBIT>>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT>
		<TELL <GETP .RM ,P?LDESC> CR>
		<RFALSE>)
	       (T
		<COND (<AND .LB
			    <NOT <FSET? ,HERE ,RLANDBIT>>
			    <NOT ,DEAD>
			    <FSET? .WLOC ,VEHBIT>>
		       %<COND (<==? ,ZORK-NUMBER 1>
			       '<TELL
T-CO .WLOC " encosta na margem." CR CR>)
			      (<==? ,ZORK-NUMBER 2>
			       '<COND (<EQUAL? .WLOC ,BALLOON>
				       <TELL
"O balão pousa." CR>)
				      (<FSET? .WLOC ,VEHBIT>
				       <TELL
T-CO .WLOC " finalmente para." CR CR>)>)
			      (<==? ,ZORK-NUMBER 3>
			       '<COND (<FSET? .WLOC ,VEHBIT>
				       <TELL
T-CO .WLOC " finalmente para." CR CR>)>)>)>
		<COND (.AV
		       <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 80>>
		       <COND (,SPRAYED?
			      <TELL
"Há ruídos sinistros de gorgolejo na escuridão ao seu redor!" CR>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		                       <JIGS-UP
"Ah, não! Dezenas de grues à espreita atacam e devoram você! Você deve
ter tropeçado num autêntico covil de grues!">))
				    (T
				     '(<NULL-F>
				       <RFALSE>))>
			     (T
			      <TELL
"Ah, não! Um grue à espreita deslizou para dentro ">
			      <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
				     <TELL T-DO <LOC ,WINNER>>)
				    (T <TELL "da sala">)>
			      <JIGS-UP " e devorou você!">
			      <RTRUE>)>)>
		<COND (<AND <NOT ,LIT>
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <TELL "Você entrou num lugar escuro." CR>
		       <SETG P-CONT <>>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<SCORE-OBJ .RM>
		<COND (<NOT <EQUAL? ,HERE .RM>> <RTRUE>)
		      (<AND <NOT <EQUAL? ,ADVENTURER ,WINNER>>
			    <IN? ,ADVENTURER .OHERE>>
		       <TELL T-CO ,WINNER " sai da sala." CR>)
		      %<COND (<==? ,ZORK-NUMBER 1>
			      '(<AND <EQUAL? ,HERE .OHERE>
				      ;"no double description"
				     <EQUAL? ,HERE ,ENTRANCE-TO-HADES>>
				<RTRUE>))
			     (ELSE
			      '(<NULL-F> <RTRUE>))>
		      (<AND .V?
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)
	 <COND (<SET TX <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQ .OBJ1 .TX <- </ <PTSIZE .TX> 2> 1>>)>> ;"V5: objetos são palavras"

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .W .WHAT>
			     <NOT <EQUAL? .W ,ADVENTURER>>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

<ROUTINE HELD? (CAN)
	 <REPEAT ()
		 <SET CAN <LOC .CAN>>
		 <COND (<NOT .CAN> <RFALSE>)
		       (<EQUAL? .CAN ,WINNER> <RTRUE>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX) ;"finds room beyond given door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET TX <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TX> ,DEXIT>
				    <EQUAL? <GET .TX ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE MUNG-ROOM (RM STR)
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<EQUAL? .RM ,INSIDE-BARROW>
			 <RFALSE>)>)
		(ELSE T)>
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>>

<COND (<N==? ,ZORK-NUMBER 3>
       <GLOBAL SWIMYUKS
	       <LTABLE 0 "Você não pode nadar na masmorra.">>)>

<GLOBAL HELLOS
	<LTABLE 0 "Olá."
	       "Bom dia."
	       "Que tempo bom tem feito ultimamente, não?"
	       "Tchau.">>

<GLOBAL YUKS
	<LTABLE
	 0
	 "Uma tentativa corajosa."
	 "Você não pode estar falando sério."
	 ;"Not bloody likely."
	 "Uma ideia interessante..."
	 "Que conceito!">>

<GLOBAL DUMMY
	<LTABLE 0 
		"Olhe em volta."
	        "Tarde demais para isso."
	        "Vá ao oculista.">>