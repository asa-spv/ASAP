//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/07/18, 08:13:15
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP2GelNumEchantillonsOK
  // Description
  //   //  RS_VérificationNumEchantillons
  // Appelée par ResP2Preambule <- ResP2MF = traitement de la page 2
  // dans le cas d'un Raema intermédiaire = 9 germes avec chacun un numéro

C_BOOLEAN:C305($0)
C_LONGINT:C283($Salé;$L)
$0:=True:C214
  // WebActualiseConnexion (NumLaboActuelA;Faux;Vrai)  // Lecture des tableaux de n° d'échantillons(TbNumEch;TbNumEchT)
$FT:=5
  //TABLEAU TEXTE(TbNumEch;0)
  //TABLEAU TEXTE(TbNumEch;$FT)
For ($Salé;1;$FT)
	$L:=Find in array:C230(TbNomsP2;"RGcb"+String:C10($Salé))
	If ($L>0)  // la case a été cochée
		  //TbNumEch{$Salé}:=TbValeursP2{$L+1}  //remplissons le numéro d'échantillon
		If (TbNumEch{$Salé}="")  //le numéro d'échantillon manque
			$0:=False:C215
			$Salé:=$FT  // sortie de la boucle 
		End if 
	Else   // la case n'est pas cochée
		$L:=Find in array:C230(TbNomsP2;"rgtextfield"+String:C10($Salé))
		If (TbValeursP2{$L}#"")  //le numéro d'échantillon est présent
			$0:=False:C215
			$Salé:=$FT  // sortie de la boucle
		End if 
	End if 
End for 
  //COPIER TABLEAU(TbNumEch;TbNumEchT)
  //WebChercheFicheXDonnées (NumLaboActuelA;Vrai;Faux)  // Ecriture des tableaux de n° d'échantillons(TbNumEch;TbNumEchT)
