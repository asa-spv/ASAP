
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		
		BouImageImpListe:=0
		BouImageImpFiche:=1
		BouImageImpEtiquette:=0
		BouImageImpEtat:=0
		
		ARRAY TEXT:C222(PUMLBChoixET;3)
		PUMLBChoixET{1}:="Imprimer l'entête sur toutes les pages"
		PUMLBChoixET{2}:="Imprimer l'entête sur aucune page"
		PUMLBChoixET{3}:="Imprimer l'entête sur la première page"
		PUMLBChoixET:=1
		FORM GOTO PAGE:C247(1)  // affichage des choix d'impression
		  // Gestion de la largeur d'impression en liste
		$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"VarComLargeur")
		OBJECT SET VISIBLE:C603(*;"PbLargeur@";True:C214)
		Case of 
			: (OnAffichePbLargeur=0)
				$Pt->:="La largeur de la ListBox est compatible avec la taille de la feuille de papier"
				OBJECT SET VISIBLE:C603(*;"PbLargeur@";False:C215)
			: (OnAffichePbLargeur=1)
				$Pt->:="La largeur de la ListBox est compatible avec la taille de la feuille de papier SI VOUS DEMANDEZ UNE IMPRESSION en PAYSAGE"
			Else 
				$Pt->:="La largeur de ListBox est INCOMPATIBLE avec la taille de la feuille de papier : Merci de choisir une option ci-dessous"
		End case 
		ARRAY TEXT:C222(PUMLBChoixLargeur;3)
		PUMLBChoixLargeur{1}:="Imprimer toutes les colonnes sur une seule page"
		PUMLBChoixLargeur{2}:="Imprimer les colonnes sur plusieurs pages"
		PUMLBChoixLargeur{3}:="Choisir une compression des colonnes"
		PUMLBChoixLargeur:=1
		  // gestion de la portée d'impression
		$FT:=Records in selection:C76(ZPtTable->)
		$NbEnr:=(Num:C11($FT>1)*("les "+String:C10($FT)+" enregistrements"))+(Num:C11($FT=1)*"un seul enregistrement")
		PortBRSel:=0
		PortBRTout:=1
		If (NbSel>0)  // pas de lignes sélectionnées
			$Titre:="Imprimer "+$NbEnr
			OBJECT SET TITLE:C194(PortBRTout;$Titre)
			$NbDSel:=(Num:C11(NbSel>1)*("les "+String:C10(NbSel)+" enregistrements"))+(Num:C11(NbSel=1)*"le seul enregistrement")+" sélectionné"+(Num:C11(NbSel>1)*("s"))
			OBJECT SET TITLE:C194(PortBRSel;"Imprimer "+$NbDSel)
			OBJECT SET VISIBLE:C603(*;"PbLargeur@";False:C215)
		Else 
			$Pt:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"VarPortéeImpression")
			$Pt->:="En l'absence de lignes sélectionnées, l'impression portera sur "+$NbEnr
		End if 
		OBJECT SET VISIBLE:C603(*;"Port@";(NbSel>0))
		OBJECT SET VISIBLE:C603(*;"VarPortéeImpression";(NbSel=0))
		OBJECT SET VISIBLE:C603(*;"PbLargeur@";False:C215)
		
		bThermoCoeff:=100
End case 
