//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/07/18, 08:32:52
  // ----------------------------------------------------
  // Paramètre $1 = rang du [RAEMAGermes] 
  // ----------------------------------------------------
  // Méthode : ResP2CreationLignesOKP3 <= ResP2FabriqueRaemaRestreint <=  ResP2MF = traitement de la page 2
  // Description : écrit le HTML des lignes pertinentes du questionnaire de la page 3 = saisie des résultats
  // en fonction du choix effectué en cochant les cases des germes 


C_LONGINT:C283($NbValeurs;$Fumé)
$CodeInitial:=NumCampagneCourante+$1
$RangBCGel:=$2
  // Plaçons nous sur la bonne ligne = la première de la page (du germe) dans le tableau général

Compteur:=Find in array:C230(<>TbRefGerme;$CodeInitial)
$THTML:=ResP2HtmlLigneTitre 
$OnAFiniLeTableau:=False:C215
Repeat 
	If (<>TbNomLigneF{Compteur}="Dilution@")  // On passe dans le bloc des réponses
		$THTML:=$THTML+ResP2HtmlResultats 
	Else   // on n'est pas dans le bloc des réponses mais dans des lignes du germe
		$MultipleCourant:=<>TbMultiple{Compteur}
		If ($MultipleCourant="")  // pas de valeur à proposer 
			  // on est dans le cas 1.1.4 = Ligne sans colonne 2 et champ de saisie fixe dans la colonne 3
			$THTML:=$THTML+ResP2HtmlLigneSimple ($RangBCGel)
		Else   // PUM            1.1.2Ligne avec menu local en 2e colonne et champ de précision initialement caché dans la 3e 
			  // ou boîtes à cocher   1.1.3Ligne avec boîtes à cocher en 2e colonne et champ de précision initialement caché dans la 3e 
			$THTML:=$THTML+ResP2HtmlLigneMultiple 
		End if 
	End if 
	Compteur:=Compteur+1
	If (Compteur>Size of array:C274(<>TbRefGerme))
		$OnAFiniLeTableau:=True:C214
	Else 
		$CodeCourant:=<>TbRefGerme{Compteur}
	End if 
Until ($CodeCourant#$CodeInitial) | ($OnAFiniLeTableau)
$0:=$THTML