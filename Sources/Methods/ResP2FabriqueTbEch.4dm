//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/07/18, 06:16:09
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ResP2FabriqueTbEch. <= ResP2MF
  // fabrication de TbNumEch n° des échantillons tels que saisis
  // et TbNumEchT n° des échantillons triés selon le rang du RAEMA
  // à partir de TbNomsP2 TbValeursP2 (tableaux des valeurs
  //  des variables de la page 2 d'un RAEMA poudre)
  // REMARQUE IMPORTANTE pour le RAEMA POUDRE:  
  // le nom des champs désigne les échantillons 
  // dans l'ordre saisi par le laboratoire
  // "textfield3" = échantillon 1, "textfield32", "textfield33"
  // "textfield34" et "textfield35" les échantillons 2, 3, 4 et 5
  // Pour le RAEMA gel, les champs sont préfixés "rgtextfield"
  // pour éviter les contrôles JavaScript de longueur et de cohérence
  // propres au RAEMA poudre
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)


  // Initialisation des tableaux

If (RaemaPoudre)  // La drepou
	ARRAY TEXT:C222(TbNumEch;5)  // 5 n° d'échantillons dans l'ordre de saisie
	ARRAY TEXT:C222(TbNumEchT;5)  // 5 n° d'échantillons finalement triés par le rang
	ARRAY TEXT:C222($TbNumEchRaccourci;5)  // 5 n° d'échantillons tronqués pour débuter par le rang
	
	  // recherche du rang de saisie
	$NomEnrRaema:="Raema n°"+<>NumCampagneEnCoursSaisie
	  //CHERCHER([RAEMACampagnes];[RAEMACampagnes]NumCampagne=<>NumCampagneEnCoursSaisie)
	  //$ChiffreSignificatif:=OB Lire([RAEMACampagnes]Arguments;"Rang";Est un numérique)
	$ChiffreSignificatif:=<>TbCampagnesRang{LigneRaemaCourant}
	
	  //Pour chaque échantillon
	$L:=Find in array:C230(TbNomsP2;"textfield3")
	TbNumEch{1}:=TbValeursP2{$L}
	$TbNumEchRaccourci{1}:=Substring:C12(TbValeursP2{$L};$ChiffreSignificatif)
	
	
	$L:=Find in array:C230(TbNomsP2;"textfield32")
	TbNumEch{2}:=TbValeursP2{$L}
	$TbNumEchRaccourci{2}:=Substring:C12(TbValeursP2{$L};$ChiffreSignificatif)
	
	$L:=Find in array:C230(TbNomsP2;"textfield33")
	TbNumEch{3}:=TbValeursP2{$L}
	$TbNumEchRaccourci{3}:=Substring:C12(TbValeursP2{$L};$ChiffreSignificatif)
	
	$L:=Find in array:C230(TbNomsP2;"textfield34")
	TbNumEch{4}:=TbValeursP2{$L}
	$TbNumEchRaccourci{4}:=Substring:C12(TbValeursP2{$L};$ChiffreSignificatif)
	
	$L:=Find in array:C230(TbNomsP2;"textfield35")
	TbNumEch{5}:=TbValeursP2{$L}
	$TbNumEchRaccourci{5}:=Substring:C12(TbValeursP2{$L};$ChiffreSignificatif)
	
	COPY ARRAY:C226(TbNumEch;TbNumEchT)
	SORT ARRAY:C229($TbNumEchRaccourci;TbNumEchT;>)  // Tri uniquement du tableau finalement trié
	
Else   // RAEMA gel
	
	$Test:=<>NumCampagneEnCoursSaisie+"@"
	  //CHERCHER([RAEMAGermes];[RAEMAGermes]Identifiant=$Test)  // autant de cases que de germes
	  //$FT:=Enregistrements trouvés([RAEMAGermes])-1  // -1 car il ya les conditions générales qui ne sont pas des germes
	$FT:=<>TbCampagnesNbGermes{LigneRaemaCourant}
	ARRAY TEXT:C222(TbNumEch;0)
	ARRAY TEXT:C222(TbNumEchT;0)
	For ($Salé;1;$FT)
		$Nom:="rgtextfield"+String:C10($Salé)
		$NumEch:=WebTrouveValeurParNom ($Nom;->TbNomsP2;->TbValeursP2)
		If ($NumEch#"")
			APPEND TO ARRAY:C911(TbNumEch;$NumEch)
		End if 
	End for 
	
	
End if 
