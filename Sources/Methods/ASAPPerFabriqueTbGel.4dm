//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 13/08/19, 10:42:26
  // ----------------------------------------------------
  // Paramètre : le numéro de la campagne
  // ----------------------------------------------------
  // Méthode : ASAPPerFabriqueTbGel
  // Description
  // Permet d'afficher le tableau des RAEMA gel 
  //  de l'année concernée en mettant en vert 
  //  les germes sélectionnés par le laboratoire
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$L;$FT;$TT)
C_TEXT:C284($NomGermeCourant)

$NumCampagne:=$1
$Suffixe:=(Num:C11(Num:C11($NumCampagne)%2=0)*"Mai")+(Num:C11(Num:C11($NumCampagne)%2=1)*"Dec")

  // Initalisation des couleurs des lignes
$CouleurVert:=0x0013E90B
$PtTbCouleur:=Get pointer:C304("TbCouleurFond"+$Suffixe)
ARRAY LONGINT:C221($PtTbCouleur->;0)

  // rappel de la campagne principale
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";=;Null:C1517)
RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)
SELECTION TO ARRAY:C260([CampagneGelGermes:25]NomDuGerme:3;$TbNomGerme;[CampagneGelGermes:25]NbreColisSupAvecRapport:5;$TbNbGelSAR;[CampagneGelGermes:25]NbreColisSupSansRapport:4;$TbNbGelSSR)
$TT:=Size of array:C274($TbNomGerme)
ARRAY TEXT:C222($TbNomGermeSchéma;$TT)
For ($Salé;1;$TT)
	$L:=Find in array:C230(<>TbNomGermeCampagneGEL;$TbNomGerme{$Salé})
	If ($L=-1)
		$L:=Find in array:C230(<>TbNomGermeSchémaGEL;$TbNomGerme{$Salé})
	End if 
	$TbNomGermeSchéma{$Salé}:=<>TbNomGermeSchémaGEL{$L}
End for 
  // Rappel des germes possibles
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]UUIDCampagne:2=[RAEMACampagnes:20]UUID:1;*)
QUERY:C277([RAEMAGermes:21]; & [RAEMAGermes:21]NomFr:4#"Condi@")
  //Tri des germes possibles
$PtTbNomDef:=Get pointer:C304("TbNomGerme"+$Suffixe)
$PtTbARDef:=Get pointer:C304("TbNbGelSAR"+$Suffixe)
$PtTbSRDef:=Get pointer:C304("TbNbGelSSR"+$Suffixe)

SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;$PtTbNomDef->)
$TT:=Size of array:C274($PtTbNomDef->)

ARRAY LONGINT:C221($PtTbARDef->;0)
ARRAY LONGINT:C221($PtTbSRDef->;0)
ARRAY LONGINT:C221($PtTbARDef->;$TT)
ARRAY LONGINT:C221($PtTbSRDef->;$TT)

ARRAY LONGINT:C221($PtTbCouleur->;$TT)

ARRAY LONGINT:C221($TbOrdre;$TT)
For ($Salé;1;$TT)
	$NomGermeCourant:=$PtTbNomDef->{$Salé}
	$L:=Find in array:C230(<>TbNomGermeSchémaGEL;$NomGermeCourant)
	$TbOrdre{$Salé}:=Num:C11(<>TbOrdreGermeCampagneGEL{$L})
	$L:=Find in array:C230($TbNomGermeSchéma;$NomGermeCourant)
	If ($L>0)
		$PtTbCouleur->{$Salé}:=$CouleurVert
		$PtTbARDef->{$Salé}:=$TbNbGelSAR{$L}
		$PtTbSRDef->{$Salé}:=$TbNbGelSSR{$L}
	Else 
		$PtTbCouleur->{$Salé}:=0x00FFFFFF
	End if 
End for 
SORT ARRAY:C229($TbOrdre;$PtTbNomDef->;$PtTbSRDef->;$PtTbARDef->;$PtTbCouleur->;>)




  // renseignement des n° de RAEMA utilisés comme RAEMA lié
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
$PtVar:=Get pointer:C304("Var"+$Suffixe+"NRL")
$PtVar->:=""
If (Records in selection:C76([CampagneParticipations:17])>0)
	ARRAY OBJECT:C1221($TbArgument;0)
	SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArgument)
	$FT:=Size of array:C274($TbArgument)
	For ($Salé;1;$FT)
		$PtVar->:=$PtVar->+","+String:C10(RAEMADemoduleMdPWeb (OB Get:C1224($TbArgument{$Salé};"CodeRaemaLié";Est un texte:K8:3)))
	End for 
	$PtVar->:=Substring:C12($PtVar->;2)
End if 
OBJECT SET VISIBLE:C603(*;("Var"+$Suffixe+"NRL");($PtVar->#""))