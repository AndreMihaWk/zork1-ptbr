"1ACTIONS for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc. All Rights Reserved."

"SUBTITLE THE WHITE HOUSE"

<ROUTINE WEST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Você está em um campo aberto a oeste de uma casa branca, com a porta da
frente tapada com tábuas.">
		<COND (,WON-FLAG
		       <TELL
" Uma trilha secreta leva para sudoeste, floresta adentro.">)>
		<CRLF>)>>

<ROUTINE EAST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Você está atrás da casa branca. Uma trilha leva para a floresta, a
leste. Em um canto da casa há uma pequena janela, que está ">
		<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		       <TELL "aberta.">)
		      (T <TELL "entreaberta.">)>
		<CRLF>)>>

<ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)
	 <COND (<VERB? OPEN>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY>>)
		      (T
		       <TELL .STROPN>
		       <FSET .OBJ ,OPENBIT>)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL .STRCLS>
		       <FCLEAR .OBJ ,OPENBIT>
		       T)
		      (T <TELL <PICK-ONE ,DUMMY>>)>
		<CRLF>)>>

<ROUTINE BOARD-F ()
	 <COND (<VERB? TAKE EXAMINE>
		<TELL "As tábuas estão bem pregadas." CR>)>>

<ROUTINE TEETH-F ()
	 <COND (<AND <VERB? BRUSH>
		     <EQUAL? ,PRSO ,TEETH>>
		<COND (<AND <EQUAL? ,PRSI ,PUTTY>
			    <IN? ,PRSI ,WINNER>>
		       <JIGS-UP
"Bem, parece que você escovou os dentes com algum tipo de cola. Por
causa disso, sua boca fica grudada (junto com o nariz) e você morre de
insuficiência respiratória.">)
		      (<NOT ,PRSI>
		       <TELL
"A higiene bucal é altamente recomendável, mas não sei com o que você
quer escová-los." CR>)
		      (T
		       <TELL "Boa ideia, mas com " T-UM ,PRSI "?" CR>)>)>>

<ROUTINE GRANITE-WALL-F ()
	 <COND (<EQUAL? ,HERE ,NORTH-TEMPLE>
		<COND (<VERB? FIND>
		       <TELL "Aqui, a parede oeste é de granito maciço." CR>)
		      (<VERB? TAKE RAISE LOWER>
		       <TELL "É granito maciço." CR>)>)
	       (<EQUAL? ,HERE ,TREASURE-ROOM>
		<COND (<VERB? FIND>
		       <TELL "Aqui, a parede leste é de granito maciço." CR>)
		      (<VERB? TAKE RAISE LOWER>
		       <TELL "É granito maciço." CR>)>)
	       (<EQUAL? ,HERE ,SLIDE-ROOM>
		<COND (<VERB? FIND READ>
		       <TELL "Só está ESCRITO \"Parede de Granito\"." CR>)
		      (T <TELL "A parede não é de granito." CR>)>)
	       (T
		<TELL "Não há nenhuma parede de granito aqui." CR>)>>

<ROUTINE SONGBIRD-F ()
	 <COND (<VERB? FIND TAKE>
		<TELL "O pássaro canoro não está aqui, mas deve estar por perto." CR>)
	       (<VERB? LISTEN>
		<TELL "Você não consegue ouvir o pássaro canoro agora." CR>)
	       (<VERB? FOLLOW>
		<TELL "Não dá para segui-lo." CR>)
	       (T
		<TELL "Você não vê nenhum pássaro canoro aqui." CR>)>>

<ROUTINE WHITE-HOUSE-F ()
    <COND (<EQUAL? ,HERE ,KITCHEN ,LIVING-ROOM ,ATTIC>
	   <COND (<VERB? FIND>
		  <TELL "Por que você não procura o seu juízo?" CR>)
		 (<VERB? WALK-AROUND>
		  <GO-NEXT ,IN-HOUSE-AROUND>
		  T)>)
	  (<NOT <OR <EQUAL? ,HERE ,EAST-OF-HOUSE ,WEST-OF-HOUSE>
		    <EQUAL? ,HERE ,NORTH-OF-HOUSE ,SOUTH-OF-HOUSE>>>
	   <COND (<VERB? FIND>
		  <COND (<EQUAL? ,HERE ,CLEARING>
			 <TELL "Parece que fica a oeste." CR>)
			(T
			 <TELL "Estava aqui agora há pouco...." CR>)>)
		 (T <TELL "Você não está perto da casa." CR>)>)
	  (<VERB? FIND>
	   <TELL
"Está bem aqui! Você é cego ou o quê?" CR>)
	  (<VERB? WALK-AROUND>
	   <GO-NEXT ,HOUSE-AROUND>
	   T)
	  (<VERB? EXAMINE>
	   <TELL
"É uma bela casa colonial, pintada de branco. Os donos com certeza eram
riquíssimos." CR>)
	  (<VERB? THROUGH OPEN>
	   <COND (<EQUAL? ,HERE ,EAST-OF-HOUSE>
		  <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
			 <GOTO ,KITCHEN>)
			(T
			 <TELL "A janela está fechada." CR>
			 <THIS-IS-IT ,KITCHEN-WINDOW>)>)
		 (T
		  <TELL "Não vejo como entrar por aqui." CR>)>)
	  (<VERB? BURN>
	   <TELL "Você só pode estar brincando." CR>)>>

;"0 -> no next, 1 -> success, 2 -> failed move"

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<COND (<NOT <GOTO .VAL>> 2)
		      (T 1)>)>>

<ROUTINE FOREST-F ()
	 <COND (<VERB? WALK-AROUND>
		<COND (<OR <EQUAL? ,HERE
			       ,WEST-OF-HOUSE ,NORTH-OF-HOUSE
			       ,SOUTH-OF-HOUSE>
			   <EQUAL? ,HERE ,EAST-OF-HOUSE>>
		       <TELL "Você nem está na floresta." CR>)>
		<GO-NEXT ,FOREST-AROUND>)
	       (<VERB? DISEMBARK>
		<TELL "Você vai ter que dizer uma direção." CR>)
	       (<VERB? FIND>
		<TELL "As árvores não deixam você ver a floresta." CR>)
	       (<VERB? LISTEN>
		<TELL "Os pinheiros e os abetos parecem murmurar."
		      CR>)>>

<ROUTINE MOUNTAIN-RANGE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "Não acredita em mim? As montanhas são intransponíveis!"
		      CR>)>>

<ROUTINE WATER-F ("AUX" AV W PI?)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH BOARD>
		<TELL <PICK-ONE ,SWIMYUKS> CR>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<OR <EQUAL? ,PRSO ,GLOBAL-WATER>
		    <EQUAL? ,PRSO ,WATER>>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (ELSE
		<SET W ,PRSI>
		<COND (.W <SET PI? T>)>)>
	 <COND (<EQUAL? .W ,GLOBAL-WATER>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE-CAREFULLY .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<NOT <FSET? .AV ,VEHBIT>> <SET AV <>>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND .AV
			    <OR <EQUAL? .AV ,PRSI>
				<AND <NOT ,PRSI>
				     <NOT <IN? .W .AV>>>>>
		       <TELL "Agora há uma poça no fundo "
			     T-DO .AV "." CR>
		       <REMOVE-CAREFULLY ,PRSO>
		       <MOVE ,PRSO .AV>)
		      (<AND ,PRSI <NOT <EQUAL? ,PRSI ,BOTTLE>>>
		       <TELL "A água vaza " T-DO ,PRSI
			     " e evapora na hora." CR>
		       <REMOVE-CAREFULLY .W>)
		      (<IN? ,BOTTLE ,WINNER>
		       <COND (<NOT <FSET? ,BOTTLE ,OPENBIT>>
			      <TELL "A garrafa está fechada." CR>
			      <THIS-IS-IT ,BOTTLE>)
			     (<NOT <FIRST? ,BOTTLE>>
			      <MOVE ,WATER ,BOTTLE>
			      <TELL "Agora a garrafa está cheia de água." CR>)
			     (T
			      <TELL "A água escorre entre os seus dedos." CR>
			      <RTRUE>)>)
		      (<AND <IN? ,PRSO ,BOTTLE>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <TELL
"Ela está na garrafa. Talvez seja melhor pegar a garrafa." CR>)
		      (T
		       <TELL "A água escorre entre os seus dedos." CR>)>)
	       (.PI?
		<COND (<AND <VERB? PUT>
			    <GLOBAL-IN? ,RIVER ,HERE>>
		       <PERFORM ,V?PUT ,PRSO ,RIVER>)
		      (ELSE
		       <TELL "Boa tentativa." CR>)>
		<RTRUE>)
	       (<VERB? DROP GIVE>
		<COND (<AND <VERB? DROP>
			    <IN? ,WATER ,BOTTLE>
			    <NOT <FSET? ,BOTTLE ,OPENBIT>>>
		       <TELL "A garrafa está fechada." CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,WATER>
		<COND (.AV
		       <TELL "Agora há uma poça no fundo "
			     T-DO .AV "." CR>
		       <MOVE ,WATER .AV>)
		      (T
		       <TELL
"A água se derrama no chão e evapora na hora." CR>
		       <REMOVE-CAREFULLY ,WATER>)>)
	       (<VERB? THROW>
		<TELL
"A água espirra nas paredes e evapora na hora." CR>
		<REMOVE-CAREFULLY ,WATER>)>>

<GLOBAL KITCHEN-WINDOW-FLAG <>>

<ROUTINE KITCHEN-WINDOW-F ()
	 <COND (<VERB? OPEN CLOSE>
		<SETG KITCHEN-WINDOW-FLAG T>
		<OPEN-CLOSE ,KITCHEN-WINDOW
"Com grande esforço, você abre a janela o suficiente para passar."
"A janela se fecha (com mais facilidade do que abriu).">)
	       (<AND <VERB? EXAMINE>
		     <NOT ,KITCHEN-WINDOW-FLAG>>
		<TELL
"A janela está entreaberta, mas não o suficiente para passar." CR>)
	       (<VERB? WALK BOARD THROUGH>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <DO-WALK ,P?EAST>)
		      (T
		       <DO-WALK ,P?WEST>)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Você vê ">
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <TELL "uma área aberta que leva a uma floresta." CR>)
		      (T
		       <TELL "o que parece ser uma cozinha." CR>)>)>>

<ROUTINE GHOSTS-F ()
	 <COND (<VERB? TELL>
		<TELL "The spirits jeer loudly and ignore you." CR>
		<SETG P-CONT <>>)
	       (<VERB? EXORCISE>
		<TELL "Only the ceremony itself has any effect." CR>)
	       (<AND <VERB? ATTACK MUNG> <EQUAL? ,PRSO ,GHOSTS>>
		<TELL "How can you attack a spirit with material objects?" CR>)
	       (T
		<TELL "You seem unable to interact with these spirits." CR>)>>

<GLOBAL CAGE-TOP T>

<ROUTINE BASKET-F ()
	 <COND (<VERB? RAISE>
		<COND (,CAGE-TOP
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (T
		       <MOVE ,RAISED-BASKET ,SHAFT-ROOM>
		       <MOVE ,LOWERED-BASKET ,LOWER-SHAFT>
		       <SETG CAGE-TOP T>
		       <THIS-IS-IT ,RAISED-BASKET>
		       <TELL
"The basket is raised to the top of the shaft." CR>)>)
	       (<VERB? LOWER>
		<COND (<NOT ,CAGE-TOP>
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (T
		       <MOVE ,RAISED-BASKET ,LOWER-SHAFT>
		       <MOVE ,LOWERED-BASKET ,SHAFT-ROOM>
		       <THIS-IS-IT ,LOWERED-BASKET>
		       <TELL
"The basket is lowered to the bottom of the shaft." CR>
		       <SETG CAGE-TOP <>>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "It is now pitch black." CR>)>
		       T)>)
	       (<OR <EQUAL? ,PRSO ,LOWERED-BASKET>
		    <EQUAL? ,PRSI ,LOWERED-BASKET>>
		<TELL "The basket is at the other end of the chain." CR>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,RAISED-BASKET ,LOWERED-BASKET>>
		<TELL "The cage is securely fastened to the iron chain." CR>)>>

<ROUTINE BAT-F ()
	 <COND (<VERB? TELL>
		<FWEEP 6>
		<SETG P-CONT <>>)
	       (<VERB? TAKE ATTACK MUNG>
		<COND (<EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>
		       <TELL "You can't reach him; he's on the ceiling." CR>)
		      (T <FLY-ME>)>)>>

<ROUTINE FLY-ME ()
	 <FWEEP 4>
	 <TELL
"The bat grabs you by the scruff of your neck and lifts you away...." CR CR>
	 <GOTO <PICK-ONE ,BAT-DROPS> <>>
	 <COND (<NOT <EQUAL? ,HERE ,ENTRANCE-TO-HADES>>
		<V-FIRST-LOOK>)>
	 T>

<ROUTINE FWEEP (N)
	 <REPEAT ()
		 <COND (<L? <SET N <- .N 1>> 1> <RETURN>)
		       (T <TELL "    Fweep!" CR>)>>
	 <CRLF>>

<GLOBAL BAT-DROPS
      <LTABLE 0
	      MINE-1
	      MINE-2
	      MINE-3
	      MINE-4
	      LADDER-TOP
	      LADDER-BOTTOM
	      SQUEEKY-ROOM
	      MINE-ENTRANCE>>

<ROUTINE BELL-F ()
	 <COND (<VERB? RING>
		<COND (<AND <EQUAL? ,HERE ,LLD-ROOM>
			    <NOT ,LLD-FLAG>>
		       <RFALSE>)
		      (T
		       <TELL "Ding, dong." CR>)>)>>

<ROUTINE HOT-BELL-F ()
	 <COND (<VERB? TAKE>
		<TELL "The bell is very hot and cannot be taken." CR>)
	       (<OR <VERB? RUB> <AND <VERB? RING> ,PRSI>>
		<COND (<FSET? ,PRSI ,BURNBIT>
		       <TELL "The " D ,PRSI " burns and is consumed." CR>
		       <REMOVE-CAREFULLY ,PRSI>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "The bell is too hot to touch." CR>)
		      (T
		       <TELL "The heat from the bell is too intense." CR>)>)
	       (<VERB? POUR-ON>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "The water cools the bell and is evaporated." CR>
		<QUEUE I-XBH 0>
		<I-XBH>)
	       (<VERB? RING>
		<TELL "The bell is too hot to reach." CR>)>>

<ROUTINE BOARDED-WINDOW-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "As janelas estão tapadas com tábuas e não podem ser abertas." CR>)
	       (<VERB? MUNG>
		<TELL "Você não consegue arrombar as janelas." CR>)>>

<ROUTINE NAILS-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"Os pregos, cravados fundo na porta, não podem ser arrancados." CR>)>>

<ROUTINE CRACK-FCN ()
	 <COND (<VERB? THROUGH>
		<TELL "Você não cabe na fenda." CR>)>>

<ROUTINE KITCHEN-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Você está na cozinha da casa branca. Uma mesa parece ter sido usada há
pouco tempo para preparar comida. Uma passagem leva para oeste, e uma
escada escura sobe. Uma chaminé escura desce, e a leste há uma pequena
janela, que está ">
	       <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		      <TELL "aberta." CR>)
		     (T
		      <TELL "entreaberta." CR>)>)
	      (<==? .RARG ,M-BEG>
	       <COND (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <DO-WALK ,P?UP>)
		     (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <TELL "Não há escada que desça daqui." CR>)>)>>

<ROUTINE STONE-BARROW-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <OR <VERB? ENTER>
			 <AND <VERB? WALK>
			      <EQUAL? ,PRSO ,P?WEST ,P?IN>>
			 <AND <VERB? THROUGH>
			      <EQUAL? ,PRSO ,BARROW>>>>
		<TELL
"Inside the Barrow|
As you enter the barrow, the door closes inexorably behind you. Around
you it is dark, but ahead is an enormous cavern, brightly lit. Through
its center runs a wide stream. Spanning the stream is a small wooden
footbridge, and beyond a path leads into a dark tunnel. Above the
bridge, floating in the air, is a large sign. It reads:  All ye who
stand before this bridge have completed a great and perilous adventure
which has tested your wit and courage. You have mastered">
		<COND (<EQUAL? <BAND <GETB 0 1> 8> 0>
		       <TELL "
the first part of the ZORK trilogy. Those who pass over this bridge must be
prepared to undertake an even greater adventure that will severely test your
skill and bravery!|
|
The ZORK trilogy continues with \"ZORK II: The Wizard of Frobozz\" and
is completed in \"ZORK III: The Dungeon Master.\"" CR>)
		      (T
		       <TELL "
ZORK: The Great Underground Empire.|" CR>)>
		<FINISH>)>>

<ROUTINE BARROW-DOOR-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "The door is too heavy." CR>)>>

<ROUTINE BARROW-FCN ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?WEST>)>>

\

<ROUTINE TROPHY-CASE-FCN ()
    <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,TROPHY-CASE>>
	   <TELL
"A vitrine de troféus está bem presa à parede." CR>)>>
	
<GLOBAL RUG-MOVED <>>

<ROUTINE LIVING-ROOM-FCN (RARG "AUX" RUG? TC)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"Você está na sala de estar. Há uma passagem para leste">
	       <COND (,MAGIC-FLAG
		      <TELL
". A oeste,
uma velha porta de madeira tem uma abertura com o formato de um ciclope e,
acima dela, umas estranhas letras góticas. Há também ">)
		     (T
		      <TELL
", uma porta
de madeira a oeste com estranhas letras góticas, que parece estar
pregada, ">)>
	       <TELL "uma vitrine de troféus ">
	       <SET RUG? ,RUG-MOVED>
	       <COND (<AND .RUG? <FSET? ,TRAP-DOOR ,OPENBIT>>
		      <TELL
		       "e um tapete largado ao lado de um alçapão aberto.">)
		     (.RUG?
		      <TELL "e um alçapão fechado aos seus pés.">)
		     (<FSET? ,TRAP-DOOR ,OPENBIT>
		      <TELL "e um alçapão aberto aos seus pés.">)
		     (T
		      <TELL
		       "e um grande tapete oriental no centro da sala.">)>
	       <CRLF>
	       T)
	      (<EQUAL? .RARG ,M-END>
	       <COND (<OR <VERB? TAKE>
			  <AND <VERB? PUT>
			       <EQUAL? ,PRSI ,TROPHY-CASE>>>
		      <COND (<IN? ,PRSO ,TROPHY-CASE>
			     <TOUCH-ALL ,PRSO>)>
		      <SETG SCORE <+ ,BASE-SCORE <OTVAL-FROB>>>
		      <SCORE-UPD 0>
		      <RFALSE>)>)>>

<ROUTINE TOUCH-ALL (OBJ "AUX" F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<FSET .F ,TOUCHBIT>
			<COND (<FIRST? .F> <TOUCH-ALL .F>)>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE OTVAL-FROB ("OPTIONAL" (O ,TROPHY-CASE) "AUX" F (SCORE 0))
	 <SET F <FIRST? .O>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .SCORE>)>
		 <SET SCORE <+ .SCORE <GETP .F ,P?TVALUE>>>
		 <COND (<FIRST? .F> <OTVAL-FROB .F>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE TRAP-DOOR-FCN ()
    <COND (<VERB? RAISE>
	   <PERFORM ,V?OPEN ,TRAP-DOOR>
	   <RTRUE>)
	  (<AND <VERB? OPEN CLOSE>
		<EQUAL? ,HERE ,LIVING-ROOM>>
	   <OPEN-CLOSE ,PRSO
"O alçapão se abre a contragosto e revela uma escada bamba que desce para
a escuridão."
"O alçapão se fecha com um baque.">)
	  (<AND <VERB? LOOK-UNDER> <EQUAL? ,HERE LIVING-ROOM>>
	   <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		  <TELL
"Você vê uma escada bamba que desce para a escuridão." CR>)
		 (T <TELL "Está fechado." CR>)>)
	  (<EQUAL? ,HERE ,CELLAR>
	   <COND (<AND <VERB? OPEN UNLOCK>
		       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <TELL
"O alçapão está trancado por cima." CR>)
		 (<AND <VERB? CLOSE> <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		  <FCLEAR ,TRAP-DOOR ,OPENBIT>
		  <TELL "O alçapão se fecha e se tranca." CR>)
		 (<VERB? OPEN CLOSE>
		  <TELL <PICK-ONE ,DUMMY> CR>)>)>>

<ROUTINE CELLAR-FCN (RARG)
  <COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL
"Você está num porão escuro e úmido, com uma passagem estreita que leva
para o norte e, ao sul, um túnel baixo por onde só se passa rastejando. A
oeste fica o pé de uma rampa de metal íngreme, impossível de escalar." CR>)
	(<EQUAL? .RARG ,M-ENTER>
	 <COND (<AND <FSET? ,TRAP-DOOR ,OPENBIT>
		     <NOT <FSET? ,TRAP-DOOR ,TOUCHBIT>>>
		<FCLEAR ,TRAP-DOOR ,OPENBIT>
		<FSET ,TRAP-DOOR ,TOUCHBIT>
		<TELL
"O alçapão se fecha com estrondo, e você ouve alguém passar a tranca." CR CR>)>)>>

<ROUTINE CHIMNEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "A chaminé leva para ">
		<COND (<==? ,HERE ,KITCHEN>
		       <TELL "baixo">)
		      (T <TELL "cima">)>
		<TELL " e parece dar para escalá-la." CR>)>>

