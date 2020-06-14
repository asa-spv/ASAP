//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Info-Lar - Arnaud PAPA
  // Date et heure : 23/11/10
  // Modifié par Patrick EMANUEL
  // ----------------------------------------------------
  // M√©thode : SVG_f_GFX
  // Description : Cr√©ation g√©n√©rique de graphique en SVG

  // $1 ->Style Visuel (Diff√©rentes couleurs et options...)
  // $2 ->S√©rie X
  //¬†$3 ->S√©rie Y1
  // $4 ->Couleur de la s√©rie Y1
  // $5 -> Nom de la s√©rie Y1
  // $6 -> S√©rie Y2 (Facultatif)
  // $7 ->Couleur de la s√©rie Y2 (Facultatif)
  // $8 -> Nom de la s√©rie Y2 (Facultatif)
  // etc
  // etc
  // etc
  //
  // Param√®tres
  // ----------------------------------------------------

C_PICTURE:C286($img)
C_PICTURE:C286($0)

C_POINTER:C301(${1})

C_LONGINT:C283($Nbre_Serie)
C_LONGINT:C283($Img_X;$Img_Y;$j;$k;$Marge;$Type;$Nbr_X)
C_REAL:C285($Angle;$Legende_X;$Num_Serie;$Degra_Rad;$Interv_X)
C_TEXT:C284($Col_Axe;$Col_Repere;$Degra_1;$Degra_2;$Col_Police;$Col_Box_Legende)

$MaxParametres:=Count parameters:C259

