//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/02/16, 16:34:59
  // ----------------------------------------------------
  // Méthode : RecruteLaboParticipants
  // Description
  // Permet de sélectionner les [CampagneParticipation]
  // des laboratoires ayant envoyé un résultat au serveur Web
  // ou par une feuille EXCEL
  // Paramètre : $1 = N° de la campagne
  // ----------------------------------------------------
  //
  //CHERCHER([CampagneParticipation];[CampagneParticipation]NumCampagne=$1;*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]NumLaboRaema#"";*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]ParticipationKO=Faux;*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]NumLaboEntier>0;*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]TexteParticipation1="@envoi du mail@";*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]NumLaboRaema#"13")
  //NOMMER ENSEMBLE([CampagneParticipation];"Internet")
  //
  //
  //
  //CHERCHER([CampagneParticipation];[CampagneParticipation]NumCampagne=$1;*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]NumLaboRaema#"";*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]ParticipationKO=Faux;*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]NumLaboEntier>0;*)
  //CHERCHER([CampagneParticipation]; & [CampagneParticipation]HorsInternet=Vrai)
  //NOMMER ENSEMBLE([CampagneParticipation];"EXcel")
  //
  //REUNION("Internet";"Excel";"participant")
  //UTILISER ENSEMBLE("participant")
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$1;*)
VarTesteur:=WebTrouveValeurParNom ("testeur";-><>TbPerNomLong;-><>TbPerUUID)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2#VarTesteur)  // Elimination du 13
CREATE SET:C116([CampagneParticipations:17];"participant")

  // TRIER([CampagneParticipation];[CampagneParticipation]NumLaboEntier;>)
  // En ASAP, le tri se fera ultérieurement

