//%attributes = {}
  // RapportTesteAdresseMail
  // {$1} = RAEMA sélectionné dans ◊PUMCampagne
C_LONGINT:C283($Salé;1;$FT;$NumLabo;$Pos;$NumRAEMA)
AlerteA:=""
If (Count parameters:C259=1)
	$NumRA:=<>PUMCampagne{<>PUMCampagne}
Else 
	$NumRA:=<>NumCampagneEnCoursSaisie
End if 
RecruteLaboParticipants ($NumRA)
$FT:=Records in selection:C76([CampagneParticipations:17])
<>VarEtaMailRap:=""
$Compteur:=0
$Compteur2:=0
ARRAY LONGINT:C221($TbMN;0)  // le tableau des mails absents
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUILabo)
For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbPerUUID;$TbUUILabo{$Salé})
	If (<>TbPAEmailRAEMA{$L}="")
		$Compteur2:=$Compteur2+1
		APPEND TO ARRAY:C911($TbMN;<>TbPerNumLaboRAEMA{$l})
	End if 
End for 
SORT ARRAY:C229($TbMN;>)
If ($Compteur=0) & ($Compteur2=0)
	<>VarEtaMailRap:="Données courriel complètes"
Else 
	$s:=Num:C11($Compteur2>1)*"s"
	<>VarEtaMailRap:=String:C10($Compteur2)+" email absent"+$s+<>ZCR+ZTableauVersTexte (->$TbMN;", ")
End if 
POST OUTSIDE CALL:C329(-1)
ZAmnistiePartielle (->[CampagneParticipations:17])
