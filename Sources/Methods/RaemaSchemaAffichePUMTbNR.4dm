//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/18, 19:38:27
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSchemaAffichePUMTbNR
  // Description
  // // Affiche le menu local des RAEMA de la base

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/09/16, 10:59:26
  // ----------------------------------------------------
  // Méthode : RaemaSchemaAffichePUMTbNR
  // Description
  // Affiche le PUM restreint des campagne 
  // sauf si on mainitent la touche Commande enfoncée
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$TT)
C_DATE:C307($Date)
$MCE:=Macintosh command down:C546
RaemaSchemaBlanc 
If ($MCE)
	ALL RECORDS:C47([RAEMACampagnes:20])
Else 
	$Date:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)-1))
	QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]DateEnvoiColis:3>$Date)
End if 
SELECTION TO ARRAY:C260([RAEMACampagnes:20]NumCampagne:2;TbNR;[RAEMACampagnes:20]UUID:1;TbUUIDCampagne)
SORT ARRAY:C229(TbNR;TbUUIDCampagne;<)