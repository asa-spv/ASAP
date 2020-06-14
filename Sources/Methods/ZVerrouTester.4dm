//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 09:11:02
  // ----------------------------------------------------
  // Méthode : ZVerrouTester
  // Description
  //  Historique : ZfTesteVerrou V11 du 10/08/2010
  //  fonction qui permet d'informer l'utilisateur de l'état de la fiche courante
  // Paramètre
  // $1= pt sur fichier
  // ----------------------------------------------------



OK:=1
While (Locked:C147($1->) & (OK=1))
	LOCKED BY:C353($1->;$Process;$Machine;$Utilisateur;$NomProcess)
	If ($Process#0)
		$mess:="Fiche occupée par "+$Utilisateur+<>ZCR+"Process "+String:C10($Process)+" "+$NomProcess+<>ZCR+"sur l'ordinateur "+$Machine
		CONFIRM:C162($mess+<>ZCR+"Voulez-vous patienter?")
		DELAY PROCESS:C323(Current process:C322;300)
	End if 
	LOAD RECORD:C52($1->)
End while 
$0:=(OK=1)