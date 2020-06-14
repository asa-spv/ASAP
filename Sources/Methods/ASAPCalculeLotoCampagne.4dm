//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/07/19, 16:14:58
  // ----------------------------------------------------
  // Paramètre : $1 = N° de la campagne
  // ----------------------------------------------------
  // Méthode : ASAPCalculeLotoCampagne
  // Description : met à jour la propriété "Loto" de [RAEMACampagnes]Arguments
  // de la campagne passée en paramètre
$NumCampagne:=$1
READ WRITE:C146([RAEMACampagnes:20])
QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
RELATE MANY:C262([RAEMACampagnes:20]NumCampagne:2)  // Rappel des participations
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLaboPart;[CampagneParticipations:17]Arguments:5;$TbArgumentsPart)
$FT:=Size of array:C274($TbUUIDLaboPart)
ARRAY LONGINT:C221($TbLoto;$FT)  // va se retrouver dans la propriété "Loto" de [RAEMACampagnes]Arguments
For ($Salé;1;$FT)
	$RaemaLié:=OB Get:C1224($TbArgumentsPart{$Salé};"CodeRaemaLié";Est un texte:K8:3)
	If ($RaemaLié="")  // laboratoire principal
		$TbLoto{$Salé}:=Num:C11(ASAPTrouveNumeroLaboParUUID ($TbUUIDLaboPart{$Salé}))
	Else   // laboratoire lié
		$TbLoto{$Salé}:=RAEMADemoduleMdPWeb ($RaemaLié)
	End if 
End for 
SORT ARRAY:C229($TbLoto;>)
OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"Loto";$TbLoto)
SAVE RECORD:C53([RAEMACampagnes:20])
ZAmnistiePartielle (->[RAEMACampagnes:20])