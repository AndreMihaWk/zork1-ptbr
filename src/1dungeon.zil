"1DUNGEON for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc. All Rights Reserved."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<GLOBAL SCORE-MAX 350>

<GLOBAL FALSE-FLAG <>>

"SUBTITLE OBJECTS"

<OBJECT BOARD
	(IN LOCAL-GLOBALS)
	(SYNONYM BOARDS BOARD TABUA TABUAS)
	(DESC "tábua")
	(FLAGS NDESCBIT FEMBIT)
	(ACTION BOARD-F)>

<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH DENTES)
	(DESC "dentes")
	(FLAGS NDESCBIT PLURALBIT)
	(ACTION TEETH-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS PAREDE PAREDES MURO)
	(ADJECTIVE SURROUNDING)
	(DESC "paredes ao redor")
	(FLAGS FEMBIT PLURALBIT)>

<OBJECT GRANITE-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL PAREDE)
	(ADJECTIVE GRANITE GRANITO)
	(DESC "parede de granito")
	(FLAGS FEMBIT)
	(ACTION GRANITE-WALL-F)>

<OBJECT SONGBIRD
	(IN LOCAL-GLOBALS)
	(SYNONYM BIRD SONGBIRD PASSARO PASSARINHO AVE)
	(ADJECTIVE SONG CANORO)
	(DESC "pássaro canoro")
	(FLAGS NDESCBIT)
	(ACTION SONGBIRD-F)>

<OBJECT WHITE-HOUSE	
	(IN LOCAL-GLOBALS)
	(SYNONYM HOUSE CASA)
	(ADJECTIVE WHITE BEAUTIFUL COLONIAL BRANCA BONITA)
	(DESC "casa branca")
	(FLAGS NDESCBIT FEMBIT)
	(ACTION WHITE-HOUSE-F)>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(SYNONYM FOREST TREES PINES HEMLOCKS FLORESTA MATA ARVORES PINHEIROS
		 ABETOS)
	(DESC "floresta")
	(FLAGS NDESCBIT FEMBIT)
	(ACTION FOREST-F)>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(SYNONYM TREE BRANCH ARVORE GALHO GALHOS)
	(ADJECTIVE LARGE STORM ;"-TOSSED" GRANDE)
	(DESC "árvore")
	(FLAGS NDESCBIT CLIMBBIT FEMBIT)>

<OBJECT MOUNTAIN-RANGE
	(IN MOUNTAINS)
	(DESC "cadeia de montanhas")
	(SYNONYM MOUNTAIN RANGE CADEIA MONTANHA MONTANHAS SERRA)
	(ADJECTIVE IMPASSABLE FLATHEAD MONTANHAS)
	(FLAGS NDESCBIT CLIMBBIT FEMBIT)
	(ACTION MOUNTAIN-RANGE-F)>

<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER QUANTITY AGUA)
	(DESC "água")
	(FLAGS DRINKBIT FEMBIT PARTITIVOBIT)
	(ACTION WATER-F)>

<OBJECT WATER
	(IN BOTTLE)
	(SYNONYM WATER QUANTITY LIQUID H2O AGUA LIQUIDO)
	(DESC "água")
	(FLAGS TRYTAKEBIT TAKEBIT DRINKBIT FEMBIT PARTITIVOBIT)
	(ACTION WATER-F)
	(SIZE 4)>

<OBJECT	KITCHEN-WINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW JANELA)
	(ADJECTIVE KITCHEN SMALL COZINHA PEQUENA)
	(DESC "janela da cozinha")
	(FLAGS DOORBIT NDESCBIT FEMBIT)
	(ACTION KITCHEN-WINDOW-F)>

<OBJECT CHIMNEY
	(IN LOCAL-GLOBALS)
	(SYNONYM CHIMNEY CHAMINE)
	(ADJECTIVE DARK NARROW ESCURA ESTREITA)
	(DESC "chaminé")
	(ACTION CHIMNEY-F)
	(FLAGS CLIMBBIT NDESCBIT FEMBIT)>

<OBJECT GHOSTS
	(IN ENTRANCE-TO-HADES)
	(SYNONYM GHOSTS SPIRITS FIENDS FORCE ESPIRITOS ESPIRITO FANTASMAS
		 FANTASMA DEMONIOS DEMONIO ASSOMBRAC FORCA)
	(ADJECTIVE INVISIBLE EVIL INVISIVEI MALIGNOS MAUS)
	(DESC "espíritos")
	(FLAGS ACTORBIT NDESCBIT PLURALBIT)
	(ACTION GHOSTS-F)>

<OBJECT SKULL
	(IN LAND-OF-LIVING-DEAD)
	(SYNONYM SKULL HEAD TREASURE TREASURES TESOURO TESOUROS CAVEIRA CRANIO
		 CABECA)
	(ADJECTIVE CRYSTAL CRISTAL)
	(DESC "caveira de cristal")
	(FDESC
"Num canto da sala há uma caveira de cristal lindamente esculpida. Ela
parece sorrir para você com um ar bem maldoso.")
	(FLAGS TAKEBIT FEMBIT)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT LOWERED-BASKET
	(IN LOWER-SHAFT)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(ADJECTIVE LOWERED)
	(LDESC "From the chain is suspended a basket.")
	(DESC "basket")
	(FLAGS TRYTAKEBIT)
	(ACTION BASKET-F)>

<OBJECT RAISED-BASKET
	(IN SHAFT-ROOM)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(DESC "basket")
	(FLAGS TRANSBIT TRYTAKEBIT CONTBIT OPENBIT)
	(ACTION BASKET-F)
	(LDESC "At the end of the chain is a basket.")
	(CAPACITY 50)>

<OBJECT LUNCH
	(IN SANDWICH-BAG)
	(SYNONYM FOOD SANDWICH LUNCH DINNER COMIDA SANDUICHE LANCHE ALMOCO JANTAR)
	(ADJECTIVE HOT PEPPER PIMENTA APIMENTAD QUENTE)
	(DESC "lanche")
	(FLAGS TAKEBIT FOODBIT)
	(LDESC "Há um sanduíche apimentado aqui.")>

<OBJECT BAT
	(IN BAT-ROOM)
	(SYNONYM BAT VAMPIRE)
	(ADJECTIVE VAMPIRE DERANGED)
	(DESC "bat")
	(FLAGS ACTORBIT TRYTAKEBIT)
	(DESCFCN BAT-D)
	(ACTION BAT-F)>

<OBJECT BELL
	(IN NORTH-TEMPLE)
	(SYNONYM BELL SINO SININHO)
	(ADJECTIVE SMALL BRASS PEQUENO LATAO)
	(DESC "sino de latão")
	(FLAGS TAKEBIT)
	(ACTION BELL-F)>

<OBJECT HOT-BELL
	(SYNONYM BELL SINO SININHO)
	(ADJECTIVE BRASS HOT RED SMALL LATAO QUENTE VERMELHO INCANDESC PEQUENO)
	(DESC "sino de latão em brasa")
	(FLAGS TRYTAKEBIT)
	(ACTION HOT-BELL-F)
	(LDESC "No chão há um sino em brasa.")>

<OBJECT AXE
	(IN TROLL)
	(SYNONYM AXE AX MACHADO)
	(ADJECTIVE BLOODY ENSANGUEN)
	(DESC "machado ensanguentado")
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(ACTION AXE-F)
	(SIZE 25)>

<OBJECT BOLT
	(IN DAM-ROOM)
	(SYNONYM BOLT NUT PARAFUSO PORCA)
	(ADJECTIVE METAL LARGE GRANDE METALICO)
	(DESC "parafuso")
	(FLAGS NDESCBIT TURNBIT TRYTAKEBIT)
	(ACTION BOLT-F)>

<OBJECT BUBBLE
	(IN DAM-ROOM)
	(SYNONYM BUBBLE BOLHA)
	(ADJECTIVE SMALL GREEN PLASTIC PEQUENA VERDE PLASTICO)
	(DESC "bolha verde")
	(FLAGS NDESCBIT TRYTAKEBIT FEMBIT)
	(ACTION BUBBLE-F)>

<OBJECT ALTAR
	(IN SOUTH-TEMPLE)
	(SYNONYM ALTAR)
	(DESC "altar")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 50)>

<OBJECT BOOK
	(IN ALTAR)
	(SYNONYM BOOK PRAYER PAGE BOOKS LIVRO LIVROS PAGINA ORACAO)
	(ADJECTIVE LARGE BLACK GRANDE NEGRO PRETO)
	(DESC "livro negro")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT TURNBIT)
	(ACTION BLACK-BOOK)
	(FDESC "Sobre o altar há um grande livro negro, aberto na página 569.")
	(SIZE 10)
	(TEXT
"Mandamento #12592|
|
Ó vós que andais por aí dizendo a cada um:  \"Olá, marinheiro\":|
Sabes tu a grandeza do teu pecado diante dos deuses?|
Sim, em verdade, serás moído entre duas pedras.|
Lançarão os deuses irados o teu corpo no redemoinho?|
Por certo, teu olho será furado com uma vara pontuda!|
Até os confins da terra vagarás, e|
À terra dos mortos serás enfim enviado.|
Por certo te arrependerás da tua astúcia." )>

<OBJECT BROKEN-LAMP
	(SYNONYM LAMP LANTERN LANTERNA LAMPADA LAMPIAO)
	(ADJECTIVE BROKEN QUEBRADA)
	(DESC "lanterna quebrada")
	(FLAGS TAKEBIT FEMBIT)>

<OBJECT SCEPTRE
	(IN COFFIN)
	(SYNONYM SCEPTRE SCEPTER TREASURE TREASURES TESOURO TESOUROS CETRO)
	(ADJECTIVE SHARP EGYPTIAN ANCIENT ENAMELED AFIADO PONTIAGUD EGIPCIO
		   ANTIGO ESMALTADO ORNAMENTA)
	(DESC "cetro")
	(FLAGS TAKEBIT WEAPONBIT)
	(ACTION SCEPTRE-FUNCTION)
	(LDESC
"Há aqui um cetro ornamentado, que se afina até terminar numa ponta afiada.")
	(FDESC
"Dentro do caixão há um cetro, talvez o do próprio Egito antigo. O cetro é
ornamentado com esmalte colorido e se afina até terminar numa ponta afiada.")
	(SIZE 3)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT TIMBERS
	(IN TIMBER-ROOM)
	(SYNONYM TIMBERS TIMBER PILE)
	(ADJECTIVE WOODEN BROKEN)
	(DESC "broken timber")
	(FLAGS TAKEBIT)
	(SIZE 50)>

<OBJECT	SLIDE
	(IN LOCAL-GLOBALS)
	(SYNONYM CHUTE RAMP SLIDE)
	(ADJECTIVE STEEP METAL TWISTING)
	(DESC "chute")
	(FLAGS CLIMBBIT)
	(ACTION SLIDE-FUNCTION)>

<OBJECT KITCHEN-TABLE
	(IN KITCHEN)
	(SYNONYM TABLE MESA)
	(ADJECTIVE KITCHEN COZINHA)
	(DESC "mesa da cozinha")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT FEMBIT)
	(CAPACITY 50)>

<OBJECT ATTIC-TABLE
	(IN ATTIC)
	(SYNONYM TABLE MESA)
	(DESC "mesa")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT FEMBIT)
	(CAPACITY 40)>

<OBJECT SANDWICH-BAG
	(IN KITCHEN-TABLE)
	(SYNONYM BAG SACK SACO SACOLA)
	(ADJECTIVE BROWN ELONGATED SMELLY MARROM COMPRIDO FEDORENTO)
	(DESC "saco marrom")
	(FLAGS TAKEBIT CONTBIT BURNBIT)
	(FDESC
"Sobre a mesa há um saco marrom comprido, com cheiro de pimenta.")
	(CAPACITY 9)
	(SIZE 9)
	(ACTION SANDWICH-BAG-FCN)>

<OBJECT TOOL-CHEST
	(IN MAINTENANCE-ROOM)
	(SYNONYM CHEST CHESTS GROUP TOOLCHESTS CAIXA CAIXAS GRUPO)
	(ADJECTIVE TOOL FERRAMENTA FERRAMENTAS)
	(DESC "caixas de ferramentas")
	(FLAGS CONTBIT OPENBIT TRYTAKEBIT SACREDBIT FEMBIT PLURALBIT)
	(ACTION TOOL-CHEST-FCN)>

