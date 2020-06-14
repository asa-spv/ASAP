//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/02/19, 17:14:57
  // ----------------------------------------------------
  // Méthode : ASAPPerCreationChampRecherche
  // Description
  // Méthode qui attribue les valeurs nécessaires au champ 
  //
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)

$MotsClefs:=[Personnes:12]Identificateur:4+" "+[Personnes:12]NomCourt:3+" "+[Personnes:12]NomLong:2+" "
OB GET PROPERTY NAMES:C1232([Personnes:12]Arguments:7;$TbProprio)
$FT:=Size of array:C274($TbProprio)
For ($Salé;1;$FT)
	$NomArgumentCourant:=$TbProprio{$Salé}
	$ValeurCourante:=OB Get:C1224([Personnes:12]Arguments:7;$NomArgumentCourant)
	If ($NomArgumentCourant="tb@")  // tableau
		ARRAY TEXT:C222($TbArg;0)
		  //COLLECTION VERS TABLEAU($ValeurCourante;$TbArg)
		OB GET ARRAY:C1229([Personnes:12]Arguments:7;$NomArgumentCourant;$TbArg)
		$ValeurCourante:=ZTableauVersTexte (->$TbArg;",")
	End if 
	$MotsClefs:=$MotsClefs+String:C10($ValeurCourante)+" "
End for 
RELATE MANY:C262([Personnes:12]UUID:1)
SELECTION TO ARRAY:C260([PersonnesAdresses:11]LigneAdresse1:3;$TbAdresse1;[PersonnesAdresses:11]LigneAdresse2:4;$TbAdresse2\
;[PersonnesAdresses:11]LigneAdresse3:5;$TbAdresse3;[PersonnesAdresses:11]CodePostal:6;$TbCP;[PersonnesAdresses:11]Ville:7;$TbLocalité\
;[PersonnesAdresses:11]Pays:8;$TbPays)
$FT:=Size of array:C274($TbAdresse1)
For ($Salé;1;$FT)
	$MotsClefs:=$MotsClefs+$TbAdresse1{$Salé}+" "+$TbAdresse2{$Salé}+" "+$TbAdresse3{$Salé}+" "
	$MotsClefs:=$MotsClefs+$TbCP{$Salé}+" "+$TbLocalité{$Salé}+" "+$TbPays{$Salé}+" "
End for 
GET TEXT KEYWORDS:C1141($MotsClefs;$TbClefs)
$FT:=Size of array:C274($TbClefs)
For ($Salé;1;$FT)
	$MotsClefs:=$MotsClefs+ZSoundexFrance ($TbClefs{$Salé})+" "
End for 
$0:=$MotsClefs