//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/01/18, 06:16:41
  // ----------------------------------------------------
  // Méthode : ZDroitsFabriqueTbDroits
  // Description
  // Méthode qui à partir des [XAttributions] et des [XProfils] des [XFonctions]
  //  fabrique les tableaux des droits correspondants
  // ----------------------------------------------------

  // Sélectionnons les profils des différentes fonctions attribuées
RELATE MANY SELECTION:C340([XProfils:4]UUIDFonction:2)
  // Plaçons tous les renseignements utiles dans des tableaux
SELECTION TO ARRAY:C260([XProfils:4]Voir:4;$TbAccesP\
;[XProfils:4]Ajouter:5;$TbAjoutP\
;[XProfils:4]Imprimer:8;$TbImpressionP\
;[XProfils:4]Modifier:6;$TbModificationP\
;[XProfils:4]NumTableSensible:3;$TbNumTableP\
;[XProfils:4]UUIDFonction:2;$TbUUIDFonctionP\
;[XProfils:4]Special1:9;$TbSpecial1P\
;[XProfils:4]Special2:10;$TbSpecial2P\
;[XProfils:4]Supprimer:7;$TbSuppressionP)

$FT:=Size of array:C274($TbAccesP)
$SFT:=$FT/Records in selection:C76([XFonctions:3])
  // initialisons les tableaux qui recueillent les droits calculés
ARRAY TEXT:C222($TbUUIDUtilisateur;$SFT)
For ($Salé;1;$SFT)
	$TbUUIDUtilisateur{$Salé}:=[XUtilisateurs:2]UUID:1
End for 

ARRAY LONGINT:C221($TbNumTable;$SFT)
$SSFT:=Size of array:C274(<>TbNumTableSensible)
$Compteur:=1
For ($Salé;1;$SSFT)
	If (<>TbSensible{$Salé})
		$TbNumTable{$Compteur}:=<>TbNumTableSensible{$Salé}
		$Compteur:=$Compteur+1
	End if 
End for 

ARRAY BOOLEAN:C223($TbAcces;$SFT)
ARRAY BOOLEAN:C223($TbAjout;$SFT)
ARRAY BOOLEAN:C223($TbImpression;$SFT)
ARRAY BOOLEAN:C223($TbModification;$SFT)
ARRAY BOOLEAN:C223($TbSpecial1;$SFT)
ARRAY BOOLEAN:C223($TbSpecial2;$SFT)
ARRAY BOOLEAN:C223($TbSuppression;$SFT)

For ($Salé;1;$FT)
	
	$NumTableCourant:=$TbNumTableP{$Salé}
	$L:=Find in array:C230($TbNumTable;$NumTableCourant)
	
	If ($TbAccesP{$Salé})
		$TbAcces{$L}:=True:C214
	End if 
	If ($TbAjoutP{$Salé})
		$TbAjout{$L}:=True:C214
	End if 
	If ($TbImpressionP{$Salé})
		$TbImpression{$L}:=True:C214
	End if 
	If ($TbModificationP{$Salé})
		$TbModification{$L}:=True:C214
	End if 
	If ($TbSpecial1P{$Salé})
		$TbSpecial1{$L}:=True:C214
	End if 
	If ($TbSpecial2P{$Salé})
		$TbSpecial2{$L}:=True:C214
	End if 
	If ($TbSuppressionP{$Salé})
		$TbSuppression{$L}:=True:C214
	End if 
	
End for 

  // Affichage de la listbox des droits
COPY ARRAY:C226($TbAcces;TbVoir)
COPY ARRAY:C226($TbAjout;TbAjouter)
COPY ARRAY:C226($TbImpression;TbImprimer)
COPY ARRAY:C226($TbModification;TBModifier)
COPY ARRAY:C226($TbSuppression;TbSupprimer)
COPY ARRAY:C226($TbSpecial1;TbSpécial1)
COPY ARRAY:C226($TbSpecial2;TbSpécial2)
COPY ARRAY:C226($TbNumTable;TbNumTableSensible)
$FT:=Size of array:C274(TbVoir)
ARRAY TEXT:C222(TbTableSensible;$FT)
For ($Salé;1;$FT)
	$NumTableCourant:=$TbNumTable{$Salé}
	TbTableSensible{$Salé}:=Table name:C256($NumTableCourant)
End for 