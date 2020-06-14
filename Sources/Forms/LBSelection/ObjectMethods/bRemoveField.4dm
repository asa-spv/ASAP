  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/05/12
  // ----------------------------------------------------
  // Méthode : Balance.bSupp_Field
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
ZLBColonneSupprime 
  //TABLEAU TEXTE($tabNomsEntêtes;0)
  //TABLEAU TEXTE($tabNomsCols;0)
  //TABLEAU POINTEUR($tabVarCols;0)
  //TABLEAU POINTEUR($tabVarEntêtes;0)
  //TABLEAU BOOLÉEN($tabColsVisibles;0)
  //TABLEAU POINTEUR($tabStyles;0)

  //$vtItems:="Table : "+ZNomTable+";-;"

  //LISTBOX LIRE TABLEAUX(*;"Lb_Balance";$tabNomsCols;$tabNomsEntêtes;$tabVarCols;$tabVarEntêtes;$tabColsVisibles;$tabStyles)
  //$col_i:=LISTBOX Lire nombre colonnes(*;"Lb_Balance")

  //  // Retirons les champs déjà affichés
  //Boucle ($z;1;$col_i)
  //  // Création du PopUp dynamique des champs
  //$PtChamps:=$tabVarCols{$z}
  //$vtItems:=$vtItems+Nom du champ($PtChamps)+Choisir($z<$col_i;";";"")
  //Fin de boucle 

  //POSITION SOURIS($vlMouseX;$vlMouseY;$vlBouton)
  //$vlChoixUtilisateur:=Pop up menu($vtItems)

  //Si (($vlChoixUtilisateur>0) & ($vlChoixUtilisateur>2))  // Il faut au moins avoir cliqué dans le PopUp Menu
  //$vlChoixUtilisateur:=$vlChoixUtilisateur-2  // A cause des 2 lignes ajoutées initialement

  //LISTBOX SUPPRIMER COLONNE(*;"Lb_Balance";$vlChoixUtilisateur)

  //ZLBColonnesSauvePE 

  //Fin de si 