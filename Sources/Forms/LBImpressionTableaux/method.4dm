Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		  // Déclaration des c@g
		C_LONGINT:C283($LargeurColonneTotale;$Salé;$FT;$NumProchaineLigneTbOb;$LargeurColonneCourante;$HauteurPapier;$LargeurPapier;$AffEntete)
		  // Déclaration des descripteur de la LB d'impression
		C_POINTER:C301($PtColVar;$PtColonneVide)
		C_TEXT:C284($ColNom;$ETNom)
		  // Déclaration du coefficient de largeur
		C_REAL:C285($CoeffLargeur)
		
		  //  // Détermination de la table concernée 
		  //  // par lecture dans le premier élément de TbObParam rempli dans ZLBDecritLBImpression
		  //$NumTable:=OB Lire(TbObParam{1};"LBSource";Est un entier long)
		  //LISTBOX FIXER TABLE SOURCE(*;"LB_TableauxImpression";$NumTable)
		
		  // Obtention des données physiques de la page imprimable
		GET PRINTABLE AREA:C703($HauteurPapier;$LargeurPapier)
		$LargeurColonneTotale:=0  // Largeur courante de la LB d'impression
		
		  // Détection de la prochaine ligne de TbObParam
		If (TbObParam=0)  // lors d'impression de la première page
			$NumProchaineLigneTbOb:=2  // la première ligne est occupée par la description de la table et des options
		Else   // impression des pages suivantes 
			$NumProchaineLigneTbOb:=TbObParam  // TbObParam est actualisé dans la suite de cette méthode
		End if 
		TbObParam:=0  // initialisation
		
		  // Test de l'option ET des colonnes sur toutes les pages initialisé dans ZLBDecritLBImpression
		  //. si "Entete" n'existe pas =>0 toutes les pages ont l'ET,  si existe enlève l'ET à partir de la page 2 
		$AffEntete:=OB Get:C1224(TbObParam{1};"Entete";Est un entier long:K8:6)
		
		Case of   // Gestion des cas d'ajustement de la largeur d'impression
			: (OB Get:C1224(TbObParam{1};"AjusteLargeur";Est un booléen:K8:9)=True:C214)  // on a décidé de tout écrire sur une page en largeur
				$TotalL:=0  // initialisation de la largeur imprimée
				$FT:=Size of array:C274(TbObParam)
				For ($Salé;$NumProchaineLigneTbOb;$FT)  // toutes les colonnes concernées par la page
					  //Si ($Salé<$FT)
					$TotalL:=$TotalL+OB Get:C1224(TbObParam{$Salé};"colSize")  // Ajout
					  //Sinon 
					  //$TotalL:=$TotalL+VarLargeurOptimaleDerCol
					  //Fin de si 
				End for 
				If ($LargeurPapier<$TotalL)  // la largeur imprimée est trop large pour une impression sans correction
					$CoeffLargeur:=Round:C94($LargeurPapier/$TotalL;2)-0.01  // Attribution d'un coefficient < 1
				Else   // la largeur imprimée n'est pas trop large pour une impression sans correction
					$CoeffLargeur:=1
				End if 
				
			: (OB Get:C1224(TbObParam{1};"coeffL";Est un numérique:K8:4)#0)  // Option d'appliquer un coeff de largeur (thermomètre) 
				$CoeffLargeur:=OB Get:C1224(TbObParam{1};"coeffL";Est un numérique:K8:4)  // Le coeff existe
				
			Else   // pas d'option de largeur
				$CoeffLargeur:=1  // pleine largeur
		End case 
		
		If ($CoeffLargeur#1)  // largeur modifiée
			$TaillePolice:=12-Int:C8((1-$CoeffLargeur)*13)  // Recalcul de la taille de police
			If ($TaillePolice<1)  // On s'arrête à 1 !!!
				$TaillePolice:=1
			End if 
			OBJECT SET FONT SIZE:C165(*;"LB_TableauxImpression";$TaillePolice)  // Attribution de la taille de police
			  // 4D n'ajuste pas la hauteur de ligne si on ne la fixe pas à nouveau après avoir modifié la taille de la police
			LISTBOX SET ROWS HEIGHT:C835(*;"LB_TableauxImpression";1;lk lignes:K53:23)  // Attribution de la hauteur de ligne
		End if 
		
		For ($Salé;$NumProchaineLigneTbOb;Size of array:C274(TbObParam))  // pour toutes les lignes de TbObParam concernées
			$LargeurColonneCourante:=Int:C8(OB Get:C1224(TbObParam{$Salé};"colSize")*$CoeffLargeur)  // largeur de la colonne eventuellement corrigée
			$LargeurColonneTotale:=$LargeurColonneTotale+$LargeurColonneCourante  // Cumul les largeurs
			If ($LargeurColonneTotale>$LargeurPapier) & ($LargeurColonneCourante<$LargeurPapier)  // Ca ne tient pas alors que cela pourrait tenir
				TbObParam:=$Salé  // On met la ligne sélectionnée = au compteur
				$Salé:=Size of array:C274(TbObParam)  // on sort de la boucle
			Else   // Ca tient ou la colonne actuelle ne peut pas tenir dans la largeur papier : on imprime
				$ColNom:=OB Get:C1224(TbObParam{$Salé};"colNom";Est un texte:K8:3)
				$PtColVar:=OB Get:C1224(TbObParam{$Salé};"colVar";Est un pointeur:K8:14)
				$ETNom:=OB Get:C1224(TbObParam{$Salé};"entNom";Est un texte:K8:3)
				$vColFormula:=OB Get:C1224(TbObParam{$Salé};"colFormule";Est un texte:K8:3)
				$vPPNom:=OB Get:C1224(TbObParam{$Salé};"PPNom";Est un texte:K8:3)
				If ($vPPNom#"")  // Pas de pied
					If ($vColFormula="")  // Pas de pied, Pas de formule
						LISTBOX INSERT COLUMN:C829(*;"LB_TableauxImpression";$Salé;$ColNom;$PtColVar->;$ETNom;$PtColonneVide;$vPPNom;$PtColonneVide)
					Else   // Pas de pied, Une formule
						$type:=OB Get:C1224(TbObParam{$Salé};"colType";Est un entier long:K8:6)  // Type du résultat de la formule
						LISTBOX INSERT COLUMN FORMULA:C970(*;"LB_TableauxImpression";$Salé;$ColNom;$vColFormula;$type;$ETNom;$PtColonneVide;$vPPNom;$PtColonneVide)
					End if 
				Else   // Un pied
					If ($vColFormula="")  // Un pied, Pas de formule
						LISTBOX INSERT COLUMN:C829(*;"LB_TableauxImpression";$Salé;$ColNom;$PtColVar->;$ETNom;$PtColonneVide)
					Else   // Un pied, Une formule
						$type:=OB Get:C1224(TbObParam{$Salé};"colType";Est un entier long:K8:6)  // Type du résultat de la formule
						LISTBOX INSERT COLUMN FORMULA:C970(*;"LB_TableauxImpression";$Salé;$ColNom;$vColFormula;$type;$ETNom;$PtColonneVide)
					End if 
				End if 
				OBJECT SET TITLE:C194(*;$ETNom;OB Get:C1224(TbObParam{$Salé};"colTitre"))
				
				LISTBOX SET COLUMN WIDTH:C833(*;$ColNom;$LargeurColonneCourante)
			End if 
		End for 
		  // On cache l'entête de la dernière colonne : Il suffit de passer une entête invisible pour cacher toutes les entêtes
		  // NB : On ne peut pas montrer l'entête ou le pied si il n'est pas visible en structure
		If ($AffEntete=2)
			OBJECT SET VISIBLE:C603(*;$ETNom;False:C215)
		End if 
End case 

