//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 11/09/17, 16:23:55
  // ----------------------------------------------------
  // Méthode : RaemaTendanceBouFinal
  // Description : Calcul des tableaux des occurrences
  // du dialogue
  // ----------------------------------------------------

C_LONGINT:C283($C;$L;$salé;$TT)
If (Count parameters:C259=0)
	LISTBOX GET CELL POSITION:C971(ListBoxChose;$C;$L)
	VarGerme:=ZoneChose{$L}
	Case of 
		: (CaCMethode=1)
			VarNature:="Méthode"
			
		: (CaCFabricant=1)
			VarNature:="Fabricant"
			
		: (CaCMilieu=1)
			VarNature:="Milieu"
			
	End case 
End if 

ARRAY TEXT:C222(Colonne9;0)
ARRAY LONGINT:C221(Colonne10N;0)
ARRAY LONGINT:C221(Colonne11N;0)
ARRAY LONGINT:C221(Colonne12N;0)

ARRAY TEXT:C222($TbRaemaConcernes;2)
$TbRaemaConcernes{1}:=TbNR{TbNR+4}
$TbRaemaConcernes{2}:=TbNR{TbNR+2}
$TT:=Size of array:C274(TbPL)
For ($salé;1;$TT)
	$Germe:=TbGerme{$salé}
	$Nature:=TbNature{$salé}
	If (($Nature=VarNature) & ($Germe=VarGerme))
		$CampagneConcernee:=TbNumCampagne{$salé}
		$Valeurs:=TbValeurs{$salé}
		$Occurrence:=TbOccurrence{$salé}
		$Rang:=TbRangLigne{$salé}
		If ($CampagneConcernee=$TbRaemaConcernes{1})
			APPEND TO ARRAY:C911(Colonne9;$Valeurs)
			APPEND TO ARRAY:C911(Colonne10N;0)
			APPEND TO ARRAY:C911(Colonne11N;$Occurrence)
			APPEND TO ARRAY:C911(Colonne12N;$Rang)
		Else 
			$L:=Find in array:C230(Colonne9;$Valeurs)
			If ($L>0)
				Colonne10N{$L}:=$Occurrence
			Else 
				APPEND TO ARRAY:C911(Colonne9;$Valeurs)
				APPEND TO ARRAY:C911(Colonne11N;0)
				APPEND TO ARRAY:C911(Colonne10N;$Occurrence)
				APPEND TO ARRAY:C911(Colonne12N;$Rang)
			End if 
		End if 
	End if 
End for 
SORT ARRAY:C229(Colonne12N;Colonne9;Colonne10N;Colonne11N;>)