//%attributes = {}
  // ----------------------------------------------------
  // nom utilisateur (OS) : iMacASA2017
  // date et heure : 24/01/18, 08:44:41
  // ----------------------------------------------------
  // paramètres
  // $1 = Pt sur table concernée
  // {$2} = vrai si ZAmnistiePartielle charge l'enregistrement après libération
  // ----------------------------------------------------
  // méthode : ZAmnistiePartielle
  // description
  // méthode qui remet la table $1-> en lecture seulement

UNLOAD RECORD:C212($1->)
READ ONLY:C145($1->)

If (Count parameters:C259=2)
	LOAD RECORD:C52($1->)
End if 
