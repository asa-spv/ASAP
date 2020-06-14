
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(PUMTypeGraphe;5)
		PUMTypeGraphe{1}:="Colonnes"
		PUMTypeGraphe{2}:="Points"
		PUMTypeGraphe{3}:="Lignes"
		PUMTypeGraphe{4}:="Aires"
		PUMTypeGraphe{5}:="Camembert"
		PUMTypeGraphe:=1
		
		ARRAY LONGINT:C221(PUMNbGraphe;5)
		PUMNbGraphe{1}:=1
		PUMNbGraphe{2}:=6
		PUMNbGraphe{3}:=4
		PUMNbGraphe{4}:=5
		PUMNbGraphe{5}:=7
		PUMNbGraphe:=1
		
	: ($evt=Sur données modifiées:K2:15)
		GRAPH:C169(VarGraphe;PUMNbGraphe{PUMTypeGraphe};TbXGraph;TbNbLaboGraph)
		
End case 
