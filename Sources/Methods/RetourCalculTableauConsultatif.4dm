//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 09/06/17, 10:00:07
  // ----------------------------------------------------
  // Méthode : RetourCalculTableauConsultatif
  // Description
  // Permet de remplir les tableaux des retours
  //  en fonction du domaine considéré
  // Paramètre {$1} si existe le domaine choisi sinon global
  // ----------------------------------------------------


  // INUTILE car déjà fait
  // Création des tableaux de correspondance N° de RAEMA <-> ASA ou ADILVA

  //CHERCHER([Adhérents];[Adhérents]NumRAEMA#"")
  //TABLEAU ENTIER(TbNumRaemaN;0)
  //TABLEAU TEXTE($TbAssociation;0)
  //TABLEAU TEXTE(TbAssociation;0)
  //SÉLECTION VERS TABLEAU([Adhérents]NumRAEMAEntier;TbNumRaemaN;[Adhérents]Association;$TbAssociation)
  //$TT:=Taille tableau(TbNumRaemaN)
  //TABLEAU TEXTE(TbAssociation;$TT)
  //Boucle ($salé;1;$TT)
  //TbAssociation{$salé}:=(Num($TbAssociation{$salé}="@ADILVA@")*"ADILVA")+(Num($TbAssociation{$salé}#"@ADILVA@")*"ASA")
  //Fin de boucle 

VarTitre:="Tableau récapitulatif du Groupe Consultatif pour le domaine "+PumDomaine{PumDomaine}+" du "+String:C10(VarDateDebut)+" au "+String:C10(VarDateFin)

  // Recrutement des enregistrements des RetoursFiches
$DomaineCourant:=PUMDomaine{PUMDomaine}
QUERY:C277([RetoursFiches:24];[RetoursFiches:24]DateRetour:3>=VarDateDebut;*)
If ($DomaineCourant#"global")
	QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]Domaine:6=$DomaineCourant;*)
End if 
QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3<=VarDateFin)

SELECTION TO ARRAY:C260([RetoursFiches:24]Campagne:7;TbCampagne\
;[RetoursFiches:24]Classification:8;TbClassification\
;[RetoursFiches:24]Domaine:6;TbDomaine\
;[RetoursFiches:24]Motif:9;TbMotif\
;[RetoursFiches:24]UUID:1;TbIDRetour\
;[RetoursFiches:24]TypeRetour:5;TbTypeRetour\
;[RetoursFiches:24]NumFiche:2;TbNumFiche)

  // Extraction des campagnes concernées
ARRAY TEXT:C222(TbCampagnesConcernees;0)
$TT:=Size of array:C274(TbCampagne)
For ($salé;1;$TT)
	GET TEXT KEYWORDS:C1141(TbCampagne{$salé};$TbCampagne)
	$TTT:=Size of array:C274($TbCampagne)
	For ($fumé;1;$TTT)
		If (Find in array:C230(TbCampagnesConcernees;$TbCampagne{$fumé})=-1)
			APPEND TO ARRAY:C911(TbCampagnesConcernees;$TbCampagne{$fumé})
		End if 
	End for 
End for 
SORT ARRAY:C229(TbCampagnesConcernees;>)



  // Création des tableaux de décompte
ARRAY LONGINT:C221(TbRASA;0)
ARRAY LONGINT:C221(TbRADILVA;0)
ARRAY LONGINT:C221(TbRTotal;0)
ARRAY LONGINT:C221(TbRIASA;0)
ARRAY LONGINT:C221(TbRIADILVA;0)
ARRAY LONGINT:C221(TbRITotal;0)
ARRAY LONGINT:C221(TbDIASA;0)
ARRAY LONGINT:C221(TbDIADILVA;0)
ARRAY LONGINT:C221(TbDITotal;0)
$TT:=Size of array:C274(TbCampagnesConcernees)
ARRAY LONGINT:C221(TbRASA;$TT)
ARRAY LONGINT:C221(TbRADILVA;$TT)
ARRAY LONGINT:C221(TbRTotal;$TT)
ARRAY LONGINT:C221(TbRIASA;$TT)
ARRAY LONGINT:C221(TbRIADILVA;$TT)
ARRAY LONGINT:C221(TbRITotal;$TT)
ARRAY LONGINT:C221(TbDIASA;$TT)
ARRAY LONGINT:C221(TbDIADILVA;$TT)
ARRAY LONGINT:C221(TbDITotal;$TT)

  // remplissage
For ($salé;1;$TT)
	$CampagneCourante:=TbCampagnesConcernees{$salé}
	  // Quels retours contiennent la campagne courante ?
	QUERY:C277([RetoursFiches:24];[RetoursFiches:24]Campagne:7%$CampagneCourante;*)
	QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3>=VarDateDebut;*)
	If ($DomaineCourant#"global")
		QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]Domaine:6=$DomaineCourant;*)
	End if 
	QUERY:C277([RetoursFiches:24]; & [RetoursFiches:24]DateRetour:3<=VarDateFin)
	SELECTION TO ARRAY:C260([RetoursFiches:24]UUID:1;$TbIDRetour;[RetoursFiches:24]TypeRetour:5;$TbTypeRetour)
	$TTTT:=Size of array:C274($TbIDRetour)
	For ($Sec;1;$TTTT)
		$TypeRetour:=$TbTypeRetour{$Sec}
		QUERY:C277([RetoursAdherents:27];[RetoursAdherents:27]IDFiche:2=$TbIDRetour{$Sec})
		SELECTION TO ARRAY:C260([RetoursAdherents:27]IDAdherent:3;$TbIDAdherent)
		$TTT:=Size of array:C274($TbIDAdherent)
		For ($fumé;1;$TTT)  // pour chaque labo
			$L:=Find in array:C230(<>TbPerUUID;$TbIDAdherent{$fumé})
			$Asso:=<>TbPAAssociation{$L}
			$Association:=(Num:C11($Asso="@ADILVA@")*"ADILVA")+(Num:C11($Asso#"@ADILVA@")*"ASA")  // son association
			  // Quel tableau de décompte est concerné ?
			$Sigleretour:=(Num:C11($TypeRetour="@récla@")*"R")+(Num:C11($TypeRetour="@dema@")*"DI")+(Num:C11($TypeRetour="@reto@")*"RI")
			If ($Sigleretour#"")
				$Pt:=Get pointer:C304("Tb"+$Sigleretour+$Association)
				$Pt->{$salé}:=$Pt->{$salé}+1
				$Pt:=Get pointer:C304("Tb"+$Sigleretour+"Total")
				$Pt->{$salé}:=$Pt->{$salé}+1
			End if 
		End for 
		
	End for 
	
End for 
