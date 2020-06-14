//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/14, 11:15:01
  // ----------------------------------------------------
  // Méthode : ResFlipFlop
  // Description
  // Permet de vérifier si la valeur choisie dans le PUM
  // doit ou non déclencher l'apparition d'un champ supplémentaire
  // ainsi que l'attribution de champs f(méthode)
  // Paramètres : $1 = envoi AJAX de la page Web
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$Pos;$Pos1;$Pos2;$NumPage)


$Mess:=$1
If ($mess="flipflopcheckbox@")  // C'est une case à cocher
	$Objet:=Substring:C12($Mess;22)
	  //$NumPageA:=Sous chaîne($Objet;1;2)
	  //$NumOrdreA:=Sous chaîne($Objet;3;2)
	  //$RangA:=Sous chaîne($Objet;5)
	  //$identifiantLigne:=<>NumCampagneEnCoursSaisie+$NumPageA+$NumOrdre
	$IdentifiantValeur:=<>NumCampagneEnCoursSaisie+$Objet
	QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$IdentifiantValeur)
	ORDER BY:C49([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3;>)
	GOTO SELECTED RECORD:C245([RAEMAValeurs:23];$Rang)
	$AppChamp:=Num:C11(OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Précision";Est un booléen:K8:9))
	$ValeurChamp:="Champ"+String:C10($NumPage;"00")+String:C10($NumOrdre;"00")
	$reponse:=$ValeurChamp+","+String:C10($AppChamp)
	
Else   // C'est un menu local
	  // $Mess a la forme "flipflop"+"2 - AFNOR BKR 23/09-05/15 (Rhapsody agar)"+","+PUM0301
	$envoi:=Substring:C12($Mess;9)  // élimination de "flipflop"
	$Pos:=Position:C15(",";$envoi)  // repérage de la virgule
	$ValeurChoisie:=Substring:C12($envoi;1;$Pos-1)  // Valeur choisie du PUM 
	$Rang:=Num:C11(Substring:C12($ValeurChoisie;1;3))
	$LigneValeurA:=String:C10($Rang;"00")
	$Pos1:=Position:C15(Char:C90(160);$ValeurChoisie)  // Repérage du premier espace insécable
	$Pos2:=Position:C15(Char:C90(160);$ValeurChoisie;$Pos1+1)  // Repérage du deuxième espace insécable
	$TestTableau:=Substring:C12($ValeurChoisie;$Pos2+1)  // Extraction de la valeur chosie dans son n°
	$ValeurRangA:=Substring:C12($envoi;$Pos+4)
	$PageA:=Substring:C12($ValeurRangA;1;2)
	$NumOrdreA:=Substring:C12($ValeurRangA;3;2)
	$NumOrdre:=Num:C11($NumOrdreA)
	$identifiantLigne:=<>NumCampagneEnCoursSaisie+$PageA+$NumOrdreA
	$IdentifiantValeur:=$identifiantLigne+$LigneValeurA
	
	QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3=$IdentifiantValeur)
	$AppChamp:=Num:C11(OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Précision";Est un booléen:K8:9))
	$ValeurChamp:="Champ"+$ValeurRangA
	$reponse:=$ValeurChamp+","+String:C10($AppChamp)
	  // type Champ0201,0 =champ concerné st le 0201 et 0 veut dire qu'on n'a pas à afficher le champ de précision
	
	  // passons à l'attribution de champs f(méthode) 
	$NomFabricant:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Fabricant";Est un texte:K8:3)
	$NomMilieu:=OB Get:C1224([RAEMAValeurs:23]Arguments:6;"Milieu";Est un texte:K8:3)
	If (Length:C16($NomFabricant+$NomMilieu)>0)  // il existe un fabricant et/ou un milieu liés à la valeur
		$TestLigne:=<>NumCampagneEnCoursSaisie+$PageA+"@"
		QUERY:C277([RAEMALignes:22];[RAEMALignes:22]Identifiant:3=$TestLigne)  // selection de toutes les lignes du germe
		SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbIdLigne;[RAEMALignes:22]Arguments:6;$TbArg)
		
		$CodeMilieu:=""
		$CodeFabricant:=""
		$FT:=Size of array:C274($TbArg)
		$RangCode:=3+Num:C11(<>NumCampagneEnCoursSaisie="@a")
		For ($Salé;1;$FT)
			$Arg:=OB Get:C1224($TbArg{$Salé};"Nature";Est un texte:K8:3)
			If ($Arg="Fabricant")
				$CodeFabricant:=Substring:C12($TbIdLigne{$Salé};$RangCode;4)
				$L:=Find in array:C230(<>TbRefLigne;$TbIdLigne{$Salé})  // Première ligne des [RAEMAValeurs]
				$LigneFabricant:=Find in array:C230(<>TbNomValeurF;$NomFabricant;$L)-$L+1
			End if 
			If ($Arg="Milieu")
				$CodeMilieu:=Substring:C12($TbIdLigne{$Salé};$RangCode;4)
				$L:=Find in array:C230(<>TbRefLigne;$TbIdLigne{$Salé})  // Première ligne des [RAEMAValeurs]
				$LigneMilieu:=Find in array:C230(<>TbNomValeurF;$NomMilieu;$L)-$L+1
			End if 
		End for 
		If ($CodeMilieu#"") & ($CodeFabricant#"")
			$reponse:=$reponse+"£"+$CodeMilieu+String:C10($LigneMilieu)+";"+$CodeFabricant+String:C10($LigneFabricant)
			  // Type Champ0201,0.  (déjà initalisé plus haut) £02022;02033
			  // Champ0201 = champ originel
			  // ,0  = pas d'apparition d'un champ de précision
			  // £ séparateur
			  //.  0202 = PUM du milieu ciblé  2 = rang à attribuer
			  //.  0203 = PUM du fabricant ciblé  3 = rang à attribuer
		End if 
	End if 
	
End if 

WEB SEND TEXT:C677($reponse)



  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/07/14, 11:15:01
  // ----------------------------------------------------
  // Méthode : ResFlipFlop
  // Description
  // Permet de vérifier si la valeur choisie dans le PUM
  // doit ou non déclencher l'apparition d'un champ supplémentaire
  // ainsi que l'attribution de champs f(méthode)
  // Paramètres : $1 = envoi AJAX de la page Web
  // ----------------------------------------------------
  //$Mess:=$1
  //Si ($mess="flipflopcheckbox@")  // C'est une case à cocher
  //$Objet:=Sous chaîne($Mess;22)
  //$NumPage:=Num(Sous chaîne($Objet;1;2))
  //$NumOrdre:=Num(Sous chaîne($Objet;3;2))
  //$Rang:=Num(Sous chaîne($Objet;5))
  //CHERCHER([RAEMA];[RAEMA]NumPage=$NumPage;*)
  //CHERCHER([RAEMA]; & [RAEMA]Ordre=$NumOrdre;*)
  //CHERCHER([RAEMA]; & [RAEMA]NumRAEMA=<>NumCampagneEnCoursSaisie)
  //CHERCHER([RAEMAValeursPossibles];[RAEMAValeursPossibles]IDVPRaema=[RAEMA]IDRaema)
  //TRIER([RAEMAValeursPossibles];[RAEMAValeursPossibles]Ordre;>)
  //ALLER DANS SÉLECTION([RAEMAValeursPossibles];$Rang)
  //$AppChamp:=Num([RAEMAValeursPossibles]Precision)
  //$ValeurChamp:="Champ"+Chaîne($NumPage;"00")+Chaîne($NumOrdre;"00")
  //$reponse:=$ValeurChamp+","+Chaîne($AppChamp)

  //Sinon   // C'est un menu local
  //$envoi:=Sous chaîne($Mess;9)
  //$Pos:=Position(",";$envoi)
  //$ValeurChoisie:=Sous chaîne($envoi;1;$Pos-1)
  //$Pos1:=Position(Caractère(160);$ValeurChoisie)
  //$Pos2:=Position(Caractère(160);$ValeurChoisie;$Pos1+1)
  //$TestTableau:=Sous chaîne($ValeurChoisie;$Pos2+1)
  //$ValeurRang:=Sous chaîne($envoi;$Pos+4)
  //$NumPage:=Num(Sous chaîne($ValeurRang;1;2))
  //$PageA:=Chaîne($NumPage;"00")
  //$NumOrdre:=Num(Sous chaîne($ValeurRang;3;2))
  //CHERCHER([RAEMA];[RAEMA]NumPage=$NumPage;*)  // les [RAEMA] de la campagne
  //CHERCHER([RAEMA]; & [RAEMA]NumRAEMA=<>NumCampagneEnCoursSaisie)
  //TRIER([RAEMA];[RAEMA]Ordre;>)
  //SÉLECTION VERS TABLEAU([RAEMA]Intitule;$ZoneChose;[RAEMA]IDRaema;$TbIDRaema)
  //CHERCHER DANS SÉLECTION([RAEMA];[RAEMA]Ordre=$NumOrdre)
  //CHERCHER([RAEMAValeursPossibles];[RAEMAValeursPossibles]IDVPRaema=[RAEMA]IDRaema)
  //TRIER([RAEMAValeursPossibles];[RAEMAValeursPossibles]Ordre;>)
  //SÉLECTION VERS TABLEAU([RAEMAValeursPossibles]Precision;$TbPre\
;[RAEMAValeursPossibles]Intitule;$LigneF\
;[RAEMAValeursPossibles]UUID;$UUID\
;[RAEMAValeursPossibles]Heading;$LigneA)
  //$L:=Chercher dans tableau($LigneF;$TestTableau)
  //Si ($L<0)
  //$L:=Chercher dans tableau($LigneA;$TestTableau)
  //Fin de si 
  //$AppChamp:=Num($TbPre{$L})
  //$ValeurChamp:="Champ"+$ValeurRang
  //$reponse:=$ValeurChamp+","+Chaîne($AppChamp)

  //  // passons à l'attribution de champs f(méthode) 
  //CHERCHER([RAEMAValeursPossibles];[RAEMAValeursPossibles]UUID=$UUID{$L})
  //CHERCHER([XDonnees];[XDonnees]XType="PrecPUM";*)  // Repérage [XDonnees]
  //CHERCHER([XDonnees]; & [XDonnees]XAlpha=[RAEMAValeursPossibles]UUID)
  //Si (Enregistrements trouvés([XDonnees])=1)  // on l'a trouvé
  //Si (Taille BLOB([XDonnees]XBlob)>0)  // Son Blob contient les tableaux voulus
  //TABLEAU TEXTE($TbNature;0)
  //TABLEAU TEXTE($TbValeur;0)
  //ZBlobVersVariable (->[XDonnees]XBlob;->$TbNature;->$TbValeur)  // extraction des tb
  //$L2:=Chercher dans tableau($ZoneChose;"Nature@")
  //CHERCHER([RAEMAValeursPossibles];[RAEMAValeursPossibles]IDVPRaema=$TbIDRaema{$L2})
  //TRIER([RAEMAValeursPossibles];[RAEMAValeursPossibles]Ordre;>)
  //SÉLECTION VERS TABLEAU([RAEMAValeursPossibles]Intitule;$PUM)
  //$L:=Chercher dans tableau($TbNature;"Milieu")
  //$RangMilieu:=Chaîne(($L2-1);"00")
  //$LigneMilieu:=Chercher dans tableau($PUM;$TbValeur{$L})

  //$L2:=Chercher dans tableau($ZoneChose;"Fabric@")
  //CHERCHER([RAEMAValeursPossibles];[RAEMAValeursPossibles]IDVPRaema=$TbIDRaema{$L2})
  //TRIER([RAEMAValeursPossibles];[RAEMAValeursPossibles]Ordre;>)
  //SÉLECTION VERS TABLEAU([RAEMAValeursPossibles]Intitule;$PUM)
  //$L:=Chercher dans tableau($TbNature;"Fabricant")
  //$RangFab:=Chaîne(($L2-1);"00")
  //$LigneFab:=Chercher dans tableau($PUM;$TbValeur{$L})
  //$reponse:=$reponse+"£"+$PageA+$RangMilieu+Chaîne($LigneMilieu)+";"+$PageA+$RangFab+Chaîne($LigneFab)
  //Fin de si 
  //Fin de si 
  //Fin de si 
  //WEB ENVOYER TEXTE($reponse)

