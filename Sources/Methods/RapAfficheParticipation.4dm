//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 23/04/19, 06:33:55
  // ----------------------------------------------------
  // Méthode : RapAfficheParticipation
  // Description
  //   Méthode qui affiche la participation du laboratoire
  //   à partir des tableaux du formulaire projet 'DlgSuiviRapport'
  // Paramètre : Pt sur le tableau
  // ----------------------------------------------------
C_POINTER:C301($1;$Pt)
C_TEXT:C284($Ident;$NumLaboA)

$Pt:=$1
$NumLaboA:=String:C10($Pt->{$Pt->})  // N°du laboratoire double-cliqué
$CampagneCourante:=<>PUMCampagne{<>PUMCampagne}
$Pos:=Position:C15("-";$NumLaboA)
If ($Pos=0)
	$Ident:=$NumLaboA+"_"+$CampagneCourante+"_"
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Ident)
Else 
	  // allons chercher dans <>TbLotoNumLaboRapportCampagne type "615_66" la ligne adéquate
	$test:=Substring:C12($NumLaboA;($Pos+1))+"_"+$CampagneCourante
	$L:=Find in array:C230(<>TbLotoNumLaboRapportCampagne;$test)
End if 
If ($L>0)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUID:1=<>TbLotoUUIDParticipation{$L})
	FORM SET INPUT:C55([CampagneParticipations:17];"Visu")
	DISPLAY SELECTION:C59([CampagneParticipations:17])
Else 
	TRACE:C157
End if 