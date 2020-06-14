
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(TbLiaison;0)
		ARRAY TEXT:C222(TbProprio;0)
		ARRAY TEXT:C222(TbComparateur;0)
		ARRAY TEXT:C222(TbValeurs;0)
		ARRAY TEXT:C222(TbEnsemble;0)
		ARRAY LONGINT:C221(TbNb;0)
		
		LISTBOX DELETE ROWS:C914(*;"ListBoxRecherche";1;Size of array:C274(TbProprio))
		LISTBOX INSERT ROWS:C913(*;"ListBoxRecherche";1;1)
		TbLiaison{1}:="ET"
		EDIT ITEM:C870(TbProprio;1)
		VarNbEnrTrouvés:=0
		VarNbEnrTrouvésSel:=0
End case 
