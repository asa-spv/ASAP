//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/01/19, 15:09:45
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPBoumPersonne
  // Description
  // Méthode des destructions des enre-gistrements liés
  // à l'enregistrement courant de [Personnes]


$TypePersonne:=$1

READ WRITE:C146([PersonnesAdresses:11])

READ WRITE:C146([Factures:15])
READ WRITE:C146([Ventes:16])

  // Destructions communes aux laboratoires et aux adhérents personnels
RELATE MANY:C262([Personnes:12]UUID:1)
DELETE SELECTION:C66([PersonnesAdresses:11])

RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)
DELETE SELECTION:C66([Ventes:16])
DELETE SELECTION:C66([Factures:15])

If ($TypePersonne="Laboratoire")
	  // destructions propres aux laboratoire
	READ WRITE:C146([CampagneParticipations:17])
	DELETE SELECTION:C66([CampagneParticipations:17])
	
	READ WRITE:C146([CampagneGelGermes:25])
	DELETE SELECTION:C66([CampagneGelGermes:25])
	
	READ WRITE:C146([WebConnexions:13])
	DELETE SELECTION:C66([WebConnexions:13])
	
	READ WRITE:C146([RetoursAdherents:27])
	READ WRITE:C146([RetoursFiches:24])
	RELATE ONE SELECTION:C349([RetoursAdherents:27];[RetoursFiches:24])
	DELETE SELECTION:C66([RetoursFiches:24])
	DELETE SELECTION:C66([RetoursAdherents:27])
End if 
ZAmnistieInternationale 
READ WRITE:C146([Personnes:12])




