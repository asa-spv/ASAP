//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 19/07/18, 14:54:36
  // ----------------------------------------------------
  // Méthode : ASAPObjetNomProprio
  // Description
  // Méthode qui permet de récupérer sous forme texte 
  //. la liste des propriétés d'un objet 4D
  // Paramètre : $1 = Pt sur le champ objet
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
ARRAY OBJECT:C1221($TbArguments;0)

$PtChamp:=$1

$PtTable:=Table:C252(Table:C252($PtChamp))
ALL RECORDS:C47($PtTable->)
SELECTION TO ARRAY:C260($PtChamp->;$TbArguments)
$FT:=Size of array:C274($TbArguments)
ARRAY TEXT:C222($TbProDistinctes;0)
ARRAY TEXT:C222($TbNomProprio;0)
For ($Salé;1;$FT)
	OB GET PROPERTY NAMES:C1232($TbArguments{$Salé};$TbNomProprio)
	$SFT:=Size of array:C274($TbNomProprio)
	For ($Fumé;1;$SFT)
		If (Find in array:C230($TbProDistinctes;$TbNomProprio{$Fumé})<0)
			APPEND TO ARRAY:C911($TbProDistinctes;$TbNomProprio{$Fumé})
		End if 
	End for 
End for 
  // FIXER TEXTE DANS CONTENEUR(ZTableauVersTexte (->$TbProDistinctes))
