//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 20/09/16, 16:06:38
  // ----------------------------------------------------
  // Méthode : RetourAfficheAdh
  // Description : Rempli la liste Box avec les laboratoires du contact client
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  // CHERCHER([RetoursAdherents];[RetoursAdherents]IDFiche=[RetoursFiches]IDRetour)
  //LIEN RETOUR([RetoursFiches]IdRetour)
  //SÉLECTION VERS TABLEAU([RetoursAdherents]IDAdherent;Colonne1N)
  //$TT:=Taille tableau(Colonne1N)
  //TABLEAU TEXTE(Colonne2;0)
  //TABLEAU TEXTE(Colonne3;0)
  //Boucle ($salé;1;$TT)
  //CHERCHER([Adhérents];[Adhérents]NumRAEMAEntier=Colonne1N{$salé})
  //Au cas ou 
  //: ([Adhérents]Association="@Belge@")
  //AJOUTER À TABLEAU(Colonne2;"Belges")
  //: ([Adhérents]Association="@ASA@")
  //AJOUTER À TABLEAU(Colonne2;"ASA")
  //: ([Adhérents]Association="@Adilva@")
  //AJOUTER À TABLEAU(Colonne2;"Adilva")
  //Sinon 
  //AJOUTER À TABLEAU(Colonne2;"Autre")
  //Fin de cas 
  //AJOUTER À TABLEAU(Colonne3;[Adhérents]Association)
  //Fin de boucle 
  //TRIER TABLEAU(Colonne1N;Colonne2;Colonne3;>)