			"Generic GLOBALS file for
			    The ZORK Trilogy
		       started on 7/28/83 by MARC"

"SUBTITLE GLOBAL OBJECTS"

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT
	       OPENBIT SEARCHBIT TRANSBIT ONBIT RLANDBIT FIGHTBIT
	       STAGGERED WEARBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(DESCFCN PATH-OBJECT)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "F")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(VTYPE 1)
	(SIZE 0)
	(CAPACITY 0)>

;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(FLAGS TOOLBIT)
	(DESC "número")>

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudoobj") ;"V5: 9 letras = 3 palavras, ver GLOBAL-CHECK"
	(ACTION CRETIN-FCN)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM HER HIM)
	(DESC "objeto qualquer")
	(FLAGS NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "coisa dessas" ;"[not here]")
	(FLAGS FEMBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Essas coisas não estão aqui!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 ;"Here is the default 'cant see any' printer"
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "Você não vê ">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " aqui!" CR>)
	       (T
		<TELL T-CO ,WINNER " parece confus" T-G ,WINNER ". \"Não vejo ">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " aqui!\"" CR>)>
	 <RTRUE>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (,P-OFLAG
	<COND (,P-XADJ <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM <PRINTB ,P-XNAM>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> T>) ;"PT: com o artigo digitado"
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> T>)>>

<ROUTINE NULL-F ("OPTIONAL" A1 A2)
	 <RFALSE>>

/^L

"Objects shared by all three Zorks go here"

<GLOBAL LOAD-MAX 100>

<GLOBAL LOAD-ALLOWED 100>

<OBJECT BLESSINGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM BLESSINGS GRACES BENCAOS BENCAO GRACAS)
	(DESC "bênçãos")
	(FLAGS NDESCBIT FEMBIT PLURALBIT)>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS STAIRCASE STAIRWAY ESCADA ESCADAS DEGRAUS ESCADARIA)
	(ADJECTIVE STONE DARK MARBLE FORBIDDING STEEP PEDRA ESCURA MARMORE INGREME)
	(DESC "escada")
	(FLAGS NDESCBIT CLIMBBIT FEMBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? THROUGH>
		<TELL
"Diga se você quer subir ou descer." CR>)>>

<OBJECT SAILOR
	(IN GLOBAL-OBJECTS)
	(SYNONYM SAILOR FOOTPAD AVIATOR MARINHEIR)
	(DESC "marinheiro")
	(FLAGS NDESCBIT)
	(ACTION SAILOR-FCN)>

<ROUTINE SAILOR-FCN ()
	  <COND (<VERB? TELL>
		 <SETG P-CONT <>>
		 <SETG QUOTE-FLAG <>>
		 <TELL "Não dá para falar com o marinheiro desse jeito." CR>)
		(<VERB? EXAMINE>
		 %<COND (<==? ,ZORK-NUMBER 3>
			 '<COND (<NOT <FSET? ,VIKING-SHIP ,INVISIBLE>>
				 <TELL
"Ele tem cara de marinheiro." CR>
				 <RTRUE>)>)
			(ELSE T)>
		 <TELL
"Não há marinheiro nenhum à vista." CR>)
		(<VERB? HELLO>
		 <SETG HS <+ ,HS 1>>
		 %<COND (<==? ,ZORK-NUMBER 3>
			 '<COND (<NOT <FSET? ,VIKING-SHIP ,INVISIBLE>>
		                 <TELL
"O marujo levanta os olhos e manobra o barco em direção à praia. Ele grita:
\"Esperei três eras por alguém que dissesse essas palavras e me salvasse de
navegar por este oceano sem fim. Por favor, aceite este presente. Talvez ele
lhe seja útil!\" Ele joga algo que cai perto de você na areia e depois parte
navegando para o oeste, cantando uma canção de marinheiro animada, mas um
tanto grosseira." CR>
		                 <FSET ,VIKING-SHIP ,INVISIBLE>
		                 <MOVE ,VIAL ,HERE>)
		                (<==? ,HERE ,FLATHEAD-OCEAN>
		                 <COND (,SHIP-GONE
			                <TELL "Nada mais acontece." CR>)
			               (T
				        <TELL "Nada acontece ainda." CR>)>)
				(T <TELL "Nada acontece aqui." CR>)>)
			(T
			 '<COND (<0? <MOD ,HS 20>>
				 <TELL
"Você parece estar se repetindo." CR>)
				(<0? <MOD ,HS 10>>
				 <TELL
"Acho que essa frase já está meio gasta." CR>)
				(T
				 <TELL "Nada acontece aqui." CR>)>)>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM GROUND SAND DIRT FLOOR CHAO SOLO AREIA TERRA PISO)
	(DESC "chão")
	(ACTION GROUND-FUNCTION)>

<ROUTINE GROUND-FUNCTION ()
	 <COND (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSI ,GROUND>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,SANDY-CAVE>
			 <SAND-FUNCTION>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<VERB? DIG>
		<TELL "O chão aqui é duro demais para cavar." CR>)>>

