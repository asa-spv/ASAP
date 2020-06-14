//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 07/12/09
  // ----------------------------------------------------
  // Méthode : DeplaceLB
  // Description
  // Deplace une ligne sélectionnée dans un listbox vers une autre
  //
  // Paramètres
  // ----------------------------------------------------
  //$1 = sens
  //$2 = LB de Gauche
  //$3 = LB ID de Gauche
  //$4 = LB de Droite
  //$5 = LB ID de Droite

C_POINTER:C301($2;$3;$4;$5)
C_TEXT:C284($1)
C_LONGINT:C283($col;$line)

Case of 
		
	: ($1="Droite")  //On part de la B de Gauche et on arrive à la LB de droite
		LISTBOX GET CELL POSITION:C971($2->;$Col;$Line)
		
		If ($Line<=Size of array:C274($2->))
			INSERT IN ARRAY:C227($4->;Size of array:C274($4->)+1)
			$4->{Size of array:C274($4->)}:=$2->{$Line}
			
			INSERT IN ARRAY:C227($5->;Size of array:C274($5->)+1)
			$5->{Size of array:C274($5->)}:=$3->{$Line}
			
			DELETE FROM ARRAY:C228($2->;$Line;1)
			DELETE FROM ARRAY:C228($3->;$Line;1)
		End if 
		
	: ($1="Gauche")  //On part de la B de Droite et on arrive à la LB de Gauche
		LISTBOX GET CELL POSITION:C971($4->;$Col;$Line)
		
		If ($Line<=Size of array:C274($4->))
			INSERT IN ARRAY:C227($2->;Size of array:C274($2->)+1)
			$2->{Size of array:C274($2->)}:=$4->{$Line}
			
			INSERT IN ARRAY:C227($3->;Size of array:C274($3->)+1)
			$3->{Size of array:C274($3->)}:=$5->{$Line}
			
			DELETE FROM ARRAY:C228($4->;$Line;1)
			DELETE FROM ARRAY:C228($5->;$Line;1)
		End if 
		
End case 

  // REDESSINER FENETRE(Fenetre premier plan)

