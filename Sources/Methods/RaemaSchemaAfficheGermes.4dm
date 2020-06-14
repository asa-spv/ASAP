//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/07/18, 17:51:47
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : RaemaSchemaAfficheGermes
  // Description
  // // Affiche les germes en fonction de la campagne sélectionnée

C_LONGINT:C283($Salé;$FT)

RELATE MANY:C262([RAEMACampagnes:20]UUID:1)
ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;TbNomGermeFr\
;[RAEMAGermes:21]NomEn:5;TbNomGermeEn\
;[RAEMAGermes:21]Arguments:6;$TbArgumentsGerme\
;[RAEMAGermes:21]UUID:1;TbUUIDGerme\
;[RAEMAGermes:21]Identifiant:3;TbIdentifiantGerme)
LONGINT ARRAY FROM SELECTION:C647([RAEMAGermes:21];TbNumEnrGerme)
$FT:=Size of array:C274($TbArgumentsGerme)
ARRAY BOOLEAN:C223(TbCofracGerme;$FT)
ARRAY BOOLEAN:C223(TbExperimentalGerme;$FT)
For ($Salé;1;$FT)
	TbCofracGerme{$Salé}:=OB Get:C1224($TbArgumentsGerme{$Salé};"COFRAC";Est un booléen:K8:9)
	TbExperimentalGerme{$Salé}:=OB Get:C1224($TbArgumentsGerme{$Salé};"Experimental";Est un booléen:K8:9)
End for 

LISTBOX SELECT ROW:C912(*;"GermesListBox";0;lk supprimer de sélection:K53:3)