<OBJECT GRUE
	(IN GLOBAL-OBJECTS)
	(SYNONYM GRUE)
	(ADJECTIVE LURKING SINISTER HUNGRY SILENT SINISTRO FAMINTO SILENCIOS)
	(DESC "grue à espreita")
	(ACTION GRUE-FUNCTION)>

<ROUTINE GRUE-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"O grue é uma presença sinistra, sempre à espreita nos lugares escuros da
terra. Seu prato favorito são aventureiros, mas o apetite insaciável dele é
contido pelo medo da luz. Nenhum grue jamais foi visto à luz do dia, e
poucos sobreviveram às suas mandíbulas temíveis para contar a história." CR>)
	  (<VERB? FIND>
	   <TELL
"Não há nenhum grue aqui, mas tenho certeza de que pelo menos um está à
espreita na escuridão aqui perto. Se eu fosse você, não deixaria a minha
luz se apagar!" CR>)
	  (<VERB? LISTEN>
	   <TELL
"Ele não faz barulho nenhum, mas está sempre à espreita na escuridão aqui
perto." CR>)>>

<OBJECT LUNGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM LUNGS AIR MOUTH BREATH PULMOES AR BOCA FOLEGO)
	(DESC "sopro de ar")
	(FLAGS NDESCBIT)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF CRETIN EU MIM)
	(DESC "você")
	(FLAGS ACTORBIT SEMARTIGOBIT)
	(ACTION CRETIN-FCN)>

<ROUTINE CRETIN-FCN ()
	 <COND (<VERB? TELL>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<TELL
"Dizem que falar sozinho é sinal de colapso mental iminente." CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<VERB? MAKE>
		<TELL "Só você pode fazer isso." CR>)
	       (<VERB? DISEMBARK>
		<TELL "Isso você vai ter que fazer sozinho." CR>)
	       (<VERB? EAT>
		<TELL "Autocanibalismo não é a resposta." CR>)
	       (<VERB? ATTACK MUNG>
		<COND (<AND ,PRSI <FSET? ,PRSI ,WEAPONBIT>>
		       <JIGS-UP "Se você insiste... Puf, você morreu!">)
		      (T
		       <TELL "Suicídio não é a resposta." CR>)>)
	       (<VERB? THROW>
		<COND (<==? ,PRSO ,ME>
		       <TELL
"Por que você não anda como as pessoas normais?" CR>)>)
	       (<VERB? TAKE>
		<TELL "Que romântico!" CR>)
	       (<VERB? EXAMINE>
		<COND %<COND (<==? ,ZORK-NUMBER 1>
			      '(<EQUAL? ,HERE <LOC ,MIRROR-1> <LOC ,MIRROR-2>>
		                <TELL
"A sua imagem no espelho parece cansada." CR>))
			     (<==? ,ZORK-NUMBER 3>
			      '(,INVIS
				<TELL
"Belo truque, já que você está invisível no momento." CR>))
			     (T
			      '(<NULL-F> <RTRUE>))>
		      (T
		       %<COND (<==? ,ZORK-NUMBER 3>
			       '<TELL
"O que dá para ver parece bem normal, lamento dizer." CR>)
			      (ELSE
			       '<TELL
"Isso é difícil, a não ser que os seus olhos sejam preênseis." CR>)>)>)>>

<OBJECT ADVENTURER
	(SYNONYM ADVENTURER AVENTUREI)
	(DESC "cretino")
	(FLAGS NDESCBIT INVISIBLE SACREDBIT ACTORBIT)
	(STRENGTH 0)
	(ACTION 0)>

<OBJECT PATHOBJ
	(IN GLOBAL-OBJECTS)
	(SYNONYM TRAIL PATH TRILHA CAMINHO PASSAGEM)
        (ADJECTIVE FOREST NARROW LONG WINDING FLORESTA ESTREITA LONGA SINUOSA)
	(DESC "passagem")
	(FLAGS NDESCBIT FEMBIT)
	(ACTION PATH-OBJECT)>

<ROUTINE PATH-OBJECT ()
	 <COND (<VERB? TAKE FOLLOW>
		<TELL "Você precisa dizer em que direção ir." CR>)
	       (<VERB? FIND>
		<TELL "Aí eu não posso ajudar..." CR>)
	       (<VERB? DIG>
		<TELL "Nem pensar." CR>)>>

<OBJECT ZORKMID
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZORKMID)
	(DESC "zorkmid")
	(ACTION ZORKMID-FUNCTION)>

<ROUTINE ZORKMID-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"O zorkmid é a unidade monetária do Grande Império Subterrâneo." CR>)
	  (<VERB? FIND>
	   <TELL
"O melhor jeito de achar zorkmids é sair por aí procurando." CR>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM PAIR HANDS HAND PAR MAOS MAO)
	(ADJECTIVE BARE NUAS)
	(DESC "par de mãos")
	(FLAGS NDESCBIT TOOLBIT)>