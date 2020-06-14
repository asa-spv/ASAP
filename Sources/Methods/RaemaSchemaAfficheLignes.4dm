//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/07/18, 19:23:51
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : RaemaSchemaAfficheLignes
  // Description
  // Méthode qui affiche la sélection des lignes
  // en fonction du germe sélectionné

C_LONGINT:C283($Salé;$FT)

  // Rappel des [RAEMALignes] et affichage dans les tableaux
RELATE MANY:C262([RAEMAGermes:21]UUID:1)
ORDER BY:C49([RAEMALignes:22];[RAEMALignes:22]Identifiant:3;>)
SELECTION TO ARRAY:C260([RAEMALignes:22]NomEn:5;TbNomLigneEn\
;[RAEMALignes:22]NomFr:4;TbNomLigneFr\
;[RAEMALignes:22]Arguments:6;TbArgumentsLigne\
;[RAEMALignes:22]Identifiant:3;TbIdentifiantLigne)
LONGINT ARRAY FROM SELECTION:C647([RAEMALignes:22];TbNumEnrLigne)

$FT:=Size of array:C274(TbNomLigneFr)
ARRAY BOOLEAN:C223(TbEscamotable;$FT)
ARRAY BOOLEAN:C223(TbMultiple;$FT)
For ($Salé;1;$FT)
	TbEscamotable{$Salé}:=OB Get:C1224(TbArgumentsLigne{$Salé};"Escamotable";Est un booléen:K8:9)
	TbMultiple{$Salé}:=OB Get:C1224(TbArgumentsLigne{$Salé};"ChoixMultiple";Est un booléen:K8:9)
End for 
OBJECT SET ENTERABLE:C238(TbNomLigneFr;False:C215)
OBJECT SET ENTERABLE:C238(TbNomLigneEn;False:C215)
LISTBOX SELECT ROW:C912(*;"LignesListBox";0;lk supprimer de sélection:K53:3)

OBJECT SET ENABLED:C1123(*;"LigneBouColler";(Size of array:C274(TbNECopierLigne)>0))
