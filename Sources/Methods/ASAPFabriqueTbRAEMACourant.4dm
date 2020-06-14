//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 19:27:40
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbRAEMACourant
  // Description
  // Méthode qui fabrique les tableaux comprenant 
  //  toutes les données des schémas des RAEMA
  // ----------------------------------------------------

$H1:=Milliseconds:C459
While (<>CalculTableauxGénérauxEnCours)
	DELAY PROCESS:C323(Current process:C322;10*60)
End while 
<>CalculTableauxGénérauxEnCours:=True:C214
RaemaInitPUMCampagne 
If (<>ZClient)
	ASAPFabriqueTbCampagneToutesMAJ 
	ASAPFabriqueTbParticipeMAJ 
	ASAPFabriqueTbCampagneUneMAJ 
Else 
	ASAPFabriqueTbCampagnesToutes 
	ASAPFabriqueTbParticipe 
	ASAPFabriqueTbCampagneUne 
End if 
ASAPFabriqueTbPrestations (True:C214)
<>CalculTableauxGénérauxEnCours:=False:C215
$H2:=Milliseconds:C459
  // ALERTE(Chaîne($H2-$H1))
