C_LONGINT:C283($g;$h;$d;$b;$larg_fix;$haut_préc;$g1;$h1;$d1;$b1)
C_LONGINT:C283($pos_finale;$i;$larg;$haut;$larg1;$haut1)
C_LONGINT:C283($position_c;$position_e;$hauteur_a_imprimer;$hauteur_restante)

Case of 
	: (Form event code:C388=Sur impression corps:K2:18)  //Impression du corps en cours
		OBJECT GET COORDINATES:C663(VarDetail;$g;$h;$d;$b)
		$larg_fix:=$d-$g  //Calcul de la taille du champ texte Acteurs
		$haut_préc:=$b-$h
		OBJECT GET BEST SIZE:C717(VarDetail;$larg;$haut;$larg_fix)
		  //Taille optimale du champ en fonction du contenu
		$deplacement:=$haut-$haut_préc
		
		OBJECT GET COORDINATES:C663(VarDetailE;$g1;$h1;$d1;$b1)
		$larg_fix1:=$d1-$g1  //Calcul de la taille du champ texte Résumé
		$haut_préc1:=$b1-$h1
		OBJECT GET BEST SIZE:C717(VarDetailE;$larg1;$haut1;$larg_fix1)
		  //Taille optimale du champ en fonction du contenu
		$deplacement1:=$haut1-$haut_préc1
		If ($deplacement1>$deplacement)
			  //On détermine le champ le plus haut
			$deplacement:=$deplacement1
		End if 
		
		If ($deplacement>0)
			$position:=Get print marker:C708(Corps formulaire:K43:1)
			$pos_finale:=$position+$deplacement
			  //On déplace le taquet Corps et ceux qui le suivent
			SET PRINT MARKER:C709(Corps formulaire:K43:1;$pos_finale;*)
			  //Redimensionnement des zones de texte
			OBJECT MOVE:C664(VarDetail;$g;$h;$d;$haut+$h;*)
			OBJECT MOVE:C664(VarDetailE;$g1;$h1;$d1;$haut1+$h1;*)
			  //
			  //  `Redimensionnement des lignes de séparation
			  //LIRE RECT OBJET(*;"LigneH1";$g;$h;$d;$b)
			  //DEPLACER OBJET(*;"LigneH1";$g;$pos_finale-1;$d;$pos_finale;*)
			  //Boucle ($i;1;4;1)
			  //LIRE RECT OBJET(*;"LigneV"+Chaine($i);$g;$h;$d;$b)
			  //DEPLACER OBJET(*;"LigneV"+Chaine($i);$g;$h;$d;$pos_finale;*)
			  //Fin de boucle 
		End if 
		
		  //Calcul de la place disponible
		  //$position_c:=Lire taquet impression(Corps formulaire )
		  //$position_e:=Lire taquet impression(Entête formulaire )
		  //$hauteur_a_imprimer:=$position_c-$position_e
		  //$hauteur_restante:=hauteur_impression-vLhauteur_imprimee
		  //Si ($hauteur_restante<$hauteur_a_imprimer)  `Hauteur insuffisante
		  //NE PAS VALIDER  `Passer la ligne sur la page suivante
		  //Fin de si 
End case 

