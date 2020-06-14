//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/03/18, 16:11:15
  // ----------------------------------------------------
  // Méthode : ZLBImprimeLaListe
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;$NomFormulaireImpression;$2;$TitrePage;$3;$NomLBImpression)
$NomFormulaireImpression:=$1
$TitrePage:=$2
$NomLBImpression:=$3

C_LONGINT:C283($L;$Gauche;$Haut;$Droite;$Bas;$Fin;$NbPage;$HauteurPapier;$LargeurPapier;$NouvelleLargeur;$NouvelleHauteur;$numLigneTot;$NumLigne)
C_BOOLEAN:C305($ImpressionLBFinie;$ok;$Fini)

PRINT SETTINGS:C106
If (OK=1)
	$NbPage:=0
	$PiedPage:="Edité le "+String:C10(Current date:C33(*);7)
	SET PRINT OPTION:C733(Option nom document à imprimer:K47:10;$TitrePage)
	OPEN PRINTING JOB:C995
	
	$ImpressionLBComplète:=False:C215
	$NumLigne:=1
	$NumLigneRec:=0
	$NumLigneTot:=1
	While (Not:C34($ImpressionLBComplète))
		TbObParam:=0
		Repeat 
			FORM LOAD:C1103($NomFormulaireImpression)  // Charge le formulaire projet ($1) et exécute son Sur chargerment
			FORM GET OBJECTS:C898($tObjets)  // Récupère les noms d'objets du formulaire d'impression
			$L:=Find in array:C230($tObjets;"wNomVis")
			If ($L>0)
				(OBJECT Get pointer:C1124(Objet nommé:K67:5;"wNomVis"))->:=$TitrePage
			End if 
			GET PRINTABLE AREA:C703($HauteurPapier;$LargeurPapier)
			$Fin:=Size of array:C274($tObjets)
			$NbPage:=$NbPage+1
			OBJECT GET COORDINATES:C663(*;$NomLBImpression;$Gauche;$Haut;$Droite;$Bas)
			$AffEntete:=OB Get:C1224(TbObParam{1};"Entete";Est un entier long:K8:6)
			If ($AffEntete=3) & ($NbPage>1)
				$vEntNom:=OB Get:C1224(TbObParam{2};"entNom";Est un texte:K8:3)
				OBJECT SET VISIBLE:C603(*;$vEntNom;False:C215)
			End if 
			If ($Droite<$LargeurPapier)
				$NouvelleLargeur:=$LargeurPapier-10
			Else 
				$NouvelleLargeur:=$Droite
			End if 
			If ($Bas>$HauteurPapier)
				$NouvelleHauteur:=$HauteurPapier-30
			Else 
				$NouvelleHauteur:=$Bas
			End if 
			If ($NouvelleHauteur#$Haut)
				OBJECT SET COORDINATES:C1248(*;$NomLBImpression;$Gauche;$Haut;$NouvelleLargeur;$NouvelleHauteur)
			End if 
			OBJECT SET SCROLL POSITION:C906(*;$NomLBImpression;$NumLigneTot)
			OBJECT GET COORDINATES:C663(*;$NomLBImpression;$x;$y;$d;$b)
			$ImpressionLBFinie:=Print object:C1095(*;$NomLBImpression;$x;$y)
			LISTBOX GET PRINT INFORMATION:C1110(*;$NomLBImpression;lk nombre lignes imprimées:K53:13;$NumLigneRec)
			
			  // Impression des autres objets
			vEditMV:=$PiedPage+"   -   page "+String:C10($NbPage)
			For ($i;1;$Fin)
				$objet:=$tObjets{$i}
				If ($objet#$NomLBImpression)
					OBJECT GET COORDINATES:C663(*;$objet;$Gauche;$Haut;$Droite;$Bas)
					If ($Bas>$HauteurPapier)
						$Haut:=$HauteurPapier-20
					End if 
					$ok:=Print object:C1095(*;$objet;$Gauche;$Haut)
				End if 
			End for 
			LISTBOX GET PRINT INFORMATION:C1110(*;$NomLBImpression;lk impression terminée:K53:14;$Fini)
			
			If ($ImpressionLBComplète=False:C215) | (TbObParam#0) | (Not:C34($Fini))
				PAGE BREAK:C6(>)
			End if 
			
		Until (TbObParam=0)
		$numLigneTot:=$numLigneTot+$numLigneRec-1
		If ($numLigneTot=Records in selection:C76(ZPtTable->))
			$ImpressionLBComplète:=True:C214
		Else 
			  //. LISTBOX LIRE INFORMATION IMPRESSION(*;$NomLBImpression;lk num dernière ligne impr;$numLigne)
			$NumLigneTot:=$NumLigneTot+1
		End if 
	End while 
	
	CLOSE PRINTING JOB:C996
End if 