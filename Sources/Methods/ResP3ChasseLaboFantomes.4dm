//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/08/18, 07:02:26
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ResP3ChasseLaboFantomes
  // Description
  // Le mdp caché est-il correct ?  Chasse aux laboratoire 0 qui poluent les résultats

$Fantome:=(Length:C16(MotDePasseActuel)#10) | (NumLaboActuelA="")
If ($Fantome)  // Le mdp caché n'est pas correct
	If (LangueCourante="F")  // renseignée dans WebChercheFicheXDonnées
		TitrePage:="Erreur de communication"
		WEB SEND FILE:C619("DlgErreurWebFr.shtml")
	Else 
		TitrePage:="Web error"
		WEB SEND FILE:C619("DlgErreurWebEn.shtml")
	End if 
End if 
$0:=Not:C34($Fantome)