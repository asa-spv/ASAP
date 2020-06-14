//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/02/19, 07:00:50
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : WebAppelEspaceClient
  // Description
  // Méthode qui trapse les messages de l'espace client 
  //   pour orienter le laboratoire vers l'action désirée


$Mess:=Substring:C12($1;4)  // élimination du EC_
$EstCeUnRapport:=($Mess="Res@")
$Pos:=Position:C15("_";$Mess)
$Méthode:=Substring:C12($Mess;1;($Pos-1))
NumCampagneActuelle:=<>NumCampagneEnCoursSaisie  // récupérons le n° de RAEMA actuel (alphanumérique)
NumLaboActuelA:=Substring:C12($Mess;($Pos+1))

  // Si ($EstCeUnRapport)
$Test:=NumLaboActuelA+"_"+NumCampagneActuelle
$L:=Find in array:C230(<>TbLotoNumLaboRapportCampagne;$Test)
If ($L>0)
	$IDCampagne:=<>TbLotoIdentifiantParticipation{$L}
	$Pos:=Position:C15("_";$IDCampagne)
	$IDCampagne:=Substring:C12($IDCampagne;($Pos+1))
	$Pos:=Position:C15("_";$IDCampagne)
	MotDePasseActuel:=Substring:C12($IDCampagne;($Pos+1))
	UUIDParticipation:=<>TbLotoUUIDParticipation{$L}
Else 
	$Test:=NumLaboActuelA+"_"+NumCampagneActuelle+"_"
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test)
	If ($L>0)
		UUIDParticipation:=<>TbLotoUUIDParticipation{$L}
		$UUIDLabo:=<>TbLotoUUIDLabo{$L}
		$L:=Find in array:C230(<>TbPerUUID;$UUIDLabo)
		MotDePasseActuel:=<>TbPerIdentificateur{$L}
	Else 
		TRACE:C157
	End if 
End if 
If ($EstCeUnRapport)
	RaemaPoudre:=(NumCampagneActuelle#"@A")
	EXECUTE METHOD:C1007($Méthode)
	
Else   // demandes des rapports et attestations antérieures ou d'une facture
	TypeDemande:=Substring:C12($Méthode;1;3)  // Rap, Att ou Fac
	WebTelechargeDocument 
End if 

