//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 25/01/18, 06:41:22
  // ----------------------------------------------------
  // Méthode : GA15InitPUMAnRaemaGel
  // Description  OBSOLETE
  // Fabrique le menu local de [Adhérents];"SaisieLabo"
  //   qui permet de choisir l'année concernée par les Raema gel
  // ----------------------------------------------------

  //C_ENTIER LONG($Salé;1;$FT)

  //TABLEAU TEXTE(PUMAn;0)
  //TOUT SÉLECTIONNER([CampagneGelGermes])
  //Si (Enregistrements trouvés([CampagneGelGermes])>0)
  //VALEURS DISTINCTES([CampagnesRAEMAGel]AnCampagne;$PUMAn)
  //$AnCourant:="20"+<>ZPermMille
  //Si (Taille tableau($PUMAn)=1)
  //TABLEAU TEXTE(PUMAn;1)
  //PUMAn{1}:=$AnCourant
  //Sinon 
  //$FT:=Taille tableau($PUMAn)
  //TABLEAU TEXTE(PUMAn;$FT)
  //Boucle ($Salé;1;$FT)
  //PUMAn{$Salé}:=(Num(Longueur($PUMAn{$Salé})=2)*"20")+$PUMAn{$Salé}
  //Fin de boucle 
  //Fin de si 
  //TRIER TABLEAU(PUMAn;<)
  //$DateBascule:=Date("15/12/"+$AnCourant)
  //Si (Date du jour>$DateBascule)
  //VarPermMilleRaemaGel:="20"+Chaîne(Num(<>ZPermMille)+1)
  //INSÉRER DANS TABLEAU(PUMAn;1)
  //PUMAn{1}:=VarPermMilleRaemaGel
  //Sinon 
  //VarPermMilleRaemaGel:=$AnCourant
  //Fin de si 
  //Fin de si 
