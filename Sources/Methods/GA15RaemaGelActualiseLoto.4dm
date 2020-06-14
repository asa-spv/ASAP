//%attributes = {}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : MBPASA2015
  //  // Date et heure : 19/03/18, 15:59:34
  //  // ----------------------------------------------------
  //  // Méthode : GA15RaemaGelActualiseLoto
  //  // Description
  //  // 
  //  //
  //  // Paramètres {$1} année du RAEMA (alpha 4 caractères), année courante sinon
  //  // ----------------------------------------------------
  //Si (Nombre de paramètres=1)
  //$VarPermMilleRaemaGel:=$1
  //Sinon 
  //$VarPermMilleRaemaGel:="20"+<>ZPermMille
  //Fin de si 

  //$NumRG1:=RaemaTrouveNumCampagneParAn (Num($VarPermMilleRaemaGel);2)
  //LECTURE ÉCRITURE([XDonnées])
  //CHERCHER([XDonnées];[XDonnées]XAlpha=$NumRG1;*)
  //CHERCHER([XDonnées]; & [XDonnées]XNom="Participation au RAEMA";*)
  //CHERCHER([XDonnées]; & [XDonnées]XType="LFP")  // Type des participations RAEMA
  //Si (Enregistrements trouvés([XDonnées])=0)
  //CRÉER ENREGISTREMENT([XDonnées])
  //[XDonnées]XAlpha:=$NumRG1
  //[XDonnées]XNom:="Participation au RAEMA"
  //[XDonnées]XType:="LFP"
  //Fin de si 
  //CHERCHER([RAEMAGel];[RAEMAGel]AnCampagne=$VarPermMilleRaemaGel;*)
  //CHERCHER([RAEMAGel]; & [RAEMAGel]Periode="Mai")
  //VALEURS DISTINCTES([RAEMAGel]NumRaema;$TbNumRaemaA)
  //$TT:=Taille tableau($TbNumRaemaA)
  //TABLEAU ENTIER LONG($TbNumRaemaN;$TT)
  //Boucle ($Salé;1;$TT)
  //$TbNumRaemaN{$Salé}:=Num($TbNumRaemaA{$Salé})
  //Fin de boucle 
  //TRIER TABLEAU($TbNumRaemaN;>)
  //ZVariableVersBlob (->[XDonnées]XBlob;->$TbNumRaemaN)
  //STOCKER ENREGISTREMENT([XDonnées])

  //$NumRG2:=RaemaTrouveNumCampagneParAn (Num($VarPermMilleRaemaGel);4)
  //CHERCHER([XDonnées];[XDonnées]XAlpha=$NumRG2;*)
  //CHERCHER([XDonnées]; & [XDonnées]XNom="Participation au RAEMA";*)
  //CHERCHER([XDonnées]; & [XDonnées]XType="LFP")  // Type des participations RAEMA
  //Si (Enregistrements trouvés([XDonnées])=0)
  //CRÉER ENREGISTREMENT([XDonnées])
  //[XDonnées]XAlpha:=$NumRG2
  //[XDonnées]XNom:="Participation au RAEMA"
  //[XDonnées]XType:="LFP"
  //Fin de si 
  //CHERCHER([RAEMAGel];[RAEMAGel]AnCampagne=$VarPermMilleRaemaGel;*)
  //CHERCHER([RAEMAGel]; & [RAEMAGel]Periode#"Mai")
  //VALEURS DISTINCTES([RAEMAGel]NumRaema;$TbNumRaemaA)
  //$TT:=Taille tableau($TbNumRaemaA)
  //TABLEAU ENTIER LONG($TbNumRaemaN;$TT)
  //Boucle ($Salé;1;$TT)
  //$TbNumRaemaN{$Salé}:=Num($TbNumRaemaA{$Salé})
  //Fin de boucle 
  //TRIER TABLEAU($TbNumRaemaN;>)
  //ZVariableVersBlob (->[XDonnées]XBlob;->$TbNumRaemaN)
  //STOCKER ENREGISTREMENT([XDonnées])
  //ZAmnistiePartielle (->[XDonnées])