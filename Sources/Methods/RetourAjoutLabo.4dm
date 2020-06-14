//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 21/09/16, 14:37:50
  // ----------------------------------------------------
  // Méthode : RetourAjoutLabo
  // Description : Ajoute un laboratoire dans les retours
  // ----------------------------------------------------
GET TEXT KEYWORDS:C1141(VarNumLaboA;$TbMots)
$TT:=Size of array:C274($TbMots)
For ($salé;1;$TT)
	$LabosCourant:=$TbMots{$salé}
	$LabosCourantN:=Num:C11($TbMots{$salé})
	If (Find in array:C230(Colonne1N;$LabosCourantN)>0)
		ALERT:C41("Désolé, le numéro"+$LabosCourant+" existe déjà")
	Else 
		$UUIDLabo:=ASAPTrouveUUIDLaboParNumero ($LabosCourantN)
		QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$UUIDLabo)
		If (Records in selection:C76([Personnes:12])=0)
			ALERT:C41("Désolé, pas de trace du laboratoire n°"+String:C10($LabosCourant))
		Else 
			CREATE RECORD:C68([RetoursAdherents:27])
			[RetoursAdherents:27]IDAdherent:3:=$UUIDLabo
			[RetoursAdherents:27]IDFiche:2:=[RetoursFiches:24]UUID:1
			SAVE RECORD:C53([RetoursAdherents:27])
		End if 
	End if 
	
End for 

ASAPRetourAfficheAdh 
