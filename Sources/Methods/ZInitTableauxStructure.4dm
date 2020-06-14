//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 09/05/18, 05:37:41
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZInitTableauxStructure
  // Description
  // Garde en mémoire la structure de la base et 
  //  la personnalisation des ET de colonne


C_LONGINT:C283($FT;$SFT;$Salé;$Fumé)
C_POINTER:C301($PtChamp)
C_OBJECT:C1216($Objet)
ARRAY LONGINT:C221(<>TbNumChampTableBase;0)
ARRAY LONGINT:C221(<>TbNumTableBase;0)
ARRAY LONGINT:C221(<>TbNumChampBase;0)
ARRAY TEXT:C222(<>TbNomTableBase;0)
ARRAY TEXT:C222(<>TbNomChampBase;0)
ARRAY TEXT:C222(<>TbNomChampListe;0)
ARRAY TEXT:C222(<>TbCodeChampBase;0)
ARRAY LONGINT:C221(<>TbTypeChampBase;0)
ARRAY POINTER:C280(<>TbPtChampBase;0)

READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="NomChampAfficheLB";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Nom des ET des ListBox pour "+<>ZQuiCode;*)
QUERY:C277([XData:1]; & [XData:1]XAlpha:8=<>ZQuiCode)
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="NomChampAfficheLB"
	[XData:1]XNom:2:="Nom des ET des ListBox pour "+<>ZQuiCode
	[XData:1]XAlpha:8:=<>ZQuiCode
	SAVE RECORD:C53([XData:1])
End if 
$Objet:=OB Copy:C1225([XData:1]XObjet:18)
  // Initialisation des tableaux de la structure (Tables & Champs) de la base
$FT:=Get last table number:C254
For ($Salé;1;$FT)
	If (Is table number valid:C999($Salé))
		APPEND TO ARRAY:C911(<>TbNomTableBase;Table name:C256($Salé))
		APPEND TO ARRAY:C911(<>TbNumTableBase;$Salé)
		$SFT:=Get last field number:C255($Salé)
		ARRAY TEXT:C222($TbNomNTTableEnCours;0)  // le tableau des noms de champs en structure
		ARRAY TEXT:C222($TbNomETTableEnCours;0)  // le tableau des noms de champs en ET de liste
		OB GET ARRAY:C1229($Objet;"ET"+String:C10($Salé);$TbNomETTableEnCours)
		$CompteurChampValide:=0
		For ($Fumé;1;$SFT)
			If (Is field number valid:C1000($Salé;$Fumé))
				$CompteurChampValide:=$CompteurChampValide+1
				APPEND TO ARRAY:C911(<>TbNumChampTableBase;$Salé)
				APPEND TO ARRAY:C911(<>TbNumChampBase;$Fumé)
				$PtChamp:=Field:C253($Salé;$Fumé)
				$NomDuChamp:=Field name:C257($PtChamp)
				APPEND TO ARRAY:C911(<>TbPtChampBase;$PtChamp)
				APPEND TO ARRAY:C911(<>TbNomChampBase;$NomDuChamp)
				APPEND TO ARRAY:C911($TbNomNTTableEnCours;$NomDuChamp)
				If (Size of array:C274($TbNomETTableEnCours)<$CompteurChampValide)
					APPEND TO ARRAY:C911(<>TbNomChampListe;ZTexteEnCamelCaseEspacé ($NomDuChamp))
					APPEND TO ARRAY:C911($TbNomETTableEnCours;ZTexteEnCamelCaseEspacé ($NomDuChamp))
				Else 
					APPEND TO ARRAY:C911(<>TbNomChampListe;$TbNomETTableEnCours{$Fumé})
				End if 
				APPEND TO ARRAY:C911(<>TbTypeChampBase;Type:C295($PtChamp->))
			End if 
			APPEND TO ARRAY:C911(<>TbCodeChampBase;String:C10($Salé)+"_"+String:C10($Fumé))
		End for 
		OB SET ARRAY:C1227($Objet;"ET"+String:C10($Salé);$TbNomETTableEnCours)
		OB SET ARRAY:C1227($Objet;"NC"+String:C10($Salé);$TbNomNTTableEnCours)
	End if 
End for 
[XData:1]XObjet:18:=OB Copy:C1225($Objet)
SAVE RECORD:C53([XData:1])
