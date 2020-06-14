

  //Si (Macintosh commande enfoncée)
  //CONFIRMER("Voulez-vous VRAIMENT déplacer vers la gauche TOUS le laboratoires ???")
  //Si (OK=0)
  //ALERTE("Bon, alors je ne fais rien...")
  //Sinon 
  //LECTURE ÉCRITURE([CampagneParticipations])
  //CHERCHER([CampagneParticipations];[CampagneParticipations]=<>PUMCampagne{<>PUMCampagne})
  //APPLIQUER À SÉLECTION([CampagneParticipations];RapRemetRapportsAGauche)
  //RapInitTbRecupRapports (Vrai)
  //ZAmnistiePartielle (->[CampagneParticipations];Vrai)
  //Fin de si 
  //Sinon 
RapChangeColonne (->TbRapportsPris)
  //Fin de si 
