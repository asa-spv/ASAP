
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		
		C_LONGINT:C283($Salé;$FT;$L)
		$menu:=""
		$FT:=Size of array:C274(<>TbFonctionsNomFonction)
		ARRAY TEXT:C222($TbAttribution;0)
		For ($Salé;1;$FT)
			$FonctionCourante:=<>TbFonctionsNomFonction{$Salé}
			If (Find in array:C230(TbAttributions;$FonctionCourante)<0)
				$menu:=$menu+";"+$FonctionCourante
				APPEND TO ARRAY:C911($TbAttribution;$FonctionCourante)
			End if 
		End for 
		$L:=Pop up menu:C542($menu)
		If ($L>0)  //Choix d'une fonction dans la liste
			$FonctionChoisie:=$TbAttribution{$L}
			APPEND TO ARRAY:C911(TbAttributions;$FonctionChoisie)
			$L:=Find in array:C230(<>TbFonctionsNomFonction;$FonctionChoisie)
			APPEND TO ARRAY:C911(TbUUIDFonction;<>TbFonctionsUUID{$L})
			$FT:=Size of array:C274(TbUUIDFonction)
			ARRAY TEXT:C222($TbUUIDUtilisateur;$FT)
			For ($Salé;1;$FT)
				$TbUUIDUtilisateur{$Salé}:=[XUtilisateurs:2]UUID:1
			End for 
			ARRAY TO SELECTION:C261($TbUUIDUtilisateur;[XAttributions:5]UUIDUtilisateur:2;TbUUIDFonction;[XAttributions:5]UUIDFonction:3)
			ZDroitsRecalcule 
		Else 
			ALERT:C41("Merci de choisir la fonction à attribuer à "+[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2)
		End if 
End case 
