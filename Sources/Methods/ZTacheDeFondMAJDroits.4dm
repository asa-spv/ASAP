//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 05/05/18, 09:27:16
  // ----------------------------------------------------
  // Pas de paramètre : tout est dans [XTachesDeFond]ObjetTdF
  // ----------------------------------------------------
  // Méthode : ZTacheDeFondMAJDroits
  // Description
  // Permet, à partir d'une fonction modifiée, 
  //  d'actualiser les droits des utilisateurs

C_LONGINT:C283($Salé;$FT)
$NumEnr:=OB Get:C1224([XTachesDeFond:10]ObjetTdF:2;"NumEnr")

GOTO RECORD:C242([XFonctions:3];$NumEnr)
RELATE MANY:C262([XFonctions:3]UUID:1)  // Rappel des [XProfils] et des [XAttributions]
RELATE ONE SELECTION:C349([XAttributions:5];[XUtilisateurs:2])  // rappel des utilisateurs ayant cette fonction

$FT:=Records in selection:C76([XUtilisateurs:2])
FIRST RECORD:C50([XUtilisateurs:2])
For ($Salé;1;$FT)
	ZDroitsRecalcule (True:C214;True:C214)
	NEXT RECORD:C51([XUtilisateurs:2])
End for 