//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/11/19, 06:45:30
  // ----------------------------------------------------
  // Méthode : ASAPViderBase
  // Description
  // Méthode qui vide les données conjoncturelles
  //  en vue d'une importation des données de Biblio et GestAsa
  // Paramètres
  // ----------------------------------------------------
READ WRITE:C146(*)
ALL RECORDS:C47([CampagneGelGermes:25])
DELETE SELECTION:C66([CampagneGelGermes:25])
ALL RECORDS:C47([CampagneParticipations:17])
DELETE SELECTION:C66([CampagneParticipations:17])
  //TOUT SÉLECTIONNER([CourrielsTypes])
  //SUPPRIMER SÉLECTION([CourrielsTypes])
ALL RECORDS:C47([Factures:15])
DELETE SELECTION:C66([Factures:15])
ALL RECORDS:C47([Personnes:12])
DELETE SELECTION:C66([Personnes:12])
ALL RECORDS:C47([PersonnesAdresses:11])
DELETE SELECTION:C66([PersonnesAdresses:11])
ALL RECORDS:C47([Prestations:26])
DELETE SELECTION:C66([Prestations:26])
ALL RECORDS:C47([RAEMACampagnes:20])
DELETE SELECTION:C66([RAEMACampagnes:20])
ALL RECORDS:C47([RAEMAGermes:21])
DELETE SELECTION:C66([RAEMAGermes:21])
ALL RECORDS:C47([RAEMALignes:22])
DELETE SELECTION:C66([RAEMALignes:22])
ALL RECORDS:C47([RAEMAValeurs:23])
DELETE SELECTION:C66([RAEMAValeurs:23])
ALL RECORDS:C47([RetoursAdherents:27])
DELETE SELECTION:C66([RetoursAdherents:27])
ALL RECORDS:C47([RetoursFiches:24])
DELETE SELECTION:C66([RetoursFiches:24])
ALL RECORDS:C47([Ventes:16])
DELETE SELECTION:C66([Ventes:16])
ALL RECORDS:C47([WebConnexions:13])
DELETE SELECTION:C66([WebConnexions:13])




