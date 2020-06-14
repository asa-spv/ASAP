//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/02/12
  // ----------------------------------------------------
  // Méthode : ZLBAfficheListe
  // Description
  // Méthode qui remplit la ListBox ZNomListe au chargement
  // ----------------------------------------------------

If (GestionFixe) & (GestionTableau)
	EXECUTE METHOD:C1007(ZMethodeTableaux)
Else 
	C_LONGINT:C283($FT;NumEnrPremListe;$SFT;$Salé;$TT;$PageCourante;$g;$h;$d;$b)
	C_POINTER:C301(ZptChamp;$PttLB;$PtCourant)
	C_OBJECT:C1216($Objet)
	ARRAY TEXT:C222(TbPUMFormatPossible;0)
	ARRAY TEXT:C222(TbUUIDFormatPossible;0)
	GestionTableau:=(ZNomListe="Lb_Tableaux")
	$FT:=ZLBFabriquePUMListes 
	
	If ($FT>0)  // il existe une liste préalable
		GOTO RECORD:C242([XData:1];NumEnrPremListe)
		NomSchemaListBoxCourante:=TbPUMFormatPossible{1}
		  // Nombre maxi de colonne : 20
		  // Nom de la Variable pour les boutons : de tLB1 à tLB20 initialisées dans ZInitVariables
		  //  Vous pouvez utiliser des champs ou des variables de type chaîne, numérique, Date, Heure, Image et Booléen.
		ZLBColonnesCharge 
		
	Else   // il n'existe pas de liste préalable
		If (GestionFixe=False:C215)
			If (ZNomForSortie="")  // pas de sortie par défaut : on ne met que le champ significatif
				$Der:=LISTBOX Get number of columns:C831(*;$NomLB)
				LISTBOX INSERT COLUMN:C829(*;$NomLB;$Der+1;ZNomChaDis;ZptChamp->;ZNomChaDis;tLB1)
				OBJECT SET TITLE:C194(tLB1;ZNomChaDis)
				  // Enlevons la première colonne qui ne nous sert plus à rien 
				LISTBOX DELETE COLUMN:C830(*;$NomLB;1)
				
			Else   //il existe un formulaire de sortie copions les champs présents
				OB SET:C1220($Objet;"NumTable";ZNumTable)
				FORM LOAD:C1103(ZPtTable->;ZNomForSortie)  // Allons zieuter le formulire de sortie définie pourZLBGèreListe
				FORM GET OBJECTS:C898($TbObjets;$TbVariables;$TbPages)  // Repérage des objets de ce formulaire
				$TT:=Size of array:C274($TbVariables)
				$CompteurChamp:=0  // Le nombre de champ étant différent du compteur d'objet, initialisons-le
				For ($Salé;1;$TT)  // Pour chacun des objets
					$PageCourante:=$TbPages{$Salé}
					$PtCourant:=$TbVariables{$Salé}
					RESOLVE POINTER:C394($PtCourant;$nomVar;$NumTable;$NumChamp)
					If ($PageCourante=1) & ($NumTable=ZNumTable)  // On ne conserve que les champs de la table courante qui sont en page 1
						$CompteurChamp:=$CompteurChamp+1
						$ZNomChaDis:=Field name:C257($PtCourant)
						$PttLB:=Get pointer:C304("tLB"+String:C10($CompteurChamp))
						$ColCourante:="Colonne"+String:C10($CompteurChamp;"00")
						$PtObjet:=Get pointer:C304("$ObjetColonne"+String:C10($CompteurChamp))
						OBJECT GET COORDINATES:C663($PtCourant->;$g;$h;$d;$b)
						
						C_OBJECT:C1216($PtObjet->)
						OB SET:C1220($PtObjet->;"ColNom";$ZNomChaDis\
							;"ColNumTable";$NumTable\
							;"ColNumChamp";$NumChamp\
							;"ColNomVarET";"Colonne"+String:C10($CompteurChamp;"00")\
							;"ColTaille";$d-$g\
							;"ColTitre";$ZNomChaDis)
						OB SET:C1220($Objet;$ColCourante;$PtObjet->)
						
					End if 
					
				End for 
				FORM UNLOAD:C1299
				
				ZLBColonnesCharge (->$Objet)
				VarObjet:=$Objet
			End if 
		End if 
		
		
		  // créons la Liste des chmps par défaut
		CREATE RECORD:C68([XData:1])
		[XData:1]XNom:2:=ZNomListeXData
		[XData:1]XType:3:="LB"+ZNomTable
		[XData:1]XDate:4:=Current date:C33
		$Ob:=ZLBFabriqueObjetLB   // Affectation des caractéristiques de la LB
		[XData:1]XEntier:6:=OB Get:C1224($Ob;"NbColonne")
		[XData:1]XObjet:18:=$Ob
		[XData:1]XAlpha:8:="Liste par défaut"
		[XData:1]XTexte:9:=<>ZQuiCode
		SAVE RECORD:C53([XData:1])
		
		  // Actualisons le PUM
		QUERY:C277([XData:1];[XData:1]XNom:2=ZNomListeXData;*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="LB"+ZNomTable)
		  // initialisation des PUM de choix des formats
		INSERT IN ARRAY:C227(TbPUMFormatPossible;1)
		TbPUMFormatPossible{1}:="Liste par défaut"
		INSERT IN ARRAY:C227(TbUUIDFormatPossible;1)
		TbUUIDFormatPossible{1}:=[XData:1]UUID:1
		TbPUMFormatPossible:=1
	End if 
	TbPUMFormatPossible:=Find in array:C230(TbPUMFormatPossible;"Liste par défaut")  // plaçons le PUM 
	
End if 
