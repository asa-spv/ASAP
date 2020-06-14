//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/01/19, 06:46:05
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPPrestationsAfficheEnCours
  // Description
  // // Méthode qui affiche dans une fenêtre modale 
  // les prestations des RAEMA de l'année en cours
C_LONGINT:C283($Salé;$FT)
READ WRITE:C146([Prestations:26])
$F:=Open form window:C675("DlgPrestations")
DIALOG:C40("DlgPrestations")
If (BouOK=1)
	ARRAY TO SELECTION:C261(Colonne1;[Prestations:26]NomPrestation:3\
		;Colonne2N;[Prestations:26]PrixPrestation:4\
		;Colonne3N;[Prestations:26]TauxTVAPrestation:5)
End if 
CLOSE WINDOW:C154
