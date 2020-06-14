If (False:C215)
	
	  //C_ENTIER LONG($Salé;$FT)
	  //$FT:=Taille tableau(Colonne1)
	  //TABLEAU TEXTE(TbNomsGermes;0)
	  //TOUT SÉLECTIONNER([RAEMAGel])
	  //VALEURS DISTINCTES([RAEMAGel]NomDuGerme;TbNomsGermes)
	  //TRIER TABLEAU(TbNomsGermes;>)
	  //TABLEAU ENTIER LONG(TbOrdre;Taille tableau(TbNomsGermes))
	  //TbOrdre{1}:=30
	  //TbOrdre{2}:=10
	  //TbOrdre{3}:=50
	  //TbOrdre{4}:=40
	  //TbOrdre{5}:=20
	  //TRIER TABLEAU(TbOrdre;TbNomsGermes;>)
	
	  //TABLEAU TEXTE(TbPeriodeGel;2)
	  //TbPeriodeGel{1}:="Mai"
	  //TbPeriodeGel{2}:="Décembre"
	
	
	  //  // TABLEAU DES [RAEMAGel] à remplir
	  //TABLEAU TEXTE(TbAnCampagne;0)
	  //TABLEAU ENTIER LONG(TbNbrePotAvecRapport;0)
	  //TABLEAU ENTIER LONG(TbNbrePotSansRapport;0)
	  //TABLEAU TEXTE(TbNomDuGermee;0)
	  //TABLEAU TEXTE(TbNumRAEMA;0)
	  //TABLEAU TEXTE(TbPeriode;0)
	
	
	  //Boucle ($Salé;1;$FT)
	  //$NumRaemaCourant:=ColRGA1{$Salé}  // le n° RAEMA du laboratoire
	  //CHERCHER([Adhérents];[Adhérents]NumRAEMA=$NumRaemaCourant)
	  //Si (GA15AdilvaGelOK )
	  //LECTURE ÉCRITURE([RAEMAGel])
	  //CHERCHER([RAEMAGel];[RAEMAGel]AnCampagne=VarPermMilleRaemaGel;*)
	  //CHERCHER([RAEMAGel];[RAEMAGel]NumRaema=$NumRaemaCourant)
	  //SUPPRIMER SÉLECTION([RAEMAGel])
	
	  //Boucle ($Fumé;1;10)  // pour les 2x 5 germes de l'année
	  //$CompteurPeriode:=7+(Num($Fumé>5)*15)
	  //$NumPériode:=1+Num($Fumé>5)
	  //$Incrémentation:=$Fumé-(Num($Fumé>5)*5)
	  //$Pt:=Pointeur vers("ColRGA"+Chaîne($CompteurPeriode+$Incrémentation))
	  //$NbEnvoi:=Num($Pt->{$Salé})  // envoi principal
	  //$Pt:=Pointeur vers("ColRGA"+Chaîne($CompteurPeriode+$Incrémentation+5))
	  //$NbAvec:=Num($Pt->{$Salé})  // avec rapport
	  //$Pt:=Pointeur vers("ColRGA"+Chaîne($CompteurPeriode+$Incrémentation+10))
	  //$NbSans:=Num($Pt->{$Salé})  // sans rapport
	
	  //Si ($NbEnvoi>0)
	  //AJOUTER À TABLEAU(TbAnCampagne;VarPermMilleRaemaGel)
	  //AJOUTER À TABLEAU(TbNbrePotAvecRapport;$NbAvec)
	  //AJOUTER À TABLEAU(TbNbrePotSansRapport;$NbSans)
	  //AJOUTER À TABLEAU(TbNomDuGermee;TbNomsGermes{$Incrémentation})
	  //AJOUTER À TABLEAU(TbNumRAEMA;$NumRaemaCourant)
	  //AJOUTER À TABLEAU(TbPeriode;TbPeriodeGel{$NumPériode})
	  //Si ($NbEnvoi>1)
	  //TbNbrePotSansRapport{Taille tableau(TbNbrePotSansRapport)}:=TbNbrePotSansRapport{Taille tableau(TbNbrePotSansRapport)}+($NbEnvoi-1)
	  //Fin de si 
	  //Sinon 
	  //Si (($NbAvec+$NbSans)>0)
	  //ALERTE("Des pot supplémentaires sont demandés sans qu'il y ait de d'envoi principal...")
	  //Fin de si 
	  //Fin de si 
	  //Fin de boucle 
	  //Fin de si 
	
	  //Fin de boucle 
	  //TABLEAU VERS SÉLECTION(TbAnCampagne;[RAEMAGel]AnCampagne\
		;TbNbrePotAvecRapport;[RAEMAGel]NbrePotAvecRapport\
		;TbNbrePotSansRapport;[RAEMAGel]NbrePotSansRapport\
		;TbNomDuGermee;[RAEMAGel]NomDuGerme\
		;TbNumRAEMA;[RAEMAGel]NumRaema\
		;TbPeriode;[RAEMAGel]Periode)
	
	  //GA15RaemaGelActualiseLoto 
	
	
	  // DONNEES héritées du fichier de l'ADILVA
	  //ColRGA1;Colonne1  = N° RAEMA
	  //ColRGA2 = N° de département
	  //ColRGA3 = Nom département
	  //ColRGA4 = CP + localité
	  //ColRGA5 = Nom Directeur
	  //ColRGA6 = Mail directeur
	  //ColRGA7 = Téléphone
	  // COMMANDE INITIALE de MAI
	  //ColRGA8;Colonne2 =  Bacillus Mai
	  //ColRGA9;Colonne3 = Pseudo Mai
	  //ColRGA10;Colonne4 = Lactiques Mai
	  //ColRGA11;Colonne5 = LM Ens Mai
	  //ColRGA12;Colonne6 /= LM Sep Mai
	
	  // Pots sup AVEC COFRAC
	  //ColRGA13 =  Bacillus 
	  //ColRGA14 = Pseudo
	  //ColRGA15 = Lactiques
	  //ColRGA16 = LM Ens
	  //ColRGA17 = LM Sep
	
	  // Pots sup SANS COFRAC
	  //ColRGA18 =  Bacillus 
	  //ColRGA19 = Pseudo
	  //ColRGA20 = Lactiques
	  //ColRGA21 = LM Ens
	  //ColRGA22 = LM Sep
	
	  // COMMANDE INITIALE de DECEMBRE
	  //ColRGA23;Colonne7  // Bacillus Décembre
	  //ColRGA24;Colonne8  // Pseudo Décembre
	  //ColRGA25;Colonne9  // Lactiques Décembre
	  //ColRGA26;Colonne10  // LM Ens Décembre
	  //ColRGA27;Colonne11  // LM Sep Décembre
	
	  // Pots sup AVEC COFRAC
	  //ColRGA28 =  Bacillus 
	  //ColRGA29 = Pseudo
	  //ColRGA30 = Lactiques
	  //ColRGA31 = LM Ens
	  //ColRGA32 = LM Sep
	
	  // Pots sup SANS COFRAC
	  //ColRGA33 =  Bacillus 
	  //ColRGA34 = Pseudo
	  //ColRGA35 = Lactiques
	  //ColRGA36 = LM Ens
	  //ColRGA37 = LM Sep
	
	
	
End if 