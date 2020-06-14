//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 16/06/18, 18:41:59
  // ----------------------------------------------------
  // Méthode : GAInitInterfaceAdh
  // Description
  // Initialisation des variables d'interface 
  //  d'un enregistrement de [Personnes]
  // ----------------------------------------------------


  //OBJET FIXER VISIBLE(*;"Modif@";ZModif)
  //OBJET FIXER SAISISSABLE([Adhérents]AJour;Faux)
  //TABLEAU TEXTE(PUMAdCourriel;0)
  //TABLEAU POINTEUR(TbPtChampEmail;0)
  //Si ([Adhérents]EMail#"")
  //AJOUTER À TABLEAU(PUMAdCourriel;"Adresse courriel principale : "+[Adhérents]EMail)
  //AJOUTER À TABLEAU(TbPtChampEmail;->[Adhérents]EMail)
  //Fin de si 
  //Si ([Adhérents]EMailBis#"")
  //AJOUTER À TABLEAU(PUMAdCourriel;"Adresse courriel secondaire : "+[Adhérents]EMailBis)
  //AJOUTER À TABLEAU(TbPtChampEmail;->[Adhérents]EMailBis)
  //Fin de si 
  //Si ([Adhérents]EmailRAEMA#"")
  //AJOUTER À TABLEAU(PUMAdCourriel;"Adresse courriel pour le RAEMA : "+[Adhérents]EmailRAEMA)
  //AJOUTER À TABLEAU(TbPtChampEmail;->[Adhérents]EmailRAEMA)
  //Fin de si 
  //Si ([Adhérents]EMailInternet#"")
  //AJOUTER À TABLEAU(PUMAdCourriel;"Adresse courriel du site Internet : "+[Adhérents]EMailInternet)
  //AJOUTER À TABLEAU(TbPtChampEmail;->[Adhérents]EMailInternet)
  //Fin de si 
  //OBJET FIXER VISIBLE(*;"AdCourr@";(Taille tableau(PUMAdCourriel)>0))
  //OBJET FIXER SAISISSABLE([Adhérents]NumRAEMALié;([Adhérents]NumRAEMALié=""))

  //BouCadenas:=0
  //GA15GèreCadenas

  //WR VERROUILLER DOCUMENT (ZoneCourAdh;wr document verrouillé)
