//%attributes = {}

$doc:=Select document:C905("";"";"Quel doc ??";0)

Yv18Zipf (document;document+".zip";"";True:C214)

  //C_ENTIER LONG($Salé;1;$FT)
  //LECTURE ÉCRITURE([CampagneParticipations])
  //CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="@A")
  //$FT:=Enregistrements trouvés([CampagneParticipations])
  //Boucle ($Salé;1;$FT)
  //CHERCHER([CampagneGelGermes];[CampagneGelGermes]UUIDParticipation=[CampagneParticipations]UUID)
  //Si (Enregistrements trouvés([CampagneGelGermes])=0)
  //SUPPRIMER ENREGISTREMENT([CampagneParticipations])
  //Fin de si 
  //ENREGISTREMENT SUIVANT([CampagneParticipations])
  //Fin de boucle 



  //Si (Macintosh commande enfoncée)
  //TRACE
  //Fin de si 
  //CHERCHER PAR ATTRIBUT([Personnes];[Personnes]Arguments;"BoiteIsotherme";"#";Null)

  //  //$proc:=EXÉCUTER SUR CLIENT("@";"Méthode Tests")