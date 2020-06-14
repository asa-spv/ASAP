//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/01/19, 08:54:36
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPRetourSurValidation
  // Description
  // Méthode exécutée après validation de [RetoursFiches]

[RetoursFiches:24]DateRetour:3:=vDate
If (VarNouvFiche)
	APPEND TO ARRAY:C911(TbNumFicheRetour;[RetoursFiches:24]NumFiche:2)
	SORT ARRAY:C229(TbNumFicheRetour;<)
	DerNumActuelRetour:=[RetoursFiches:24]NumFiche:2
End if 
[RetoursFiches:24]Recherche:11:=ASAPFabriqueRechercheRetour 
VALIDATE TRANSACTION:C240