<ROUTINE UP-CHIMNEY-FUNCTION ("AUX" F)
  <COND (<NOT <SET F <FIRST? ,WINNER>>>
	 <TELL "Subir de mãos vazias é uma má ideia." CR>
	 <RFALSE>)
	(<AND <OR <NOT <SET F <NEXT? .F>>>
		  <NOT <NEXT? .F>>>
	      <IN? ,LAMP ,WINNER>>
	 <COND (<NOT <FSET? ,TRAP-DOOR ,OPENBIT>>
		<FCLEAR ,TRAP-DOOR ,TOUCHBIT>)>
	 <RETURN ,KITCHEN>)
	(T
	 <TELL "Você não consegue subir por ali com o que está carregando." CR>
	 <RFALSE>)>>

<ROUTINE TRAP-DOOR-EXIT ()
	 <COND (,RUG-MOVED
		<COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		       <RETURN ,CELLAR>)
		      (T
		       <TELL "O alçapão está fechado." CR>
		       <THIS-IS-IT ,TRAP-DOOR>
		       <RFALSE>)>)
	       (T
		<TELL "Você não pode ir por aí." CR>
		<RFALSE>)>>

<ROUTINE RUG-FCN ()
   <COND (<VERB? RAISE>
	  <TELL "O tapete é pesado demais para levantar">
	  <COND (,RUG-MOVED
		 <TELL "." CR>)
		(T
		 <TELL
", mas, ao tentar, você
notou uma irregularidade embaixo dele." CR>)>)
	 (<VERB? MOVE PUSH>
	  <COND (,RUG-MOVED
		 <TELL
"Como você já moveu o tapete antes, não consegue movê-lo de novo." CR>)
		(T
		 <TELL
"Com grande esforço, você arrasta o tapete para um canto da sala e revela
a tampa empoeirada de um alçapão fechado." CR>
		 <FCLEAR ,TRAP-DOOR ,INVISIBLE>
		 <THIS-IS-IT ,TRAP-DOOR>
		 <SETG RUG-MOVED T>)>)
	 (<VERB? TAKE>
	  <TELL
"O tapete é pesadíssimo e não dá para carregá-lo." CR>)
	 (<AND <VERB? LOOK-UNDER>
	       <NOT ,RUG-MOVED>
	       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
	  <TELL
"Embaixo do tapete há um alçapão fechado. Quando você solta a ponta do
tapete, o alçapão volta a ficar escondido." CR>)
	 (<VERB? CLIMB-ON>
	  <COND (<AND <NOT ,RUG-MOVED>
		      <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		 <TELL
"Ao se sentar, você nota uma irregularidade embaixo dele. Para não ficar
desconfortável, você se levanta de novo." CR>)
		(ELSE
		 <TELL "Por acaso você acha que é um tapete voador?" CR>)>)>>

\

"SUBTITLE TROLL"

<ROUTINE AXE-F ()
	 <COND (,TROLL-FLAG <>)
	       (T <WEAPON-FUNCTION ,AXE ,TROLL>)>>

<ROUTINE STILETTO-FUNCTION ()
	 <WEAPON-FUNCTION ,STILETTO ,THIEF>>

<ROUTINE WEAPON-FUNCTION (W V)
	<COND (<NOT <IN? .V ,HERE>> <RFALSE>)
	      (<VERB? TAKE>
	       <COND (<IN? .W .V>
		      <TELL
T-CO .V " afasta " T-O .W " do seu alcance com um gesto rápido." CR>)
		     (T
		      <TELL T-CO .W " ">
		      <PRINT-PLURAL .W "parece" "parecem">
		      <TELL
" estar em brasa. Você não consegue segurá-l" T-G .W "." CR>)>
	       T)>>

<ROUTINE TROLL-FCN ("OPTIONAL" (MODE <>))
	 <COND (<VERB? TELL>
		<SETG P-CONT <>>
		<TELL "O troll não é de muita conversa." CR>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,AXE ,TROLL> <>)
		      (<AND <IN? ,AXE ,HERE> <PROB 75 90>>
		       <FSET ,AXE ,NDESCBIT>
		       <FCLEAR ,AXE ,WEAPONBIT>
		       <MOVE ,AXE ,TROLL>
		       <PUTP ,TROLL ,P?LDESC
"Um troll de aspecto ameaçador, brandindo um machado ensanguentado,
bloqueia todas as saídas da sala.">
		       <AND <IN? ,TROLL ,HERE>
			    <TELL
"O troll, furioso e humilhado, recupera a arma. Pelo jeito, ele quer
acertar as contas com você, a machadadas." CR>>
		      T)
		     (<IN? ,TROLL ,HERE>
		      <PUTP ,TROLL ,P?LDESC
"Um troll está aqui, balbuciando de dar pena.">
		      <TELL
"O troll, desarmado, se encolhe de pavor e implora pela vida na língua
gutural dos trolls." CR>
		      T)>)
	      (<EQUAL? .MODE ,F-DEAD>
	       <COND (<IN? ,AXE ,TROLL>
		      <MOVE ,AXE ,HERE>
		      <FCLEAR ,AXE ,NDESCBIT>
		      <FSET ,AXE ,WEAPONBIT>)>
	       <SETG TROLL-FLAG T>)
	      (<EQUAL? .MODE ,F-UNCONSCIOUS>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <COND (<IN? ,AXE ,TROLL>
		      <MOVE ,AXE ,HERE>
		      <FCLEAR ,AXE ,NDESCBIT>
		      <FSET ,AXE ,WEAPONBIT>)>
	       <PUTP ,TROLL ,P?LDESC
"Um troll inconsciente está esparramado no chão. Todas as saídas da sala
estão livres.">
	       <SETG TROLL-FLAG T>)
	      (<EQUAL? .MODE ,F-CONSCIOUS>
	       <COND (<IN? ,TROLL ,HERE>
		      <FSET ,TROLL ,FIGHTBIT>
		      <TELL
"O troll se mexe e logo volta à posição de combate." CR>)>
	       <COND (<IN? ,AXE ,TROLL>
		      <PUTP ,TROLL ,P?LDESC
"Um troll de aspecto ameaçador, brandindo um machado ensanguentado,
bloqueia todas as saídas da sala.">)
		     (<IN? ,AXE ,TROLL-ROOM>
		      <FSET ,AXE ,NDESCBIT>
		      <FCLEAR ,AXE ,WEAPONBIT>
		      <MOVE ,AXE ,TROLL>
		      <PUTP ,TROLL ,P?LDESC
"Um troll de aspecto ameaçador, brandindo um machado ensanguentado,
bloqueia todas as saídas da sala.">)
		     (T
		      <PUTP ,TROLL ,P?LDESC
"Há um troll aqui.">)>
	       <SETG TROLL-FLAG <>>)
	      (<EQUAL? .MODE ,F-FIRST?>
	       <COND (<PROB 33>
		      <FSET ,TROLL ,FIGHTBIT>
		      <SETG P-CONT <>>
		      T)>)
	      (<NOT .MODE>
	       <COND (<VERB? EXAMINE>
		      <TELL <GETP ,TROLL ,P?LDESC> CR>)
		     (<OR <AND <VERB? THROW GIVE>
			       ,PRSO
			       <EQUAL? ,PRSI ,TROLL>>
			  <VERB? TAKE MOVE MUNG>>
		      <AWAKEN ,TROLL>
		      <COND (<VERB? THROW GIVE>
			     <COND (<AND <EQUAL? ,PRSO ,AXE>
					 <IN? ,AXE ,WINNER>>
				    <TELL
"O troll coça a cabeça, confuso, e depois pega o machado." CR>
				    <FSET ,TROLL ,FIGHTBIT>
				    <MOVE ,AXE ,TROLL>
				    <RTRUE>)
				   (<EQUAL? ,PRSO ,TROLL ,AXE>
				    <TELL
"Primeiro você teria que pegar " T-O ,PRSO ", e isso parece improvável." CR>
				    <RTRUE>)>
			     <COND (<VERB? THROW>
				    <TELL
"O troll, que tem uma coordenação admirável, apanha " T-O ,PRSO " no ar">)
				   (T
				    <TELL
"O troll, que não é nada orgulhoso, aceita " T-O ,PRSO " de bom grado">)>
			     <COND (<AND <PROB 20>
					 <EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>>
				    <REMOVE-CAREFULLY ,PRSO>
				    <TELL
" e " T-G ,PRSO " devora, faminto. Pobre troll: ele morre de hemorragia
interna, e a carcaça dele desaparece numa sinistra névoa negra." CR>
				    <REMOVE-CAREFULLY ,TROLL>
				    <APPLY <GETP ,TROLL ,P?ACTION> ,F-DEAD>
				    <SETG TROLL-FLAG T>)
				   (<EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>
				    <MOVE ,PRSO ,HERE>
				    <TELL
" e, saciado por enquanto, " T-G ,PRSO " atira de volta. Por sorte, o
troll tem péssima pontaria, e " T-O ,PRSO " cai no chão. Ele não parece
nada satisfeito." CR>
				    <FSET ,TROLL ,FIGHTBIT>)
				   (T
				    <TELL
" e, como não tem um paladar muito exigente, " T-G ,PRSO " come todo
contente." CR>
				    <REMOVE-CAREFULLY ,PRSO>)>)
			    (<VERB? TAKE MOVE>
			     <TELL
"O troll cospe na sua cara e grunhe \"Mais sorte da próxima vez\" com um
sotaque um tanto bárbaro." CR>)
			    (<VERB? MUNG>
			     <TELL
"O troll ri do seu gestinho patético." CR>)>)
		     (<VERB? LISTEN>
		      <TELL
"De vez em quando o troll diz alguma coisa, provavelmente nada elogiosa, na
língua gutural dele." CR>)
		     (<AND ,TROLL-FLAG <VERB? HELLO>>
		      <TELL "Infelizmente, o troll não pode ouvir você." CR>)>)>>

\

"SUBTITLE GRATING/MAZE"

;<GLOBAL LEAVES-GONE <>> ;"no longer used?"
<GLOBAL GRATE-REVEALED <>>
<GLOBAL GRUNLOCK <>>

<ROUTINE LEAVES-APPEAR ()
	<COND (<AND <NOT <FSET? ,GRATE ,OPENBIT>>
	            <NOT ,GRATE-REVEALED>>
	       <COND (<VERB? MOVE TAKE>
		      <TELL
"Ao mexer no monte de folhas, você descobre uma grade." CR>)
		     (T <TELL
"Com as folhas fora do lugar, aparece uma grade." CR>)>
	       <FCLEAR ,GRATE ,INVISIBLE>
	       <SETG GRATE-REVEALED T>)>
	<>>

<ROUTINE LEAF-PILE ()
	<COND (<VERB? COUNT>
	       <TELL "Há 69.105 folhas aqui." CR>)
	      (<VERB? BURN>
	       <LEAVES-APPEAR>
	       <REMOVE-CAREFULLY ,PRSO>
	       <COND (<IN? ,PRSO ,HERE>
		      <TELL
"As folhas queimam." CR>)
		     (T
		      <JIGS-UP
"As folhas queimam, e você também.">)>)
	      (<VERB? CUT>
	       <TELL "Você remexe as folhas e faz a maior bagunça." CR>
	       <LEAVES-APPEAR>
	       <RTRUE>)
	      (<VERB? MOVE TAKE>
	       <COND (<VERB? MOVE>
		      <TELL "Pronto." CR>)>
	       <COND (,GRATE-REVEALED <RFALSE>)>
	       <LEAVES-APPEAR>
	       <COND (<VERB? TAKE> <RFALSE>)
		     (T <RTRUE>)>)
	      (<AND <VERB? LOOK-UNDER>
		    <NOT ,GRATE-REVEALED>>
	       <TELL
"Embaixo do monte de folhas há uma grade. Quando você solta as folhas, a
grade volta a ficar escondida." CR>)>>
 
<ROUTINE CLEARING-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT ,GRATE-REVEALED>
		       <FSET ,GRATE ,INVISIBLE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Você está em uma clareira, cercado pela floresta por todos os lados.
Uma trilha leva para o sul.">
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <CRLF>
		       <TELL
"Há uma grade aberta, que desce para a escuridão.">)
		      (,GRATE-REVEALED
		       <CRLF>
		       <TELL
"Há uma grade firmemente presa ao chão.">)>
		<CRLF>)>>

<ROUTINE MAZE-11-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,GRATE ,INVISIBLE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a small room near the maze. There are twisty passages
in the immediate vicinity." CR>
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <TELL
 "Above you is an open grating with sunlight pouring in.">)
		      (,GRUNLOCK
		       <TELL "Above you is a grating.">)
		      (T
		       <TELL
 "Above you is a grating locked with a skull-and-crossbones lock.">)>
		<CRLF>)>>

<ROUTINE GRATE-FUNCTION ()
    	 <COND (<AND <VERB? OPEN> <EQUAL? ,PRSI ,KEYS>>
		<PERFORM ,V?UNLOCK ,GRATE ,KEYS>
		<RTRUE>)
	       (<VERB? LOCK>
		<COND (<EQUAL? ,HERE ,GRATING-ROOM>
		       <SETG GRUNLOCK <>>
		       <TELL "A grade está trancada." CR>)
	              (<EQUAL? ,HERE ,GRATING-CLEARING>
		       <TELL "Você não consegue trancá-la deste lado." CR>)>)
	       (<AND <VERB? UNLOCK> <EQUAL? ,PRSO ,GRATE>>
		<COND (<AND <EQUAL? ,HERE ,GRATING-ROOM> <EQUAL? ,PRSI ,KEYS>>
		       <SETG GRUNLOCK T>
		       <TELL "A grade está destrancada." CR>)
		      (<AND <EQUAL? ,HERE ,GRATING-CLEARING>
			    <EQUAL? ,PRSI ,KEYS>>
		       <TELL "Você não alcança a fechadura daqui." CR>)
		      (T
		       <TELL
"Dá para destrancar uma grade com " T-UM ,PRSI "?" CR>)>)
               (<VERB? PICK>
		<TELL "Você não consegue forçar a fechadura." CR>)
               (<VERB? OPEN CLOSE>
		<COND (,GRUNLOCK
		       <OPEN-CLOSE ,GRATE
				   <COND (<EQUAL? ,HERE ,CLEARING>
					  "A grade se abre.")
					 (T
"A grade se abre e revela árvores acima de você.")>
				   "A grade se fecha.">
		       <COND (<FSET? ,GRATE ,OPENBIT>
			      <COND (<AND <NOT <EQUAL? ,HERE ,CLEARING>>
					  <NOT ,GRATE-REVEALED>>
				     <TELL
"Um monte de folhas cai na sua cabeça e no chão." CR>
				     <SETG GRATE-REVEALED T>
				     <MOVE ,LEAVES ,HERE>)>
			      <FSET ,GRATING-ROOM ,ONBIT>)
			     (T <FCLEAR ,GRATING-ROOM ,ONBIT>)>)
		      (T <TELL "A grade está trancada." CR>)>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,GRATE>>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 20>
		       <TELL "Isso não passa pela grade." CR>)
		      (T
		       <MOVE ,PRSO ,GRATING-ROOM>
		       <TELL T-CO ,PRSO " ">
		       <PRINT-PLURAL ,PRSO "passa" "passam">
		       <TELL " pela grade rumo à escuridão lá embaixo." CR>)>)>>

<ROUTINE MAZE-DIODES ()
	 <TELL
"You won't be able to get back up to the tunnel you are going through
when it gets to the next room." CR CR>
	 <COND (<EQUAL? ,HERE ,MAZE-2> ,MAZE-4)
	       (<EQUAL? ,HERE ,MAZE-7> ,DEAD-END-1)
	       (<EQUAL? ,HERE ,MAZE-9> ,MAZE-11)
	       (<EQUAL? ,HERE ,MAZE-12> ,MAZE-5)>>

<ROUTINE RUSTY-KNIFE-FCN ()
	<COND (<VERB? TAKE>
	       <AND <IN? ,SWORD ,WINNER>
		    <TELL
"As you touch the rusty knife, your sword gives a single pulse of blinding
blue light." CR>>
	       <>)
	      (<OR <AND <EQUAL? ,PRSI ,RUSTY-KNIFE>
			<VERB? ATTACK>>
		   <AND <VERB? SWING>
			<EQUAL? ,PRSO ,RUSTY-KNIFE>
			,PRSI>>
	       <REMOVE-CAREFULLY ,RUSTY-KNIFE>
	       <JIGS-UP
"As the knife approaches its victim, your mind is submerged by an
overmastering will. Slowly, your hand turns, until the rusty blade
is an inch from your neck. The knife seems to sing as it savagely
slits your throat.">)>>

<ROUTINE KNIFE-F ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,ATTIC-TABLE ,NDESCBIT>
		<RFALSE>)>>

<ROUTINE SKELETON ()
	 <COND (<VERB? TAKE RUB MOVE PUSH RAISE LOWER ATTACK KICK KISS>
		<TELL
"A ghost appears in the room and is appalled at your desecration of
the remains of a fellow adventurer. He casts a curse on your valuables
and banishes them to the Land of the Living Dead. The ghost leaves,
muttering obscenities." CR>
	 	<ROB ,HERE ,LAND-OF-LIVING-DEAD 100>
	 	<ROB ,ADVENTURER ,LAND-OF-LIVING-DEAD>
	 	T)>>

\

<ROUTINE TORCH-OBJECT ()
    <COND (<VERB? EXAMINE>
	   <TELL "The torch is burning." CR>)
	  (<AND <VERB? POUR-ON>
		<EQUAL? ,PRSI ,TORCH>>
	   <TELL "The water evaporates before it gets close." CR>)
	  (<AND <VERB? LAMP-OFF> <FSET? ,PRSO ,ONBIT>>
	   <TELL
"You nearly burn your hand trying to extinguish the flame." CR>)>>

\

"SUBTITLE MIRROR, MIRROR, ON THE WALL"

<ROUTINE MIRROR-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
	        <TELL
"You are in a large square room with tall ceilings. On the south wall
is an enormous mirror which fills the entire wall. There are exits
on the other three sides of the room." CR>
		<COND (,MIRROR-MUNG
		       <TELL
"Unfortunately, the mirror has been destroyed by your recklessness." CR>)>)>>

<GLOBAL MIRROR-MUNG <>>
<GLOBAL LUCKY T>

<ROUTINE MIRROR-MIRROR ("AUX" (RM2 ,MIRROR-ROOM-2) L1 L2 N)
	<COND (<AND <NOT ,MIRROR-MUNG> <VERB? RUB>>
	       <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,HANDS>>>
		      <TELL
"You feel a faint tingling transmitted through the " D ,PRSI "." CR>
		      <RTRUE>)>
	       <COND (<EQUAL? ,HERE .RM2>
		      <SET RM2 ,MIRROR-ROOM-1>)>
	       <SET L1 <FIRST? ,HERE>>
	       <SET L2 <FIRST? .RM2>>
	       <REPEAT ()
		       <COND (<NOT .L1> <RETURN>)>
		       <SET N <NEXT? .L1>>
		       <MOVE .L1 .RM2>
		       <SET L1 .N>>
	       <REPEAT ()
		       <COND (<NOT .L2> <RETURN>)>
		       <SET N <NEXT? .L2>>
		       <MOVE .L2 ,HERE>
		       <SET L2 .N>>
	       <GOTO .RM2 <>>
	       <TELL
"There is a rumble from deep within the earth and the room shakes." CR>)
	      (<VERB? LOOK-INSIDE EXAMINE>
	       <COND (,MIRROR-MUNG
		      <TELL "The mirror is broken into many pieces.">)
		     (T
		      <TELL "There is an ugly person staring back at you.">)>
	       <CRLF>)
	      (<VERB? TAKE>
	       <TELL
"The mirror is many times your size. Give up." CR>)
	      (<VERB? MUNG THROW ATTACK>
	       <COND (,MIRROR-MUNG
		      <TELL
"Haven't you done enough damage already?" CR>)
		     (T
		      <SETG MIRROR-MUNG T>
		      <SETG LUCKY <>>
		      <TELL
"You have broken the mirror. I hope you have a seven years' supply of
good luck handy." CR>)>)>>

\

"SUBTITLE THE DOME"

<ROUTINE TORCH-ROOM-FCN (RARG)
 	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large room with a prominent doorway leading to a down
staircase. Above you is a large dome. Up around the edge of the
dome (20 feet up) is a wooden railing. In the center of the room
sits a white marble pedestal." CR>
		<COND (,DOME-FLAG
		       <TELL
"A piece of rope descends from the railing above, ending some
five feet above your head." CR>)>)>>

<ROUTINE DOME-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are at the periphery of a large dome, which forms the ceiling
of another room below. Protecting you from a precipitous drop is a
wooden railing which circles the dome." CR>
		<COND (,DOME-FLAG
		       <TELL
"Hanging down from the railing is a rope which ends about ten feet
from the floor below." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (,DEAD
		       <TELL
"As you enter the dome you feel a strong pull as if from a wind
drawing you over the railing and down." CR>
		       <MOVE ,WINNER ,TORCH-ROOM>
		       <SETG HERE ,TORCH-ROOM>
		       <RTRUE>)
		      (<VERB? LEAP>
		       <JIGS-UP
"I'm afraid that the leap you attempted has done you in.">)>)>>

;<GLOBAL EGYPT-FLAG <>>	;"no longer used?"

\

"SUBTITLE LAND OF THE DEAD"

<ROUTINE LLD-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are outside a large gateway, on which is inscribed||
  Abandon every hope
all ye who enter here!||
The gate is open; through it you can see a desolation, with a pile of
mangled bodies in one corner. Thousands of voices, lamenting some
hideous fate, can be heard." CR>
		<COND (<AND <NOT ,LLD-FLAG> <NOT ,DEAD>>
		       <TELL
"The way through the gate is barred by evil spirits, who jeer at your
attempts to pass." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? EXORCISE>
		       <COND (<NOT ,LLD-FLAG>
			      <COND (<AND <IN? ,BELL ,WINNER>
					  <IN? ,BOOK ,WINNER>
					  <IN? ,CANDLES ,WINNER>>
				     <TELL
"You must perform the ceremony." CR>)
				    (T
				     <TELL
"You aren't equipped for an exorcism." CR>)>)>)
		      (<AND <NOT ,LLD-FLAG>
			    <VERB? RING>
			    <EQUAL? ,PRSO ,BELL>>
		       <SETG XB T>
		       <REMOVE-CAREFULLY ,BELL>
		       <THIS-IS-IT ,HOT-BELL>
		       <MOVE ,HOT-BELL ,HERE>
		       <TELL
"The bell suddenly becomes red hot and falls to the ground. The
wraiths, as if paralyzed, stop their jeering and slowly turn to face
you. On their ashen faces, the expression of a long-forgotten terror
takes shape." CR>
		       <COND (<IN? ,CANDLES ,WINNER>
			      <TELL
"In your confusion, the candles drop to the ground (and they are out)." CR>
			      <MOVE ,CANDLES ,HERE>
			      <FCLEAR ,CANDLES ,ONBIT>
			      <DISABLE <INT I-CANDLES>>)>
		       <ENABLE <QUEUE I-XB 6>>
		       <ENABLE <QUEUE I-XBH 20>>)
		      (<AND ,XC
			    <VERB? READ>
			    <EQUAL? ,PRSO ,BOOK>
			    <NOT ,LLD-FLAG>>
		       <TELL
"Each word of the prayer reverberates through the hall in a deafening
confusion. As the last word fades, a voice, loud and commanding,
speaks: \"Begone, fiends!\" A heart-stopping scream fills the cavern,
and the spirits, sensing a greater power, flee through the walls." CR>
		       <REMOVE-CAREFULLY ,GHOSTS>
		       <SETG LLD-FLAG T>
		       <DISABLE <INT I-XC>>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND ,XB
			    <IN? ,CANDLES ,WINNER>
			    <FSET? ,CANDLES ,ONBIT>
			    <NOT ,XC>>
		       <SETG XC T>
		       <TELL
"The flames flicker wildly and appear to dance. The earth beneath
your feet trembles, and your legs nearly buckle beneath you.
The spirits cower at your unearthly power." CR>
		       <DISABLE <INT I-XB>>
		       <ENABLE <QUEUE I-XC 3>>)>)>>

<GLOBAL XB <>>

<GLOBAL XC <>>

<ROUTINE I-XB ()
	 <OR ,XC
	     <AND <EQUAL? ,HERE ,ENTRANCE-TO-HADES>
		  <TELL
"The tension of this ceremony is broken, and the wraiths, amused but
shaken at your clumsy attempt, resume their hideous jeering." CR>>>
	 <SETG XB <>>>

<ROUTINE I-XC ()
	 <SETG XC <>>
	 <I-XB>>

<ROUTINE I-XBH ()
	 <REMOVE-CAREFULLY ,HOT-BELL>
	 <MOVE ,BELL ,ENTRANCE-TO-HADES>
	 <COND (<EQUAL? ,HERE ,ENTRANCE-TO-HADES>
		<TELL "The bell appears to have cooled down." CR>)>>

\

"SUBTITLE FLOOD CONTROL DAM #3"

<GLOBAL GATE-FLAG <>>
<GLOBAL GATES-OPEN <>>

<ROUTINE DAM-ROOM-FCN (RARG)
   	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Você está no alto da Barragem de Controle de Enchentes #3, que foi uma
grande atração turística em tempos muito distantes. Há trilhas para o
norte, o sul e o oeste, e uma descida acidentada." CR>
		<COND (<AND ,LOW-TIDE ,GATES-OPEN>
		       <TELL
"O nível da água atrás da barragem está baixo: as comportas foram
abertas. A água jorra pela barragem e segue rio abaixo." CR>)
		      (,GATES-OPEN
		       <TELL
"As comportas estão abertas, e a água jorra pela barragem. O nível da
água atrás da barragem ainda está alto." CR>)
		      (,LOW-TIDE
		       <TELL
"As comportas estão fechadas. O nível da água na represa está bem baixo,
mas está subindo depressa." CR>)
		      (T
		       <TELL
"As comportas da barragem estão fechadas. Atrás da barragem, vê-se uma
represa larga. A água transborda por cima da barragem, hoje abandonada." CR>)>
		<TELL
"Há aqui um painel de controle, no qual está montado um grande parafuso de
metal. Logo acima do parafuso há uma pequena bolha verde de plástico">
		<COND (,GATE-FLAG
		       <TELL ", que
brilha serenamente">)>
		<TELL "." CR>)>>

<ROUTINE BOLT-F ()
	<COND (<VERB? TURN>
	       <COND (<EQUAL? ,PRSI ,WRENCH>
		      <COND (,GATE-FLAG
			     <FCLEAR ,RESERVOIR-SOUTH ,TOUCHBIT>
			     <COND (,GATES-OPEN
				    <SETG GATES-OPEN <>>
				    <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
				    <TELL
"As comportas se fecham, e a água começa a se acumular atrás da barragem." CR>
				    <ENABLE <QUEUE I-RFILL 8>>
				    <QUEUE I-REMPTY 0>
				    T)
				   (T
				    <SETG GATES-OPEN T>
				    <TELL
"As comportas se abrem, e a água jorra pela barragem." CR>
				    <ENABLE <QUEUE I-REMPTY 8>>
				    <QUEUE I-RFILL 0>
				    T)>)
			    (T <TELL
"Por mais que você se esforce, o parafuso não gira." CR>)>)
		     (ELSE
		      <TELL
"O parafuso não gira com " T-O ,PRSI "." CR>)>)
	      (<VERB? TAKE>
	       <INTEGRAL-PART>)
	      (<VERB? OIL>
	       <TELL
"Hum. Parece que o tubo continha cola, não óleo. Girar o parafuso não vai
ficar nem um pouco mais fácil...." CR>)>>

<ROUTINE BUBBLE-F ()
	 <COND (<VERB? TAKE>
		<INTEGRAL-PART>)>>

<ROUTINE INTEGRAL-PART ()
	 <TELL "Isso faz parte do painel de controle." CR>>

<ROUTINE I-RFILL ()
	 <FSET ,RESERVOIR ,NONLANDBIT>
	 <FCLEAR ,RESERVOIR ,RLANDBIT>
	 <FCLEAR ,DEEP-CANYON ,TOUCHBIT>
	 <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
	 <AND <IN? ,TRUNK ,RESERVOIR>
	      <FSET ,TRUNK ,INVISIBLE>>
	 <SETG LOW-TIDE <>>
	 <COND (<EQUAL? ,HERE ,RESERVOIR>
		<COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		       <TELL
"O barco se solta devagar da lama e agora está flutuando na
represa." CR>)
		      (T
		       <JIGS-UP
"Você é erguido pelas águas que sobem! Você tenta nadar, mas as correntes
são fortes demais. Você chega cada vez mais perto da imponente estrutura
da Barragem de Controle de Enchentes #3. A barragem chama por você. O
rugido da água quase o deixa surdo, mas você continua consciente enquanto
despenca por cima da barragem rumo à morte certa entre as pedras lá
embaixo.">)>)
	       (<EQUAL? ,HERE ,DEEP-CANYON>
		<TELL
"Um som, como o de água corrente, começa a vir lá de baixo." CR>)
	       (<EQUAL? ,HERE ,LOUD-ROOM>
		<TELL
"De repente, um rugido assustadoramente alto toma conta da sala. Morrendo
de medo, você foge às pressas." CR>
		<GOTO <PICK-ONE ,LOUD-RUNS>>)
	       (<EQUAL? ,HERE ,RESERVOIR-NORTH ,RESERVOIR-SOUTH>
		<TELL
"Você percebe que o nível da água subiu a ponto de ser impossível
atravessar." CR>)>
	 T>

<GLOBAL LOUD-RUNS <LTABLE 0 DAMP-CAVE ROUND-ROOM DEEP-CANYON>>

<ROUTINE I-REMPTY ()
	 <FSET ,RESERVOIR ,RLANDBIT>
	 <FCLEAR ,RESERVOIR ,NONLANDBIT>
	 <FCLEAR ,DEEP-CANYON ,TOUCHBIT>
	 <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
	 <FCLEAR ,TRUNK ,INVISIBLE>
	 <SETG LOW-TIDE T>
	 <COND (<AND <EQUAL? ,HERE ,RESERVOIR>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<TELL
"O nível da água baixou tanto que o barco não consegue mais flutuar. Ele
afunda na lama." CR>)
	       (<EQUAL? ,HERE ,DEEP-CANYON>
		<TELL
"O rugido da água corrente está mais fraco agora." CR>)
	       (<EQUAL? ,HERE ,RESERVOIR-NORTH ,RESERVOIR-SOUTH>
		<TELL
"Agora o nível da água aqui está bem baixo, e daria para atravessar
facilmente para o outro lado." CR>)>
	 T>

;"PT: completa \"Agora a água aqui está \" (I-MAINT-ROOM)"
<GLOBAL DROWNINGS
      <TABLE (PURE) "pelos tornozelos."
	"pelas canelas."
	"pelos joelhos."
	"pelos quadris."
	"pela cintura."
	"pelo peito."
	"pelo pescoço."
	"acima da sua cabeça."
	"bem dentro dos seus pulmões.">>

<GLOBAL WATER-LEVEL 0>
<GDECL (WATER-LEVEL) FIX>

<ROUTINE BUTTON-F ()
	 <COND (<VERB? READ>
		<TELL "Para você, é tudo grego." CR>)
	       (<VERB? PUSH>
		<COND (<EQUAL? ,PRSO ,BLUE-BUTTON>
		       <COND (<0? ,WATER-LEVEL>
			      <FCLEAR ,LEAK ,INVISIBLE>
			      <TELL
"Ouve-se um ronco, e um jato de água parece irromper da parede leste da
sala (pelo visto, surgiu um vazamento num cano)." CR>
			      <SETG WATER-LEVEL 1>
			      <ENABLE <QUEUE I-MAINT-ROOM -1>>
			      T)
			     (T
			      <TELL
			        "O botão azul parece estar emperrado." CR>)>)
		      (<EQUAL? ,PRSO ,RED-BUTTON>
		       <TELL "As luzes da sala ">
		       <COND (<FSET? ,HERE ,ONBIT>
			      <FCLEAR ,HERE ,ONBIT>
			      <TELL "se apagam." CR>)
			     (T
			      <FSET ,HERE ,ONBIT>
			      <TELL "se acendem." CR>)>)
		      (<EQUAL? ,PRSO ,BROWN-BUTTON>
		       <FCLEAR ,DAM-ROOM ,TOUCHBIT>
		       <SETG GATE-FLAG <>>
		       <TELL "Clique." CR>)
		      (<EQUAL? ,PRSO ,YELLOW-BUTTON>
		       <FCLEAR ,DAM-ROOM ,TOUCHBIT>
		       <SETG GATE-FLAG T>
		       <TELL "Clique." CR>)>)>>

<ROUTINE TOOL-CHEST-FCN ()
	 <COND (<VERB? EXAMINE>
		<TELL "As caixas estão todas vazias." CR>)
	       (<VERB? TAKE OPEN PUT>
		<REMOVE-CAREFULLY ,TOOL-CHEST>
<TELL
"As caixas estão tão enferrujadas e corroídas que se desfazem quando
você toca nelas." CR>)
	       (<VERB? OPEN>
		<TELL "As caixas já estão abertas." CR>)>>

<ROUTINE I-MAINT-ROOM ("AUX" HERE?)
	 <SET HERE? <EQUAL? ,HERE ,MAINTENANCE-ROOM>>
	 <COND (.HERE? <TELL "Agora a água aqui está "> <TELL <GET
		,DROWNINGS </ ,WATER-LEVEL 2>>> <CRLF>)>
	 <SETG WATER-LEVEL <+ 1 ,WATER-LEVEL>>
	 <COND (<NOT <L? ,WATER-LEVEL 14>>
		<MUNG-ROOM ,MAINTENANCE-ROOM
"A sala está cheia de água, e não dá para entrar.">
		<QUEUE I-MAINT-ROOM 0>
		<COND (.HERE?
		     <JIGS-UP
"Lamento, mas parece que você conseguiu se afogar.">)>)
	       (<AND <IN? ,WINNER ,INFLATED-BOAT>
		     <EQUAL? ,HERE ,MAINTENANCE-ROOM ,DAM-ROOM ,DAM-LOBBY>>
		<JIGS-UP
"A água que sobe leva o barco por cima da barragem, rio abaixo e cataratas
abaixo. Tsc, tsc.">)>
	 <RTRUE>>

<ROUTINE LEAK-FUNCTION ()
	<COND (<G? ,WATER-LEVEL 0>
	       <COND (<AND <VERB? PUT PUT-ON>
			   <EQUAL? ,PRSO ,PUTTY>>
		      <FIX-MAINT-LEAK>)
		     (<VERB? PLUG>
		      <COND (<EQUAL? ,PRSI ,PUTTY>
			     <FIX-MAINT-LEAK>)
			    (T <WITH-TELL ,PRSI>)>)>)>>

<ROUTINE FIX-MAINT-LEAK ()
	 <SETG WATER-LEVEL -1>
	 <QUEUE I-MAINT-ROOM 0>
	 <TELL
"Por algum milagre da tecnologia zorkiana, você conseguiu estancar o
vazamento da barragem." CR>>

<ROUTINE PUTTY-FCN ()
	 <COND (<OR <AND <VERB? OIL>
			 <EQUAL? ,PRSI ,PUTTY>>
		    <AND <VERB? PUT>
			 <EQUAL? ,PRSO ,PUTTY>>>
		<TELL "A gosma multiuso não é lubrificante." CR>)>>

<ROUTINE TUBE-FUNCTION ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TUBE>>
		<TELL "O tubo se recusa a aceitar qualquer coisa." CR>)
	       (<VERB? SQUEEZE>
		<COND (<AND <FSET? ,PRSO ,OPENBIT>
			    <IN? ,PUTTY ,PRSO>>
		       <MOVE ,PUTTY ,WINNER>
		       <TELL "O material viscoso escorre para a sua mão." CR>)
		      (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Pelo jeito, o tubo está vazio." CR>)
		      (T
		       <TELL "O tubo está fechado." CR>)>)>>

<ROUTINE DAM-FUNCTION ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "Parece razoável, mas não é assim que se faz." CR>)
	       (<VERB? PLUG>
		<COND (<EQUAL? ,PRSI ,HANDS>
		       <TELL
"Quem você pensa que é, o menino holandês que tapou o dique com o dedo?
Sinto muito, mas esta barragem é grande." CR>)
		      (T
		       <TELL
"Com " T-UM ,PRSI "? Você sabe o tamanho desta barragem? Com isso, você
só conseguiria tapar um vazamentozinho de nada." CR>)>)>>

<ROUTINE WITH-TELL (OBJ)
	 <TELL "Com " T-UM .OBJ "?" CR>>

<ROUTINE RESERVOIR-SOUTH-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <COND (<AND ,LOW-TIDE ,GATES-OPEN>
		      <TELL
"Você está numa sala comprida. Ao norte havia um lago, mas, com o nível
da água mais baixo, agora só resta um riacho largo correndo pelo meio da
sala.">)
		     (,GATES-OPEN
		      <TELL
"Você está numa sala comprida. Ao norte há um lago grande, fundo demais
para atravessar. Mas você percebe que o nível da água parece estar
baixando depressa. Logo, talvez dê para atravessar daqui para o outro
lado.">)
		     (,LOW-TIDE
		      <TELL
"Você está numa sala comprida. Ao norte há uma área larga que antes era
uma represa, mas agora não passa de um riacho. Só que você percebe que o
nível do riacho está subindo depressa e que logo vai ser impossível
atravessar por aqui.">)
		     (T
		      <TELL
"Você está numa sala comprida, na margem sul de um lago grande, fundo e
largo demais para atravessar.">)>
	       <CRLF>
	       <TELL
"Há uma trilha ao longo do riacho, para leste ou para oeste, um caminho
íngreme que sobe para sudoeste pela beira de um abismo e uma trilha que
leva a um cânion, a sudeste." CR>)>>

<ROUTINE RESERVOIR-FCN (RARG)
   	<COND (<AND <EQUAL? .RARG ,M-END>
		    <NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		    <NOT ,GATES-OPEN>
		    ,LOW-TIDE>
	       <TELL
"Você percebe que o nível da água aqui está subindo depressa. As
correntes também estão ficando mais fortes. Ficar aqui parece bem
perigoso!" CR>)
	      (<EQUAL? .RARG ,M-LOOK>
	       <COND (,LOW-TIDE
		      <TELL
"Você está no que antes era um lago grande, mas agora não passa de um
enorme lamaçal. Há \"margens\" ao norte e ao sul.">)
		     (T
		      <TELL
"Você está no lago. Dá para ver praias ao norte e ao sul. Mais acima, um
riachinho deságua no lago por uma fenda estreita entre as pedras. Mais
abaixo, dá para ver a barragem.">)>
	       <CRLF>)>>

<ROUTINE RESERVOIR-NORTH-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <COND (<AND ,LOW-TIDE ,GATES-OPEN>
		      <TELL
"Você está numa sala grande e cavernosa. Ao sul havia um lago, mas, com
o nível da água mais baixo, agora só resta um riacho largo correndo por
ali.">)
		     (,GATES-OPEN
		      <TELL
"Você está numa área grande e cavernosa. Ao sul há um lago largo, cujo
nível parece estar baixando depressa.">)
		     (,LOW-TIDE
		      <TELL
"Você está numa área cavernosa. Ao sul há um riacho muito largo. O nível
do riacho está subindo depressa, e parece que logo vai ser impossível
atravessar para o outro lado.">)
		     (T
		      <TELL
"Você está numa sala grande e cavernosa, ao norte de um lago grande.">)>
	       <CRLF>
	       <TELL
"Uma escada coberta de limo sai da sala para o norte." CR>)>>

\

"SUBTITLE WATER, WATER EVERYWHERE..."

<ROUTINE BOTTLE-FUNCTION ("AUX" (E? <>))
  <COND (<AND <VERB? THROW> <==? ,PRSO ,BOTTLE>>
	 <REMOVE-CAREFULLY ,PRSO>
	 <SET E? T>
	 <TELL "A garrafa bate na parede do outro lado e se espatifa." CR>)
	(<VERB? MUNG>
	 <SET E? T>
	 <REMOVE-CAREFULLY ,PRSO>
	 <TELL "Uma manobra brilhante destrói a garrafa." CR>)
	(<VERB? SHAKE>
	 <COND (<AND <FSET? ,PRSO ,OPENBIT> <IN? ,WATER ,PRSO>>
		<SET E? T>)>)>
  <COND (<AND .E? <IN? ,WATER ,PRSO>>
	 <TELL "A água se derrama no chão e evapora." CR>
	 <REMOVE-CAREFULLY ,WATER>
	 T)
	(.E? <RTRUE>)>>

\

"SUBTITLE CYCLOPS"

<GLOBAL CYCLOWRATH 0>

<ROUTINE CYCLOPS-FCN ("AUX" COUNT)
	<SET COUNT ,CYCLOWRATH>
	<COND (<EQUAL? ,WINNER ,CYCLOPS>
	       <COND (,CYCLOPS-FLAG
		      <TELL "No use talking to him. He's fast asleep." CR>)
		     (<VERB? ODYSSEUS>
		      <SETG WINNER ,ADVENTURER>
		      <PERFORM ,V?ODYSSEUS>
		      <RTRUE>)
		     (ELSE
		      <TELL
"The cyclops prefers eating to making conversation." CR>)>)
	      (,CYCLOPS-FLAG
	       <COND (<VERB? EXAMINE>
		      <TELL
"The cyclops is sleeping like a baby, albeit a very ugly one." CR>)
		     (<VERB? ALARM KICK ATTACK BURN MUNG>
		      <TELL
"The cyclops yawns and stares at the thing that woke him up." CR>
		      <SETG CYCLOPS-FLAG <>>
		      <FSET ,CYCLOPS ,FIGHTBIT>
		      <COND (<L? .COUNT 0>
			     <SETG CYCLOWRATH <- .COUNT>>)
			    (T
			     <SETG CYCLOWRATH .COUNT>)>)>)
	      (<VERB? EXAMINE>
	       <TELL
"A hungry cyclops is standing at the foot of the stairs." CR>)
	      (<AND <VERB? GIVE> <EQUAL? ,PRSI ,CYCLOPS>>
	       <COND (<EQUAL? ,PRSO ,LUNCH>
		      <COND (<NOT <L? .COUNT 0>>
			     <REMOVE-CAREFULLY ,LUNCH>
			     <TELL
"The cyclops says \"Mmm Mmm. I love hot peppers! But oh, could I use
a drink. Perhaps I could drink the blood of that thing.\"  From the
gleam in his eye, it could be surmised that you are \"that thing\"." CR>
			     <SETG CYCLOWRATH <MIN -1 <- .COUNT>>>)>
		      <ENABLE <QUEUE I-CYCLOPS -1>>)
		     (<OR <EQUAL? ,PRSO ,WATER>
			  <AND <EQUAL? ,PRSO ,BOTTLE>
			       <IN? ,WATER ,BOTTLE>>>
		      <COND (<L? .COUNT 0>
			     <REMOVE-CAREFULLY ,WATER>
			     <MOVE ,BOTTLE ,HERE>
			     <FSET ,BOTTLE ,OPENBIT>
			     <FCLEAR ,CYCLOPS ,FIGHTBIT>
			     <TELL
"The cyclops takes the bottle, checks that it's open, and drinks the water.
A moment later, he lets out a yawn that nearly blows you over, and then
falls fast asleep (what did you put in that drink, anyway?)." CR>
			     <SETG CYCLOPS-FLAG T>)
			    (T
			     <TELL
"The cyclops apparently is not thirsty and refuses your generous offer." CR>)>)
		     (<EQUAL? ,PRSO ,GARLIC>
		      <TELL
"The cyclops may be hungry, but there is a limit." CR>)
		     (T
		      <TELL
"The cyclops is not so stupid as to eat THAT!" CR>)>)
	      (<VERB? THROW ATTACK MUNG>
	       <ENABLE <QUEUE I-CYCLOPS -1>>
	       <COND (<VERB? MUNG>
		      <TELL
"\"Do you think I'm as stupid as my father was?\", he says, dodging." CR>)
		     (T
		      <TELL
"The cyclops shrugs but otherwise ignores your pitiful attempt." CR>
		      <COND (<VERB? THROW>
			     <MOVE ,PRSO ,HERE>)>
		      <RTRUE>)>)
	      (<VERB? TAKE>
	       <TELL
"The cyclops doesn't take kindly to being grabbed." CR>)
	      (<VERB? TIE>
	       <TELL
"You cannot tie the cyclops, though he is fit to be tied." CR>)
	      (<VERB? LISTEN>
	       <TELL
"You can hear his stomach rumbling." CR>)>>

<ROUTINE I-CYCLOPS ()
	 <COND (<OR ,CYCLOPS-FLAG ,DEAD> <RTRUE>)
	       (<NOT <EQUAL? ,HERE ,CYCLOPS-ROOM>>
		<DISABLE <INT I-CYCLOPS>>)
	       (T
		<COND (<G? <ABS ,CYCLOWRATH> 5>
		       <DISABLE <INT I-CYCLOPS>>
		       <JIGS-UP
"The cyclops, tired of all of your games and trickery, grabs you firmly.
As he licks his chops, he says \"Mmm. Just like Mom used to make 'em.\"
It's nice to be appreciated.">)
		      (T
		       <COND (<L? ,CYCLOWRATH 0>
			      <SETG CYCLOWRATH <- ,CYCLOWRATH 1>>)
			     (T
			      <SETG CYCLOWRATH <+ ,CYCLOWRATH 1>>)>
		       <COND (<NOT ,CYCLOPS-FLAG>
			      <TELL <NTH ,CYCLOMAD <- <ABS ,CYCLOWRATH> 1>>
				    CR>)>)>)>>

<ROUTINE CYCLOPS-ROOM-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"This room has an exit on the northwest, and a staircase leading up." CR>
	       <COND (<AND ,CYCLOPS-FLAG <NOT ,MAGIC-FLAG>>
		      <TELL
"The cyclops is sleeping blissfully at the foot of the stairs." CR>)
		     (,MAGIC-FLAG
		      <TELL
"The east wall, previously solid, now has a cyclops-sized opening in it." CR>)
		     (<0? ,CYCLOWRATH>
		      <TELL
"A cyclops, who looks prepared to eat horses (much less mere
adventurers), blocks the staircase. From his state of health, and
the bloodstains on the walls, you gather that he is not very
friendly, though he likes people." CR>)
		     (<G? ,CYCLOWRATH 0>
		      <TELL
"The cyclops is standing in the corner, eyeing you closely. I don't
think he likes you very much. He looks extremely hungry, even for a
cyclops." CR>)
		     (<L? ,CYCLOWRATH 0>
		      <TELL
"The cyclops, having eaten the hot peppers, appears to be gasping.
His enflamed tongue protrudes from his man-sized mouth." CR>)>)
	      (<EQUAL? .RARG ,M-ENTER>
	       <OR <0? ,CYCLOWRATH> <ENABLE <INT I-CYCLOPS>>>)>>

<GLOBAL CYCLOMAD
	<TABLE (PURE)
	  "The cyclops seems somewhat agitated."
	  "The cyclops appears to be getting more agitated."
	  "The cyclops is moving about the room, looking for something."
	  "The cyclops was looking for salt and pepper. No doubt they are
condiments for his upcoming snack."
	  "The cyclops is moving toward you in an unfriendly manner."
	  "You have two choices: 1. Leave  2. Become dinner.">>

\

"SUBTITLE LOUD LOUD LOUD"

<GLOBAL LOUD-FLAG <>>

<ROUTINE LOUD-ROOM-FCN (RARG "AUX" WRD)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Esta é uma sala grande, com um teto tão alto que não se consegue
enxergá-lo do chão. Há uma passagem estreita de leste a oeste e uma escada
de pedra que sobe.">
		<COND (<OR ,LOUD-FLAG
			   <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
		       <TELL " A sala é de um silêncio sinistro.">)
		      (T
		       <TELL " A sala é tomada por um barulho ensurdecedor,
um som de correnteza que não se sabe de onde vem. O som parece reverberar
em todas as paredes, e fica difícil até pensar.">)>
		<CRLF>)
	       (<AND <EQUAL? .RARG ,M-END> ,GATES-OPEN <NOT ,LOW-TIDE>>
		<TELL
"O barulho aqui é insuportável, um rugido de estourar os tímpanos que
parece vir de todos os lados. Sua cabeça lateja sem parar. Com um esforço
tremendo, você consegue sair da sala aos tropeços." CR CR>
		<GOTO <PICK-ONE ,LOUD-RUNS>>
		<RFALSE>)		
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<OR ,LOUD-FLAG
			   <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
		       <RFALSE>)
		      (<AND ,GATES-OPEN <NOT ,LOW-TIDE>>
		       <RFALSE>)
		      (T
		       <V-FIRST-LOOK>
		       <COND (,P-CONT
			      <TELL
"O resto dos seus comandos se perdeu no barulho." CR>
			      <SETG P-CONT <>>)>
		       <REPEAT ()
			       <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
			       <TELL ">">
			       <READ-INPUT>
			       <COND (<0? <GETB ,P-LEXV ,P-LEXWORDS>>
			              <TELL "Como é?" CR>
				      <AGAIN>)>
			       ;"PT: as palavras em português ao lado das
				 originais (eco, oeste, salve, diga...). Ir para o
				 oeste e suba já chegam aqui como uma palavra só
				 (ver AJUSTA-LEXV), assim como carregar e desistir."
			       <SET WRD <GET ,P-LEXV 1>>
			       <COND (<EQUAL? .WRD ,W?GO ,W?WALK ,W?RUN>
				      <SET WRD <GET ,P-LEXV 3>>)
				     (<EQUAL? .WRD ,W?SAY ,W?DIGA ,W?DIZER ,W?DIZ>
				      <SET WRD <GET ,P-LEXV 5>>)>
			       <COND (<EQUAL? .WRD ,W?SAVE ,W?SALVE ,W?SALVAR
					      ,W?GRAVE ,W?GRAVAR>
				      <V-SAVE>)
				     (<EQUAL? .WRD ,W?RESTORE>
				      <V-RESTORE>)
				     (<EQUAL? .WRD ,W?Q ,W?QUIT>
				      <V-QUIT>)
				     (<EQUAL? .WRD ,W?W ,W?WEST ,W?OESTE>
				      <RETURN <GOTO ,ROUND-ROOM>>)
				     (<EQUAL? .WRD ,W?E ,W?EAST ,W?L ,W?LESTE>
				      <RETURN <GOTO ,DAMP-CAVE>>)
				     (<EQUAL? .WRD ,W?U ,W?UP ,W?CIMA ,W?C ,W?ACIMA>
				      <RETURN <GOTO ,DEEP-CANYON>>)
				     (<EQUAL? .WRD ,W?BUG>
				      <TELL "Essa é só a sua opinião." CR>)
				     (<EQUAL? .WRD ,W?ECHO ,W?ECO>
				      <SETG LOUD-FLAG T>
				      <FCLEAR ,BAR ,SACREDBIT>
				      <TELL
"A acústica da sala muda sutilmente." CR>
				      <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
				      <RETURN>)
				     ;(,DEAD <CRLF>)
				     (T
				      <V-ECHO>)>>)>)>>

<ROUTINE DEEP-CANYON-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Você está na borda sul de um cânion profundo. Há passagens para leste,
noroeste e sudoeste. Uma escada desce.">
		<COND (<AND ,GATES-OPEN <NOT ,LOW-TIDE>>
		       <TELL
" Lá de baixo vem um rugido alto, como o de água correndo com força.">)
		      (<AND <NOT ,GATES-OPEN> ,LOW-TIDE>
		       <CRLF>
		       <RTRUE>)
		      (T
		       <TELL
" Lá de baixo vem o som de água corrente.">)>
		<CRLF>)>>


<GLOBAL EGG-SOLVE <>>

\

"SUBTITLE A SEEDY LOOKING GENTLEMAN..."

<GLOBAL THIEF-HERE <>>

;"I-THIEF moved to DEMONS"

\

"SUBTITLE THINGS THIEF MIGHT DO"

"INTERACTION WITH ADVENTURER -- RETURNS T IF THIEF FINISHED."

<ROUTINE THIEF-VS-ADVENTURER (HERE? "AUX" ROBBED? (WINNER-ROBBED? <>))
  <COND (<AND <NOT ,DEAD> <EQUAL? ,HERE ,TREASURE-ROOM>>)
        (<NOT ,THIEF-HERE>
         <COND (<AND <NOT ,DEAD> <NOT .HERE?> <PROB 30>>
	        <COND (<IN? ,STILETTO ,THIEF>
		       <FCLEAR ,THIEF ,INVISIBLE>
		       <TELL
"Someone carrying a large bag is casually leaning against one of the
walls here. He does not speak, but it is clear from his aspect that
the bag will be taken only over his dead body." CR>
		       <SETG THIEF-HERE T>
		       <RTRUE>)
		      ;(<IN? ,STILETTO ,WINNER>
		       <MOVE ,STILETTO ,THIEF>
		       <FSET ,STILETTO ,NDESCBIT>
		       <FCLEAR ,THIEF ,INVISIBLE>
		       <TELL
"You feel a light finger-touch, and turning, notice a grinning figure
holding a large bag in one hand and a stiletto in the other.">
		       <SETG THIEF-HERE T>
		       <RTRUE>)>)
	       (<AND .HERE?
		     <FSET? ,THIEF ,FIGHTBIT>
		     <NOT <WINNING? ,THIEF>>>
		<TELL
"Your opponent, determining discretion to be the better part of
valor, decides to terminate this little contretemps. With a rueful
nod of his head, he steps backward into the gloom and disappears." CR>
		<FSET ,THIEF ,INVISIBLE>
		<FCLEAR ,THIEF ,FIGHTBIT>
		<RECOVER-STILETTO>
		<RTRUE>)
	       (<AND .HERE? <FSET? ,THIEF ,FIGHTBIT> <PROB 90>>
		<RFALSE>)
	       (<AND .HERE? <PROB 30>>
	        <TELL
"The holder of the large bag just left, looking disgusted.
Fortunately, he took nothing." CR>
		<FSET ,THIEF ,INVISIBLE>
		<RECOVER-STILETTO>
	        <RTRUE>)
	       (<PROB 70> <RFALSE>)
	       (<NOT ,DEAD>
		<COND (<ROB ,HERE ,THIEF 100>
		       <SET ROBBED? ,HERE>)
		      (<ROB ,WINNER ,THIEF>
		       <SET ROBBED? ,PLAYER>)>
		<SETG THIEF-HERE T>
	        <COND (<AND .ROBBED? <NOT .HERE?>>
		       <TELL
"A seedy-looking individual with a large bag just wandered through
the room. On the way through, he quietly abstracted some valuables from ">
		       <COND (<EQUAL? .ROBBED? ,HERE>
			      <TELL "the room">)
			     (ELSE
			      <TELL "your possession">)>
		       <TELL ", mumbling something about
\"Doing unto others before...\"" CR>
		       <STOLE-LIGHT?>)
		      (.HERE?
		       <RECOVER-STILETTO>
		       <COND (.ROBBED?
			      <TELL
"The thief just left, still carrying his large bag. You may
not have noticed that he ">
			      <COND (<EQUAL? .ROBBED? ,PLAYER>
				     <TELL
"robbed you blind first.">)
				    (T
				     <TELL
"appropriated the valuables in the room.">)>
			      <CRLF>
			      <STOLE-LIGHT?>)
			     (T
			      <TELL
"The thief, finding nothing of value, left disgusted." CR>)>
		       <FSET ,THIEF ,INVISIBLE>
		       <SET HERE? <>>
		       <RTRUE>)
		      (T
		       <TELL
"A \"lean and hungry\" gentleman just wandered through, carrying a
large bag. Finding nothing of value, he left disgruntled." CR>
		       <RTRUE>)>)>)
	(T
	 <COND (.HERE?			;"Here, already announced."
		<COND (<PROB 30>
		       <COND (<ROB ,HERE ,THIEF 100>
			      <SET ROBBED? ,HERE>)
			     (<ROB ,WINNER ,THIEF>
			      <SET ROBBED? ,PLAYER>)>
		       <COND (.ROBBED?
			      <TELL
"The thief just left, still carrying his large bag. You may
not have noticed that he ">
			      <COND (<EQUAL? .ROBBED? ,PLAYER>
				     <TELL
"robbed you blind first.">)
				    (T
				     <TELL
"appropriated the valuables in the room.">)>
			      <CRLF>
			      <STOLE-LIGHT?>)
			     (T
			      <TELL
"The thief, finding nothing of value, left disgusted." CR>)>
		       <FSET ,THIEF ,INVISIBLE>
		       <SET HERE? <>>
		       <RECOVER-STILETTO>)>)>)>
       <RFALSE>>

<ROUTINE STOLE-LIGHT? ("AUX" OLD-LIT)
	 <SET OLD-LIT ,LIT>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT ,LIT> .OLD-LIT>
		<TELL "The thief seems to have left you in the dark." CR>)>
	 <RTRUE>>

"SNARF STILETTO IF DROPPED IT"

;"RECOVER-STILETTO moved to DEMONS"

"PUT HIS BOOTY IN TREASURE ROOM"

<ROUTINE HACK-TREASURES ("AUX" X)
	 <RECOVER-STILETTO>
	 <FSET ,THIEF ,INVISIBLE>
	 <SET X <FIRST? ,TREASURE-ROOM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN>)
		       (T <FCLEAR .X ,INVISIBLE>)>
		 <SET X <NEXT? .X>>>>

<ROUTINE DEPOSIT-BOOTY (RM "AUX" X N (FLG <>))
	 <SET X <FIRST? ,THIEF>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .FLG>)>
		 <SET N <NEXT? .X>>
		 <COND (<EQUAL? .X ,STILETTO ,LARGE-BAG>)
		       (<G? <GETP .X ,P?TVALUE> 0>
			<MOVE .X .RM>
			<SET FLG T>
			<COND (<EQUAL? .X ,EGG>
			       <SETG EGG-SOLVE T>
			       <FSET ,EGG ,OPENBIT>)>)>
		 <SET X .N>>>

"TAKE ALL OF THE VALUABLES SOMEWHERE AND PUT THEM SOMEWHERE ELSE"

"MOVED TO DEMONS"

"ROB MAZE"

<ROUTINE ROB-MAZE (RM "AUX" X N)
	 <SET X <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RFALSE>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <FSET? .X ,TAKEBIT>
			     <NOT <FSET? .X ,INVISIBLE>>
			     <PROB 40>>
			<TELL
"You hear, off in the distance, someone saying \"My, I wonder what
this fine " D .X " is doing here.\"" CR>
			<COND (<PROB 60 80>
			       <MOVE .X ,THIEF>
			       <FSET .X ,TOUCHBIT>
			       <FSET .X ,INVISIBLE>)>
			<RETURN>)>
		 <SET X .N>>>

"STEAL SOME JUNK - moved to DEMONS"

"DROP SOME JUNK - moved to DEMONS"



\

"ROBBER-FUNCTION -- more prosaic thiefly occupations"

<GLOBAL THIEF-ENGROSSED <>>

<ROUTINE ROBBER-FUNCTION ("OPTIONAL" (MODE <>) "AUX" (FLG <>) X N)
	 <COND (<VERB? TELL>
		<TELL "The thief is a strong, silent type." CR>
		<SETG P-CONT <>>)
	       (<NOT .MODE>
		<COND (<AND <VERB? HELLO>
			    <EQUAL? <GETP ,THIEF ,P?LDESC> ,ROBBER-U-DESC>>
		       <TELL
"The thief, being temporarily incapacitated, is unable to acknowledge
your greeting with his usual graciousness." CR>)
		      (<AND <EQUAL? ,PRSO ,KNIFE>
			    <VERB? THROW>
			    <NOT <FSET? ,THIEF ,FIGHTBIT>>>
		       <MOVE ,PRSO ,HERE>
		       <COND (<PROB 10 0>
			      <TELL
"You evidently frightened the robber, though you didn't hit him. He
flees">
			      <REMOVE ,LARGE-BAG>
			      <SET X <>>
			      <COND (<IN? ,STILETTO ,THIEF>
				     <REMOVE ,STILETTO>
				     <SET X T>)>
			      <COND (<FIRST? ,THIEF>
				     <MOVE-ALL ,THIEF ,HERE>
				     <TELL
", but the contents of his bag fall on the floor.">)
				    (T
				     <TELL ".">)>
			      <MOVE ,LARGE-BAG ,THIEF>
			      <COND (.X <MOVE ,STILETTO ,THIEF>)>
			      <CRLF>
			      <FSET ,THIEF ,INVISIBLE>)
			     (T
			      <TELL
"You missed. The thief makes no attempt to take the knife, though it
would be a fine addition to the collection in his bag. He does seem
angered by your attempt." CR>
			      <FSET ,THIEF ,FIGHTBIT>)>)
		      (<AND <VERB? THROW GIVE>
			    ,PRSO
			    <NOT <EQUAL? ,PRSO ,THIEF>>
			    <EQUAL? ,PRSI ,THIEF>>
		       <COND (<L? <GETP ,THIEF ,P?STRENGTH> 0>
			      <PUTP ,THIEF
				    ,P?STRENGTH
				    <- <GETP ,THIEF ,P?STRENGTH>>>
			      <ENABLE <INT I-THIEF>>
			      <RECOVER-STILETTO>
			      <PUTP ,THIEF ,P?LDESC ,ROBBER-C-DESC>
			      <TELL
"Your proposed victim suddenly recovers consciousness." CR>)>
		       <MOVE ,PRSO ,THIEF>
		       <COND ;(<EQUAL? ,PRSO ,STILETTO>
			      <TELL
"The thief takes his stiletto and salutes you with a small nod of
his head." CR>)
			     (<G? <GETP ,PRSO ,P?TVALUE> 0>
			      <SETG THIEF-ENGROSSED T>
			      <TELL
"The thief is taken aback by your unexpected generosity, but accepts
the " D ,PRSO " and stops to admire its beauty." CR>)
			     (T
			      <TELL
"The thief places the " D ,PRSO " in his bag and thanks
you politely." CR>)>)
		      (<VERB? TAKE>
		       <TELL
"Once you got him, what would you do with him?" CR>)
		      (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"The thief is a slippery character with beady eyes that flit back
and forth. He carries, along with an unmistakable arrogance, a large bag
over his shoulder and a vicious stiletto, whose blade is aimed
menacingly in your direction. I'd watch out if I were you." CR>)
		      (<VERB? LISTEN>
		       <TELL
"The thief says nothing, as you have not been formally introduced." CR>)>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,STILETTO ,THIEF> <>)
		      (<IN? ,STILETTO <LOC ,THIEF>>
		       <MOVE ,STILETTO ,THIEF>
		       <FSET ,STILETTO ,NDESCBIT>
		       <COND (<IN? ,THIEF ,HERE>
			      <TELL
"The robber, somewhat surprised at this turn of events, nimbly
retrieves his stiletto." CR>)>
		       T)>)
	       (<EQUAL? .MODE ,F-DEAD>
		<MOVE ,STILETTO ,HERE>
		<FCLEAR ,STILETTO ,NDESCBIT>
		<SET X <DEPOSIT-BOOTY ,HERE>>
		<COND (<EQUAL? ,HERE ,TREASURE-ROOM>
		       <SET X <FIRST? ,HERE>>
		       <REPEAT ()
			       <COND
				(<NOT .X>
				 <TELL "The chalice is now safe to take." CR>
				 <RETURN>)
				(<NOT <EQUAL? .X ,CHALICE ,THIEF ,ADVENTURER>>
				 <FCLEAR .X ,INVISIBLE>
				 <COND (<NOT .FLG>
					<SET FLG T>
					<TELL
"As the thief dies, the power of his magic decreases, and his
treasures reappear:" CR>)>
				 <TELL "  A " D .X>
				 <COND (<AND <FIRST? .X>
					     <SEE-INSIDE? .X>>
					<TELL ", with ">
					<PRINT-CONTENTS .X>)>
				 <CRLF>)>
			       <SET X <NEXT? .X>>>)
		      (.X
		       <TELL "His booty remains." CR>)>
		<DISABLE <INT I-THIEF>>)
	       (<EQUAL? .MODE ,F-FIRST?>
		<COND (<AND ,THIEF-HERE
			    <NOT <FSET? ,THIEF ,INVISIBLE>>
			    <PROB 20>>
		       <FSET ,THIEF ,FIGHTBIT>
		       <SETG P-CONT <>>
		       T)>)
	       (<EQUAL? .MODE ,F-UNCONSCIOUS>
		<DISABLE <INT I-THIEF>>
		<FCLEAR ,THIEF ,FIGHTBIT>
		<MOVE ,STILETTO ,HERE>
		<FCLEAR ,STILETTO ,NDESCBIT>
		<PUTP ,THIEF ,P?LDESC ,ROBBER-U-DESC>)
	       (<EQUAL? .MODE ,F-CONSCIOUS>
		<COND (<EQUAL? <LOC ,THIEF> ,HERE>
		       <FSET ,THIEF ,FIGHTBIT>
		       <TELL
"The robber revives, briefly feigning continued unconsciousness, and,
when he sees his moment, scrambles away from you." CR>)>
		<ENABLE <INT I-THIEF>>
		<PUTP ,THIEF ,P?LDESC ,ROBBER-C-DESC>
		<RECOVER-STILETTO>)>>

<GLOBAL ROBBER-C-DESC
"There is a suspicious-looking individual, holding a bag, leaning
against one wall. He is armed with a vicious-looking stiletto.">

<GLOBAL ROBBER-U-DESC
"There is a suspicious-looking individual lying unconscious on the
ground.">

<ROUTINE LARGE-BAG-F ()
	 <COND (<VERB? TAKE>
		<COND (<EQUAL? <GETP ,THIEF ,P?LDESC> ,ROBBER-U-DESC>
		       <TELL
"Sadly for you, the robber collapsed on top of the bag. Trying to take
it would wake him." CR>)
		      (T
		       <TELL
"The bag will be taken over his dead body." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LARGE-BAG>>
		<TELL "It would be a good trick." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"Getting close enough would be a good trick." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The bag is underneath the thief, so one can't say what, if anything, is
inside." CR>)>>

<ROUTINE MOVE-ALL (FROM TO "AUX" X N)
	 <COND (<SET X <FIRST? .FROM>>
		<REPEAT ()
			<COND (<NOT .X> <RETURN>)>
			<SET N <NEXT? .X>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .TO>
			<SET X .N>>)>>

<ROUTINE CHALICE-FCN ()
	 <COND (<VERB? TAKE>
		<COND (<AND <IN? ,PRSO ,TREASURE-ROOM>
			    <IN? ,THIEF ,TREASURE-ROOM>
			    <FSET? ,THIEF ,FIGHTBIT>
			    <NOT <FSET? ,THIEF ,INVISIBLE>>
			    <NOT <EQUAL? <GETP ,THIEF ,P?LDESC>
					 ,ROBBER-U-DESC>>>
		       <TELL
"You'd be stabbed in the back first." CR>)>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CHALICE>>
		<TELL
"You can't. It's not a very good chalice, is it?" CR>)
	       (T <DUMB-CONTAINER>)>>

<ROUTINE TREASURE-ROOM-FCN (RARG "AUX" TL)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <1? <GET <INT I-THIEF> ,C-ENABLED?>>
		     <NOT ,DEAD>>
		<COND (<NOT <IN? ,THIEF ,HERE>>
		       <TELL
"You hear a scream of anguish as you violate the robber's hideaway.
Using passages unknown to you, he rushes to its defense." CR>
		       <MOVE ,THIEF ,HERE>)>
		<FSET ,THIEF ,FIGHTBIT>
		<FCLEAR ,THIEF ,INVISIBLE>
		<THIEF-IN-TREASURE>)>>

<ROUTINE THIEF-IN-TREASURE ("AUX" F N)
	 <SET F <FIRST? ,HERE>>
	 <COND (<AND .F <NEXT? .F>>
		<TELL
"The thief gestures mysteriously, and the treasures in the room
suddenly vanish." CR CR>)>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (<NOT <EQUAL? .F ,CHALICE ,THIEF>>
			<FSET .F ,INVISIBLE>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE FRONT-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "A porta não pode ser aberta." CR>)
	       (<VERB? BURN>
		<TELL
		 "Você não pode queimar esta porta." CR>)
	       (<VERB? MUNG>
		<TELL "Você não consegue danificar a porta." CR>)
	       (<VERB? LOOK-BEHIND>
		<TELL "Ela não abre." CR>)>>

\

"SUBTITLE RANDOM FUNCTIONS"

<ROUTINE BODY-FUNCTION ()
	 <COND (<VERB? TAKE>
		<TELL "A force keeps you from taking the bodies." CR>)
	       (<VERB? MUNG BURN>
		<JIGS-UP
"The voice of the guardian of the dungeon booms out from the darkness,
\"Your disrespect costs you your life!\" and places your head on a sharp
pole.">)>>

<ROUTINE BLACK-BOOK ()
	 <COND (<VERB? OPEN>
		<TELL "The book is already open to page 569." CR>)
	       (<VERB? CLOSE>
		<TELL "As hard as you try, the book cannot be closed." CR>)
	       (<OR <VERB? TURN>
		    <AND <VERB? READ-PAGE>
			 <EQUAL? ,PRSI ,INTNUM>
			 <NOT <EQUAL? ,P-NUMBER 569>>>>
		<TELL
"Beside page 569, there is only one other page with any legible printing on
it. Most of it is unreadable, but the subject seems to be the banishment of
evil. Apparently, certain noises, lights, and prayers are efficacious in this
regard." CR>)
	       (<VERB? BURN>
		<REMOVE-CAREFULLY ,PRSO>
		<JIGS-UP
"A booming voice says \"Wrong, cretin!\" and you notice that you have
turned into a pile of dust. How, I can't imagine.">)>>

<ROUTINE PAINTING-FCN ()
	 <COND (<VERB? MUNG>
		<PUTP ,PRSO ,P?TVALUE 0>
		<PUTP ,PRSO ,P?LDESC
"Há um pedaço de tela sem valor nenhum aqui.">
		<TELL
"Parabéns! Ao contrário dos outros vândalos, que só roubaram as
obras-primas do artista, você destruiu uma." CR>)>>

\

"SUBTITLE LET THERE BE LIGHT SOURCES"

<GLOBAL LAMP-TABLE
	<TABLE (PURE)
	       100
	       "A lanterna parece um pouco mais fraca."
	       70
	       "A lanterna está bem mais fraca agora."
	       15
	       "A lanterna está quase apagando."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<VERB? THROW>
		<TELL
"A lanterna se espatifa no chão, e a luz se apaga." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE-CAREFULLY ,LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "Uma lanterna sem bateria não acende." CR>)
		      (T
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "A bateria da lanterna já acabou." CR>)
		      (T
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<TELL "A lanterna ">
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "está sem bateria.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "está acesa.">)
		      (T
		       <TELL "está apagada.">)>
		<CRLF>)>>

<ROUTINE MAILBOX-F ()
	 <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,MAILBOX>>
		<TELL "Ela está firmemente presa ao chão." CR>)>>

<GLOBAL MATCH-COUNT 6>

<ROUTINE MATCH-FUNCTION ("AUX" CNT)
	 <COND (<AND <VERB? LAMP-ON BURN> <EQUAL? ,PRSO ,MATCH>>
		<COND (<G? ,MATCH-COUNT 0>
		       <SETG MATCH-COUNT <- ,MATCH-COUNT 1>>)>
		<COND (<NOT <G? ,MATCH-COUNT 0>>
		       <TELL
			"Receio que os seus fósforos tenham acabado." CR>)
		      (<EQUAL? ,HERE ,LOWER-SHAFT ,TIMBER-ROOM>
		       <TELL
"Esta sala tem correntes de ar, e o fósforo se apaga na hora." CR>)
		      (T
		       <FSET ,MATCH ,FLAMEBIT>
		       <FSET ,MATCH ,ONBIT>
		       <ENABLE <QUEUE I-MATCH 2>>
		       <TELL "Um dos fósforos começa a queimar." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT T>
			      <V-LOOK>)>
		       <RTRUE>)>)
	       (<AND <VERB? LAMP-OFF> <FSET? ,MATCH ,FLAMEBIT>>
		<TELL "O fósforo se apaga." CR>
		<FCLEAR ,MATCH ,FLAMEBIT>
		<FCLEAR ,MATCH ,ONBIT>
		<SETG LIT <LIT? ,HERE>>
		<COND (<NOT ,LIT> <TELL "Está um breu total aqui dentro!" CR>)>
		<QUEUE I-MATCH 0>
		<RTRUE>)
	       (<VERB? COUNT OPEN>
		<TELL "Você ">
	        <SET CNT <- ,MATCH-COUNT 1>>
		<COND (<NOT <G? .CNT 0>> <TELL "não tem nenhum">)
		      (T <TELL "tem " N .CNT>)>
		<TELL " fósforo">
		<COND (<G? .CNT 1> <TELL "s.">) (T <TELL ".">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,MATCH ,ONBIT>
		       <TELL "O fósforo está queimando.">)
		      (T
		       <TELL
"A caixa de fósforos não tem nada de interessante, a não ser o que está
escrito nela.">)>
		<CRLF>)>>

<ROUTINE I-MATCH ()
	 <TELL "O fósforo se apagou." CR>
	 <FCLEAR ,MATCH ,FLAMEBIT>
	 <FCLEAR ,MATCH ,ONBIT>
	 <SETG LIT <LIT? ,HERE>>
	 <RTRUE>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

<ROUTINE I-CANDLES ("AUX" TICK (TBL <VALUE CANDLE-TABLE>))
	 <FSET ,CANDLES ,TOUCHBIT>
	 <ENABLE <QUEUE I-CANDLES <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,CANDLES .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG CANDLE-TABLE <REST .TBL 4>>)>>

<ROUTINE LIGHT-INT (OBJ TBL TICK)
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,ONBIT>
		<FSET .OBJ ,RMUNGBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"É melhor você arranjar uma luz melhor que " T-O .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>>

<ROUTINE MIN (N1 N2)
	 <COND (<L? .N1 .N2> .N1)
	       (T .N2)>>

<ROUTINE CANDLES-FCN ()
	 <COND (<NOT <FSET? ,CANDLES ,TOUCHBIT>>
		<ENABLE <INT I-CANDLES>>)>
	 <COND (<EQUAL? ,CANDLES ,PRSI> <RFALSE>)
	       (T
		<COND (<VERB? LAMP-ON BURN>
		       <COND (<FSET? ,CANDLES ,RMUNGBIT>
			      <TELL
"Alas, there's not much left of the candles. Certainly not enough to
burn." CR>)
			     (<NOT ,PRSI>
			      <COND (<FSET? ,MATCH ,FLAMEBIT>
				     <TELL "(with the match)" CR>
				     <PERFORM ,V?LAMP-ON ,CANDLES ,MATCH>
				     <RTRUE>)
				    (T
				     <TELL
"You should say what to light them with." CR>
				     <RFATAL>)>)
			     (<AND <EQUAL? ,PRSI ,MATCH>
				   <FSET? ,MATCH ,ONBIT>>
			      <TELL "The candles are ">
			      <COND (<FSET? ,CANDLES ,ONBIT>
				     <TELL "already lit." CR>)
				    (T
				     <FSET ,CANDLES ,ONBIT>
				     <TELL "lit." CR>
				     <ENABLE <INT I-CANDLES>>)>)
			     (<EQUAL? ,PRSI ,TORCH>
			      <COND (<FSET? ,CANDLES ,ONBIT>
				     <TELL
"You realize, just in time, that the candles are already lighted." CR>)
				    (T
				     <TELL
"The heat from the torch is so intense that the candles are vaporized." CR>
				     <REMOVE-CAREFULLY ,CANDLES>)>)
			     (T
			      <TELL
"You have to light them with something that's burning, you know." CR>)>)
		      (<VERB? COUNT>
		       <TELL
"Let's see, how many objects in a pair? Don't tell me, I'll get it." CR>)
		      (<VERB? LAMP-OFF>
		       <DISABLE <INT I-CANDLES>>
		       <COND (<FSET? ,CANDLES ,ONBIT>
			      <TELL "The flame is extinguished.">
			      <FCLEAR ,CANDLES ,ONBIT>
			      <FSET ,CANDLES ,TOUCHBIT>
			      <SETG LIT <LIT? ,HERE>>
			      <COND (<NOT ,LIT>
				     <TELL " It's really dark in here....">)>
			      <CRLF>
			      <RTRUE>)
			     (T <TELL "The candles are not lighted." CR>)>)
		      (<AND <VERB? PUT> <FSET? ,PRSI ,BURNBIT>>
		       <TELL "That wouldn't be smart." CR>)
		      (<VERB? EXAMINE>
		       <TELL "The candles are ">
		       <COND (<FSET? ,CANDLES ,ONBIT>
			      <TELL "burning.">)
			     (T <TELL "out.">)>
		       <CRLF>)>)>>

<GLOBAL CANDLE-TABLE
	<TABLE (PURE)
	       20
	       "The candles grow shorter."
	       10
	       "The candles are becoming quite short."
	       5
	       "The candles won't last long now."
	       0>>

<ROUTINE CAVE2-ROOM (RARG)
  <COND (<EQUAL? .RARG ,M-END>
	 <COND (<AND <IN? ,CANDLES ,WINNER>
		     <PROB 50 80>
		     <FSET? ,CANDLES ,ONBIT>>
		<DISABLE <INT I-CANDLES>>
		<FCLEAR ,CANDLES ,ONBIT>
		<TELL
"A gust of wind blows out your candles!" CR>
		<COND (<NOT <SETG LIT <LIT? ,HERE>>>
		       <TELL "It is now completely dark." CR>)>)>)>>

\

"SUBTITLE ASSORTED WEAPONS"

<ROUTINE SWORD-FCN ("AUX" G)
	 <COND (<AND <VERB? TAKE> <EQUAL? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? <SET G <GETP ,SWORD ,P?TVALUE>> 1>
		       <TELL
"Sua espada emite um fraco brilho azulado." CR>)
		      (<EQUAL? .G 2>
		       <TELL
"Sua espada está brilhando intensamente." CR>)>)>>

"SUBTITLE COAL MINE"

<ROUTINE BOOM-ROOM (RARG "AUX" (DUMMY? <>) FLAME)
         <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <EQUAL? .RARG ,M-END>
			    <VERB? LAMP-ON BURN>
			    <EQUAL? ,PRSO ,CANDLES ,TORCH ,MATCH>>
		       <SET DUMMY? T>)>
		<COND (<OR <AND <HELD? ,CANDLES>
				<FSET? ,CANDLES ,ONBIT>>
			   <AND <HELD? ,TORCH>
				<FSET? ,TORCH ,ONBIT>>
			   <AND <HELD? ,MATCH>
				<FSET? ,MATCH ,ONBIT>>>
		       <COND (.DUMMY?
			      <TELL
"How sad for an aspiring adventurer to light a " D ,PRSO " in a room which
reeks of gas. Fortunately, there is justice in the world." CR>)
			     (T
			      <TELL
"Oh dear. It appears that the smell coming from this room was coal gas.
I would have thought twice about carrying flaming objects in here." CR>)>
		       <JIGS-UP "|
      ** BOOOOOOOOOOOM **">)>)>> 

<ROUTINE BAT-D ("OPTIONAL" FOO)
	 <COND (<EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>
		<TELL
"In the corner of the room on the ceiling is a large vampire bat who
is obviously deranged and holding his nose." CR>)
	       (T
		<TELL
"A large vampire bat, hanging from the ceiling, swoops down at you!" CR>)>>

<ROUTINE BATS-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a small room which has doors only to the east and south." CR>)
	       (<AND <EQUAL? .RARG ,M-ENTER> <NOT ,DEAD>>
		<COND (<NOT <EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>>
		       <V-LOOK>
		       <CRLF>
		       <FLY-ME>)>)>>

<ROUTINE MACHINE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large, cold room whose sole exit is to the north. In one
corner there is a machine which is reminiscent of a clothes
dryer. On its face is a switch which is labelled \"START\".
The switch does not appear to be manipulable by any human hand (unless the
fingers are about 1/16 by 1/4 inch). On the front of the machine is a large
lid, which is ">
		<COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL "open.">)
		      (T <TELL "closed.">)>
		<CRLF>)>>

<ROUTINE MACHINE-F ()
	 <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,MACHINE>>
		<TELL "It is far too large to carry." CR>)
	       (<VERB? OPEN>
	        <COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (<FIRST? ,MACHINE>
		       <TELL "The lid opens, revealing ">
		       <PRINT-CONTENTS ,MACHINE>
		       <TELL "." CR>
		       <FSET ,MACHINE ,OPENBIT>)
		      (T
		       <TELL "The lid opens." CR>
		       <FSET ,MACHINE ,OPENBIT>)>)
	       (<VERB? CLOSE>
	        <COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL "The lid closes." CR>
		       <FCLEAR ,MACHINE ,OPENBIT>
		       T)
		      (T
		       <TELL <PICK-ONE ,DUMMY> CR>)>)
	       (<VERB? LAMP-ON>
		<COND (<NOT ,PRSI>
		       <TELL
"It's not clear how to turn it on with your bare hands." CR>)
		      (T
		       <PERFORM ,V?TURN ,MACHINE-SWITCH ,PRSI>
		       <RTRUE>)>)>>

<ROUTINE MSWITCH-FUNCTION ("AUX" O)
	 <COND (<VERB? TURN>
		<COND (<EQUAL? ,PRSI ,SCREWDRIVER>
		       <COND (<FSET? ,MACHINE ,OPENBIT>
			      <TELL
"The machine doesn't seem to want to do anything." CR>)
			     (T <TELL
"The machine comes to life (figuratively) with a dazzling display of
colored lights and bizarre noises. After a few moments, the
excitement abates." CR>
			      <COND (<IN? ,COAL ,MACHINE>
				     <REMOVE-CAREFULLY ,COAL>
				     <MOVE ,DIAMOND ,MACHINE>)
				    (T
				     <REPEAT ()
					     <COND (<SET O <FIRST? ,MACHINE>>
						    <REMOVE-CAREFULLY .O>)
						   (T <RETURN>)>>
				     <MOVE ,GUNK ,MACHINE>)>)>)
		      (T
		       <TELL "It seems that a " D ,PRSI " won't do." CR>)>)>>

<ROUTINE GUNK-FUNCTION ()
	 <REMOVE-CAREFULLY ,GUNK>
	 <TELL
"The slag was rather insubstantial, and crumbles into dust at your touch." CR>>

<ROUTINE NO-OBJS (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SET F <FIRST? ,WINNER>>
		<SETG EMPTY-HANDED T>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)
			      (<G? <WEIGHT .F> 4>
			       <SETG EMPTY-HANDED <>>
			       <RETURN>)>
			<SET F <NEXT? .F>>>
		<COND (<AND <EQUAL? ,HERE ,LOWER-SHAFT> ,LIT>
		       <SCORE-UPD ,LIGHT-SHAFT>
		       <SETG LIGHT-SHAFT 0>)>
		<RFALSE>)>>

<ROUTINE SOUTH-TEMPLE-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SETG COFFIN-CURE <NOT <IN? ,COFFIN ,WINNER>>>
		<RFALSE>)>>

<GLOBAL LIGHT-SHAFT 13>
<GDECL (LIGHT-SHAFT) FIX>

\

"SUBTITLE OLD MAN RIVER, THAT OLD MAN RIVER..."

<ROUTINE WHITE-CLIFFS-FUNCTION (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<IN? ,INFLATED-BOAT ,WINNER>
		       <SETG DEFLATE <>>)
	       	      (T
		       <SETG DEFLATE T>)>)>>

<ROUTINE SCEPTRE-FUNCTION ()
	 <COND (<VERB? WAVE RAISE>
		<COND (<OR <EQUAL? ,HERE ,ARAGAIN-FALLS>
			   <EQUAL? ,HERE ,END-OF-RAINBOW>>
		       <COND (<NOT ,RAINBOW-FLAG>
			      <FCLEAR ,POT-OF-GOLD ,INVISIBLE>
			      <TELL
"Suddenly, the rainbow appears to become solid and, I venture,
walkable (I think the giveaway was the stairs and bannister)." CR>
			      <COND (<AND <EQUAL? ,HERE ,END-OF-RAINBOW>
					  <IN? ,POT-OF-GOLD ,END-OF-RAINBOW>>
				     <TELL
"A shimmering pot of gold appears at the end of the rainbow." CR>)>
			      <SETG RAINBOW-FLAG T>)
			     (T
			      <ROB ,ON-RAINBOW ,WALL>
			      <TELL
"The rainbow seems to have become somewhat run-of-the-mill." CR>
			      <SETG RAINBOW-FLAG <>>
			      <RTRUE>)>)
		      (<EQUAL? ,HERE ,ON-RAINBOW>
		       <SETG RAINBOW-FLAG <>>
		       <JIGS-UP
"The structural integrity of the rainbow is severely compromised,
leaving you hanging in midair, supported only by water vapor. Bye.">)
		      (T
		       <TELL
"A dazzling display of color briefly emanates from the sceptre." CR>)>)>>

<ROUTINE FALLS-ROOM (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"You are at the top of Aragain Falls, an enormous waterfall with a
drop of about 450 feet. The only path here is on the north end." CR>
	   <COND (,RAINBOW-FLAG
		  <TELL
"A solid rainbow spans the falls.">)
		 (T
		  <TELL
"A beautiful rainbow can be seen over the falls and to the west.">)>
	   <CRLF>)>>

<ROUTINE RAINBOW-FCN ()
	 <COND (<VERB? CROSS THROUGH>
		<COND (<EQUAL? ,HERE ,CANYON-VIEW>
		       <TELL "From here?!?" CR>
		       <RTRUE>)>
		<COND (,RAINBOW-FLAG
		       <COND (<EQUAL? ,HERE ,ARAGAIN-FALLS>
			      <GOTO ,END-OF-RAINBOW>)
			     (<EQUAL? ,HERE ,END-OF-RAINBOW>
			      <GOTO ,ARAGAIN-FALLS>)
			     (T
			      <TELL "You'll have to say which way..." CR>)>)
		      (T
		       <TELL "Can you walk on water vapor?"
			     CR>)>)
	       (<VERB? LOOK-UNDER>
		<TELL "The Frigid River flows under the rainbow." CR>)>>

<ROUTINE DBOAT-FUNCTION ("AUX")
	 <COND (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSO ,PUTTY>>
		<FIX-BOAT>)
	       (<VERB? INFLATE FILL>
		<TELL
"Sem chance. Algum imbecil furou o barco." CR>)
	       (<VERB? PLUG>
		<COND (<EQUAL? ,PRSI ,PUTTY>
		       <FIX-BOAT>)
		      (T <WITH-TELL ,PRSI>)>)>>

<ROUTINE FIX-BOAT ()
	 <TELL "Muito bem. O barco está consertado." CR>
	 <MOVE ,INFLATABLE-BOAT <LOC ,PUNCTURED-BOAT>>
	 <REMOVE-CAREFULLY ,PUNCTURED-BOAT>>

<ROUTINE RIVER-FUNCTION ()
	 <COND (<VERB? PUT>
		<COND (<EQUAL? ,PRSI ,RIVER>
		       <COND (<EQUAL? ,PRSO ,ME>
			      <JIGS-UP
"Você se debate na água por um tempo, lutando contra a correnteza, e
então se afoga.">)
			     (<EQUAL? ,PRSO ,INFLATED-BOAT>
			      <TELL
"Você deveria entrar no barco e depois lançá-lo." CR>)
			     (<FSET? ,PRSO ,BURNBIT>
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL T-CO ,PRSO " ">
			      <PRINT-PLURAL ,PRSO "flutua" "flutuam">
			      <TELL " por um instante e depois ">
			      <PRINT-PLURAL ,PRSO "afunda" "afundam">
			      <TELL "." CR>)
			     (T
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL T-CO ,PRSO " ">
			      <PRINT-PLURAL ,PRSO "cai" "caem">
			      <TELL " na água e ">
			      <PRINT-PLURAL ,PRSO "some" "somem">
			      <TELL " para sempre." CR>)>)>)
	       (<VERB? LEAP THROUGH>
		<TELL
"Olhando antes de pular, você vê que o rio é largo e perigoso, com
correntes rápidas e pedras grandes meio escondidas. Você decide deixar o
mergulho para outro dia." CR>)>>

<GLOBAL RIVER-SPEEDS
	<LTABLE (PURE) RIVER-1 4 RIVER-2 4 RIVER-3 3 RIVER-4 2 RIVER-5 1>>

<GLOBAL RIVER-NEXT
	<LTABLE (PURE) RIVER-1 RIVER-2 RIVER-3 RIVER-4 RIVER-5>>

<GLOBAL RIVER-LAUNCH
	<LTABLE (PURE) DAM-BASE RIVER-1
		WHITE-CLIFFS-NORTH RIVER-3
		WHITE-CLIFFS-SOUTH RIVER-4
		SHORE RIVER-5
		SANDY-BEACH RIVER-4
		RESERVOIR-SOUTH RESERVOIR
		RESERVOIR-NORTH RESERVOIR
		STREAM-VIEW IN-STREAM>>

<ROUTINE I-RIVER ("AUX" RM)
	 <COND (<AND <NOT <EQUAL? ,HERE ,RIVER-1 ,RIVER-2 ,RIVER-3>>
		     <NOT <EQUAL? ,HERE ,RIVER-4 ,RIVER-5>>>
		<DISABLE <INT I-RIVER>>)
	       (<SET RM <LKP ,HERE ,RIVER-NEXT>>
		<TELL "A correnteza leva você rio abaixo." CR CR>
		<GOTO .RM>
		<ENABLE <QUEUE I-RIVER <LKP ,HERE ,RIVER-SPEEDS>>>)
	       (T
		<JIGS-UP
"Infelizmente, o barco mágico não protege contra as pedras e rochas que
a gente encontra no pé das cachoeiras. Inclusive desta.">)>>

<ROUTINE RBOAT-FUNCTION ("OPTIONAL" (RARG <>) "AUX" TMP)
    <COND (<EQUAL? .RARG ,M-ENTER ,M-END ,M-LOOK> <>)	
	  (<EQUAL? .RARG ,M-BEG>
	   <COND (<VERB? WALK>
		  <COND (<EQUAL? ,PRSO ,P?LAND ,P?EAST ,P?WEST>
			 <RFALSE>)
			(<AND <EQUAL? ,HERE ,RESERVOIR>
			      <EQUAL? ,PRSO ,P?NORTH ,P?SOUTH>>
			 <RFALSE>)
			(<AND <EQUAL? ,HERE ,IN-STREAM>
			      <EQUAL? ,PRSO ,P?SOUTH>>
			 <RFALSE>)
			(T
			 <TELL
"Leia a etiqueta para ver as instruções do barco." CR>
			 <RTRUE>)>)
		 (<VERB? LAUNCH>
		  <COND (<OR <EQUAL? ,HERE ,RIVER-1 ,RIVER-2 ,RIVER-3>
			     <EQUAL? ,HERE ,RIVER-4 ,RESERVOIR ,IN-STREAM>>
			 <TELL
"Você já está ">
			 <COND (<EQUAL? ,HERE ,RESERVOIR>
				<TELL "na represa">)
			       (<EQUAL? ,HERE ,IN-STREAM>
				<TELL "no riacho">)
			       (T <TELL "no rio">)>
			 <TELL ", ou esqueceu?" CR>)
			(<EQUAL? <SET TMP <GO-NEXT ,RIVER-LAUNCH>> 1>
			 <ENABLE <QUEUE I-RIVER <LKP ,HERE ,RIVER-SPEEDS>>>
			 <RTRUE>)
			(<NOT <EQUAL? .TMP 2>>
			 <TELL "Você não pode lançar o barco aqui." CR>
			 <RTRUE>)
			(T <RTRUE>)>)
		 (<OR <AND <VERB? DROP>
			   <FSET? ,PRSO ,WEAPONBIT>>
		      <AND <VERB? PUT>
			   <FSET? ,PRSO ,WEAPONBIT>
			   <EQUAL? ,PRSI ,INFLATED-BOAT>>
		      <AND <VERB? ATTACK MUNG>
			   <FSET? ,PRSI ,WEAPONBIT>>>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,PUNCTURED-BOAT ,HERE>
		  <ROB ,INFLATED-BOAT ,HERE>
		  <MOVE ,WINNER ,HERE>
		  <TELL
"Parece que ">
		  <COND (<VERB? DROP PUT>
			 <TELL T-O ,PRSO " não se ">
			 <PRINT-PLURAL ,PRSO "deu" "deram">)
			(T
			 <TELL T-O ,PRSI " não se ">
			 <PRINT-PLURAL ,PRSI "deu" "deram">)>
		  <TELL " bem com o barco, a julgar pelo chiado alto
que sai dele. Com um gorgolejo patético, o barco murcha e deixa você a ver
navios." CR>
		  <COND (<FSET? ,HERE ,NONLANDBIT>
			 <CRLF>
			 <COND (<==? ,HERE ,RESERVOIR ,IN-STREAM>
				<JIGS-UP
"Outro gorgolejo patético, desta vez seu, anuncia o seu afogamento.">)
			       (T
				<JIGS-UP
"Ou melhor, a ver navios enquanto luta contra as correntes ferozes do Rio
Frígido. Você até consegue se aguentar por um tempo, mas depois é
arrastado por uma cachoeira e cai em cima de umas pedras nada simpáticas.
Ai!">)>)>
		  <RTRUE>)
		 (<VERB? LAUNCH>
	  	   <TELL "Você não está no barco!" CR>)>)
	  (<VERB? BOARD>
	   <COND (<OR <IN? ,SCEPTRE ,WINNER>
		      <IN? ,KNIFE ,WINNER>
		      <IN? ,SWORD ,WINNER>
		      <IN? ,RUSTY-KNIFE ,WINNER>
		      <IN? ,AXE ,WINNER>
		      <IN? ,STILETTO ,WINNER>>
		  <TELL
"Opa! Parece que alguma coisa afiada escorregou e furou o barco. O barco
murcha entre chiados, gorgolejos e palavrões." CR>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,PUNCTURED-BOAT ,HERE>
		  <THIS-IS-IT ,PUNCTURED-BOAT>
		  T)>)
	  (<VERB? INFLATE FILL>
	   <TELL "Se você inflar mais, o barco provavelmente vai estourar." CR>)
	  (<VERB? DEFLATE>
	   <COND (<EQUAL? <LOC ,WINNER> ,INFLATED-BOAT>
		  <TELL
"Você não pode esvaziar o barco enquanto está dentro dele." CR>)
		 (<NOT <IN? ,INFLATED-BOAT ,HERE>>
		  <TELL
"O barco precisa estar no chão para ser esvaziado." CR>)
		 (T <TELL
"O barco se esvazia." CR>
		  <SETG DEFLATE T>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,INFLATABLE-BOAT ,HERE>
		  <THIS-IS-IT ,INFLATABLE-BOAT>)>)>>

<ROUTINE BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE IBOAT-FUNCTION ()
	 <COND (<VERB? INFLATE FILL>
		<COND (<NOT <IN? ,INFLATABLE-BOAT ,HERE>>
		       <TELL
"O barco precisa estar no chão para ser inflado." CR>)
		      (<EQUAL? ,PRSI ,PUMP>
		       <TELL
"O barco se enche e parece pronto para navegar." CR>
		       <COND (<NOT <FSET? ,BOAT-LABEL ,TOUCHBIT>>
			      <TELL
"Há uma etiqueta bege dentro do barco." CR>)>
		       <SETG DEFLATE <>>
		       <REMOVE-CAREFULLY ,INFLATABLE-BOAT>
		       <MOVE ,INFLATED-BOAT ,HERE>
		       <THIS-IS-IT ,INFLATED-BOAT>)
		      (<EQUAL? ,PRSI ,LUNGS>
		       <TELL
"Você não tem fôlego suficiente para inflar o barco." CR>)
		      (T
		       <TELL
"Com " T-UM ,PRSI "? Você só pode estar brincando!" CR>)>)>>

<GLOBAL BUOY-FLAG T>

<ROUTINE RIVR4-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <IN? ,BUOY ,WINNER> ,BUOY-FLAG>
	      	       <TELL
"Você sente algo esquisito ao apalpar a boia." CR>
		       <SETG BUOY-FLAG <>>)>)>>

<GLOBAL BEACH-DIG -1>

<GDECL (BEACH-DIG) FIX>

<ROUTINE SAND-FUNCTION ()
	 <COND (<AND <VERB? DIG> <==? ,PRSI ,SHOVEL>>
		<SETG BEACH-DIG <+ 1 ,BEACH-DIG>>
		<COND (<G? ,BEACH-DIG 3>
		       <SETG BEACH-DIG -1>
		       <AND <IN? ,SCARAB ,HERE> <FSET ,SCARAB ,INVISIBLE>>
		       <JIGS-UP "O buraco desmorona e soterra você.">)
		      (<EQUAL? ,BEACH-DIG 3>
		       <COND (<FSET? ,SCARAB ,INVISIBLE>
			      <TELL
"Você vê um escaravelho aqui na areia." CR>
			      <THIS-IS-IT ,SCARAB>
			      <FCLEAR ,SCARAB ,INVISIBLE>)>)
		      (T
		       <TELL <GET ,BDIGS ,BEACH-DIG> CR>)>)>>

<GLOBAL BDIGS
	<TABLE (PURE) "Parece que você está cavando um buraco aqui."
	       "O buraco está ficando mais fundo, mas é só isso."
	       "Você está cercado por uma parede de areia por todos os lados.">>

\

"SUBTITLE TOITY POIPLE BOIDS A CHOIPIN' AN' A BOIPIN' ... "

<ROUTINE TREE-ROOM (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Você está a uns três metros do chão, aninhado entre alguns galhos
grandes. O galho mais próximo acima de você está fora do seu alcance." CR>
		<COND (<AND <SET F <FIRST? ,PATH>>
			    <NEXT? .F>>
		       <TELL "No chão, lá embaixo, você vê:  ">
		       <PRINT-CONTENTS ,PATH>
		       <TELL "." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,TREE ,ROOMS>>
		       <DO-WALK ,P?DOWN>)
		      (<AND <VERB? CLIMB-UP CLIMB-FOO>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)
		      (<VERB? DROP>
		       <COND (<NOT <IDROP>> <RTRUE>)
			     (<AND <EQUAL? ,PRSO ,NEST> <IN? ,EGG ,NEST>>
			      <TELL
"O ninho cai no chão, e o ovo rola para fora, seriamente
danificado." CR>
			      <REMOVE-CAREFULLY ,EGG>
			      <MOVE ,BROKEN-EGG ,PATH>)
			     (<EQUAL? ,PRSO ,EGG>
			      <TELL
"O ovo cai no chão e se abre, seriamente danificado.">
			      <MOVE ,EGG ,PATH>
			      <BAD-EGG>
			      <CRLF>)
			     (<NOT <EQUAL? ,PRSO ,WINNER ,TREE>>
			      <MOVE ,PRSO ,PATH>
			      <TELL T-CO ,PRSO " ">
			      <PRINT-PLURAL ,PRSO "cai" "caem">
			      <TELL " no chão." CR>)
			     (<VERB? LEAP>
			      <JIGS-UP
			        "Era um pouquinho alto demais.">)>)>)
	       (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)>>

<ROUTINE EGG-OBJECT ()
	 <COND (<AND <VERB? OPEN MUNG> <EQUAL? ,PRSO ,EGG>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "O ovo já está aberto." CR>)
		      (<NOT ,PRSI>
		       <TELL "Você não tem nem as ferramentas nem a habilidade."
			     CR>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "Duvido que você consiga fazer isso sem danificá-lo."
			     CR>)
		      (<OR <FSET? ,PRSI ,WEAPONBIT>
			   <FSET? ,PRSI ,TOOLBIT>
			   <VERB? MUNG>>
		       <TELL
"O ovo agora está aberto, mas a falta de jeito da sua tentativa
comprometeu seriamente o valor estético dele.">
		       <BAD-EGG>
		       <CRLF>)
		      (<FSET? ,PRSO ,FIGHTBIT>
		       <TELL "Não que usar "
			     T-O ,PRSI
			     " também não seja original..." CR>)
		      (T
		       <TELL "A ideia de usar "
			     T-UM ,PRSI
			     " é sem dúvida original." CR>
		       <FSET ,PRSO ,FIGHTBIT>)>)
	       (<VERB? CLIMB-ON HATCH>
		<TELL
"Você ouve um estalo bem nítido embaixo de você e, ao examinar, descobre
que o ovo está aberto e muito danificado.">
		<BAD-EGG>
		<CRLF>)
	       (<VERB? OPEN MUNG THROW>
		<COND (<VERB? THROW> <MOVE ,PRSO ,HERE>)>
		<TELL
"Seu manuseio nada delicado causou alguns danos ao ovo, embora você
tenha conseguido abri-lo.">
		<BAD-EGG>
		<CRLF>)>>

<ROUTINE BAD-EGG ("AUX" L)
	 <COND (<IN? ,CANARY ,EGG>
		<TELL " " <GETP ,BROKEN-CANARY ,P?FDESC>>)
	       (T <REMOVE-CAREFULLY ,BROKEN-CANARY>)>
	 <MOVE ,BROKEN-EGG <LOC ,EGG>>
	 <REMOVE-CAREFULLY ,EGG>
	 <RTRUE>>

<GLOBAL SING-SONG <>>

<ROUTINE CANARY-OBJECT ()
	 <COND (<VERB? WIND>
		<COND (<EQUAL? ,PRSO ,CANARY>
		       <COND (<AND <NOT ,SING-SONG> <FOREST-ROOM?>>
			      <TELL
"O canário gorjeia, um pouco desafinado, uma ária de uma ópera
esquecida. Do meio do verde sai voando um belo pássaro canoro. Ele
pousa num galho bem acima da sua cabeça e abre o bico para cantar. Ao
fazer isso, deixa cair do bico um lindo berloque de latão, que quica no
alto da sua cabeça e vai parar, reluzente, na grama. Quando a corda do
canário acaba, o pássaro canoro vai embora voando." CR>
			     <SETG SING-SONG T>
			     <MOVE ,BAUBLE
				   <COND (<EQUAL? ,HERE ,UP-A-TREE> ,PATH)
					 (T ,HERE)>>)
			    (T
			     <TELL
"O canário gorjeia alegre, ainda que meio metálico, por um tempinho." CR>)>)
		     (T
		      <TELL
"Sai um rangido desagradável de dentro do canário." CR>)>)>>

<ROUTINE FOREST-ROOM? ()
	 <OR <EQUAL? ,HERE ,FOREST-1 ,FOREST-2 ,FOREST-3>
	     <EQUAL? ,HERE ,PATH ,UP-A-TREE>>>

<ROUTINE I-FOREST-ROOM ()
	 <COND (<NOT <FOREST-ROOM?>>
		<DISABLE <INT I-FOREST-ROOM>>
		<RFALSE>)
	       (<PROB 15>
		<TELL
"Você ouve ao longe o gorjeio de um pássaro canoro." CR>)>>

<ROUTINE FOREST-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-FOO CLIMB-UP>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)>)>>

<ROUTINE WCLIF-OBJECT ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "Os penhascos são íngremes demais para escalar." CR>)>>

<ROUTINE CLIFF-OBJECT ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
		 "That would be very unwise. Perhaps even fatal." CR>)
	       (<EQUAL? ,PRSI ,CLIMBABLE-CLIFF>
		<COND (<VERB? PUT THROW-OFF>
		       <TELL
"The " D ,PRSO " tumbles into the river and is seen no more." CR>
		       <REMOVE-CAREFULLY ,PRSO>)>)>>

\

"SUBTITLE CHUTES AND LADDERS"

<ROUTINE ROPE-FUNCTION ("AUX" RLOC)
	 <COND (<NOT <EQUAL? ,HERE ,DOME-ROOM>>
		<SETG DOME-FLAG <>>
		<COND (<VERB? TIE>
		       <TELL "You can't tie the rope to that." CR>)>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,PRSI ,RAILING>
		       <COND (,DOME-FLAG
			      <TELL
			       "The rope is already tied to it." CR>)
			     (T
			      <TELL
"The rope drops over the side and comes within ten feet of the floor." CR>
			      <SETG DOME-FLAG T>
			      <FSET ,ROPE ,NDESCBIT>
			      <SET RLOC <LOC ,ROPE>>
			      <COND (<OR <NOT .RLOC>
					 <NOT <IN? .RLOC ,ROOMS>>>
				     <MOVE ,ROPE ,HERE>)>
			      T)>)>)
	       (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,ROPE ,ROOMS> ,DOME-FLAG>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? TIE-UP>
		     <EQUAL? ,ROPE ,PRSI>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<L? <GETP ,PRSO ,P?STRENGTH> 0>
			      <TELL
"Your attempt to tie up the " D ,PRSO " awakens him.">
			      <AWAKEN ,PRSO>)
			     (T
			      <TELL
"The " D ,PRSO " struggles and you cannot tie him up." CR>)>)
		      (T
		       <TELL "Why would you tie up a " D ,PRSO "?" CR>)>)
	       (<VERB? UNTIE>
		<COND (,DOME-FLAG
		       <SETG DOME-FLAG <>>
		       <FCLEAR ,ROPE ,NDESCBIT>
		       <TELL "The rope is now untied." CR>)
		      (T
		       <TELL "It is not tied to anything." CR>)>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,DOME-ROOM>
		     <NOT ,DOME-FLAG>>
		<MOVE ,ROPE ,TORCH-ROOM>
		<TELL "The rope drops gently to the floor below." CR>)
	       (<VERB? TAKE>
		<COND (,DOME-FLAG
		       <TELL "The rope is tied to the railing." CR>)>)>>

<ROUTINE UNTIE-FROM ()
    <COND (<AND <EQUAL? ,PRSO ,ROPE>
		<AND ,DOME-FLAG <EQUAL? ,PRSI ,RAILING>>>
	   <PERFORM ,V?UNTIE ,PRSO>)
	  (T <TELL "It's not attached to that!" CR>)>>

<ROUTINE SLIDE-FUNCTION ()
	 <COND (<OR <VERB? THROUGH CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<COND (<EQUAL? ,HERE ,CELLAR>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (T
		       <TELL "You tumble down the slide...." CR>
		       <GOTO ,CELLAR>)>)
	       (<VERB? PUT>
		<SLIDER ,PRSO>)>>

<ROUTINE SLIDER (OBJ)
	 <COND (<FSET? .OBJ ,TAKEBIT>
		<TELL "The " D .OBJ " falls into the slide and is gone." CR>
		<COND (<EQUAL? .OBJ ,WATER> <REMOVE-CAREFULLY .OBJ>)
		      (T
		       <MOVE .OBJ ,CELLAR>)>)
	       (T <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE SANDWICH-BAG-FCN ()
	 <COND (<AND <VERB? SMELL>
		     <IN? ,LUNCH ,PRSO>>
		<TELL "Tem cheiro de pimenta." CR>)>>

"MORE RANDOMNESS"

<ROUTINE DEAD-FUNCTION ("OPTIONAL" (FOO <>) "AUX" M)
	 <COND (<VERB? WALK>
		<COND (<AND <EQUAL? ,HERE ,TIMBER-ROOM>
			    <EQUAL? ,PRSO ,P?WEST>>
		       <TELL "You cannot enter in your condition." CR>)>)
	       (<VERB? BRIEF VERBOSE SUPER-BRIEF
		       VERSION ;AGAIN SAVE RESTORE QUIT RESTART>
		<>)
	       (<VERB? ATTACK MUNG ALARM SWING>
		<TELL "All such attacks are vain in your condition." CR>)
	       (<VERB? OPEN CLOSE EAT DRINK
		       INFLATE DEFLATE TURN BURN
		       TIE UNTIE RUB>
		<TELL
"Even such an action is beyond your capabilities." CR>)
	       (<VERB? WAIT>
		<TELL "Might as well. You've got an eternity." CR>)
	       (<VERB? LAMP-ON>
		<TELL "You need no light to guide you." CR>)
	       (<VERB? SCORE>
		<TELL "You're dead! How can you think of your score?" CR>)
	       (<VERB? TAKE RUB>
		<TELL "Your hand passes through its object." CR>)
	       (<VERB? DROP THROW INVENTORY>
		<TELL "You have no possessions." CR>)
	       (<VERB? DIAGNOSE>
		<TELL "You are dead." CR>)
	       (<VERB? LOOK>
		<TELL "The room looks strange and unearthly">
		<COND (<NOT <FIRST? ,HERE>>
		       <TELL ".">)
		      (T
		       <TELL " and objects appear indistinct.">)>
		<CRLF>
		<COND (<NOT <FSET? ,HERE ,ONBIT>>
		       <TELL
"Although there is no light, the room seems dimly illuminated." CR>)>
		<CRLF>
		<>)
	       (<VERB? PRAY>
		<COND (<EQUAL? ,HERE ,SOUTH-TEMPLE>
		       <FCLEAR ,LAMP ,INVISIBLE>
		       <PUTP ,WINNER ,P?ACTION 0>
		       ;<SETG GWIM-DISABLE <>>
		       <SETG ALWAYS-LIT <>>
		       <SETG DEAD <>>
		       <COND (<IN? ,TROLL ,TROLL-ROOM>
			      <SETG TROLL-FLAG <>>)>
		       <TELL
"From the distance the sound of a lone trumpet is heard. The room
becomes very bright and you feel disembodied. In a moment, the
brightness fades and you find yourself rising as if from a long
sleep, deep in the woods. In the distance you can faintly hear a
songbird and the sounds of the forest." CR CR>
		       <GOTO ,FOREST-1>)
		      (T
		       <TELL "Your prayers are not heard." CR>)>)
	       (T
		<TELL "You can't even do that." CR>
		<SETG P-CONT <>>
		<RFATAL>)>>

;"Pseudo-object routines"

<ROUTINE LAKE-PSEUDO ()
	 <COND (,LOW-TIDE
		<TELL "Não sobrou muito lago...." CR>)
	       (<VERB? CROSS>
		<TELL "É largo demais para atravessar." CR>)
	       (<VERB? THROUGH>
		<TELL "Não dá para nadar neste lago." CR>)>>

<ROUTINE STREAM-PSEUDO ()
	 <COND (<VERB? SWIM THROUGH>
		<TELL "Não dá para nadar no riacho." CR>)
	       (<VERB? CROSS>
		<TELL "O outro lado é um paredão de pedra." CR>)>>

<ROUTINE CHASM-PSEUDO ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
"Você olha antes de pular e percebe que nunca sobreviveria." CR>)
	       (<VERB? CROSS>
		<TELL "É longe demais para pular, e não há nenhuma ponte." CR>)
	       (<AND <VERB? PUT THROW-OFF> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL T-CO ,PRSO " ">
		<PRINT-PLURAL ,PRSO "cai no abismo e some" "caem no abismo e somem">
		<TELL " de vista." CR>
		<REMOVE-CAREFULLY ,PRSO>)>>

<ROUTINE DOME-PSEUDO ()
	 <COND (<VERB? KISS>
		<TELL "No." CR>)>>

<ROUTINE GATE-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (T
		<TELL
"The gate is protected by an invisible force. It makes your
teeth ache to touch it." CR>)>>

<ROUTINE DOOR-PSEUDO () ;"in Studio"
	 <COND (<VERB? OPEN CLOSE>
		<TELL "A porta não se mexe." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?SOUTH>)>>

<ROUTINE PAINT-PSEUDO ()
	 <COND (<VERB? MUNG>
		<TELL "Um pouco de tinta descasca e revela mais tinta." CR>)>>

<ROUTINE GAS-PSEUDO ()
	 <COND (<VERB? BREATHE>	;"REALLY BLOW"
		<TELL "There is too much gas to blow away." CR>)
	       (<VERB? SMELL>
		<TELL "It smells like coal gas in here." CR>)>>

"SUBTITLE MELEE"

"melee actions (object functions for villains called with these"

<CONSTANT F-BUSY? 1>		;"busy recovering weapon?"
<CONSTANT F-DEAD 2>		;"mistah kurtz, he dead."
<CONSTANT F-UNCONSCIOUS 3>	;"into dreamland"
<CONSTANT F-CONSCIOUS 4>	;"rise and shine"
<CONSTANT F-FIRST? 5>		;"strike first?"

\

"blow results"

<CONSTANT MISSED 1>		;"attacker misses"
<CONSTANT UNCONSCIOUS 2>	;"defender unconscious"
<CONSTANT KILLED 3>		;"defender dead"
<CONSTANT LIGHT-WOUND 4>	;"defender lightly wounded"
<CONSTANT SERIOUS-WOUND 5>	;"defender seriously wounded"
<CONSTANT STAGGER 6>		;"defender staggered (miss turn)"
<CONSTANT LOSE-WEAPON 7>	;"defender loses weapon"
<CONSTANT HESITATE 8>		;"hesitates (miss on free swing)"
<CONSTANT SITTING-DUCK 9>	;"sitting duck (crunch!)"

"tables of melee results"

<GLOBAL DEF1
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 UNCONSCIOUS UNCONSCIOUS
	 KILLED KILLED KILLED KILLED KILLED>>

<GLOBAL DEF2A
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS>>

<GLOBAL DEF2B
	<TABLE (PURE)
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS
	 KILLED KILLED KILLED>>

<GLOBAL DEF3A
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3B
	<TABLE (PURE)
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3C
	<TABLE (PURE)
	 MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF1-RES
	<TABLE DEF1
	       0 ;<REST ,DEF1 2>
	       0 ;<REST ,DEF1 4>>>

<GLOBAL DEF2-RES
	<TABLE DEF2A
	       DEF2B
	       0; <REST ,DEF2B 2>
	       0; <REST ,DEF2B 4>>>

<GLOBAL DEF3-RES
	<TABLE DEF3A
	       0 ;<REST ,DEF3A 2>
	       DEF3B
	       0 ;<REST ,DEF3B 2>
	       DEF3C>>

\

"useful constants"

<CONSTANT STRENGTH-MAX 7>
<CONSTANT STRENGTH-MIN 2>
<CONSTANT CURE-WAIT 30>

\

"I-FIGHT moved to DEMONS"

<ROUTINE DO-FIGHT (LEN "AUX" CNT RES O OO (OUT <>))
	<REPEAT ()
	      <SET CNT 0>
	      <REPEAT ()
		      <SET CNT <+ .CNT 1>>
		      <COND (<EQUAL? .CNT .LEN>
			     <SET RES T>
			     <RETURN T>)>
		      <SET OO <GET ,VILLAINS .CNT>>
		      <SET O <GET .OO ,V-VILLAIN>>
		      <COND (<NOT <FSET? .O ,FIGHTBIT>>)
			    (<APPLY <GETP .O ,P?ACTION>
				    ,F-BUSY?>)
			    (<NOT <SET RES
				       <VILLAIN-BLOW
					.OO
					.OUT>>>
			     <SET RES <>>
			     <RETURN>)
			    (<EQUAL? .RES ,UNCONSCIOUS>
			     <SET OUT <+ 1 <RANDOM 3>>>)>>
	      <COND (.RES
		     <COND (<NOT .OUT> <RETURN>)
			   (T
			    <SET OUT <- .OUT 1>>
			    <COND (<0? .OUT> <RETURN>)>)>)
		    (T <RETURN>)>>>

\

"takes a remark, defender, and good-guy's weapon"

<ROUTINE REMARK (REMARK D W "AUX" (LEN <GET .REMARK 0>) (CNT 0) STR)
	 <REPEAT ()
	         <COND (<G? <SET CNT <+ .CNT 1>> .LEN> <RETURN>)>
		 <SET STR <GET .REMARK .CNT>>
		 <COND (<EQUAL? .STR ,F-WEP> <PRINTD .W>)
		       (<EQUAL? .STR ,F-DEF> <PRINTD .D>)
		       (<EQUAL? .STR ,F-O-WEP> <TELL T-O .W>)
		       (<EQUAL? .STR ,F-CO-WEP> <TELL T-CO .W>)
		       (<EQUAL? .STR ,F-DO-WEP> <TELL T-DO .W>)
		       (<EQUAL? .STR ,F-SEU-WEP> <TELL T-SEU .W>)
		       (<EQUAL? .STR ,F-CSEU-WEP> <TELL T-CSEU .W>)
		       (<EQUAL? .STR ,F-O-DEF> <TELL T-O .D>)
		       (<EQUAL? .STR ,F-CO-DEF> <TELL T-CO .D>)
		       (<EQUAL? .STR ,F-DO-DEF> <TELL T-DO .D>)
		       (<EQUAL? .STR ,F-NO-DEF> <TELL T-NO .D>)
		       (<EQUAL? .STR ,F-AO-DEF> <TELL T-AO .D>)
		       (T <PRINT .STR>)>>
	 <CRLF>>

"Strength of the player is a basic value (S) adjusted by his P?STRENGTH
property, which is normally 0"

<ROUTINE FIGHT-STRENGTH ("OPTIONAL" (ADJUST? T) "AUX" S)
	 <SET S
	      <+ ,STRENGTH-MIN
		 </ ,SCORE
		    </ ,SCORE-MAX
		       <- ,STRENGTH-MAX ,STRENGTH-MIN>>>>>
	 <COND (.ADJUST? <+ .S <GETP ,WINNER ,P?STRENGTH>>)(T .S)>>

<ROUTINE VILLAIN-STRENGTH (OO
			   "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
			   OD TMP)
	 <SET OD <GETP .VILLAIN ,P?STRENGTH>>
	 <COND (<NOT <L? .OD 0>>
		<COND (<AND <EQUAL? .VILLAIN ,THIEF> ,THIEF-ENGROSSED>
		       <COND (<G? .OD 2> <SET OD 2>)>
		       <SETG THIEF-ENGROSSED <>>)>
		<COND (<AND ,PRSI
			    <FSET? ,PRSI ,WEAPONBIT>
			    <EQUAL? <GET .OO ,V-BEST> ,PRSI>>
		       <SET TMP <- .OD <GET .OO ,V-BEST-ADV>>>
		       <COND (<L? .TMP 1> <SET TMP 1>)>
		       <SET OD .TMP>)>)>
	 .OD>

"find a weapon (if any) in possession of argument"

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<OR <EQUAL? .W ,STILETTO ,AXE ,SWORD>
			    <EQUAL? .W ,KNIFE ,RUSTY-KNIFE>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

\

<ROUTINE VILLAIN-BLOW (OO OUT?
		       "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
		       (REMARKS <GET .OO ,V-MSGS>)
		       DWEAPON ATT DEF OA OD TBL RES NWEAPON)
	 <FCLEAR ,WINNER ,STAGGERED>
	 <COND (<FSET? .VILLAIN ,STAGGERED>
		<TELL T-CO .VILLAIN
		      " se levanta devagar." CR>
		<FCLEAR .VILLAIN ,STAGGERED>
		<RTRUE>)>
	 <SET OA <SET ATT <VILLAIN-STRENGTH .OO>>>
	 <COND (<NOT <G? <SET DEF <FIGHT-STRENGTH>> 0>> <RTRUE>)>
	 <SET OD <FIGHT-STRENGTH <>>>
	 <SET DWEAPON <FIND-WEAPON ,WINNER>>
	 <COND (<L? .DEF 0> <SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER>
			    .DWEAPON
			    <PROB 25 <COND (.HERO? 10)(T 50)>>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET .REMARKS <- .RES 1>>>
		  ,WINNER
		  .DWEAPON>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS>)
	       (<OR <EQUAL? .RES ,KILLED>
		    <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 20>>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,WINNER ,STAGGERED>)
	       (T
		;<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<MOVE .DWEAPON ,HERE>
		<COND (<SET NWEAPON <FIND-WEAPON ,WINNER>>
		       <TELL
"Por sorte, você ainda tem " T-UM .NWEAPON "." CR>)>)>
	 <WINNER-RESULT .DEF .RES .OD>>

<ROUTINE HERO-BLOW ("AUX" OO VILLAIN (OUT? <>) DWEAPON ATT DEF (CNT 0)
		    OA OD TBL RES NWEAPON (LEN <GET ,VILLAINS 0>))
	 <REPEAT ()
		 <SET CNT <+ .CNT 1>>
		 <COND (<EQUAL? .CNT .LEN> <RETURN>)>
		 <SET OO <GET ,VILLAINS .CNT>>
		 <COND (<EQUAL? <GET .OO ,V-VILLAIN> ,PRSO>
			<RETURN>)>>
	 <FSET ,PRSO ,FIGHTBIT>
	 <COND (<FSET? ,WINNER ,STAGGERED>
		<TELL
"Você ainda está se recuperando do último golpe, então o seu ataque não
surte efeito." CR>
		<FCLEAR ,WINNER ,STAGGERED>
		<RTRUE>)>
	 <SET ATT <FIGHT-STRENGTH>>
	 <COND (<L? .ATT 1> <SET ATT 1>)>
	 <SET OA .ATT>
	 <SET VILLAIN <GET .OO ,V-VILLAIN>>
	 <COND (<0? <SET OD <SET DEF <VILLAIN-STRENGTH .OO>>>>
		<COND (<EQUAL? ,PRSO ,WINNER>
		       <RETURN <JIGS-UP
"Pois é, dessa vez você conseguiu. Será que o suicídio é indolor?">>)>
		<TELL "Atacar " T-O .VILLAIN " não adianta nada." CR>
		<RTRUE>)>
	 <SET DWEAPON <FIND-WEAPON .VILLAIN>>
	 <COND (<OR <NOT .DWEAPON> <L? .DEF 0>>
		;"PT: o adjetivo vem depois do nome (o troll desarmado)"
		<TELL T-CO .VILLAIN>
		<COND (<L? .DEF 0> <TELL " inconsciente">)
		      (T <TELL " desarmad" T-G .VILLAIN>)>
		<TELL " não consegue se defender: " T-ELE .VILLAIN
		      " morre." CR>
		<SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER> .DWEAPON <PROB 25>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET ,HERO-MELEE <- .RES 1>>>
		  ,PRSO
		  ,PRSI>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS> <SET DEF <- .DEF>>)
	       (<OR <EQUAL? .RES ,KILLED> <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,PRSO ,STAGGERED>)
	       (T
		;<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<FCLEAR .DWEAPON ,NDESCBIT>
		<FSET .DWEAPON ,WEAPONBIT>
		<MOVE .DWEAPON ,HERE>
		<THIS-IS-IT .DWEAPON>)>
	 <VILLAIN-RESULT ,PRSO .DEF .RES>>

\

<ROUTINE WINNER-RESULT (DEF RES OD)
	 <PUTP ,WINNER
	       ,P?STRENGTH
	       <COND (<0? .DEF> -10000)(T <- .DEF .OD>)>>
	 <COND (<L? <- .DEF .OD> 0>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)>
	 <COND (<NOT <G? <FIGHT-STRENGTH> 0>>
		<PUTP ,WINNER ,P?STRENGTH <+ 1 <- <FIGHT-STRENGTH <>>>>>
		<JIGS-UP
"Parece que esse último golpe foi demais para você. Receio que você
esteja morto.">
		<>)
	       (T .RES)>>

<ROUTINE VILLAIN-RESULT (VILLAIN DEF RES)
	 <PUTP .VILLAIN ,P?STRENGTH .DEF>
	 <COND (<0? .DEF>
		<FCLEAR .VILLAIN ,FIGHTBIT>
		<TELL
"Quase no mesmo instante em que " T-O .VILLAIN " dá o último suspiro, uma
nuvem de névoa negra e sinistra " T-G .VILLAIN " envolve e, quando a névoa
se dissipa, a carcaça já desapareceu." CR>
		<REMOVE-CAREFULLY .VILLAIN>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-DEAD>
		.RES)
	       (<EQUAL? .RES ,UNCONSCIOUS>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-UNCONSCIOUS>
		.RES)
	       (T .RES)>>

\

<ROUTINE WINNING? (V "AUX" VS PS)
	 <SET VS <GETP .V ,P?STRENGTH>>
	 <SET PS <- .VS <FIGHT-STRENGTH>>>
	 <COND (<G? .PS 3> <PROB 90>)
	       (<G? .PS 0> <PROB 75>)
	       (<0? .PS> <PROB 50>)
	       (<G? .VS 1> <PROB 25>)
	       (T <PROB 10>)>>

<ROUTINE I-CURE ("AUX" (S <GETP ,WINNER ,P?STRENGTH>))
	 <COND (<G? .S 0> <SET S 0> <PUTP ,WINNER ,P?STRENGTH .S>)
	       (<L? .S 0> <SET S <+ .S 1>> <PUTP ,WINNER ,P?STRENGTH .S>)>
	 <COND (<L? .S 0>
		<COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
		       <SETG LOAD-ALLOWED <+ ,LOAD-ALLOWED 10>>)>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)
	       (T
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<DISABLE <INT I-CURE>>)>>

"FIGHTS"

"messages for winner"

<CONSTANT F-WEP 0>	;"means print weapon name"
<CONSTANT F-DEF 1>	;"means print defender name (villain, e.g.)"

;"PT: a arma e o defensor com artigo, contração ou possessivo, para a
  concordância (ver REMARK): F-SEU-WEP escreve sua espada ou seu estilete,
  F-DO-DEF escreve do troll."
<CONSTANT F-O-WEP 2>	;"a espada"
<CONSTANT F-CO-WEP 3>	;"A espada"
<CONSTANT F-DO-WEP 4>	;"da espada"
<CONSTANT F-SEU-WEP 5>	;"sua espada"
<CONSTANT F-CSEU-WEP 6>	;"Sua espada"
<CONSTANT F-O-DEF 7>	;"o troll"
<CONSTANT F-CO-DEF 8>	;"O troll"
<CONSTANT F-DO-DEF 9>	;"do troll"
<CONSTANT F-NO-DEF 10>	;"no troll"
<CONSTANT F-AO-DEF 11>	;"ao troll"

<GLOBAL HERO-MELEE
 <TABLE (PURE)
  <LTABLE (PURE)
   <LTABLE (PURE) F-CSEU-WEP " erra " F-O-DEF " por um triz.">
   <LTABLE (PURE) "Um belo golpe, mas passa a um quilômetro " F-DO-DEF ".">
   <LTABLE (PURE) "Você avança, mas " F-O-DEF " salta agilmente para o lado.">
   <LTABLE (PURE) "Clang! Crás! " F-CO-DEF " apara o golpe.">
   <LTABLE (PURE) "Um golpe rápido, mas " F-O-DEF " está em guarda.">
   <LTABLE (PURE) "Um bom golpe, mas lento demais; " F-O-DEF " se esquiva.">>
  <LTABLE (PURE)
   <LTABLE (PURE) F-CSEU-WEP " desce com tudo e manda " F-O-DEF " para o mundo dos sonhos.">
   <LTABLE (PURE) F-CO-DEF " apanha até perder os sentidos.">
   <LTABLE (PURE) "Uma troca furiosa de golpes, e " F-O-DEF " vai a nocaute!">
   <LTABLE (PURE) "O cabo " F-DO-WEP " acerta " F-O-DEF " e o deixa desacordado.">
   <LTABLE (PURE) F-CO-DEF " está fora de combate!">>
  <LTABLE (PURE)
   <LTABLE (PURE) "É o fim da linha para " F-O-DEF ": " F-SEU-WEP " arranca a cabeça dele.">
   <LTABLE (PURE) "O golpe fatal atinge " F-O-DEF " bem no coração: ele morre.">
   <LTABLE (PURE) F-CO-DEF " leva um golpe fatal e desaba morto no chão.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Um golpe acerta o braço " F-DO-DEF "; o sangue começa a escorrer.">
   <LTABLE (PURE) F-CSEU-WEP " fere de leve o pulso " F-DO-DEF ", mas não é nada grave.">
   <LTABLE (PURE) "Seu golpe acerta, mas só com o lado chato da lâmina.">
   <LTABLE (PURE) "O golpe acerta e abre um corte raso no braço " F-DO-DEF "!">>
  <LTABLE (PURE)
   <LTABLE (PURE) F-CO-DEF " leva um corte profundo no flanco.">
   <LTABLE (PURE) "Um golpe selvagem na coxa! " F-CO-DEF " fica atordoado, mas ainda pode lutar!">
   <LTABLE (PURE) "Zás! Seu golpe acerta! Esse pegou uma artéria, pode ser grave!">
   <LTABLE (PURE) "Zás! Seu golpe atinge o alvo! Isso pode ser grave!">>
  <LTABLE (PURE)
   <LTABLE (PURE) F-CO-DEF " cambaleia e cai de joelhos.">
   <LTABLE (PURE) F-CO-DEF " fica desorientado por um momento e não consegue revidar.">
   <LTABLE (PURE) "A força do seu golpe joga " F-O-DEF " para trás, atordoado.">
   <LTABLE (PURE) F-CO-DEF " fica confuso e não consegue revidar.">
   <LTABLE (PURE) "A rapidez da sua estocada joga " F-O-DEF " para trás, atordoado.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "A arma " F-DO-DEF " vai ao chão, e ele fica desarmado.">
   <LTABLE (PURE) "Uma finta sutil passa pela guarda " F-DO-DEF " e o desarma.">>>>

\

"messages for cyclops (note that he has no weapon"

<GLOBAL CYCLOPS-MELEE
 <TABLE (PURE)
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops misses, but the backwash almost knocks you over.">
   <LTABLE (PURE) "The Cyclops rushes you, but runs into the wall.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops sends you crashing to the floor, unconscious.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops breaks your neck with a massive smash.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "A quick punch, but it was only a glancing blow.">
   <LTABLE (PURE) "A glancing blow from the Cyclops' fist.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The monster smashes his huge fist into your chest, breaking several
ribs.">
   <LTABLE (PURE) "The Cyclops almost knocks the wind out of you with a quick punch.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops lands a punch that knocks the wind out of you.">
   <LTABLE (PURE) "Heedless of your weapons, the Cyclops tosses you against the rock
wall of the room.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops grabs your " F-WEP ", tastes it, and throws it to the
ground in disgust.">
   <LTABLE (PURE) "The monster grabs you on the wrist, squeezes, and you drop your
" F-WEP " in pain.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops seems unable to decide whether to broil or stew his
dinner.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops, no sportsman, dispatches his unconscious victim.">>>>

\

"messages for troll"

<GLOBAL TROLL-MELEE
<TABLE (PURE)
 <LTABLE (PURE)
  <LTABLE (PURE) "O troll brande o machado, mas erra.">
  <LTABLE (PURE) "O machado do troll passa raspando pela sua orelha.">
  <LTABLE (PURE) "O machado passa zunindo enquanto você salta para o lado.">
  <LTABLE (PURE) "O machado se choca contra a rocha e solta faíscas!">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O troll acerta você delicadamente na cabeça com o lado chato do
machado, e você desmaia.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O troll arranca a sua cabeça com toda a precisão.">
  <LTABLE (PURE) "A machadada do troll abre você do umbigo ao queixo.">
  <LTABLE (PURE) "O machado do troll arranca a sua cabeça.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O machado pega você bem no flanco. Ai!">
  <LTABLE (PURE) "O lado chato do machado do troll esfola o seu antebraço.">
  <LTABLE (PURE) "O golpe do troll quase derruba você, que mal consegue aparar a
tempo.">
  <LTABLE (PURE) "O troll brande o machado, que arranha o seu braço enquanto você se
esquiva.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O troll avança, e o machado dele corta o braço com que você segura " F-O-WEP ".">
  <LTABLE (PURE) "Uma machadada abre um ferimento profundo na sua perna.">
  <LTABLE (PURE) "O machado do troll desce e rasga o seu ombro.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O troll acerta você de raspão, e você fica atordoado por um
momento.">
  <LTABLE (PURE) "O troll golpeia; a lâmina resvala na sua armadura, mas bate de
chapa na sua cabeça.">
  <LTABLE (PURE) "Você cambaleia para trás sob uma chuva de machadadas.">
  <LTABLE (PURE) "O golpe poderoso do troll põe você de joelhos.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O machado acerta " F-SEU-WEP ", que sai girando pelo ar.">
  <LTABLE (PURE) "O troll golpeia, você apara, mas a força do golpe joga " F-SEU-WEP " longe.">
  <LTABLE (PURE) "O machado faz " F-SEU-WEP " voar da mão e cair no chão.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "O troll hesita, alisando o machado.">
  <LTABLE (PURE) "O troll coça a cabeça, pensativo: será que você tem alguma
proteção mágica, ele se pergunta?">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Vencendo o medo, o troll acaba com você.">>>>

\

"messages for thief"

<GLOBAL THIEF-MELEE
<TABLE (PURE)
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief stabs nonchalantly with his stiletto and misses.">
  <LTABLE (PURE) "You dodge as the thief comes in low.">
  <LTABLE (PURE) "You parry a lightning thrust, and the thief salutes you with
a grim nod.">
  <LTABLE (PURE) "The thief tries to sneak past your guard, but you twist away.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Shifting in the midst of a thrust, the thief knocks you unconscious
with the haft of his stiletto.">
  <LTABLE (PURE) "The thief knocks you out.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Finishing you off, the thief inserts his blade into your heart.">
  <LTABLE (PURE) "The thief comes in from the side, feints, and inserts the blade
into your ribs.">
  <LTABLE (PURE) "The thief bows formally, raises his stiletto, and with a wry grin,
ends the battle and your life.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "A quick thrust pinks your left arm, and blood starts to
trickle down.">
  <LTABLE (PURE) "The thief draws blood, raking his stiletto across your arm.">
  <LTABLE (PURE) "The stiletto flashes faster than you can follow, and blood wells
from your leg.">
  <LTABLE (PURE) "The thief slowly approaches, strikes like a snake, and leaves
you wounded.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief strikes like a snake! The resulting wound is serious.">
  <LTABLE (PURE) "The thief stabs a deep cut in your upper arm.">
  <LTABLE (PURE) "The stiletto touches your forehead, and the blood obscures your
vision.">
  <LTABLE (PURE) "The thief strikes at your wrist, and suddenly your grip is slippery
with blood.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The butt of his stiletto cracks you on the skull, and you stagger
back.">
  <LTABLE (PURE) "The thief rams the haft of his blade into your stomach, leaving
you out of breath.">
  <LTABLE (PURE) "The thief attacks, and you fall back desperately.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "A long, theatrical slash. You catch it on your " F-WEP ", but the
thief twists his knife, and the " F-WEP " goes flying.">
  <LTABLE (PURE) "The thief neatly flips your " F-WEP " out of your hands, and it drops
to the floor.">
  <LTABLE (PURE) "You parry a low thrust, and your " F-WEP " slips out of your hand.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off.">
  <LTABLE (PURE) "The thief amuses himself by searching your pockets.">
  <LTABLE (PURE) "The thief entertains himself by rifling your pack.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief, forgetting his essentially genteel upbringing, cuts your
throat.">
  <LTABLE (PURE) "The thief, a pragmatist, dispatches you as a threat to his
livelihood.">>>>


"each table entry is:"

<CONSTANT V-VILLAIN 0>	;"villain"
<CONSTANT V-BEST 1>	;"best weapon"
<CONSTANT V-BEST-ADV 2>	;"advantage it confers"
<CONSTANT V-PROB 3>	;"prob of waking if unconscious"
<CONSTANT V-MSGS 4>	;"messages for that villain"

"This table must be after TROLL-MELEE, THIEF-MELEE, CYCLOPS-MELEE defined!"

<GLOBAL VILLAINS
	<LTABLE <TABLE TROLL SWORD 1 0 TROLL-MELEE>
		<TABLE THIEF KNIFE 1 0 THIEF-MELEE>
		<TABLE CYCLOPS <> 0 0 CYCLOPS-MELEE>>>

"DEMONS"

"Fighting demon"

<ROUTINE I-FIGHT ("AUX" (FIGHT? <>) (LEN <GET ,VILLAINS 0>)
		  CNT OO O P)
      <COND (,DEAD <RFALSE>)>
      <SET CNT 0>
      <REPEAT ()
	      <SET CNT <+ .CNT 1>>
	      <COND (<EQUAL? .CNT .LEN> <RETURN>)>
	      <SET OO <GET ,VILLAINS .CNT>>
	      <COND (<AND <IN? <SET O <GET .OO ,V-VILLAIN>> ,HERE>
			  <NOT <FSET? .O ,INVISIBLE>>>
		     <COND (<AND <EQUAL? .O ,THIEF> ,THIEF-ENGROSSED>
			    <SETG THIEF-ENGROSSED <>>)
			   (<L? <GETP .O ,P?STRENGTH> 0>
			    <SET P <GET .OO ,V-PROB>>
			    <COND (<AND <NOT <0? .P>> <PROB .P>>
				   <PUT .OO ,V-PROB 0>
				   <AWAKEN .O>)
				  (T
				   <PUT .OO ,V-PROB <+ .P 25>>)>)
			   (<OR <FSET? .O ,FIGHTBIT>
				<APPLY <GETP .O ,P?ACTION> ,F-FIRST?>>
			    <SET FIGHT? T>)>)
		    (T
		     <COND (<FSET? .O ,FIGHTBIT>
			    <APPLY <GETP .O ,P?ACTION> ,F-BUSY?>)>
		     <COND (<EQUAL? .O ,THIEF> <SETG THIEF-ENGROSSED <>>)>
		     <FCLEAR ,WINNER ,STAGGERED>
		     <FCLEAR .O ,STAGGERED>
		     <FCLEAR .O ,FIGHTBIT>
		     <AWAKEN .O>)>>
      <COND (<NOT .FIGHT?> <RFALSE>)>
      <DO-FIGHT .LEN>>

<ROUTINE AWAKEN (O "AUX" (S <GETP .O ,P?STRENGTH>))
	 <COND (<L? .S 0>
		<PUTP .O ,P?STRENGTH <- 0 .S>>
		<APPLY <GETP .O ,P?ACTION> ,F-CONSCIOUS>)>
	 T>

"SWORD demon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (G <GETP ,SWORD ,P?TVALUE>)
		        (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<INFESTED? ,HERE> <SET NG 2>)
		      (T
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET T <GETPT ,HERE .P>>
				      <SET L <PTSIZE .T>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GET .T ,REXIT>> ;"V5"
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<EQUAL? .NG .G> <RFALSE>)
		      (<EQUAL? .NG 2>
		       <TELL "Sua espada começou a brilhar intensamente." CR>)
		      (<1? .NG>
		       <TELL "Sua espada emite um fraco brilho azulado."
			     CR>)
		      (<0? .NG>
		       <TELL "Sua espada parou de brilhar." CR>)>
		<PUTP ,SWORD ,P?TVALUE .NG>
		<RTRUE>)
	       (T
		<PUT .DEM ,C-ENABLED? 0>
		<RFALSE>)>>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <FSET? .F ,ACTORBIT> <NOT <FSET? .F ,INVISIBLE>>>
			<RTRUE>)
		       (<NOT <SET F <NEXT? .F>>> <RFALSE>)>>>

"THIEF demon"

<ROUTINE I-THIEF ("AUX" (RM <LOC ,THIEF>) ROBJ HERE? (ONCE <>) (FLG <>))
   <PROG ()
     <COND (<SET HERE? <NOT <FSET? ,THIEF ,INVISIBLE>>>
	    <SET RM <LOC ,THIEF>>)>
     <COND
      (<AND <EQUAL? .RM ,TREASURE-ROOM> <NOT <EQUAL? .RM ,HERE>>>
       <COND (.HERE? <HACK-TREASURES> <SET HERE? <>>)>
       <DEPOSIT-BOOTY ,TREASURE-ROOM> ;"silent")
      (<AND <EQUAL? .RM ,HERE>
	    <NOT <FSET? .RM ,ONBIT>>
	    <NOT <IN? ,TROLL ,HERE>>>
       <COND (<THIEF-VS-ADVENTURER .HERE?> <RTRUE>)>
       <COND (<FSET? ,THIEF ,INVISIBLE> <SET HERE? <>>)>)
      (T
       <COND (<AND <IN? ,THIEF .RM>
		   <NOT <FSET? ,THIEF ,INVISIBLE>>> ;"Leave if victim left"
	      <FSET ,THIEF ,INVISIBLE>
	      <SET HERE? <>>)>
       <COND (<FSET? .RM ,TOUCHBIT>     ;"Hack the adventurer's belongings"
	      <ROB .RM ,THIEF 75>
	      <SET FLG
		   <COND (<AND <FSET? .RM ,MAZEBIT>
			       <FSET? ,HERE ,MAZEBIT>>
			  <ROB-MAZE .RM>)
			 (T <STEAL-JUNK .RM>)>>)>)>
     <COND (<AND <SET ONCE <NOT .ONCE>> <NOT .HERE?>>
					   ;"Move to next room, and hack."
	    <RECOVER-STILETTO>
	    <REPEAT ()
		    <COND (<AND .RM <SET RM <NEXT? .RM>>>)
			  (T <SET RM <FIRST? ,ROOMS>>)>
		    <COND (<AND <NOT <FSET? .RM ,SACREDBIT>>
				<FSET? .RM ,RLANDBIT>>
			   <MOVE ,THIEF .RM>
			   <FCLEAR ,THIEF ,FIGHTBIT>
			   <FSET ,THIEF ,INVISIBLE>
			   <SETG THIEF-HERE <>>
			   <RETURN>)>>
	    <AGAIN>)>>
   <COND (<NOT <EQUAL? .RM ,TREASURE-ROOM>>
	  <DROP-JUNK .RM>)>
   .FLG>

<ROUTINE DROP-JUNK (RM "AUX" X N (FLG <>))
	 <SET X <FIRST? ,THIEF>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .FLG>)>
		 <SET N <NEXT? .X>>
		 <COND (<EQUAL? .X ,STILETTO ,LARGE-BAG>)
		       (<AND <0? <GETP .X ,P?TVALUE>> <PROB 30 T>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .RM>
			<COND (<AND <NOT .FLG> <EQUAL? .RM ,HERE>>
			       <TELL
"The robber, rummaging through his bag, dropped a few items he found
valueless." CR>
			       <SET FLG T>)>)>
		 <SET X .N>>>

<ROUTINE RECOVER-STILETTO ()
	 <COND (<IN? ,STILETTO <LOC ,THIEF>>
		<FSET ,STILETTO ,NDESCBIT>
		<MOVE ,STILETTO ,THIEF>)>>

<ROUTINE STEAL-JUNK (RM "AUX" X N)
	 <SET X <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RFALSE>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <0? <GETP .X ,P?TVALUE>>
			     <FSET? .X ,TAKEBIT>
			     <NOT <FSET? .X ,SACREDBIT>>
			     <NOT <FSET? .X ,INVISIBLE>>
			     <OR <EQUAL? .X ,STILETTO>
				 <PROB 10 T>>>
			<MOVE .X ,THIEF>
			<FSET .X ,TOUCHBIT>
			<FSET .X ,INVISIBLE>
			<COND (<EQUAL? .X ,ROPE> <SETG DOME-FLAG <>>)>
			<COND (<EQUAL? .RM ,HERE>
			       <TELL "You suddenly notice that the "
				     D .X " vanished." CR>
			       <RTRUE>)
			      (ELSE <RFALSE>)>)>
		 <SET X .N>>>

<ROUTINE ROB (WHAT WHERE "OPTIONAL" (PROB <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHAT>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
			     <NOT <FSET? .X ,SACREDBIT>>
			     <G? <GETP .X ,P?TVALUE> 0>
			     <OR <NOT .PROB> <PROB .PROB>>>
			<MOVE .X .WHERE>
			<FSET .X ,TOUCHBIT>
			<COND (<EQUAL? .WHERE ,THIEF> <FSET .X ,INVISIBLE>)>
			<SET ROBBED? T>)>
		 <SET X .N>>>

;"special-cased routines"

<ROUTINE V-DIAGNOSE ("AUX" (MS <FIGHT-STRENGTH <>>)
		     (WD <GETP ,WINNER ,P?STRENGTH>) (RS <+ .MS .WD>))
	 #DECL ((MS WD RS) FIX)
	 <COND (<0? <GET <INT I-CURE> ,C-ENABLED?>> <SET WD 0>)
	       (ELSE <SET WD <- .WD>>)>
	 <COND (<0? .WD> <TELL "Você está em perfeita saúde.">)
	       (T
		<TELL "Você tem ">
		;"PT: o verbo (vai, vão) concorda com o ferimento"
		<COND (<1? .WD> <TELL "um ferimento leve, que vai">)
		      (<EQUAL? .WD 2> <TELL "um ferimento grave, que vai">)
		      (<EQUAL? .WD 3> <TELL "vários ferimentos, que vão">)
		      (<G? .WD 3> <TELL "ferimentos graves, que vão">)>)>
	 <COND (<NOT <0? .WD>>
		<TELL " sarar daqui a ">
		<PRINTN
		 <+ <* ,CURE-WAIT <- .WD 1>>
		    <GET <INT I-CURE> ,C-TICK>>>
		<TELL " jogadas.">)>
	 <CRLF>
	 <TELL "Você ">
	 <COND (<0? .RS> <TELL "pode esperar a morte em breve">)
	       (<1? .RS> <TELL "pode morrer com mais um ferimento leve">)
	       (<EQUAL? .RS 2> <TELL "pode morrer com um ferimento grave">)
	       (<EQUAL? .RS 3> <TELL "aguenta um ferimento grave">)
	       (<G? .RS 3>
		<TELL "aguenta vários ferimentos">)>
	 <TELL "." CR>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "Você já morreu ">
		<COND (<1? ,DEATHS> <TELL "uma vez">)
		      (T <TELL "duas vezes">)>
		<TELL "." CR>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Sua pontuação é ">
	 <TELL N ,SCORE>
	 <TELL " (de um total de 350 pontos), em ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " jogada.">) (ELSE <TELL " jogadas.">)>
	 <CRLF>
	 <TELL "Isso lhe dá o título de ">
	 <COND (<EQUAL? ,SCORE 350> <TELL "Mestre Aventureiro">)
	       (<G? ,SCORE 330> <TELL "Mago">)
	       (<G? ,SCORE 300> <TELL "Mestre">)
	       (<G? ,SCORE 200> <TELL "Aventureiro">)
	       (<G? ,SCORE 100> <TELL "Aventureiro Júnior">)
	       (<G? ,SCORE 50> <TELL "Aventureiro Novato">)
	       (<G? ,SCORE 25> <TELL "Aventureiro Amador">)
	       (T <TELL "Iniciante">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 <SETG WINNER ,ADVENTURER>
	 <COND (,DEAD
		<TELL "|
É preciso muito talento para morrer quando já se está morto. VOCÊ tem esse
talento. Infelizmente, é preciso muito talento para dar um jeito nisso. E eu
não tenho esse talento. Desculpe." CR>
		<FINISH>)>
	 <TELL .DESC CR>
	 <COND (<NOT ,LUCKY>
		<TELL "Que azar, hein?" CR>)>
	 <PROG ()
	       <SCORE-UPD -10>
	       <TELL "
|    ****  Você morreu  ****
|
|">
	       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		      <MOVE ,WINNER ,HERE>)>
	       <COND
		(<NOT <L? ,DEATHS 2>>
		 <TELL
"Está claro que você tem uma mania suicida. Não permitimos psicóticos na
caverna, porque eles podem fazer mal a outros aventureiros. Os seus restos
serão instalados na Terra dos Mortos-Vivos, onde os seus colegas aventureiros
poderão se divertir à custa deles." CR>
		 <FINISH>)
		(T
		 <SETG DEATHS <+ ,DEATHS 1>>
		 <MOVE ,WINNER ,HERE>
		 <COND (<FSET? ,SOUTH-TEMPLE ,TOUCHBIT>
			<TELL
"Ao dar o último suspiro, você se sente livre dos seus fardos. A sensação
passa quando você se vê diante dos portões do Inferno, onde os espíritos
zombam de você e lhe negam a entrada. Os seus sentidos estão perturbados.
Os objetos da masmorra parecem indistintos, desbotados, até irreais." CR CR>
			<SETG DEAD T>
			<SETG TROLL-FLAG T>
			;<SETG GWIM-DISABLE T>
			<SETG ALWAYS-LIT T>
			<PUTP ,WINNER ,P?ACTION DEAD-FUNCTION>
			<GOTO ,ENTRANCE-TO-HADES>)
		       (T
			<TELL
"Bem, vamos dar uma olhada aqui...
É, você provavelmente merece outra chance. Não consigo consertar você por
completo, mas não dá para ter tudo." CR CR>
			<GOTO ,FOREST-1>)>
		 <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		 <SETG P-CONT <>>
		 <RANDOMIZE-OBJECTS>
		 <KILL-INTERRUPTS>
		 <RFATAL>)>>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <COND (<IN? ,LAMP ,WINNER>
		<MOVE ,LAMP ,LIVING-ROOM>)>
	 <COND (<IN? ,COFFIN ,WINNER>
		<MOVE ,COFFIN ,EGYPT-ROOM>)>
	 <PUTP ,SWORD ,P?TVALUE 0>
	 <SET N <FIRST? ,WINNER>>
	 <SET L <GET ,ABOVE-GROUND 0>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<G? <GETP .F ,P?TVALUE> 0>
			<REPEAT ()
				<COND (<NOT .R> <SET R <FIRST? ,ROOMS>>)>
				<COND (<AND <FSET? .R ,RLANDBIT>
					    <NOT <FSET? .R ,ONBIT>>
					    <PROB 50>>
				       <MOVE .F .R>
				       <RETURN>)
				      (ELSE <SET R <NEXT? .R>>)>>)
		       (ELSE
			<MOVE .F <GET ,ABOVE-GROUND <RANDOM .L>>>)>>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-XB>>
	 <DISABLE <INT I-XC>>
	 <DISABLE <INT I-CYCLOPS>>
	 <DISABLE <INT I-LANTERN>>
	 <DISABLE <INT I-CANDLES>>
	 <DISABLE <INT I-SWORD>>
	 <DISABLE <INT I-FOREST-ROOM>>
	 <DISABLE <INT I-MATCH>>
	 <FCLEAR ,MATCH ,ONBIT>
	 <RTRUE>>

<ROUTINE BAG-OF-COINS-F ()
	 <STUPID-CONTAINER ,BAG-OF-COINS "coins">>

<ROUTINE TRUNK-F ()
	 <STUPID-CONTAINER ,TRUNK "joias">>

<ROUTINE STUPID-CONTAINER (OBJ STR)
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"The " .STR " are safely inside; there's no need to do that." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"There are lots of " .STR " in there." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI .OBJ>>
		<TELL
"Don't be silly. It wouldn't be a " D .OBJ " anymore." CR>)>>

<ROUTINE DUMB-CONTAINER ()
	 <COND (<VERB? OPEN CLOSE LOOK-INSIDE>
		<TELL "You can't do that." CR>)
	       (<VERB? EXAMINE>
		<TELL "It looks pretty much like a " D ,PRSO "." CR>)>>

<ROUTINE GARLIC-F ()
	 <COND (<VERB? EAT>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL
"Ah, que se dane! Assim você não vai fazer amigos, mas ninguém por aqui
é muito simpático mesmo. Glup!" CR>)>>

<ROUTINE CHAIN-PSEUDO ()
	 <COND (<VERB? TAKE MOVE>
		<TELL "The chain is secure." CR>)
	       (<VERB? RAISE LOWER>
		<TELL "Perhaps you should do that to the basket." CR>)
	       (<VERB? EXAMINE>
		<TELL "The chain secures a basket within the shaft." CR>)>> 

<ROUTINE TROLL-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,TROLL ,HERE>>
		<THIS-IS-IT ,TROLL>)>>