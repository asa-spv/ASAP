//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/01/19, 08:41:04
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPRetourAfficheAdh
  // Description
  // Méthode qui rappelle les enregistrements de [RetoursAdherents]

  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 20/09/16, 16:06:38
  // ----------------------------------------------------
  // Méthode : RetourAfficheAdh
  // Description : Rempli la liste Box avec les laboratoires du contact client
  // 
  //
  // Paramètres
  // ----------------------------------------------------

RELATE MANY:C262([RetoursFiches:24]UUID:1)
ARRAY TEXT:C222($Colonne1N;0)
SELECTION TO ARRAY:C260([RetoursAdherents:27]IDAdherent:3;$Colonne1N;[RetoursAdherents:27]UUID:1;TbUUIDAdhérent)
$TT:=Size of array:C274($Colonne1N)
ARRAY LONGINT:C221(Colonne1N;0)
ARRAY TEXT:C222(Colonne2;0)
ARRAY TEXT:C222(Colonne3;0)
For ($salé;1;$TT)
	$L:=Find in array:C230(<>TbPerUUID;$Colonne1N{$salé})
	If ($L>0)
		$Association:=<>TbPAAssociation{$L}
		$NumLaboN:=<>TbPerNumLaboRAEMA{$L}
	Else 
		$Association:=""
		$NumLaboN:=0
	End if 
	APPEND TO ARRAY:C911(Colonne1N;$NumLaboN)
	Case of 
		: ($Association="@Belge@")
			APPEND TO ARRAY:C911(Colonne2;"Belges")
		: ($Association="@ASA@")
			APPEND TO ARRAY:C911(Colonne2;"ASA")
		: ($Association="@Adilva@")
			APPEND TO ARRAY:C911(Colonne2;"Adilva")
		Else 
			APPEND TO ARRAY:C911(Colonne2;"Autre")
	End case 
	APPEND TO ARRAY:C911(Colonne3;$Association)
End for 
SORT ARRAY:C229(Colonne1N;Colonne2;Colonne3;TbUUIDAdhérent;>)