<OBJECT YELLOW-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH BOTAO BOTOES)
	(ADJECTIVE YELLOW AMARELO)
	(DESC "botão amarelo")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT BROWN-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH BOTAO BOTOES)
	(ADJECTIVE BROWN MARROM)
	(DESC "botão marrom")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT RED-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH BOTAO BOTOES)
	(ADJECTIVE RED VERMELHO)
	(DESC "botão vermelho")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT BLUE-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH BOTAO BOTOES)
	(ADJECTIVE BLUE AZUL)
	(DESC "botão azul")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT TROPHY-CASE	;"first obj so L.R. desc looks right."
	(IN LIVING-ROOM)
	(SYNONYM CASE VITRINE ESTANTE)
	(ADJECTIVE TROPHY TROFEUS)
	(DESC "vitrine de troféus")
	(FLAGS TRANSBIT CONTBIT NDESCBIT TRYTAKEBIT SEARCHBIT FEMBIT)
	(ACTION TROPHY-CASE-FCN)
	(CAPACITY 10000)>

<OBJECT RUG
	(IN LIVING-ROOM)
	(SYNONYM RUG CARPET TAPETE)
	(ADJECTIVE LARGE ORIENTAL GRANDE)
	(DESC "tapete")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION RUG-FCN)>

<OBJECT CHALICE
	(IN TREASURE-ROOM)
	(SYNONYM CHALICE CUP SILVER TREASURE TREASURES TESOURO TESOUROS CALICE
		 TACA PRATA)
	(ADJECTIVE SILVER ENGRAVINGS PRATA GRAVADO) ;"engravings exists..."
	(DESC "cálice")
	(FLAGS TAKEBIT TRYTAKEBIT CONTBIT)
	(ACTION CHALICE-FCN)
	(LDESC "Há um cálice de prata, ricamente gravado, aqui.")
	(CAPACITY 5)
	(SIZE 10)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT GARLIC
	(IN SANDWICH-BAG)
	(SYNONYM GARLIC CLOVE ALHO DENTE)
	(ADJECTIVE ALHO) ;"PT: dente de alho (ver docs/TRADUCAO.md)"
	(DESC "dente de alho")
	(FLAGS TAKEBIT FOODBIT)
	(ACTION GARLIC-F)
	(SIZE 4)>

<OBJECT TRIDENT
	(IN ATLANTIS-ROOM)
	(SYNONYM TRIDENT FORK TREASURE TREASURES TESOURO TESOUROS)
	(ADJECTIVE POSEIDON OWN CRYSTAL)
	(DESC "crystal trident")
	(FLAGS TAKEBIT)
	(FDESC "On the shore lies Poseidon's own crystal trident.")
	(SIZE 20)
	(VALUE 4)
	(TVALUE 11)>

<OBJECT CYCLOPS
	(IN CYCLOPS-ROOM)
	(SYNONYM CYCLOPS MONSTER EYE CICLOPE MONSTRO OLHO GIGANTE)
	(ADJECTIVE HUNGRY GIANT FAMINTO GIGANTE CICLOPE)
	;"PT: CICLOPE também é adjetivo, para olho do ciclope"
	(DESC "ciclope")
	(FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)
	(ACTION CYCLOPS-FCN)
	(STRENGTH 10000)>

<OBJECT DAM
	(IN DAM-ROOM)
	(SYNONYM DAM GATE GATES FCD\#3 BARRAGEM COMPORTA COMPORTAS BCE\#3)
	(DESC "barragem")
	(FLAGS NDESCBIT TRYTAKEBIT FEMBIT)
	(ACTION DAM-FUNCTION)>

<OBJECT TRAP-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR TRAPDOOR TRAP-DOOR COVER ALCAPAO)
	(ADJECTIVE TRAP DUSTY EMPOEIRAD)
	(DESC "alçapão")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION TRAP-DOOR-FCN)>

<OBJECT BOARDED-WINDOW
	(IN LOCAL-GLOBALS)
        (SYNONYM WINDOW JANELA JANELAS)
	(ADJECTIVE BOARDED TAPADA TAPADAS)
	(DESC "janela tapada")
	(FLAGS NDESCBIT FEMBIT)
	(ACTION BOARDED-WINDOW-FCN)>

<OBJECT FRONT-DOOR
	(IN WEST-OF-HOUSE)
	(SYNONYM DOOR PORTA)
	(ADJECTIVE FRONT BOARDED FRENTE TAPADA)
	(DESC "porta")
	(FLAGS DOORBIT NDESCBIT FEMBIT)
	(ACTION FRONT-DOOR-FCN)>

<OBJECT BARROW-DOOR	
	(IN STONE-BARROW)
	(SYNONYM DOOR)
	(ADJECTIVE HUGE STONE)
	(DESC "stone door")
	(FLAGS DOORBIT NDESCBIT OPENBIT)
	(ACTION BARROW-DOOR-FCN)>

<OBJECT BARROW
	(IN STONE-BARROW)
	(SYNONYM BARROW TOMB)
	(ADJECTIVE MASSIVE STONE)
	(DESC "stone barrow")
	(FLAGS NDESCBIT)
	(ACTION BARROW-FCN)>

<OBJECT BOTTLE
	(IN KITCHEN-TABLE)
	(SYNONYM BOTTLE CONTAINER GARRAFA RECIPIENT)
	(ADJECTIVE CLEAR GLASS VIDRO TRANSPARE)
	(DESC "garrafa de vidro")
	(FLAGS TAKEBIT TRANSBIT CONTBIT FEMBIT)
	(ACTION BOTTLE-FUNCTION)
	(FDESC "Há uma garrafa sobre a mesa.")
	(CAPACITY 4)>

<OBJECT CRACK
	(IN LOCAL-GLOBALS)
	(SYNONYM CRACK FENDA RACHADURA)
	(ADJECTIVE NARROW ESTREITA)
	(DESC "fenda")
	(FLAGS NDESCBIT FEMBIT)
	(ACTION CRACK-FCN)>

<OBJECT COFFIN
	(IN EGYPT-ROOM)
	(SYNONYM COFFIN CASKET TREASURE TREASURES TESOURO TESOUROS CAIXAO ATAUDE
		 SARCOFAGO ESQUIFE)
	(ADJECTIVE SOLID GOLD OURO MACICO DOURADO)
	(DESC "caixão de ouro")
	(FLAGS TAKEBIT CONTBIT SACREDBIT SEARCHBIT)
	(LDESC
"Aqui está o caixão de ouro maciço usado no enterro de Ramsés II.")
	(CAPACITY 35)
	(SIZE 55)
	(VALUE 10)
	(TVALUE 15)>

<OBJECT GRATE
	(IN LOCAL-GLOBALS)
	(SYNONYM GRATE GRATING GRADE GRELHA)
	(DESC "grade")
	(FLAGS DOORBIT NDESCBIT INVISIBLE FEMBIT)
	(ACTION GRATE-FUNCTION)>

<OBJECT PUMP
	(IN RESERVOIR-NORTH)
	(SYNONYM PUMP AIR-PUMP TOOL TOOLS BOMBA FERRAMENTA FERRAMENTAS)
	(ADJECTIVE SMALL HAND-HELD AR MANUAL PEQUENA)
	(DESC "bomba de ar manual")
	(FLAGS TAKEBIT TOOLBIT FEMBIT)>

<OBJECT DIAMOND
	(SYNONYM DIAMOND TREASURE TREASURES TESOURO TESOUROS)
	(ADJECTIVE HUGE ENORMOUS)
	(DESC "huge diamond")
	(FLAGS TAKEBIT)
	(LDESC "There is an enormous diamond (perfectly cut) here.")
	(VALUE 10)
	(TVALUE 10)>

<OBJECT JADE
	(IN BAT-ROOM)
	(SYNONYM FIGURINE TREASURE TREASURES TESOURO TESOUROS)
	(ADJECTIVE EXQUISITE JADE)
	(DESC "jade figurine")
	(FLAGS TAKEBIT)
	(LDESC "There is an exquisite jade figurine here.")
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT KNIFE
	(IN ATTIC-TABLE)
	(SYNONYM KNIVES KNIFE BLADE FACA FACAS)
	(ADJECTIVE NASTY UNRUSTY AFIADA)
	(DESC "faca afiada")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT FEMBIT)
	(FDESC "Sobre uma mesa há uma faca de aspecto ameaçador.")
	(ACTION KNIFE-F)>

<OBJECT BONES
	(IN MAZE-5)
	(SYNONYM BONES SKELETON BODY ESQUELETO OSSOS OSSADA CORPO RESTOS)
	(DESC "esqueleto")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION SKELETON)>

<OBJECT BURNED-OUT-LANTERN
	(IN MAZE-5)
	(SYNONYM LANTERN LAMP LANTERNA LAMPADA LAMPIAO)
	(ADJECTIVE RUSTY BURNED DEAD USELESS QUEIMADA ENFERRUJA INUTIL VELHA)
	(DESC "lanterna queimada")
	(FLAGS TAKEBIT FEMBIT)
	(FDESC "A lanterna inútil do falecido aventureiro está aqui.")
	(SIZE 20)>

<OBJECT BAG-OF-COINS
	(IN MAZE-5)
	(SYNONYM BAG COINS TREASURE TREASURES TESOURO TESOUROS SACO MOEDAS MOEDA)
	(ADJECTIVE OLD LEATHER COURO VELHO MOEDAS)
	;"PT: saco de couro com moedas; saco de moedas e moedas também valem"
	(DESC "saco de couro com moedas")
	(FLAGS TAKEBIT)
	(LDESC "Há aqui um velho saco de couro, estufado de moedas.")
	(ACTION BAG-OF-COINS-F)
	(SIZE 15)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT LAMP
	(IN LIVING-ROOM)
	(SYNONYM LAMP LANTERN LIGHT LANTERNA LAMPADA LAMPIAO LUZ)
	(ADJECTIVE BRASS LATAO)
	(DESC "lanterna de latão")
	(FLAGS TAKEBIT LIGHTBIT FEMBIT)
	(ACTION LANTERN)
	(FDESC "Sobre a vitrine de troféus há uma lanterna de latão a pilha.")
	(LDESC "Há uma lanterna de latão (a pilha) aqui.")
	(SIZE 15)>

<OBJECT EMERALD
	(IN BUOY)
	(SYNONYM EMERALD TREASURE TREASURES TESOURO TESOUROS ESMERALDA)
	(ADJECTIVE LARGE GRANDE)
	(DESC "esmeralda grande")
	(FLAGS TAKEBIT FEMBIT)
	(VALUE 5)
	(TVALUE 10)>

<OBJECT ADVERTISEMENT
	(IN MAILBOX)
	(SYNONYM ADVERTISEMENT LEAFLET BOOKLET MAIL FOLHETO PANFLETO)
	(ADJECTIVE SMALL PEQUENO)
	(DESC "folheto")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "Há um pequeno folheto no chão.")
	(TEXT
"\"BEM-VINDO AO ZORK!|
|
ZORK é um jogo de aventura, perigo e muita malandragem. Nele você
vai explorar alguns dos territórios mais incríveis que olhos mortais já
viram. Nenhum computador deveria ficar sem ele!\"")
	(SIZE 2)>

<OBJECT LEAK
	(IN MAINTENANCE-ROOM)
	(SYNONYM LEAK DRIP PIPE VAZAMENTO CANO GOTEIRA JATO)
	(DESC "vazamento")
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION LEAK-FUNCTION)>

<OBJECT MACHINE
	(IN MACHINE-ROOM)
	(SYNONYM MACHINE PDP10 DRYER LID)
	(DESC "machine")
	(FLAGS CONTBIT NDESCBIT TRYTAKEBIT)
	(ACTION MACHINE-F)
	(CAPACITY 50)>

<OBJECT INFLATED-BOAT
	(SYNONYM BOAT RAFT BARCO BOTE)
	;"PT: PLASTICO só como adjetivo, igual a PLASTIC no original"
	(ADJECTIVE INFLATED INFLATABLE MAGIC PLASTIC SEAWORTHY MAGICO PLASTICO
		   INFLADO INFLAVEL)
	(DESC "barco mágico")
	(FLAGS TAKEBIT BURNBIT VEHBIT OPENBIT SEARCHBIT)
	(ACTION RBOAT-FUNCTION)
	(CAPACITY 100)
	(SIZE 20)
	(VTYPE NONLANDBIT)>

