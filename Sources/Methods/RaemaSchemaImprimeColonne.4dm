//%attributes = {}

  // Modifié par : cgm (13/09/2016)
  //  RaemaColonneSuivante
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/09/16, 06:56:04
  // ----------------------------------------------------
  // Méthode : RaemaSchemaImprimeColonne
  // Description
  //  // A = 65 et Z = 90
  //  $1 = identifiant de [RAEMALignes]
  // ----------------------------------------------------

$IdentifiantLigne:=$1
$R:=OrdreActuel%26  //le reste de la division
$PE:=OrdreActuel\26  //la partie entière
OrdreActuel:=OrdreActuel+1
$Ra:="[R"+Replace string:C233($IdentifiantLigne;[RAEMACampagnes:20]NumCampagne:2;"")+"] "
If ($PE=0)
	$0:=$Ra+String:C10(OrdreActuel)+" ("+Char:C90(65+$R)+") "
Else 
	$0:=$Ra+String:C10(OrdreActuel)+" ("+Char:C90(64+$PE)+Char:C90(65+$R)+") "
End if 