Case of 
	: ($MaxParametres=1)  //Help !!
		
		  //A traiter plus tard
		
	: ($MaxParametres>29)  //Help !!
		
		  //Plus de 9 s√©ries on √©t√© g√©n√©r√©s. On r√©duit aux 9 premiers
		$MaxParametres:=29
		
	Else 
		
		$Nbre_Serie:=0
		
		  //================================================================================================================
		  //Section DATA
		  //================================================================================================================
		
		  //On r√©cup√®re le style du Gfx
		$Style:=$1
		
		If (Size of array:C274($Style->)=12)
			$Col_Axe:=$Style->{1}
			$Col_Repere:=$Style->{2}
			$Degra_1:=$Style->{3}
			$Degra_2:=$Style->{4}
			$Degra_Rad:=Num:C11($Style->{5})
			$Col_Police:=$Style->{6}
			$Col_Box_Legende:=$Style->{7}
			  //On r√©cup√®re dimensions et marge
			$Img_X:=Num:C11($Style->{8})
			$Img_Y:=Num:C11($Style->{9})
			$Marge:=Num:C11($Style->{10})+5
			  //On r√©cup√®re le titre
			$Titre:=$Style->{11}
			  //On r√©cup√®re le type de Gfx
			$Type:=Num:C11($Style->{12})
			
		Else 
			$Col_Axe:="white"
			$Col_Repere:="White"
			$Degra_1:="black"
			$Degra_2:="LightGrey"
			$Degra_Rad:=-90
			$Col_Police:="White"
			$Col_Box_Legende:="White"
			$Img_X:=1000
			$Img_Y:=480
			$Marge:=25
			$Titre:="Graphe Standard"
			$Type:=5  // Parce que j'aime bien
			
		End if 
		
		  //On garde 15% de l'image pour la l√©gende
		
		  //$Legende_X:=0,15*$Img_X
		  //$Img_X:=$Img_X-$Legende_X
		
		$Legende_X:=0
		
		  //On r√©cup√®re la s√©rie X
		$Serie_X_pt:=$2
		$Nbr_X:=Size of array:C274($Serie_X_pt->)
		$Interv_X:=($Img_X-(2*$Marge))/$Nbr_X
		
		
		ARRAY LONGINT:C221(SerieY1;$Nbr_X)
		ARRAY LONGINT:C221(SerieY2;$Nbr_X)
		ARRAY LONGINT:C221(SerieY3;$Nbr_X)
		ARRAY LONGINT:C221(SerieY4;$Nbr_X)
		ARRAY LONGINT:C221(SerieY5;$Nbr_X)
		ARRAY LONGINT:C221(SerieY6;$Nbr_X)
		ARRAY LONGINT:C221(SerieY7;$Nbr_X)
		ARRAY LONGINT:C221(SerieY8;$Nbr_X)
		ARRAY LONGINT:C221(SerieY9;$Nbr_X)
		
		C_TEXT:C284(CoulY1;CoulY2;CoulY3;CoulY4;CoulY5;CoulY6;CoulY7;CoulY8;CoulY9)
		C_TEXT:C284(NomY1;NomY2;NomY3;NomY4;NomY5;NomY6;NomY7;NomY8;NomY9)
		
		  //On r√©cup√®re les s√©ries de donn√©es
		For ($i;3;$MaxParametres;3)
			  //On r√©cupere les series
			$Nbre_Serie:=$Nbre_Serie+1  //D√©termination du nombre de s√©ries
			$Pointeur:=Get pointer:C304("SerieY"+String:C10($Nbre_Serie))
			  //TABLEAU ENTIER LONG($Pointeur->;$Nbr_X)
			For ($k;1;$Nbr_X)
				If ($k<=Size of array:C274(${$i}->))
					$Pointeur->{$k}:=${$i}->{$k}
				End if 
			End for 
			
			  //On r√©cupere les couleurs
			$PointeurCoul:=Get pointer:C304("CoulY"+String:C10($Nbre_Serie))
			$PointeurCoul->:=${$i+1}->
			
			  //On r√©cup√®re les noms de s√©rie
			$PointeurNom:=Get pointer:C304("NomY"+String:C10($Nbre_Serie))
			$PointeurNom->:=${$i+2}->
		End for 
		
		  //On d√©clare les tableaux `qui ne serviront peut-etre pas :-)
		ARRAY LONGINT:C221(Y1;$Nbre_Serie)
		ARRAY LONGINT:C221(Y2;$Nbre_Serie)
		ARRAY LONGINT:C221(Y3;$Nbre_Serie)
		ARRAY LONGINT:C221(Y4;$Nbre_Serie)
		ARRAY LONGINT:C221(Y5;$Nbre_Serie)
		ARRAY LONGINT:C221(Y6;$Nbre_Serie)
		ARRAY LONGINT:C221(Y7;$Nbre_Serie)
		ARRAY LONGINT:C221(Y8;$Nbre_Serie)
		ARRAY LONGINT:C221(Y9;$Nbre_Serie)
		
		  //On calcule l'echelle
		$Max:=0
		
		  // **************** Modification du calcul de l'√©chelle
		  // Valeurs par d√©faut
		$Max:=1
		$Num_Serie:=1
		$Rg_Serie:=1
		  // Modification de la condition en '>=' au lieu de '>' uniquement
		If ($Nbre_Serie>=1)
			For ($j;1;$Nbre_Serie)
				$Serie_tab:=Get pointer:C304("SerieY"+String:C10($j))
				For ($i;1;$Nbr_X)
					If ($Serie_tab->{$i}>$Max)
						$Max:=$Serie_tab->{$i}
						$Num_Serie:=$j  //Test
						$Rg_Serie:=$i  //Test
					End if 
				End for 
			End for 
		End if 
		
		  //  Test deb
		$Texte_Max:=String:C10(Get pointer:C304("SerieY"+String:C10($Num_Serie))->{$Rg_Serie})
		
		$Ref_Test:=SVG_New 
		SVG_New_text ($Ref_Test;$Texte_Max;0;0;"Courier";12)
		$img:=SVG_Export_to_picture ($Ref_Test)
		PICTURE PROPERTIES:C457($img;$xl;$yl)
		SVG_CLEAR ($Ref_Test)  // Nettoyons la m√©moire
		
		  // ************** R√©duction de la taille de la police de caract√®re
		$Taille_Police:=Choose:C955(((10*$Marge)/$xl)>12;12;((10*$Marge)/$xl))  //Taille 12 Maximum accept√©e. La taille peut √™tre adpat√©e en param√®tre
		  //Test fin
		
		$Echelle:=($Img_Y-(3*$Marge))/$Max
		
		  //================================================================================================================
		  //Section DESSIN
		  //================================================================================================================
		
		  //Cr√©ation de la zone SVG aux dimensions donn√©es
		$SVG_Ref:=SVG_New 
		  // $SVG_Ref:=SVG_New ($Img_X;$Img_Y)
		
		  //On trace le fond
		$Degra:=SVG_Define_linear_gradient ($SVG_Ref;"Degra_Fond";$Degra_1;$Degra_2;$Degra_Rad)
		$rect:=SVG_New_rect ($SVG_Ref;0;0;$Img_X+$Legende_X;$Img_Y;0;0;"black:0";"url(#Degra_Fond)";1)
		
		  //On trace le reste...
		Case of 
				
			: ($Type=1)  //Colonnes
				
				  //On calcule la largeur des colonnes
				$Largeur:=($Interv_X-(1*$Marge))/$Nbre_Serie
				
				For ($i;1;$Nbr_X)
					
					  //On d√©finit les d√©grad√©s
					For ($k;1;$Nbre_Serie)
						$Color:=Get pointer:C304("CoulY"+String:C10($k))->
						$Degra:=SVG_Define_linear_gradient ($SVG_Ref;"Degra"+String:C10($k);$Color+":30";"black:30")
					End for 
					
					  //On trace les colonnes
					For ($k;1;$Nbre_Serie)
						$Coord_X:=$Marge+(($i-1)*$Interv_X)+($Marge)+($Largeur*($k-1.5))
						$Pointeur:=Get pointer:C304("SerieY"+String:C10($k))
						$rect:=SVG_New_rect ($SVG_Ref;$Coord_X;$Img_Y-$Marge-($Pointeur->{$i}*$Echelle);$Largeur;($Pointeur->{$i}*$Echelle);0;0;"none";"url(#Degra"+String:C10($k)+")";1)
					End for 
					
					  //On renseigne l'axe X
					$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Serie_X_pt->{$i};$Marge+(($i-1)*$Interv_X);$Img_Y-$Marge;$Interv_X;$Marge;"Courier";$Taille_Police;Gras:K14:2;Aligné au centre:K42:3)
					SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
					
				End for 
				
				  //Cr√©ation de l'axe X
				  // $Ligne_X:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Img_X-($Marge*0,8);$Img_Y-$Marge;$Col_Axe;1)
				
				  //Cr√©ation de l'axe Y
				  // $Ligne_Y:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Marge;1,5*$Marge;$Col_Axe;1)
				$Rep_Max:=SVG_New_line ($SVG_Ref;$Marge-3;(2*$Marge);$Img_X-($Marge*0.8);(2*$Marge);$Col_Repere+":30";1)
				  // $Rep_50:=SVG_New_line ($SVG_Ref;$Marge-3;(2*$Marge)+(0,5*($Img_Y-(3*$Marge)));$Img_X-($Marge*0,8);(2*$Marge)+(0,5*($Img_Y-(3*$Marge)));$Col_Repere+":30";1)
				
				$Largeur:=$Img_Y
				$Coord_X:=$Coord_X-$Largeur+15
				
			: ($Type=2)  //Lignes bris√©es
				
				  //On d√©clare le tableaux sur X
				ARRAY LONGINT:C221($X;$Nbr_X)
				
				  //On d√©clare les tableaux
				For ($i;1;$Nbre_Serie)
					$Pointeur:=Get pointer:C304("Y"+String:C10($i))
					ARRAY LONGINT:C221($Pointeur->;$Nbr_X)
				End for 
				
				GET SYSTEM FORMAT:C994(Séparateur décimal:K60:1;$Sep)
				  //
				For ($i;1;$Nbr_X)
					  //On alimente les tableaux
					$Temp:=$Marge+(($i-1)*$Interv_X)+(0.5*$Interv_X)  // Un r√©el
					$Pos:=Position:C15($Sep;String:C10($Temp))
					$X{$i}:=Num:C11(Substring:C12(String:C10($Temp);1;$Pos-1))  //Un entier
					
					For ($k;1;$Nbre_Serie)
						Get pointer:C304("Y"+String:C10($k))->{$i}:=$Img_Y-$Marge-((Get pointer:C304("SerieY"+String:C10($k))->{$i})*$Echelle)
					End for 
					$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Serie_X_pt->{$i};$Marge+(($i-1)*$Interv_X);$Img_Y-$Marge;$Interv_X;$Marge;"Courier";$Taille_Police;1;3)
					SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
				End for 
				
				  //Cr√©ation des lignes verticales
				For ($i;1;$Nbr_X)
					$Ligne_Y:=SVG_New_line ($SVG_Ref;$Marge+(0.5*$Interv_X)+(($i-1)*$Interv_X);$Img_Y-$Marge;$Marge+(0.5*$Interv_X)+(($i-1)*$Interv_X);$Marge;$Col_Axe+":70";0.5)
				End for 
				
				  //On peut tracer
				For ($k;1;$Nbre_Serie)
					$Y_pt:=Get pointer:C304("Y"+String:C10($k))
					$Color:=Get pointer:C304("CoulY"+String:C10($k))->
					$Poly:=SVG_New_polyline_by_arrays ($SVG_Ref;->$X;$Y_pt;$Color;"none";3)
				End for 
				
				  //Cr√©ation de l'axe X
				$Ligne_X:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Img_X-($Marge*0.8);$Img_Y-$Marge;$Col_Axe;2)
				
				  //Cr√©ation de l'axe Y
				$Ligne_Y:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Marge;$Marge;$Col_Axe;2)
				$Coord_X:=0
				$Largeur:=$Img_Y-$Marge
				
			: ($Type=3)  //Emmental (c'est bon mais c'est moche pour le moment...)
				
				$Arc_deb:=0
				$Arc_fin:=0
				$Tot:=0
				For ($i;1;$Nbr_X)
					$Tot:=$Tot+Get pointer:C304("SerieY1")->{$i}
				End for 
				
				ARRAY TEXT:C222($ta_coul;$Nbr_X)
				
				$Circle:=SVG_New_circle ($SVG_Ref;0.5*$Img_X;0.5*$Img_Y;(0.25*$Img_X);"none";"white";1)
				SVG_Define_shadow ($SVG_Ref;"myShadow")
				SVG_SET_FILTER ($Circle;"myShadow")
				
				For ($i;1;$Nbr_X)
					$Arc_fin:=$Arc_deb+((Get pointer:C304("SerieY1")->{$i}/$Tot)*360)
					$Angle:=$Arc_deb+(0.5*((Get pointer:C304("SerieY1")->{$i}/$Tot)*360))
					$Angle_Rad:=$Angle*Degré:K30:2
					$CX:=(0.5*$Marge)*(Sin:C17($Angle_Rad))
					$CY:=(0.5*$Marge)*(Cos:C18($Angle_Rad))
					
					  //Si (Non(Nil(Pointeur vers("$CoulY"+Chaine($i)))))¬†¬†` C'est de la protection √† la con suite √† data incoh√©rents, mais cela ne plante pas
					  // ************** Les couleurs sont d√©j√†s transmises par ->$YCoul
					$Comp1:=Random:C100%255
					$Comp2:=Random:C100%255
					$Comp3:=Random:C100%255
					$RGB:=(($Comp1 << 16)+($Comp2 << 8)+$Comp3)
					$Coul:=SVG_Color_RGB_from_long ($RGB)
					$ta_coul{$i}:=$Coul
					  // **************
					  //Sinon 
					  //$ta_coul{$i}:=Pointeur vers("$CoulY"+Chaine($i))->
					  //Fin de si 
					  // **************
					$Cam:=SVG_New_arc ($SVG_Ref;0.5*$Img_X;0.5*$Img_Y;(0.25*$Img_X);$Arc_deb;$Arc_fin;$ta_coul{$i};$ta_coul{$i}+":70";4)
					$Arc_deb:=$Arc_fin
				End for 
				
				$Circle:=SVG_New_circle ($SVG_Ref;0.5*$Img_X;0.5*$Img_Y;(0.25*$Img_X);"black:20";"none";6)
				
				
			: ($Type=4)  //Zone
				
				  //On d√©clare le tableaux sur X
				ARRAY LONGINT:C221($X;$Nbr_X)
				
				  //On d√©clare les tableaux
				For ($i;1;$Nbre_Serie)
					$Pointeur:=Get pointer:C304("Y"+String:C10($i))
					ARRAY LONGINT:C221($Pointeur->;$Nbr_X)
				End for 
				  //
				For ($i;1;$Nbr_X)
					  //On alimente les tableaux
					$X{$i}:=$Marge+(($i-1)*$Interv_X)+(0.5*$Interv_X)
					
					For ($k;1;$Nbre_Serie)
						Get pointer:C304("Y"+String:C10($k))->{$i}:=$Img_Y-$Marge-((Get pointer:C304("SerieY"+String:C10($k))->{$i})*$Echelle)
					End for 
					$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Serie_X_pt->{$i};$Marge+(($i-1)*$Interv_X);$Img_Y-$Marge;$Interv_X;$Marge;"Courier";$Taille_Police;1;3)
					SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
					
				End for 
				
				  //Cr√©ation des lignes verticales
				For ($i;1;$Nbr_X)
					$Ligne_Y:=SVG_New_line ($SVG_Ref;$Marge+(0.5*$Interv_X)+(($i-1)*$Interv_X);$Img_Y-$Marge;$Marge+(0.5*$Interv_X)+(($i-1)*$Interv_X);$Marge;$Col_Axe+":70";0.5)
				End for 
				
				  //On trace
				For ($i;1;$Nbre_Serie)
					$Color:=Get pointer:C304("CoulY"+String:C10($i))->
					$Curve:=SVG_New_path ($SVG_Ref;$Marge;$Img_Y-$Marge;$Color;$Color+":70";2)
					
					For ($k;1;$Nbr_X)
						SVG_PATH_LINE_TO ($Curve;$X{$k};Get pointer:C304("Y"+String:C10($i))->{$k})
					End for 
					SVG_PATH_LINE_TO ($Curve;$Img_X-$Marge;$Img_Y-$Marge)
					SVG_PATH_CLOSE ($Curve)
				End for 
				
				  //Cr√©ation de l'axe X
				$Ligne_X:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Img_X-($Marge*0.8);$Img_Y-$Marge;$Col_Axe;2)
				
				  //Cr√©ation de l'axe Y
				$Ligne_Y:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Marge;$Marge;$Col_Axe;2)
				$Coord_X:=0
				$Largeur:=$Img_Y-$Marge
				
			: ($Type=5)
				
				  //On calcule la largeur des colonnes
				  //$Largeur:=$Interv_X/$Nbre_Serie  // Modifié par : MBPASA2015 (18/08/2016)
				$Largeur:=($Interv_X-(1*$Marge))/$Nbre_Serie
				
				
				  //On trace
				For ($i;1;$Nbr_X)
					
					  //On trace les colonnes
					For ($k;1;$Nbre_Serie)
						$Pointeur:=Get pointer:C304("SerieY"+String:C10($k))
						$Coord_X:=$Marge+(($i-1)*$Interv_X)+($Marge)+($Largeur*($k-1.5))
						$Coord_Y:=$Img_Y-(1*$Marge)-($Pointeur->{$i}*$Echelle)
						$Hauteur:=($Pointeur->{$i}*$Echelle)
						
						$Val_Col:=SVG_New_textArea ($SVG_Ref;String:C10($Pointeur->{$i});$Coord_X;$Coord_Y;2*$Marge;$Largeur;"Courier";$Taille_Police;1;Centrée horizontalement:K39:1)
						SVG_SET_TRANSFORM_ROTATE ($Val_Col;-90;$Coord_X;$Coord_Y)
						SVG_SET_FONT_COLOR ($Val_Col;$Col_Police)
						$Coul:=Get pointer:C304("CoulY"+String:C10($k))->
						$rect:=SVG_New_rect ($SVG_Ref;$Coord_X;$Coord_Y;$Largeur;$Hauteur;0;0;$Coul;$Coul+":70";1)
					End for 
					
					  //On renseigne l'axe X
					$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Serie_X_pt->{$i};$Marge+(($i-1)*$Interv_X);$Img_Y-$Marge;$Interv_X;$Marge;"Courier";$Taille_Police;Gras:K14:2;Aligné au centre:K42:3)
					SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
					
				End for 
				
				  //Cr√©ation de l'axe X
				$Ligne_X:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Img_X-($Marge*0.8);$Img_Y-$Marge;$Col_Axe;1)
				
				  //Cr√©ation de l'axe Y
				$Ligne_Y:=SVG_New_line ($SVG_Ref;$Marge;$Img_Y-$Marge;$Marge;1.5*$Marge;$Col_Axe;1)
				$Rep_Max:=SVG_New_line ($SVG_Ref;$Marge-3;(2*$Marge);$Img_X-($Marge*0.8);(2*$Marge);$Col_Repere+":30";1)
				  // $Rep_50:=SVG_New_line ($SVG_Ref;$Marge-3;(2*$Marge)+(0,5*($Img_Y-(3*$Marge)));$Img_X-($Marge*0,8);(2*$Marge)+(0,5*($Img_Y-(3*$Marge)));$Col_Repere+":30";1)
				
				
		End case 
		
		  // ***** la l√©gende est commune √† tous les graphs
		
		  //Cr√©ation de la l√©gende
		$CoordX:=0
		
		Case of 
			: ($type=3)
				
				For ($i;1;$Nbr_X)
					$Coul:=$ta_coul{$i}
					$CoordY:=($i*$Marge)+($i*($Marge/($Nbre_Serie+1)))
					$CoordX:=$Img_X-($Marge+(0.25*$Legende_X))
					$rect:=SVG_New_rect ($SVG_Ref;$CoordX;$CoordY;0.15*$Legende_X;0.55*$Marge;0;0;$Coul;$Coul+":70";1)
					$Nom:=$Serie_X_pt->{$i}
					$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Nom;$CoordX+25;$CoordY;0.75*$Legende_X;0.6*$Marge;"Courier";$Taille_Police;1;Aligné à gauche:K42:2)
					SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
				End for 
				
			Else   // Tous les autres types
				
				For ($i;1;$Nbre_Serie)
					$Coul:=Get pointer:C304("CoulY"+String:C10($i))->
					$Degra:=SVG_Define_linear_gradient ($SVG_Ref;"Degra"+String:C10($i);$Coul;"black")
					$CoordY:=($i*$Marge)+($i*($Marge/($Nbre_Serie+1)))
					$CoordX:=$Coord_X+$Largeur+15
					$Nom:=Get pointer:C304("NomY"+String:C10($i))->
					$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Nom;$CoordX+9;$CoordY;0.9*$Legende_X;0.95*$Marge;"Courier";$Taille_Police;1;Aligné à gauche:K42:2)
					SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
					
					Case of 
						: ($type=1)
							$rect:=SVG_New_rect ($SVG_Ref;$CoordX;$CoordY;0.05*$Legende_X;0.55*$Marge;0;0;$Coul;"url(#Degra"+String:C10($i)+")";1)
							
						Else 
							$rect:=SVG_New_rect ($SVG_Ref;$CoordX;$CoordY;0.05*$Legende_X;0.55*$Marge;0;0;$Coul;$Coul+":70";1)
							
					End case 
					
				End for 
		End case 
		
		  //Cr√©ation du titre dans la zone SVG
		$Texte_Area:=SVG_New_textArea ($SVG_Ref;$Titre;0;0;$Img_X;$Marge;"Courier";0.8*$Marge;1;3)
		SVG_SET_FONT_COLOR ($Texte_Area;$Col_Police)
		
		  //Envoi du r√©sultat
		$0:=SVG_Export_to_picture ($SVG_Ref)
		
		If (Shift down:C543)
			SVGTool_SHOW_IN_VIEWER ($SVG_Ref)
		End if 
		  //================================================================================================================
		  //Section Nettoyage de la m√©moire
		  //================================================================================================================
		
		SVG_CLEAR ($SVG_Ref)
		
		For ($i;1;$Nbre_Serie)
			$Tabl:=Get pointer:C304("SerieY"+String:C10($i))
			If (Size of array:C274($Tabl->)>0)
				DELETE FROM ARRAY:C228($Tabl->;1;Size of array:C274($Tabl->))
			End if 
			
			$Tabl:=Get pointer:C304("Y"+String:C10($i))
			If (Size of array:C274($Tabl->)>0)
				DELETE FROM ARRAY:C228($Tabl->;1;Size of array:C274($Tabl->))
			End if 
			
		End for 
		
End case 