<OBJECT MAILBOX
	(IN WEST-OF-HOUSE)
	(SYNONYM MAILBOX BOX CAIXA)
	(ADJECTIVE SMALL PEQUENA CORREIO)
	(DESC "pequena caixa de correio")
	(FLAGS CONTBIT TRYTAKEBIT FEMBIT)
	(CAPACITY 10)
	(ACTION MAILBOX-F)>

<OBJECT MATCH
	(IN DAM-LOBBY)
	(SYNONYM MATCH MATCHES MATCHBOOK CAIXA CAIXINHA FOSFORO FOSFOROS)
	(ADJECTIVE MATCH FOSFOROS)
	(DESC "caixa de fósforos")
	(FLAGS READBIT TAKEBIT FEMBIT)
	(ACTION MATCH-FUNCTION)
	(LDESC
"Há aqui uma caixa de fósforos com os dizeres \"Visite a Bela BCE#3\" na
capa.")
	(SIZE 2)
	(TEXT
"|
(Feche a capa antes de riscar)|
|
VOCÊ também pode GANHAR MUITO DINHEIRO no empolgante ramo do EMBARALHAMENTO
DE PAPÉIS!|
|
O Sr. Anderson, de Embrulhada, MA, conta: \"Antes de fazer este curso, eu
era um reles escovador de bits. Agora, com o que aprendi na GUE Tech, eu me
sinto muito importante e sei enrolar e confundir como os melhores.\"|
|
O Dr. Fulano de Tal tem isto a dizer: \"Dez curtos dias atrás, tudo o que
eu tinha pela frente era um emprego sem futuro como médico. Agora tenho um
futuro promissor e ganho zorkmids de montão.\"|
|
A GUE Tech não pode prometer esses resultados fantásticos a todo mundo. Mas,
quando você conquistar o seu diploma da GUE Tech, o seu futuro vai ser mais
brilhante." )>

<OBJECT MIRROR-2
	(IN MIRROR-ROOM-2)
	(SYNONYM REFLECTION MIRROR ENORMOUS ESPELHO REFLEXO)
	(ADJECTIVE ENORME)
	(DESC "espelho")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT MIRROR-1
	(IN MIRROR-ROOM-1)
	(SYNONYM REFLECTION MIRROR ENORMOUS ESPELHO REFLEXO)
	(ADJECTIVE ENORME)
	(DESC "espelho")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT PAINTING
	(IN GALLERY)
	(SYNONYM PAINTING ART CANVAS TREASURE TREASURES TESOURO TESOUROS PINTURA
		 QUADRO TELA ARTE OBRA)
	(ADJECTIVE BEAUTIFUL BELA LINDA)
	(DESC "pintura")
	(FLAGS TAKEBIT BURNBIT FEMBIT)
	(ACTION PAINTING-FCN)
	(FDESC
"Por sorte, ainda resta uma chance de você bancar o vândalo: na parede do
fundo há uma pintura de beleza sem igual.")
	(LDESC "Há uma pintura de um gênio incompreendido aqui.")
	(SIZE 15)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT CANDLES
	(IN SOUTH-TEMPLE)
	(SYNONYM CANDLES CANDLE PAIR VELAS VELA PAR)
	(ADJECTIVE BURNING VELAS ACESAS ACESA)
	(DESC "par de velas")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION CANDLES-FCN)
	(FDESC "Nas duas pontas do altar há velas acesas.")
	(SIZE 10)>

<OBJECT GUNK
	(SYNONYM GUNK PIECE SLAG)
	(ADJECTIVE SMALL VITREOUS)
	(DESC "small piece of vitreous slag")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION GUNK-FUNCTION)
	(SIZE 10)>

<OBJECT BODIES
	(IN LOCAL-GLOBALS)
	(SYNONYM BODIES BODY REMAINS PILE CORPOS CORPO RESTOS MONTE PILHA
		 CADAVERES CADAVER)
	(ADJECTIVE MANGLED CORPOS MUTILADOS)
	(DESC "monte de corpos")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION BODY-FUNCTION)>

<OBJECT LEAVES
	(IN GRATING-CLEARING)
	(SYNONYM LEAVES LEAF PILE FOLHAS FOLHA MONTE)
	(ADJECTIVE FOLHAS)
	(DESC "monte de folhas")
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(ACTION LEAF-PILE)
	(LDESC "Há um monte de folhas no chão.")
	(SIZE 25)>

<OBJECT PUNCTURED-BOAT
	(SYNONYM BOAT PILE PLASTIC BARCO BOTE MONTE PLASTICO)
	(ADJECTIVE PLASTIC PUNCTURE LARGE FURADO PLASTICO GRANDE)
	(DESC "barco furado")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION DBOAT-FUNCTION)
	(SIZE 20)>

<OBJECT INFLATABLE-BOAT
	(IN DAM-BASE)
	(SYNONYM BOAT PILE PLASTIC VALVE BARCO BOTE MONTE PLASTICO VALVULA)
	(ADJECTIVE PLASTIC INFLATABLE INFLATED PLASTICO INFLAVEL DOBRADO)
	(DESC "monte de plástico")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION IBOAT-FUNCTION)
	(LDESC
"Há aqui um monte de plástico dobrado, com uma pequena válvula presa a
ele.")
	(SIZE 20)>

<OBJECT BAR
	(IN LOUD-ROOM)
	(SYNONYM BAR PLATINUM TREASURE TREASURES TESOURO TESOUROS BARRA PLATINA)
	(ADJECTIVE PLATINUM LARGE PLATINA GRANDE)
	(DESC "barra de platina")
	(FLAGS TAKEBIT SACREDBIT FEMBIT)
	(LDESC "Há uma grande barra de platina no chão.")
	(SIZE 20)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT POT-OF-GOLD
	(IN END-OF-RAINBOW)
	(SYNONYM POT GOLD TREASURE TREASURES TESOURO TESOUROS)
	(ADJECTIVE GOLD)
	(DESC "pot of gold")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC "At the end of the rainbow is a pot of gold.")
	(SIZE 15)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT PRAYER
	(IN NORTH-TEMPLE)
	(SYNONYM PRAYER INSCRIPTION ORACAO PRECE INSCRICAO)
	(ADJECTIVE ANCIENT OLD ANTIGA VELHA)
	(DESC "oração")
	(FLAGS READBIT SACREDBIT NDESCBIT FEMBIT)
	(TEXT
"A oração está gravada numa escrita antiga, hoje raramente usada. Parece
ser uma filípica contra os insetos pequenos, a distração e o hábito de pegar
e largar objetos pequenos. O último verso condena os invasores à terra dos
mortos. Tudo indica que as crenças dos antigos zorkianos eram obscuras." )>

<OBJECT RAILING
	(IN DOME-ROOM)
	(SYNONYM RAILING RAIL CORRIMAO GRADIL PARAPEITO)
	(ADJECTIVE WOODEN MADEIRA)
	(DESC "corrimão de madeira")
	(FLAGS NDESCBIT)>

<OBJECT RAINBOW
	(IN LOCAL-GLOBALS)
	(SYNONYM RAINBOW)
	(DESC "rainbow")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION RAINBOW-FCN)>

<OBJECT RIVER
	(IN LOCAL-GLOBALS)
	(DESC "rio")
	(SYNONYM RIVER RIO)
	(ADJECTIVE FRIGID FRIGIDO)
	(ACTION RIVER-FUNCTION)
	(FLAGS NDESCBIT)>

<OBJECT BUOY
	(IN RIVER-4)
	(SYNONYM BUOY BOIA)
	(ADJECTIVE RED VERMELHA)
	(DESC "boia vermelha")
	(FLAGS TAKEBIT CONTBIT FEMBIT)
	(FDESC "Há uma boia vermelha aqui (provavelmente um aviso).")
	(CAPACITY 20)
	(SIZE 10)
	(ACTION TREASURE-INSIDE)>

<ROUTINE TREASURE-INSIDE ()
	 <COND (<VERB? OPEN>
		<SCORE-OBJ ,EMERALD>
		<RFALSE>)>>
<OBJECT ROPE
	(IN ATTIC)
	(SYNONYM ROPE HEMP COIL CORDA ROLO)
	(ADJECTIVE LARGE GRANDE CORDA)
	(DESC "corda")
	(FLAGS TAKEBIT SACREDBIT TRYTAKEBIT FEMBIT)
	(ACTION ROPE-FUNCTION)
	(FDESC "Um grande rolo de corda está largado no canto.")
	(SIZE 10)>

<OBJECT RUSTY-KNIFE
	(IN MAZE-5)
	(SYNONYM KNIVES KNIFE FACA FACAS)
	(ADJECTIVE RUSTY ENFERRUJA)
	(DESC "faca enferrujada")
	(FLAGS TAKEBIT TRYTAKEBIT WEAPONBIT TOOLBIT FEMBIT)
	(ACTION RUSTY-KNIFE-FCN)
	(FDESC "Ao lado do esqueleto há uma faca enferrujada.")
	(SIZE 20)>

<OBJECT SAND
	(IN SANDY-CAVE)
	(SYNONYM SAND AREIA)
	(DESC "areia")
	(FLAGS NDESCBIT FEMBIT PARTITIVOBIT)
	(ACTION SAND-FUNCTION)>

<OBJECT BRACELET
	(IN GAS-ROOM)
	(SYNONYM BRACELET JEWEL SAPPHIRE TREASURE TREASURES TESOURO TESOUROS)
	(ADJECTIVE SAPPHIRE)
	(DESC "sapphire-encrusted bracelet")
	(FLAGS TAKEBIT)
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT SCREWDRIVER
	(IN MAINTENANCE-ROOM)
	(SYNONYM SCREWDRIVER TOOL TOOLS DRIVER CHAVE FERRAMENTA FERRAMENTAS)
	(ADJECTIVE SCREW FENDA)
	(DESC "chave de fenda")
	(FLAGS TAKEBIT TOOLBIT FEMBIT)>

<OBJECT KEYS
	(IN MAZE-5)
	(SYNONYM KEY CHAVE CHAVES)
	(ADJECTIVE SKELETON MESTRA)
	(DESC "chave mestra")
	(FLAGS TAKEBIT TOOLBIT FEMBIT)
	(SIZE 10)>

<OBJECT SHOVEL
	(IN SANDY-BEACH)
	(SYNONYM SHOVEL TOOL TOOLS PA FERRAMENTA FERRAMENTAS)
	(DESC "pá")
	(FLAGS TAKEBIT TOOLBIT FEMBIT)
	(SIZE 15)>

<OBJECT COAL
	(IN DEAD-END-5)
	(SYNONYM COAL PILE HEAP)
	(ADJECTIVE SMALL)
	(DESC "small pile of coal")
	(FLAGS TAKEBIT BURNBIT)
	(SIZE 20)>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN RICKETY NARROW)
	(DESC "wooden ladder")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT SCARAB
	(IN SANDY-CAVE)
	(SYNONYM SCARAB BUG BEETLE TREASURE TREASURES TESOURO TESOUROS ESCARAVELHO
		 BESOURO)
	(ADJECTIVE BEAUTIFUL CARVED JEWELED LINDO CRAVEJADO JOIAS ENTALHADO)
	(DESC "lindo escaravelho cravejado de joias")
	(FLAGS TAKEBIT INVISIBLE)
	(SIZE 8)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT LARGE-BAG
	(IN THIEF)
	(SYNONYM BAG SACO SACOLA)
	(ADJECTIVE LARGE THIEFS GRANDE LADRAO)
	;"PT: LADRAO também é adjetivo (saco do ladrão, estilete do ladrão).
	  Fora o saco e o estilete, o que está com o ladrão fica invisível."
	(DESC "saco grande")
	(ACTION LARGE-BAG-F)
	(FLAGS TRYTAKEBIT NDESCBIT)>

<OBJECT STILETTO
	(IN THIEF)
	(SYNONYM STILETTO ESTILETE)
	(ADJECTIVE VICIOUS CRUEL LETAL LADRAO)
	(DESC "estilete")
	(ACTION STILETTO-FUNCTION)
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(SIZE 10)>

<OBJECT MACHINE-SWITCH
	(IN MACHINE-ROOM)
	(SYNONYM SWITCH)
	(DESC "switch")
	(FLAGS NDESCBIT TURNBIT)
	(ACTION MSWITCH-FUNCTION)>

