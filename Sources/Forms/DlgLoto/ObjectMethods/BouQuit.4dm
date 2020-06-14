  // methode objet du bouton de quitaison de "DlgFuturParticipants"
  // informe le serveur de modification des participants

  //<>ChangementParticipant:=Faux  // en principe rien à envoyer
  //Si (NouveauRAEMA)  // sauf s'il y a un nouveau RAEMA
  //<>ChangementParticipant:=Vrai
  //Sinon   // sauf s'il y a des changements dans les participants
  //  // dans la campagne en cours (PUMNRFLP{1})
  //CHERCHER([XFonctions];[XFonctions]UUID="Participation au RAEMA";*)
  //CHERCHER([XFonctions]; & [XFonctions]="LFP";*)
  //CHERCHER([XFonctions]; & [XFonctions]=PUMNRFLP{1})
  //TABLEAU ENTIER LONG(DerTb;0)
  //BLOB VERS VARIABLE([XFonctions];DerTb)
  //Si (Taille tableau(DerTb)#Taille tableau(TbAncParticip))
  //<>ChangementParticipant:=Vrai
  //Sinon 
  //C_ENTIER LONG($Salé;$TT)
  //$TT:=Taille tableau(DerTb)
  //Boucle ($Salé;1;$TT)
  //Si (DerTb{$Salé}#TbAncParticip{$Salé})
  //<>ChangementParticipant:=Vrai
  //$Salé:=$TT
  //Fin de si 
  //Fin de boucle 
  //Fin de si 
  //Fin de si 
