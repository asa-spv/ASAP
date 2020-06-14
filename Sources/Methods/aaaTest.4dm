//%attributes = {}


  // $0:=OB Lire([Personnes]Arguments;"Association";Est un texte)
  //FORM FIXER SORTIE([Personnes];"ListeTout")
  //IMPRIMER SÉLECTION([Personnes];*)

  //C_ENTIER LONG($Salé;$FT)
  //CHERCHER([Prestations];[Prestations]AnneePrestation=2018;*)
  //CHERCHER([Prestations]; & [Prestations]CodePrestation#"")
  //TABLEAU ENTIER LONG SUR SÉLECTION([Prestations];$TbNumEnrPrest)

  //$Ft:=Taille tableau($TbNumEnrPrest)
  //Boucle ($Salé;1;$FT)
  //ALLER À ENREGISTREMENT([Prestations];$TbNumEnrPrest{$Salé})
  //DUPLIQUER ENREGISTREMENT([Prestations])
  //[Prestations]AnneePrestation:=2019
  //STOCKER ENREGISTREMENT([Prestations])
  //Fin de boucle 





  //C_ENTIER LONG($Salé;$FT)
  //TABLEAU OBJET($TbArg;0)
  //CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="66")
  //SÉLECTION VERS TABLEAU([CampagneParticipations]UUIDPersonne;$TbUUID;[CampagneParticipations]Arguments;$TbArg)
  //TABLEAU ENTIER LONG SUR SÉLECTION([CampagneParticipations];$TbNumEnr)
  //$FT:=Taille tableau($TbNumEnr)
  //TABLEAU TEXTE($TbCodeLiaison;$FT)
  //TABLEAU TEXTE($TbNumLaboA;$FT)
  //Boucle ($Salé;1;$FT)
  //$TbCodeLiaison{$Salé}:=OB Lire($TbArg{$Salé};"CodeRaemaLié";Est un texte)
  //$TbNumLaboA{$Salé}:=WebTrouveValeurParNom ($TbUUID{$Salé};-><>TbPerUUID;-><>TbPerNumLaboRAEMAA)
  //Fin de boucle 
  //TRIER TABLEAU($TbNumLaboA;$TbCodeLiaison;$TbUUID;>)
  //$Rapport:=""
  //Boucle ($Salé;1;$FT)
  //$rapport:=$Rapport+$TbUUID{$Salé}+<>ZTab+$TbCodeLiaison{$Salé}+<>ZTab+$TbNumLaboA{$Salé}+<>ZCR
  //Fin de boucle 
  //  // FIXER TEXTE DANS CONTENEUR($Rapport)
  //Si (Faux)

  //CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="67";*)
  //CHERCHER PAR ATTRIBUT([CampagneParticipations]; & ;[CampagneParticipations]Arguments;"Sauvage";=;Faux)


  //CHERCHER PAR ATTRIBUT([Personnes];[Personnes]Arguments;"TbNumRAEMALié";#;Null)

  //APPLIQUER À SÉLECTION([RAEMACampagnes];OB FIXER TABLEAU([RAEMACampagnes]Arguments;"TbDilution";<>TbDilution))

  //  //FIXER TEXTE DANS CONTENEUR(ZTableauVersTexte (-><>TbF))
  //  //FIXER TEXTE DANS CONTENEUR(ZTableauVersTexte (-><>TbA))
  //NumCampagneCourante:="67"
  //LangueCourante:="F"
  //ResP2HtmlLigneTitre ("01")


  //ASAPObjetNomProprio (->[RAEMAValeurs]Arguments)

  //C_BOOLÉEN($esc)
  //CHERCHER PAR ATTRIBUT([RAEMALignes];[RAEMALignes]Arguments;"ChoixMultiple";=;Vrai)
  //$esc:=OB Lire([RAEMALignes]Arguments;"ChoixMultiple";Est un booléen)
  //LECTURE ÉCRITURE([Personnes])
  //TOUT SÉLECTIONNER([Personnes])
  //APPLIQUER À SÉLECTION([Personnes];[Personnes]ChampRecherche:=ASAPSurValidationSaisieLabo )
  //ZAmnistieInternationale 



  //C_ENTIER LONG($Salé;$FT)
  //TOUT SÉLECTIONNER([Personnes])
  //TABLEAU TEXTE($TbProprietes;0)

  //$FT:=Enregistrements trouvés([Personnes])

  //Boucle ($Salé;1;$FT)

  //OB LIRE NOMS PROPRIÉTÉS([Personnes]Arguments;$TbArgument)
  //$SFT:=Taille tableau($TbArgument)
  //Boucle ($Fumé;1;$SFT)
  //Si (Chercher dans tableau($TbProprietes;$TbArgument{$Fumé})=-1)
  //AJOUTER À TABLEAU($TbProprietes;$TbArgument{$Fumé})
  //Fin de si 
  //Fin de boucle 
  //Fin de boucle 
  //$T:=ZTableauVersTexte (->$TbProprietes)
  //  //FIXER TEXTE DANS CONTENEUR($T)



  //C_OBJET($Objet)
  //OB FIXER($Objet;"NomTâche";"Coucou";"NomMéthode";"AaaaaaMethode";"NumTable";1;"Destinataire";"PE";"NumEnr";1)
  //ZTacheDeFondLancer ($Objet)


  //  // affectation du descriptif de [XAttributions]
  //C_ENTIER LONG($Salé;$FT)
  //LECTURE ÉCRITURE(*)
  //TOUT SÉLECTIONNER([XAttributions])

  //$FT:=Enregistrements trouvés([XAttributions])

  //Boucle ($Salé;1;$FT)

  //STOCKER ENREGISTREMENT([XAttributions])
  //ENREGISTREMENT SUIVANT([XAttributions])
  //Fin de boucle 





  //TOUT SÉLECTIONNER([XUtilisateurs])
  //Tant que (Non(Fin de sélection([XUtilisateurs])))
  //LIEN RETOUR([XUtilisateurs]UUID)
  //SÉLECTION VERS TABLEAU([XAttributions]UUIDFonction;TbUUIDFonction)
  //ZDroitsRecalcule (Vrai;Vrai)
  //STOCKER ENREGISTREMENT([XUtilisateurs])
  //ENREGISTREMENT SUIVANT([XUtilisateurs])
  //Fin tant que 
  //Fin de si 
  //ZAmnistieInternationale 