<OBJECT WOODEN-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR LETTERING WRITING PORTA LETRAS LETREIRO INSCRICAO
		 INSCRICOES)
	(ADJECTIVE WOODEN GOTHIC STRANGE WEST MADEIRA GOTICA GOTICAS ESTRANHA
		   ESTRANHAS OESTE)
	(DESC "porta de madeira")
	(FLAGS READBIT DOORBIT NDESCBIT TRANSBIT FEMBIT)
	(ACTION FRONT-DOOR-FCN)
	(TEXT
"Traduzidas, as inscrições dizem: \"Este espaço foi deixado em branco
de propósito.\"")>

<OBJECT SWORD
	(IN LIVING-ROOM)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE ESPADA LAMINA)
	(ADJECTIVE ELVISH OLD ANTIQUE ELFICA ANTIGA VELHA)
	(DESC "espada")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT FEMBIT)
	(ACTION SWORD-FCN)
	(FDESC
"Acima da vitrine de troféus está pendurada uma espada élfica de grande
antiguidade.")
	(SIZE 30)
	(TVALUE 0)>

<OBJECT MAP
	(IN TROPHY-CASE)
	(SYNONYM PARCHMENT MAP)
	(ADJECTIVE ANTIQUE OLD ANCIENT)
	(DESC "ancient map")
	(FLAGS INVISIBLE READBIT TAKEBIT)
	(FDESC
"In the trophy case is an ancient parchment which appears to be a map.")
	(SIZE 2)
	(TEXT
"The map shows a forest with three clearings. The largest clearing contains
a house. Three paths leave the large clearing. One of these paths, leading
southwest, is marked \"To Stone Barrow\".")>

<OBJECT BOAT-LABEL
	(IN INFLATED-BOAT)
	(SYNONYM LABEL FINEPRINT PRINT ETIQUETA ROTULO LETRINHAS)
	(ADJECTIVE TAN FINE BEGE MIUDAS)
	(DESC "etiqueta bege")
	(FLAGS READBIT TAKEBIT BURNBIT FEMBIT)
	(SIZE 2)
	(TEXT
"  !!!!COMPANHIA FROBOZZ DE BARCOS MÁGICOS!!!!|
|
Olá, marinheiro!|
|
Instruções de uso:|
|
   Para entrar na água, diga \"Lance\".|
   Para chegar à margem, diga \"Atraque\" ou a direção para onde você quer
manobrar o barco.|
|
Garantia:|
|
  Este barco tem garantia contra todos os defeitos por um período de 76
milissegundos a partir da data da compra ou até o primeiro uso, o que
ocorrer primeiro.|
|
Aviso:|
   Este barco é feito de plástico fino.|
   Boa sorte!" )>

<OBJECT THIEF
	(IN ROUND-ROOM)
	(SYNONYM THIEF ROBBER MAN PERSON LADRAO HOMEM PESSOA SUJEITO INDIVIDUO
		 BANDIDO)
	(ADJECTIVE SHADY SUSPICIOUS SEEDY SUSPEITO)
	(DESC "ladrão")
	(FLAGS ACTORBIT INVISIBLE CONTBIT OPENBIT TRYTAKEBIT)
	(ACTION ROBBER-FUNCTION)
	(LDESC
"Há um indivíduo de aparência suspeita encostado numa parede, segurando
um saco grande. Ele está armado com um estilete letal.")
	(STRENGTH 5)>

<OBJECT PEDESTAL
	(IN TORCH-ROOM)
	(SYNONYM PEDESTAL)
	(ADJECTIVE WHITE MARBLE BRANCO MARMORE)
	(DESC "pedestal")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(ACTION DUMB-CONTAINER)
	(CAPACITY 30)>

<OBJECT TORCH
	(IN PEDESTAL)
	(SYNONYM TORCH IVORY TREASURE TREASURES TESOURO TESOUROS TOCHA MARFIM
		 ARCHOTE)
	(ADJECTIVE FLAMING IVORY FLAMEJANT MARFIM ACESA)
	(DESC "tocha")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT FEMBIT)
	(ACTION TORCH-OBJECT)
	(FDESC "Sobre o pedestal há uma tocha flamejante, feita de marfim.")
	(SIZE 20)
	(VALUE 14)
	(TVALUE 6)>

<OBJECT GUIDE
	(IN DAM-LOBBY)
	(SYNONYM GUIDE BOOK BOOKS GUIDEBOOKS GUIA GUIAS LIVRO LIVRETO)
	(ADJECTIVE TOUR GUIDE TURISTICO TURISTICOS)
	(DESC "guia turístico")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(FDESC
"Sobre o balcão da recepção há alguns guias turísticos intitulados
\"Barragem de Controle de Enchentes #3\".")
	(TEXT
"\"	Barragem de Controle de Enchentes #3|
|
A BCE#3 foi construída no ano 783 do Grande Império Subterrâneo para
domar o poderoso Rio Frígido. A obra contou com uma verba de 37 milhões de
zorkmids concedida pelo seu tirano local onipotente, Lorde Dimwit
Flathead, o Excessivo. Esta impressionante estrutura é composta de 10.477
metros cúbicos de concreto, tem 78 metros de altura no centro e 59 metros
de largura no topo. O lago formado atrás da barragem tem um volume de 48
milhões de metros cúbicos, uma área de 1,1 milhão de metros quadrados e
11 quilômetros de margem.|
|
A construção da BCE#3 levou 112 dias, do primeiro buraco cavado à
inauguração. Ela exigiu uma força de trabalho de 384 escravos, 34
feitores, 12 engenheiros, 2 rolinhas e uma perdiz numa pereira. A obra foi
gerenciada por uma equipe de comando formada por 2.345 burocratas, 2.347
secretárias (pelo menos duas delas sabiam datilografar), 12.256
embaralhadores de papel, 52.469 carimbadores, 245.193 processadores de
papelada e quase um milhão de árvores mortas.|
|
Agora vamos destacar algumas das características mais interessantes da
BCE#3 enquanto conduzimos você numa visita guiada pelas instalações:|
|
        1) Você começa a visita aqui na Recepção da Barragem. Repare que,
à sua direita, ...." )>

<OBJECT TROLL
	(IN TROLL-ROOM)
	(SYNONYM TROLL)
	(ADJECTIVE NASTY MALVADO HORRENDO)
	(DESC "troll")
	(FLAGS ACTORBIT OPENBIT TRYTAKEBIT)
	(ACTION TROLL-FCN)
	(LDESC
"Um troll de aspecto ameaçador, brandindo um machado ensanguentado,
bloqueia todas as saídas da sala.")
	(STRENGTH 2)>

<OBJECT TRUNK
	(IN RESERVOIR)
	(SYNONYM TRUNK CHEST JEWELS TREASURE TREASURES TESOURO TESOUROS BAU)
	;"PT: JOIAS só como adjetivo (pegue as joias também funciona). Como
	  substantivo, estragaria \"ovo cravejado de joias\"."
	(ADJECTIVE OLD VELHO JOIAS)
	(DESC "baú de joias")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC
"Meio enterrado na lama, há um baú velho abarrotado de joias.")
	(LDESC "Há aqui um baú velho, abarrotado de joias variadas.")
	(ACTION TRUNK-F)
	(SIZE 35)
	(VALUE 15)
	(TVALUE 5)>

<OBJECT TUBE
	(IN MAINTENANCE-ROOM)
	(SYNONYM TUBE TOOTH PASTE TUBO BISNAGA CREME PASTA)
	(ADJECTIVE CREME DENTAL PASTA)
	(DESC "tubo")
	(FLAGS TAKEBIT CONTBIT READBIT)
	(ACTION TUBE-FUNCTION)
	(LDESC
	 "Há aqui um objeto que parece um tubo de creme dental.")
	(CAPACITY 7)
	(SIZE 5)
	(TEXT
"---> Companhia Frobozz de Gosma Mágica <---|
	  Gosma Multiuso")>

<OBJECT PUTTY
	(IN TUBE)
	(SYNONYM MATERIAL GUNK GOSMA MASSA COLA)
	(ADJECTIVE VISCOUS VISCOSO)
	(DESC "material viscoso")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 6)
	(ACTION PUTTY-FCN)>

<OBJECT ENGRAVINGS
	(IN ENGRAVINGS-CAVE)
	(SYNONYM WALL ENGRAVINGS INSCRIPTION PAREDE PAREDES INSCRICOES INSCRICAO
		 GRAVURAS ENTALHES)
	(ADJECTIVE OLD ANCIENT ANTIGAS VELHAS)
	(DESC "parede com inscrições")
	(FLAGS READBIT SACREDBIT FEMBIT)
	(LDESC "Há inscrições antigas nas paredes aqui.")
	(TEXT
"As inscrições foram talhadas na rocha viva da parede da caverna por uma
mão desconhecida. Elas retratam, de forma simbólica, as crenças dos antigos
zorkianos. Habilmente entremeados aos baixos-relevos, há trechos que ilustram
os principais dogmas religiosos daquela época. Infelizmente, uma era
posterior parece tê-los considerado blasfemos e, com a mesma habilidade,
os apagou.")>

<OBJECT OWNERS-MANUAL
	(IN STUDIO)
	(SYNONYM MANUAL PIECE PAPER PEDACO PAPEL)
	(ADJECTIVE ZORK OWNERS SMALL PROPRIETA DONO PEQUENO PAPEL)
	(DESC "manual do proprietário do ZORK")
	(FLAGS READBIT TAKEBIT)
	(FDESC "Preso de qualquer jeito a uma parede, há um pequeno pedaço de papel.")
	(TEXT
"Parabéns!|
|
Você é o privilegiado proprietário do ZORK I: O Grande Império
Subterrâneo, um universo autossuficiente que faz a própria manutenção. Se
usado e mantido de acordo com as práticas normais de operação de
universos pequenos, o ZORK vai proporcionar muitos meses de funcionamento
sem problemas.")>

<OBJECT CLIMBABLE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM WALL CLIFF WALLS LEDGE)
	(ADJECTIVE ROCKY SHEER)
	(DESC "cliff")
	(ACTION CLIFF-OBJECT)
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT WHITE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM CLIFF CLIFFS PENHASCO PENHASCOS ROCHEDO ROCHEDOS)
	(ADJECTIVE WHITE BRANCO BRANCOS)
	(DESC "penhascos brancos")
	(FLAGS NDESCBIT CLIMBBIT PLURALBIT)
	(ACTION WCLIF-OBJECT)>

<OBJECT WRENCH
	(IN MAINTENANCE-ROOM)
	(SYNONYM WRENCH TOOL TOOLS CHAVE FERRAMENTA FERRAMENTAS)
	(ADJECTIVE INGLESA)
	(DESC "chave inglesa")
	(FLAGS TAKEBIT TOOLBIT FEMBIT)
	(SIZE 10)>

<OBJECT CONTROL-PANEL
	(IN DAM-ROOM)
	(SYNONYM PANEL PAINEL)
	(ADJECTIVE CONTROL CONTROLE)
	(DESC "painel de controle")
	(FLAGS NDESCBIT)>

<OBJECT NEST
	(IN UP-A-TREE)
	(SYNONYM NEST NINHO)
	(ADJECTIVE BIRDS PASSARO PASSARINHO)
	(DESC "ninho de passarinho")
	(FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(FDESC "Ao seu lado, no galho, há um pequeno ninho de passarinho.")
	(CAPACITY 20)>

<OBJECT EGG
	(IN NEST)
	(SYNONYM EGG TREASURE TREASURES OVO TESOURO TESOUROS)
	(ADJECTIVE BIRDS ENCRUSTED JEWELED CRAVEJADO JOIAS PASSARO)
	(DESC "ovo cravejado de joias")
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION EGG-OBJECT)
	(VALUE 5)
	(TVALUE 5)
	(CAPACITY 6)
	(FDESC
"No ninho de passarinho há um ovo grande cravejado de pedras preciosas,
pelo jeito surrupiado por algum pássaro canoro sem filhotes. O ovo é
coberto de finos embutidos de ouro e enfeitado com lápis-lazúli e
madrepérola. Ao contrário da maioria dos ovos, este tem dobradiças e
está fechado por um fecho de aparência delicada. O ovo parece
extremamente frágil.")>

<OBJECT BROKEN-EGG
	(SYNONYM EGG TREASURE TREASURES OVO TESOURO TESOUROS)
	(ADJECTIVE BROKEN BIRDS ENCRUSTED JEWEL QUEBRADO CRAVEJADO JOIAS PASSARO)
	(DESC "ovo quebrado cravejado de joias")
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(CAPACITY 6)
	(TVALUE 2)
	(LDESC "Há um ovo meio arruinado aqui.")>

<OBJECT BAUBLE
	(SYNONYM BAUBLE TREASURE TREASURES BERLOQUE TESOURO TESOUROS)
	(ADJECTIVE BRASS BEAUTIFUL LATAO LINDO)
	(DESC "lindo berloque de latão")
	(FLAGS TAKEBIT)
	(VALUE 1)
	(TVALUE 1)>

<OBJECT CANARY
	(IN EGG)
	(SYNONYM CANARY TREASURE TREASURES CANARIO TESOURO TESOUROS)
	(ADJECTIVE CLOCKWORK GOLD GOLDEN CORDA DOURADO OURO)
	(DESC "canário de corda dourado")
	(FLAGS TAKEBIT SEARCHBIT)
	(ACTION CANARY-OBJECT)
	(VALUE 6)
	(TVALUE 4)
	(FDESC
"Há um canário de corda dourado aninhado no ovo. Ele tem olhos de rubi
e bico de prata. Por uma janelinha de cristal sob a asa esquerda, dá
para ver o mecanismo complexo que ele tem por dentro. Parece que a
corda dele acabou.")>

<OBJECT BROKEN-CANARY
	(IN BROKEN-EGG)
	(SYNONYM CANARY TREASURE TREASURES CANARIO TESOURO TESOUROS)
	(ADJECTIVE BROKEN CLOCKWORK GOLD GOLDEN QUEBRADO CORDA DOURADO OURO)
	(DESC "canário de corda quebrado")
	(FLAGS TAKEBIT)
	(ACTION CANARY-OBJECT)
	(TVALUE 1)
	(FDESC
"Há um canário de corda dourado aninhado no ovo. Parece que ele passou
por uma experiência ruim há pouco tempo. Os encaixes dos olhos de joia
estão vazios, e o bico de prata está amassado. Por uma janelinha de
cristal rachada sob a asa esquerda, dá para ver o que sobrou de um
mecanismo complexo. Não se sabe o que aconteceria se alguém desse corda
nele, porque a mola principal parece ter se soltado.")>

\

"SUBTITLE ROOMS"

"SUBTITLE CONDITIONAL EXIT FLAGS"

<GLOBAL CYCLOPS-FLAG <>>
<GLOBAL DEFLATE <>>
<GLOBAL DOME-FLAG <>>
<GLOBAL EMPTY-HANDED <>>
<GLOBAL LLD-FLAG <>>
<GLOBAL LOW-TIDE <>>
<GLOBAL MAGIC-FLAG <>>
<GLOBAL RAINBOW-FLAG <>>
<GLOBAL TROLL-FLAG <>>
<GLOBAL WON-FLAG <>>
<GLOBAL COFFIN-CURE <>>

"SUBTITLE FOREST AND OUTSIDE OF HOUSE"

<ROOM WEST-OF-HOUSE
      (IN ROOMS)
      (DESC "Oeste da Casa")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (NE TO NORTH-OF-HOUSE)
      (SE TO SOUTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (EAST
"A porta está tapada com tábuas, e você não consegue removê-las.")
      (SW TO STONE-BARROW IF WON-FLAG)
      (IN TO STONE-BARROW IF WON-FLAG)
      (ACTION WEST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE BOARD FOREST)>

<ROOM STONE-BARROW
      (IN ROOMS)
      (LDESC
"You are standing in front of a massive barrow of stone. In the east face
is a huge stone door which is open. You cannot see into the dark of the tomb.")
      (DESC "Stone Barrow")
      (NE TO WEST-OF-HOUSE)
      (ACTION STONE-BARROW-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROOM NORTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"Você está diante do lado norte de uma casa branca. Não há porta aqui, e
todas as janelas estão tapadas com tábuas. Ao norte, uma trilha estreita
serpenteia entre as árvores.")
      (DESC "Norte da Casa")
      (SW TO WEST-OF-HOUSE)
      (SE TO EAST-OF-HOUSE)
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NORTH TO PATH)
      (SOUTH "As janelas estão todas tapadas com tábuas.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM SOUTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"Você está diante do lado sul de uma casa branca. Não há porta aqui, e
todas as janelas estão tapadas com tábuas.")
      (DESC "Sul da Casa")
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NE TO EAST-OF-HOUSE)
      (NW TO WEST-OF-HOUSE)
      (SOUTH TO FOREST-3)
      (NORTH "As janelas estão todas tapadas com tábuas.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM EAST-OF-HOUSE
      (IN ROOMS)
      (DESC "Atrás da Casa")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (SW TO SOUTH-OF-HOUSE)
      (NW TO NORTH-OF-HOUSE)
      (EAST TO CLEARING)
      (WEST TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (IN TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (ACTION EAST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE KITCHEN-WINDOW FOREST)>

<ROOM FOREST-1
      (IN ROOMS)
      (LDESC
"Esta é uma floresta, com árvores em todas as direções. A leste, parece
haver luz do sol.")
      (DESC "Floresta")
      (UP "Não há nenhuma árvore aqui que dê para escalar.")
      (NORTH TO GRATING-CLEARING)
      (EAST TO PATH)
      (SOUTH TO FOREST-3)
      (WEST "Você precisaria de um facão para seguir mais para oeste.")
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM FOREST-2
      (IN ROOMS)
      (LDESC
"Esta é uma floresta mal iluminada, com árvores grandes por toda parte.")
      (DESC "Floresta")
      (UP "Não há nenhuma árvore aqui que dê para escalar.")
      (NORTH "Ao norte, a floresta fica impenetrável.")
      (EAST TO MOUNTAINS)
      (SOUTH TO CLEARING)
      (WEST TO PATH)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM MOUNTAINS
      (IN ROOMS)
      (LDESC "A floresta fica mais rala e revela montanhas intransponíveis.")
      (DESC "Floresta")
      (UP "As montanhas são intransponíveis.")
      (NORTH TO FOREST-2)
      (EAST "As montanhas são intransponíveis.")
      (SOUTH TO FOREST-2)
      (WEST TO FOREST-2)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE WHITE-HOUSE)>

<ROOM FOREST-3
      (IN ROOMS)
      (LDESC
"Esta é uma floresta mal iluminada, com árvores grandes por toda parte.")
      (DESC "Floresta")
      (UP "Não há nenhuma árvore aqui que dê para escalar.")
      (NORTH TO CLEARING)
      (EAST "O mato fechado impede a passagem para leste.")
      (SOUTH "Árvores derrubadas pela tempestade bloqueiam o caminho.")
      (WEST TO FOREST-1)
      (NW TO SOUTH-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM PATH
      (IN ROOMS)
      (LDESC
"Esta é uma trilha que serpenteia por uma floresta mal iluminada. Aqui a
trilha segue de norte a sul. Uma árvore especialmente grande, com alguns
galhos baixos, fica à beira da trilha.")
      (DESC "Trilha da Floresta")
      (UP TO UP-A-TREE)
      (NORTH TO GRATING-CLEARING)
      (EAST TO FOREST-2)
      (SOUTH TO NORTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM UP-A-TREE
      (IN ROOMS)
      (DESC "No Alto da Árvore")
      (DOWN TO PATH)
      (UP "Você não consegue subir mais.")
      (ACTION TREE-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE FOREST SONGBIRD WHITE-HOUSE)>

<ROOM GRATING-CLEARING
      (IN ROOMS)
      (DESC "Clareira")
      (NORTH "Ao norte, a floresta fica impenetrável.")
      (EAST TO FOREST-2)
      (WEST TO FOREST-1)
      (SOUTH TO PATH)
      (DOWN PER GRATING-EXIT)
      (ACTION CLEARING-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE GRATE)>

<ROUTINE GRATING-EXIT ()
	 <COND (,GRATE-REVEALED
		<COND (<FSET? ,GRATE ,OPENBIT>
		       ,GRATING-ROOM)
		      (T
		       <TELL "A grade está fechada!" CR>
		       <THIS-IS-IT ,GRATE>
		       <RFALSE>)>)
	       (T <TELL "Você não pode ir por aí." CR> <RFALSE>)>>

<ROOM CLEARING
      (IN ROOMS)
      (LDESC
"Você está em uma pequena clareira numa trilha bem marcada da floresta,
que se estende para leste e para oeste.")
      (DESC "Clareira")
      (UP "Não há nenhuma árvore aqui que dê para escalar.")
      (EAST TO CANYON-VIEW)
      (NORTH TO FOREST-2)
      (SOUTH TO FOREST-3)
      (WEST TO EAST-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

\

"SUBTITLE HOUSE"

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Cozinha")
      (EAST TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (WEST TO LIVING-ROOM)
      (OUT TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (UP TO ATTIC)
      (DOWN TO STUDIO IF FALSE-FLAG ELSE
	 "Só o Papai Noel desce por chaminés.")
      (ACTION KITCHEN-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (VALUE 10)
      (GLOBAL KITCHEN-WINDOW CHIMNEY STAIRS)>

<ROOM ATTIC
      (IN ROOMS)
      (LDESC "Este é o sótão. A única saída é uma escada que desce.")
      (DESC "Sótão")
      (DOWN TO KITCHEN)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Sala de Estar")
      (EAST TO KITCHEN)
      (WEST TO STRANGE-PASSAGE IF MAGIC-FLAG ELSE "A porta está pregada.")
      (DOWN PER TRAP-DOOR-EXIT)
      (ACTION LIVING-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "NAILS" NAILS-PSEUDO "NAIL" NAILS-PSEUDO
	      "PREGOS" NAILS-PSEUDO "PREGO" NAILS-PSEUDO)>

\

"SUBTITLE CELLAR AND VICINITY"

<ROOM CELLAR
      (IN ROOMS)
      (DESC "Porão")
      (NORTH TO TROLL-ROOM)
      (SOUTH TO EAST-OF-CHASM)
      (UP TO LIVING-ROOM IF TRAP-DOOR IS OPEN)
      (WEST
"Você tenta subir a rampa, mas é impossível, e acaba escorregando de volta.")
      (ACTION CELLAR-FCN)
      (FLAGS RLANDBIT)
      (VALUE 25)
      (GLOBAL TRAP-DOOR SLIDE STAIRS)>

<ROOM TROLL-ROOM
      (IN ROOMS)
      (LDESC
"Esta é uma sala pequena, com passagens a leste e ao sul e um buraco
ameaçador que leva para oeste. Manchas de sangue e arranhões profundos
(talvez feitos por um machado) marcam as paredes.")
      (DESC "Sala do Troll")
      (SOUTH TO CELLAR)
      (EAST TO EW-PASSAGE
       IF TROLL-FLAG ELSE "O troll afasta você com um gesto ameaçador.")
      (WEST TO MAZE-1
       IF TROLL-FLAG ELSE "O troll afasta você com um gesto ameaçador.")
      (FLAGS RLANDBIT)
      (ACTION TROLL-ROOM-F)>

<ROOM EAST-OF-CHASM
      (IN ROOMS)
      (LDESC
"Você está na borda leste de um abismo cujo fundo não se consegue ver.
Uma passagem estreita segue para o norte, e o caminho em que você está
continua para leste.")
      (DESC "Leste do Abismo")
      (NORTH TO CELLAR)
      (EAST TO GALLERY)
      (DOWN "O abismo provavelmente leva direto às profundezas do inferno.")
      (FLAGS RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO "ABISMO" CHASM-PSEUDO)>

<ROOM GALLERY
      (IN ROOMS)
      (LDESC
"Esta é uma galeria de arte. A maioria dos quadros foi roubada por
vândalos de gosto excepcional. Os vândalos saíram pela saída norte ou
pela saída oeste.")
      (DESC "Galeria")
      (WEST TO EAST-OF-CHASM)
      (NORTH TO STUDIO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STUDIO
      (IN ROOMS)
      (LDESC
"Isto parece ter sido o ateliê de um artista. As paredes e o chão estão
respingados de tinta de 69 cores diferentes. Curiosamente, não há nada de
valor pendurado aqui. Na extremidade sul da sala há uma porta aberta
(também coberta de tinta). Uma chaminé escura e estreita sobe a partir de
uma lareira; talvez você consiga subir por ela, mas parece improvável que
consiga descer de volta.")
      (DESC "Ateliê")
      (SOUTH TO GALLERY)
      (UP PER UP-CHIMNEY-FUNCTION)
      (FLAGS RLANDBIT)
      (GLOBAL CHIMNEY)
      (PSEUDO "DOOR" DOOR-PSEUDO "PAINT" PAINT-PSEUDO
	      "PORTA" DOOR-PSEUDO "TINTA" PAINT-PSEUDO "TINTAS" PAINT-PSEUDO)>

\

"SUBTITLE MAZE"

<ROOM MAZE-1
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (EAST TO TROLL-ROOM)
      (NORTH TO MAZE-1)
      (SOUTH TO MAZE-2)
      (WEST TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-2
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (SOUTH TO MAZE-1)
      (DOWN PER MAZE-DIODES) ;"to MAZE-4"
      (EAST TO MAZE-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-3
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (WEST TO MAZE-2)
      (NORTH TO MAZE-4)
      (UP TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-4
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (WEST TO MAZE-3)
      (NORTH TO MAZE-1)
      (EAST TO DEAD-END-1)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-1
      (IN ROOMS)
      (DESC "Beco sem Saída")
      (LDESC "Você chegou a um beco sem saída no labirinto.")
      (SOUTH TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-5
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.
Aqui jaz um esqueleto, provavelmente o que restou de um aventureiro sem
sorte.")
      (DESC "Labirinto")
      (EAST TO DEAD-END-2)
      (NORTH TO MAZE-3)
      (SW TO MAZE-6)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-2
      (IN ROOMS)
      (DESC "Beco sem Saída")
      (LDESC "Você chegou a um beco sem saída no labirinto.")
      (WEST TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-6
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (DOWN TO MAZE-5)
      (EAST TO MAZE-7)
      (WEST TO MAZE-6)
      (UP TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-7
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (UP TO MAZE-14)
      (WEST TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to DEAD-END-1"
      (EAST TO MAZE-8)
      (SOUTH TO MAZE-15)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-8
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (NE TO MAZE-7)
      (WEST TO MAZE-8)
      (SE TO DEAD-END-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-3
      (IN ROOMS)
      (DESC "Beco sem Saída")
      (LDESC "Você chegou a um beco sem saída no labirinto.")
      (NORTH TO MAZE-8)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-9
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (NORTH TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to MAZE-11"
      (EAST TO MAZE-10)
      (SOUTH TO MAZE-13)
      (WEST TO MAZE-12)
      (NW TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-10
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (EAST TO MAZE-9)
      (WEST TO MAZE-13)
      (UP TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-11
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
       (NE TO GRATING-ROOM)
      (DOWN TO MAZE-10)
      (NW TO MAZE-13)
      (SW TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM GRATING-ROOM
      (IN ROOMS)
      (DESC "Sala da Grade")
      (SW TO MAZE-11)
      (UP TO GRATING-CLEARING
       IF GRATE IS OPEN ELSE "A grade está fechada.")
      (ACTION MAZE-11-FCN)
      (GLOBAL GRATE)
      (FLAGS RLANDBIT)>

<ROOM MAZE-12
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (DOWN PER MAZE-DIODES) ;"to MAZE-5"
      (SW TO MAZE-11)
      (EAST TO MAZE-13)
      (UP TO MAZE-9)
      (NORTH TO DEAD-END-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-4
      (IN ROOMS)
      (DESC "Beco sem Saída")
      (LDESC "Você chegou a um beco sem saída no labirinto.")
      (SOUTH TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-13
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (EAST TO MAZE-9)
      (DOWN TO MAZE-12)
      (SOUTH TO MAZE-10)
      (WEST TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-14
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
       (WEST TO MAZE-15)
      (NW TO MAZE-14)
      (NE TO MAZE-7)
      (SOUTH TO MAZE-7)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-15
      (IN ROOMS)
      (LDESC
"Isto é parte de um labirinto de pequenas passagens tortuosas, todas iguais.")
      (DESC "Labirinto")
      (WEST TO MAZE-14)
      (SOUTH TO MAZE-7)
      (SE TO CYCLOPS-ROOM)
      (FLAGS RLANDBIT MAZEBIT)>

\

"SUBTITLE CYCLOPS AND HIDEAWAY"

<ROOM CYCLOPS-ROOM
      (IN ROOMS)
      (DESC "Sala do Ciclope")
      (NW TO MAZE-15)
      (EAST TO STRANGE-PASSAGE
       IF MAGIC-FLAG ELSE "A parede leste é de rocha maciça.")
      (UP TO TREASURE-ROOM IF CYCLOPS-FLAG
        ELSE "O ciclope não parece disposto a deixar você passar.")
      (ACTION CYCLOPS-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM STRANGE-PASSAGE
      (IN ROOMS)
      (LDESC
"Esta é uma passagem comprida. A oeste fica uma das entradas. A leste há
uma velha porta de madeira, com uma grande abertura (mais ou menos do
tamanho de um ciclope).")
      (DESC "Passagem Estranha")
      (WEST TO CYCLOPS-ROOM)
      (IN TO CYCLOPS-ROOM)
      (EAST TO LIVING-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TREASURE-ROOM
      (IN ROOMS)
      (LDESC
"Esta é uma sala grande, cuja parede leste é de granito maciço. Vários
sacos abandonados, que se desfazem ao toque, estão espalhados pelo chão.
Há uma saída por uma escada que desce.")
      (DESC "Sala do Tesouro")
      (DOWN TO CYCLOPS-ROOM)
      (ACTION TREASURE-ROOM-FCN)
      (FLAGS RLANDBIT ;"CANT-HAVE-ONBIT")
      (VALUE 25)
      (GLOBAL STAIRS)>

\

"SUBTITLE RESERVOIR AREA"

<ROOM RESERVOIR-SOUTH
      (IN ROOMS)
      (DESC "Represa Sul")
      (SE TO DEEP-CANYON)
      (SW TO CHASM-ROOM)
      (EAST TO DAM-ROOM)
      (WEST TO STREAM-VIEW)
      (NORTH TO RESERVOIR
       IF LOW-TIDE ELSE "Você se afogaria.")
      (ACTION RESERVOIR-SOUTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      ;"PT: o pseudo-objeto não tem gênero (é sempre o), por isso só nomes
	masculinos: lago, abismo"
      (PSEUDO "LAKE" LAKE-PSEUDO "CHASM" CHASM-PSEUDO
	      "LAGO" LAKE-PSEUDO "ABISMO" CHASM-PSEUDO)>

<ROOM RESERVOIR
      (IN ROOMS)
      (DESC "Represa")
      (NORTH TO RESERVOIR-NORTH)
      (SOUTH TO RESERVOIR-SOUTH)
      (UP TO IN-STREAM)
      (WEST TO IN-STREAM)
      (DOWN "A barragem bloqueia o caminho.")
      (ACTION RESERVOIR-FCN)
      (FLAGS NONLANDBIT )
      (PSEUDO "STREAM" STREAM-PSEUDO "RIACHO" STREAM-PSEUDO)
      (GLOBAL GLOBAL-WATER)>

<ROOM RESERVOIR-NORTH
      (IN ROOMS)
      (DESC "Represa Norte")
      (NORTH TO ATLANTIS-ROOM)
      (SOUTH TO RESERVOIR
       IF LOW-TIDE ELSE "Você se afogaria.")
      (ACTION RESERVOIR-NORTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER STAIRS)
      (PSEUDO "LAKE" LAKE-PSEUDO "LAGO" LAKE-PSEUDO)>

<ROOM STREAM-VIEW
      (IN ROOMS)
      (LDESC
"Você está numa trilha ao lado de um riacho de correnteza mansa. A trilha
acompanha o riacho, que corre de oeste para leste.")
      (DESC "Vista do Riacho")
      (EAST TO RESERVOIR-SOUTH)
      (WEST "O riacho brota de uma abertura pequena demais para você entrar.")
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO "RIACHO" STREAM-PSEUDO)>

<ROOM IN-STREAM
      (IN ROOMS)
      (LDESC
"Você está no riacho de correnteza mansa. Correnteza acima, o canal é
estreito demais para navegar, e correnteza abaixo não dá para ver o
caminho por causa das paredes tortuosas. Há uma prainha estreita onde dá
para atracar.")
      (DESC "Riacho")
      (UP "O canal é estreito demais.")
      (WEST "O canal é estreito demais.")
      (LAND TO STREAM-VIEW)
      (DOWN TO RESERVOIR)
      (EAST TO RESERVOIR)
      (FLAGS NONLANDBIT )
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO "RIACHO" STREAM-PSEUDO)>

\

"SUBTITLE MIRROR ROOMS AND VICINITY"

<ROOM MIRROR-ROOM-1
      (IN ROOMS)
      (DESC "Sala do Espelho")
      (NORTH TO COLD-PASSAGE)
      (WEST TO TWISTING-PASSAGE)
      (EAST TO SMALL-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT)>

<ROOM MIRROR-ROOM-2
      (IN ROOMS)
      (DESC "Sala do Espelho")
      (WEST TO WINDING-PASSAGE)
      (NORTH TO NARROW-PASSAGE)
      (EAST TO TINY-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SMALL-CAVE
      (IN ROOMS)
      (LDESC
"Esta é uma caverna minúscula, com entradas a oeste e ao norte, e uma escada
que desce.")
      (DESC "Caverna")
      (NORTH TO MIRROR-ROOM-1)
      (DOWN TO ATLANTIS-ROOM)
      (SOUTH TO ATLANTIS-ROOM)
      (WEST TO TWISTING-PASSAGE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM TINY-CAVE
      (IN ROOMS)
      (LDESC
"Esta é uma caverna minúscula, com entradas a oeste e ao norte, e uma escada
escura e ameaçadora que desce.")
      (DESC "Caverna")
      (NORTH TO MIRROR-ROOM-2)
      (WEST TO WINDING-PASSAGE)
      (DOWN TO ENTRANCE-TO-HADES)
      (ACTION CAVE2-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM COLD-PASSAGE
      (IN ROOMS)
      (LDESC
"Este é um corredor frio e úmido, onde uma longa passagem leste-oeste vira
um caminho que segue para o sul.")
      (DESC "Passagem Fria")
      (SOUTH TO MIRROR-ROOM-1)
      (WEST TO SLIDE-ROOM)
      (FLAGS RLANDBIT)>

<ROOM NARROW-PASSAGE
      (IN ROOMS)
      (LDESC
"Este é um corredor longo e estreito, onde uma longa passagem norte-sul fica,
por um trecho, mais estreita ainda.")
      (DESC "Passagem Estreita")
      (NORTH TO ROUND-ROOM)
      (SOUTH TO MIRROR-ROOM-2)
      (FLAGS RLANDBIT)>

<ROOM WINDING-PASSAGE
      (IN ROOMS)
      (LDESC
"Esta é uma passagem sinuosa. Parece que só há saídas a leste e ao
norte.")
      (DESC "Passagem Sinuosa")
      (NORTH TO MIRROR-ROOM-2)
      (EAST TO TINY-CAVE)
      (FLAGS RLANDBIT)>

<ROOM TWISTING-PASSAGE
      (IN ROOMS)
      (LDESC
"Esta é uma passagem sinuosa. Parece que só há saídas a leste e ao
norte.")
      (DESC "Passagem Tortuosa")
      (NORTH TO MIRROR-ROOM-1)
      (EAST TO SMALL-CAVE)
      (FLAGS RLANDBIT)>

<ROOM ATLANTIS-ROOM
      (IN ROOMS)
      (LDESC
"This is an ancient room, long under water. There is an exit to
the south and a staircase leading up.")
      (DESC "Atlantis Room")
      (UP TO SMALL-CAVE)
      (SOUTH TO RESERVOIR-NORTH)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

\

"SUBTITLE ROUND ROOM AND VICINITY"

<ROOM EW-PASSAGE
      (IN ROOMS)
      (LDESC
"Esta é uma passagem estreita de leste a oeste. Na extremidade norte da
sala, uma escada estreita desce.")
      (DESC "Passagem Leste-Oeste")
      (EAST TO ROUND-ROOM)
      (WEST TO TROLL-ROOM)
      (DOWN TO CHASM-ROOM)
      (NORTH TO CHASM-ROOM)
      (FLAGS RLANDBIT)
      (VALUE 5)
      (GLOBAL STAIRS)>

<ROOM ROUND-ROOM
      (IN ROOMS)
      (LDESC
"Esta é uma sala circular de pedra, com passagens em todas as direções.
Infelizmente, várias delas foram bloqueadas por desmoronamentos.")
      (DESC "Sala Redonda")
      (EAST TO LOUD-ROOM)
      (WEST TO EW-PASSAGE)
      (NORTH TO NS-PASSAGE)
      (SOUTH TO NARROW-PASSAGE)
      (SE TO ENGRAVINGS-CAVE)
      (FLAGS RLANDBIT)>

<ROOM DEEP-CANYON
      (IN ROOMS)
      (DESC "Cânion Profundo")
      (NW TO RESERVOIR-SOUTH) ;COFFIN-CURE
      (EAST TO DAM-ROOM)
      (SW TO NS-PASSAGE)
      (DOWN TO LOUD-ROOM)
      (FLAGS RLANDBIT)
      (ACTION DEEP-CANYON-F)
      (GLOBAL STAIRS)>

<ROOM DAMP-CAVE
      (IN ROOMS)
      (LDESC
"Esta caverna tem saídas a oeste e a leste e, para o sul, se estreita até
virar uma fenda. Aqui a terra é especialmente úmida.")
      (DESC "Caverna Úmida")
      (WEST TO LOUD-ROOM)
      (EAST TO WHITE-CLIFFS-NORTH)
      (SOUTH "A fenda é estreita demais até para a maioria dos insetos.")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK)>

<ROOM LOUD-ROOM
      (IN ROOMS)
      (DESC "Sala Barulhenta")
      (EAST TO DAMP-CAVE)
      (WEST TO ROUND-ROOM)
      (UP TO DEEP-CANYON)
      (ACTION LOUD-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM NS-PASSAGE
      (IN ROOMS)
      (LDESC
"Esta é uma passagem alta de norte a sul, que se bifurca para nordeste.")
      (DESC "Passagem Norte-Sul")
      (NORTH TO CHASM-ROOM)
      (NE TO DEEP-CANYON)
      (SOUTH TO ROUND-ROOM)
      (FLAGS RLANDBIT)>

<ROOM CHASM-ROOM
      (IN ROOMS)
      (LDESC
"Um abismo corre de sudoeste a nordeste, e o caminho o acompanha. Você
está no lado sul do abismo, onde uma fenda se abre para uma passagem.")
      (DESC "Abismo")
      (NE TO RESERVOIR-SOUTH)
      (SW TO EW-PASSAGE)
      (UP TO EW-PASSAGE)
      (SOUTH TO NS-PASSAGE)
      (DOWN "Você perdeu o juízo?")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK STAIRS)
      (PSEUDO "CHASM" CHASM-PSEUDO "ABISMO" CHASM-PSEUDO)>

\

"SUBTITLE HADES ET AL"

<ROOM ENTRANCE-TO-HADES
      (IN ROOMS)
      (DESC "Entrada do Hades")
      (UP TO TINY-CAVE)
      (IN TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Alguma força invisível impede você de atravessar o portão.")
      (SOUTH TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Alguma força invisível impede você de atravessar o portão.")
      (ACTION LLD-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)
      (PSEUDO "GATE" GATE-PSEUDO "GATES" GATE-PSEUDO
	      "PORTAO" GATE-PSEUDO "PORTOES" GATE-PSEUDO
	      "PORTAL" GATE-PSEUDO)>

<ROOM LAND-OF-LIVING-DEAD
      (IN ROOMS)
      (LDESC
"Você entrou na Terra dos Mortos-Vivos. Dá para ouvir milhares de almas
perdidas chorando e gemendo. Num canto estão empilhados os restos de dezenas
de aventureiros que passaram por aqui antes, com menos sorte que você.
Uma passagem sai para o norte.")
      (DESC "Terra dos Mortos")
      (OUT TO ENTRANCE-TO-HADES)
      (NORTH TO ENTRANCE-TO-HADES)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)>

\

"SUBTITLE DOME, TEMPLE, EGYPT"

<ROOM ENGRAVINGS-CAVE	;"was CAVE4"
      (IN ROOMS)
      (LDESC
"Você entrou em uma caverna baixa, com passagens para noroeste e para leste.")
      (DESC "Caverna das Inscrições")
      (NW TO ROUND-ROOM)
      (EAST TO DOME-ROOM)
      (FLAGS RLANDBIT)>

<ROOM EGYPT-ROOM	;"was EGYPT"
      (IN ROOMS)
      (LDESC
"Esta sala parece um túmulo egípcio. A oeste, há uma escada que
sobe.")
      (DESC "Sala Egípcia")
      (WEST TO NORTH-TEMPLE)
      (UP TO NORTH-TEMPLE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM DOME-ROOM	;"was DOME"
      (IN ROOMS)
      (DESC "Sala da Cúpula")
      (WEST TO ENGRAVINGS-CAVE)
      (DOWN TO TORCH-ROOM
       IF DOME-FLAG ELSE "Você não consegue descer sem fraturar vários ossos.")
      (ACTION DOME-ROOM-FCN)
      (FLAGS RLANDBIT)
      (PSEUDO "DOME" DOME-PSEUDO "CUPULA" DOME-PSEUDO)>

<ROOM TORCH-ROOM
      (IN ROOMS)
      (DESC "Sala da Tocha")
      (UP "Você não alcança a corda.")
      (SOUTH TO NORTH-TEMPLE)
      (DOWN TO NORTH-TEMPLE)
      (ACTION TORCH-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "DOME" DOME-PSEUDO "CUPULA" DOME-PSEUDO)>

<ROOM NORTH-TEMPLE	;"was TEMP1"
      (IN ROOMS)
      (LDESC
"Esta é a extremidade norte de um grande templo. Na parede leste há uma
inscrição antiga, provavelmente uma oração numa língua há muito esquecida.
Abaixo da oração há uma escada que desce. A parede oeste é de granito
maciço. A saída, no lado norte da sala, passa entre enormes pilares de
mármore.")
      (DESC "Templo")
      (DOWN TO EGYPT-ROOM)
      (EAST TO EGYPT-ROOM)
      (NORTH TO TORCH-ROOM)
      (OUT TO TORCH-ROOM)
      (UP TO TORCH-ROOM)
      (SOUTH TO SOUTH-TEMPLE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM SOUTH-TEMPLE	;"was TEMP2"
      (IN ROOMS)
      (LDESC

"Esta é a extremidade sul de um grande templo. À sua frente está o que
parece ser um altar. Num canto há um pequeno buraco no chão, que leva à
escuridão. Você provavelmente não conseguiria subir de volta por ele.")
      (DESC "Altar")
      (NORTH TO NORTH-TEMPLE)
      (DOWN TO TINY-CAVE
       IF COFFIN-CURE
       ELSE "Nem rezando muito você conseguiria levar o caixão lá para baixo.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (ACTION SOUTH-TEMPLE-FCN)>

\

"SUBTITLE FLOOD CONTROL DAM #3"

<ROOM DAM-ROOM	;"was DAM"
      (IN ROOMS)
      (DESC "Barragem")
      (SOUTH TO DEEP-CANYON)
      (DOWN TO DAM-BASE)
      (EAST TO DAM-BASE)
      (NORTH TO DAM-LOBBY)
      (WEST TO RESERVOIR-SOUTH)
      (ACTION DAM-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>

<ROOM DAM-LOBBY	;"was LOBBY"
      (IN ROOMS)
      (LDESC
"Esta sala parece ter sido a sala de espera dos grupos que visitavam a
barragem. Há passagens abertas ao norte e a leste com a placa
\"Privativo\", e uma trilha segue para o sul por cima da barragem.")
      (DESC "Recepção da Barragem")
      (SOUTH TO DAM-ROOM)
      (NORTH TO MAINTENANCE-ROOM)
      (EAST TO MAINTENANCE-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MAINTENANCE-ROOM	;"was MAINT"
      (IN ROOMS)
      (LDESC
"Esta parece ter sido a sala de manutenção da Barragem de Controle de
Enchentes #3. Pelo visto, a sala foi saqueada há pouco tempo, porque quase
todo o equipamento de valor sumiu. Na parede à sua frente há uma fileira
de botões: um azul, um amarelo, um marrom e um vermelho. Há passagens a
oeste e ao sul.")
      (DESC "Sala de Manutenção")
      (SOUTH TO DAM-LOBBY)
      (WEST TO DAM-LOBBY)
      (FLAGS RLANDBIT)>

\

"SUBTITLE RIVER AREA"

<ROOM DAM-BASE	;"was DOCK"
      (IN ROOMS)
      (LDESC
"Você está na base da Barragem de Controle de Enchentes #3, que se ergue
imponente acima de você, ao norte. O Rio Frígido passa por aqui. Ao longo
do rio ficam os Penhascos Brancos, que parecem formar muralhas gigantes de
norte a sul pelas margens do rio, enquanto ele serpenteia rio abaixo.")
      (DESC "Base da Barragem")
      (NORTH TO DAM-ROOM)
      (UP TO DAM-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-1	;"was RIVR1"
      (IN ROOMS)
      (LDESC
"Você está no Rio Frígido, perto da Barragem. Aqui o rio corre tranquilo.
Há um ponto de desembarque na margem oeste.")
      (DESC "Rio Frígido")
      (UP "As correntes fortes não deixam você subir o rio.")
      (WEST TO DAM-BASE)
      (LAND TO DAM-BASE)
      (DOWN TO RIVER-2)
      (EAST "Os Penhascos Brancos impedem que você atraque aqui.")
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-2	;"was RIVR2"
      (IN ROOMS)
      (LDESC
"Aqui o rio faz uma curva, e não dá mais para ver a Barragem. Os
Penhascos Brancos se erguem na margem leste, e pedras grandes impedem o
desembarque na margem oeste.")
      (DESC "Rio Frígido")
      (UP "As correntes fortes não deixam você subir o rio.")
      (DOWN TO RIVER-3)
      (LAND "Não há nenhum lugar seguro para atracar aqui.")
      (EAST "Os Penhascos Brancos impedem que você atraque aqui.")
      (WEST "Bem na hora, você desvia das pedras.")
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-3	;"was RIVR3"
      (IN ROOMS)
      (LDESC
"Aqui o rio desce para um vale. Há uma praia estreita na margem oeste, ao
pé dos penhascos. Ao longe, dá para ouvir um ronco fraco.")
      (DESC "Rio Frígido")
      (UP "As correntes fortes não deixam você subir o rio.")
      (DOWN TO RIVER-4)
      (LAND TO WHITE-CLIFFS-NORTH)
      (WEST TO WHITE-CLIFFS-NORTH)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM WHITE-CLIFFS-NORTH	;"was WCLF1"
      (IN ROOMS)
      (LDESC
"Você está numa faixa estreita de praia que corre ao pé dos Penhascos
Brancos. Uma trilha estreita segue para o sul ao longo dos Penhascos, e uma
passagem apertada leva para oeste, para dentro dos próprios penhascos.")
      (DESC "Praia dos Penhascos Brancos")
      (SOUTH TO WHITE-CLIFFS-SOUTH IF DEFLATE ELSE "O caminho é estreito demais.")
      (WEST TO DAMP-CAVE IF DEFLATE ELSE "O caminho é estreito demais.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM WHITE-CLIFFS-SOUTH	;"was WCLF2"
      (IN ROOMS)
      (LDESC
"Você está numa faixa estreita e pedregosa de praia, ao lado dos
Penhascos. Uma trilha estreita segue para o norte pela margem.")
      (DESC "Praia dos Penhascos Brancos")
      (NORTH TO WHITE-CLIFFS-NORTH
       IF DEFLATE ELSE "O caminho é estreito demais.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM RIVER-4	;"was RIVR4"
      (IN ROOMS)
      (LDESC
"Aqui o rio corre mais rápido, e o som mais adiante parece ser de água em
turbilhão. Na margem leste há uma praia de areia. Também dá para ver um
pequeno trecho de praia ao pé dos penhascos, na margem oeste.")
      (DESC "Rio Frígido")
      (UP "As correntes fortes não deixam você subir o rio.")
      (DOWN TO RIVER-5)
      (LAND "Você pode atracar a leste ou a oeste.")
      (WEST TO WHITE-CLIFFS-SOUTH)
      (EAST TO SANDY-BEACH)
      (ACTION RIVR4-ROOM)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-5	;"was RIVR5"
      (IN ROOMS)
      (LDESC
"Aqui o barulho da água em turbilhão é quase insuportável. Na margem
leste há uma área grande para desembarque.")
      (DESC "Rio Frígido")
      (UP "As correntes fortes não deixam você subir o rio.")
      (EAST TO SHORE)
      (LAND TO SHORE)
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SHORE	;"was FANTE"
      (IN ROOMS)
      (LDESC
"Você está na margem leste do rio. Aqui a água parece um tanto
traiçoeira. Uma trilha vai de norte a sul, e a ponta sul logo dobra uma
curva fechada.")
      (DESC "Margem")
      (NORTH TO SANDY-BEACH)
      (SOUTH TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-BEACH	;"was BEACH"
      (IN ROOMS)
      (LDESC

"Você está numa grande praia de areia na margem leste do rio, que passa
depressa. Uma trilha acompanha o rio para o sul, e a nordeste há uma
passagem parcialmente soterrada pela areia.")
      (DESC "Praia de Areia")
      (NE TO SANDY-CAVE)
      (SOUTH TO SHORE)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-CAVE	;"was TCAVE"
      (IN ROOMS)
      (LDESC
"Esta é uma caverna cheia de areia, com a saída a sudoeste.")
      (DESC "Caverna de Areia")
      (SW TO SANDY-BEACH)
      (FLAGS RLANDBIT)>

<ROOM ARAGAIN-FALLS	;"was FALLS"
      (IN ROOMS)
      (DESC "Aragain Falls")
      (WEST TO ON-RAINBOW IF RAINBOW-FLAG)
      (DOWN "It's a long way...")
      (NORTH TO SHORE)
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (ACTION FALLS-ROOM)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER RAINBOW)>

<ROOM ON-RAINBOW	;"was RAINB"
      (IN ROOMS)
      (LDESC
"You are on top of a rainbow (I bet you never thought you would walk
on a rainbow), with a magnificent view of the Falls. The rainbow
travels east-west here.")
      (DESC "On the Rainbow")
      (WEST TO END-OF-RAINBOW)
      (EAST TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL RAINBOW)>

<ROOM END-OF-RAINBOW	;"was POG"
      (IN ROOMS)
      (LDESC
"You are on a small, rocky beach on the continuation of the Frigid
River past the Falls. The beach is narrow due to the presence of the
White Cliffs. The river canyon opens here and sunlight shines in
from above. A rainbow crosses over the falls to the east and a narrow
path continues to the southwest.")
      (DESC "End of Rainbow")
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (NE TO ON-RAINBOW IF RAINBOW-FLAG)
      (EAST TO ON-RAINBOW IF RAINBOW-FLAG)
      (SW TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RAINBOW RIVER)>

<ROOM CANYON-BOTTOM	;"was CLBOT"
      (IN ROOMS)
      (LDESC
"You are beneath the walls of the river canyon which may be climbable
here. The lesser part of the runoff of Aragain Falls flows by below.
To the north is a narrow path.")
      (DESC "Canyon Bottom")
      (UP TO CLIFF-MIDDLE)
      (NORTH TO END-OF-RAINBOW)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER CLIMBABLE-CLIFF RIVER)>

<ROOM CLIFF-MIDDLE	;"was CLMID"
      (IN ROOMS)
      (LDESC
"You are on a ledge about halfway up the wall of the river canyon.
You can see from here that the main flow from Aragain Falls twists
along a passage which it is impossible for you to enter. Below you is the
canyon bottom. Above you is more cliff, which appears
climbable.")
      (DESC "Rocky Ledge")
      (UP TO CANYON-VIEW)
      (DOWN TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER)>

<ROOM CANYON-VIEW	;"was CLTOP"
      (IN ROOMS)
      (LDESC
"You are at the top of the Great Canyon on its west wall. From here
there is a marvelous view of the canyon and parts of the Frigid River
upstream. Across the canyon, the walls of the White Cliffs join the
mighty ramparts of the Flathead Mountains to the east. Following the
Canyon upstream to the north, Aragain Falls may be seen, complete with
rainbow. The mighty Frigid River flows out from a great dark cavern. To
the west and south can be seen an immense forest, stretching for miles
around. A path leads northwest. It is possible to climb down into
the canyon from here.")
      (DESC "Canyon View")
      (EAST TO CLIFF-MIDDLE)
      (DOWN TO CLIFF-MIDDLE)
      (NW TO CLEARING)
      (WEST TO FOREST-3)
      (SOUTH "Storm-tossed trees block your way.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER RAINBOW)
      (ACTION CANYON-VIEW-F)>

<ROUTINE CANYON-VIEW-F (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? LEAP>
		     <NOT ,PRSO>>
		<JIGS-UP "Nice view, lousy place to jump.">
		<RTRUE>)>>
	       

\

"SUBTITLE COAL MINE AREA"

<ROOM MINE-ENTRANCE	;"was ENTRA"
      (IN ROOMS)
      (LDESC

"You are standing at the entrance of what might have been a coal mine.
The shaft enters the west wall, and there is another exit on the south
end of the room.")
      (DESC "Mine Entrance")
      (SOUTH TO SLIDE-ROOM)
      (IN TO SQUEEKY-ROOM)
      (WEST TO SQUEEKY-ROOM)
      (FLAGS RLANDBIT)>

<ROOM SQUEEKY-ROOM	;"was SQUEE"
      (IN ROOMS)
      (LDESC
"You are in a small room. Strange squeaky sounds may be heard coming
from the passage at the north end. You may also escape to the east.")
      (DESC "Squeaky Room")
      (NORTH TO BAT-ROOM)
      (EAST TO MINE-ENTRANCE)
      (FLAGS RLANDBIT)>

<ROOM BAT-ROOM	;"was BATS"
      (IN ROOMS)
      (DESC "Bat Room")
      (SOUTH TO SQUEEKY-ROOM)
      (EAST TO SHAFT-ROOM)
      (ACTION BATS-ROOM)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM SHAFT-ROOM	;"was TSHAF"
      (IN ROOMS)
      (LDESC
"This is a large room, in the middle of which is a small shaft
descending through the floor into darkness below. To the west and
the north are exits from this room. Constructed over the top of the
shaft is a metal framework to which a heavy iron chain is attached.")
      (DESC "Shaft Room")
      (DOWN "You wouldn't fit and would die if you could.")
      (WEST TO BAT-ROOM)
      (NORTH TO SMELLY-ROOM)
      (FLAGS RLANDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM SMELLY-ROOM	;"was SMELL"
      (IN ROOMS)
      (LDESC
"This is a small nondescript room. However, from the direction
of a small descending staircase a foul odor can be detected. To the
south is a narrow tunnel.")
      (DESC "Smelly Room")
      (DOWN TO GAS-ROOM)
      (SOUTH TO SHAFT-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "ODOR" GAS-PSEUDO "GAS" GAS-PSEUDO)>

<ROOM GAS-ROOM	;"was BOOM"
      (IN ROOMS)
      (LDESC
"This is a small room which smells strongly of coal gas. There is a
short climb up some stairs and a narrow tunnel leading east.")
      (DESC "Gas Room")
      (UP TO SMELLY-ROOM)
      (EAST TO MINE-1)
      (ACTION BOOM-ROOM)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "GAS" GAS-PSEUDO "ODOR" GAS-PSEUDO)>

<ROOM LADDER-TOP	;"was TLADD"
      (IN ROOMS)
      (LDESC
"This is a very small room. In the corner is a rickety wooden
ladder, leading downward. It might be safe to descend. There is
also a staircase leading upward.")
      (DESC "Ladder Top")
      (DOWN TO LADDER-BOTTOM)
      (UP TO MINE-4)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER STAIRS)>

<ROOM LADDER-BOTTOM	;"was BLADD"
      (IN ROOMS)
      (LDESC
"This is a rather wide room. On one side is the bottom of a
narrow wooden ladder. To the west and the south are passages
leaving the room.")
      (DESC "Ladder Bottom")
      (SOUTH TO DEAD-END-5)
      (WEST TO TIMBER-ROOM)
      (UP TO LADDER-TOP)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER)>

<ROOM DEAD-END-5	;"was DEAD7"
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the mine.")
      (NORTH TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)>

<ROOM TIMBER-ROOM	;"was TIMBE"
      (IN ROOMS)
      (LDESC
"This is a long and narrow passage, which is cluttered with broken
timbers. A wide passage comes from the east and turns at the
west end of the room into a very narrow passageway. From the west
comes a strong draft.")
      (DESC "Timber Room")
      (EAST TO LADDER-BOTTOM)
      (WEST TO LOWER-SHAFT
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM LOWER-SHAFT	;"was BSHAF"
      (IN ROOMS)
      (LDESC
"This is a small drafty room in which is the bottom of a long
shaft. To the south is a passageway and to the east a very narrow
passage. In the shaft can be seen a heavy iron chain.")
      (DESC "Drafty Room")
      (SOUTH TO MACHINE-ROOM)
      (OUT TO TIMBER-ROOM
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (EAST TO TIMBER-ROOM
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM MACHINE-ROOM	;"was MACHI"
      (IN ROOMS)
      (DESC "Machine Room")
      (NORTH TO LOWER-SHAFT)
      (ACTION MACHINE-ROOM-FCN)
      (FLAGS RLANDBIT)>

\

"SUBTITLE COAL MINE"

<ROOM MINE-1	;"was MINE1"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (NORTH TO GAS-ROOM)
      (EAST TO MINE-1)
      (NE TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-2	;"was MINE2"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (NORTH TO MINE-2)
      (SOUTH TO MINE-1)
      (SE TO MINE-3)
      (FLAGS RLANDBIT)>

<ROOM MINE-3	;"was MINE3"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (SOUTH TO MINE-3)
      (SW TO MINE-4)
      (EAST TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-4	;"was MINE4"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (NORTH TO MINE-3)
      (WEST TO MINE-4)
      (DOWN TO LADDER-TOP)
      (FLAGS RLANDBIT)>

<ROOM SLIDE-ROOM	;"was SLIDE"
      (IN ROOMS)
      (LDESC
"This is a small chamber, which appears to have been part of a
coal mine. On the south wall of the chamber the letters \"Granite
Wall\" are etched in the rock. To the east is a long passage, and
there is a steep metal slide twisting downward. To the north is
a small opening.")
      (DESC "Slide Room")
      (EAST TO COLD-PASSAGE)
      (NORTH TO MINE-ENTRANCE)
      (DOWN TO CELLAR)
      (FLAGS RLANDBIT)
      (GLOBAL SLIDE)>

\

;"RANDOM TABLES FOR WALK-AROUND"

<GLOBAL HOUSE-AROUND
  <LTABLE (PURE) WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  WEST-OF-HOUSE>>

<GLOBAL FOREST-AROUND
  <LTABLE (PURE) FOREST-1 FOREST-2 FOREST-3 PATH CLEARING FOREST-1>>

<GLOBAL IN-HOUSE-AROUND
  <LTABLE (PURE) LIVING-ROOM KITCHEN ATTIC KITCHEN>>

<GLOBAL ABOVE-GROUND
  <LTABLE (PURE) WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  FOREST-1 FOREST-2 FOREST-3 PATH CLEARING GRATING-CLEARING
	  CANYON-VIEW>>

;"The GO routine must live here."

<ROUTINE GO ()
	<ENABLE <QUEUE I-FIGHT -1>>
	<QUEUE I-SWORD -1>
	<ENABLE <QUEUE I-THIEF -1>>
	<QUEUE I-CANDLES 40>
	<QUEUE I-LANTERN 200>
	<PUTP ,INFLATED-BOAT ,P?VTYPE ,NONLANDBIT>
	<PUT ,DEF1-RES 1 <REST ,DEF1 2>>
	<PUT ,DEF1-RES 2 <REST ,DEF1 4>>
	<PUT ,DEF2-RES 2 <REST ,DEF2B 2>>
	<PUT ,DEF2-RES 3 <REST ,DEF2B 4>>
	<PUT ,DEF3-RES 1 <REST ,DEF3A 2>>
	<PUT ,DEF3-RES 3 <REST ,DEF3B 2>>
	<SETG HERE ,WEST-OF-HOUSE>
	<THIS-IS-IT ,MAILBOX>
	<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
	       <V-VERSION>
	       <CRLF>)>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<V-LOOK>
	<MAIN-LOOP>
	<AGAIN>>