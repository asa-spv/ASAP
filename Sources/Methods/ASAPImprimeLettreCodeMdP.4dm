//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/07/19, 04:06:58
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ASAPImprimeLettreCodeMdP
  // Description
  // Imprime la lettre qui informe le laboratoire 
  //  de son code et de son mot de passe

PRINT SETTINGS:C106
If (OK=1)
	$H:=Print form:C5([Personnes:12];"LettreCodeMdP")
	PAGE BREAK:C6
	OB REMOVE:C1226([Personnes:12]Arguments:7;"LettreCodeMdPAEnvoyer")
End if 

