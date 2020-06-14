//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/05/18, 20:47:19
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZLBFonctionSurChargement
  // Description
  // Permet de gérer le déplacement de fiche en fiche 
  //  en actualisant les profils

C_LONGINT:C283($Salé;$FT)

  // Chargement des [XProfils]
RELATE MANY:C262([XFonctions:3]UUID:1)
If (Records in selection:C76([XProfils:4])=0)
	$FT:=Size of array:C274(<>TbNumTableSensible)
	For ($Salé;1;$FT)  // pour chaque table potentiellement sensible
		If (<>TbSensible{$Salé})
			CREATE RECORD:C68([XProfils:4])
			[XProfils:4]Voir:4:=True:C214
			[XProfils:4]UUIDFonction:2:=[XFonctions:3]UUID:1
			[XProfils:4]NumTableSensible:3:=<>TbNumTableSensible{$Salé}
			SAVE RECORD:C53([XProfils:4])
		End if 
	End for 
	RELATE MANY:C262([XFonctions:3]UUID:1)
End if 
SELECTION TO ARRAY:C260([XProfils:4]Ajouter:5;TbAjouter\
;[XProfils:4]Imprimer:8;TbImprimer\
;[XProfils:4]Modifier:6;TbModifier\
;[XProfils:4]NumTableSensible:3;TbNumTableSensible\
;[XProfils:4]Special1:9;TbSpecial1\
;[XProfils:4]Special2:10;TbSpecial2\
;[XProfils:4]Supprimer:7;TbSupprimer\
;[XProfils:4]Voir:4;TbVoir\
;[XProfils:4]UUIDFonction:2;TbUUIDFonction)
LONGINT ARRAY FROM SELECTION:C647([XProfils:4];TbNumEnr)
$FT:=Size of array:C274(TbVoir)
ARRAY TEXT:C222(TbTableSensible;$FT)
For ($Salé;1;$FT)
	TbTableSensible{$Salé}:=Table name:C256(TbNumTableSensible{$Salé})
End for 

ModificationProfil:=False:C215  // permet de tester si les [XProfils] ont changé

C_LONGINT:C283($Salé;$FT)

  // Chargement des [XProfils]
RELATE MANY:C262([XFonctions:3]UUID:1)
If (Records in selection:C76([XProfils:4])=0)
	$FT:=Size of array:C274(<>TbNumTableSensible)
	For ($Salé;1;$FT)  // pour chaque table potentiellement sensible
		If (<>TbSensible{$Salé})
			CREATE RECORD:C68([XProfils:4])
			[XProfils:4]Voir:4:=True:C214
			[XProfils:4]UUIDFonction:2:=[XFonctions:3]UUID:1
			[XProfils:4]NumTableSensible:3:=<>TbNumTableSensible{$Salé}
			SAVE RECORD:C53([XProfils:4])
		End if 
	End for 
	RELATE MANY:C262([XFonctions:3]UUID:1)
End if 
SELECTION TO ARRAY:C260([XProfils:4]Ajouter:5;TbAjouter\
;[XProfils:4]Imprimer:8;TbImprimer\
;[XProfils:4]Modifier:6;TbModifier\
;[XProfils:4]NumTableSensible:3;TbNumTableSensible\
;[XProfils:4]Special1:9;TbSpecial1\
;[XProfils:4]Special2:10;TbSpecial2\
;[XProfils:4]Supprimer:7;TbSupprimer\
;[XProfils:4]Voir:4;TbVoir\
;[XProfils:4]UUIDFonction:2;TbUUIDFonction)
LONGINT ARRAY FROM SELECTION:C647([XProfils:4];TbNumEnr)
$FT:=Size of array:C274(TbVoir)
ARRAY TEXT:C222(TbTableSensible;$FT)
For ($Salé;1;$FT)
	TbTableSensible{$Salé}:=Table name:C256(TbNumTableSensible{$Salé})
End for 

ModificationProfil:=False:C215  // permet de tester si les [XProfils] ont changé
NumEnrFonction:=Record number:C243([XFonctions:3])

