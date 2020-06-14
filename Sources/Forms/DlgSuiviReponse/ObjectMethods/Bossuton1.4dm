  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 25/10/16, 15:44:27
  // ----------------------------------------------------
  // Méthode : DlgSuiviReponse.Bouton1
  // Description : importe le fichier d'excel de Ghislaine enregistré en texte tabulation
  // 
  // ----------------------------------------------------
  // UTILISER FILTRE("iso-8859-1";1)
  // UTILISER FILTRE("Macintosh";1)

USE CHARACTER SET:C205("Macintosh";1)
$doc:=Open document:C264("";Mode lecture:K24:5)
If (ok=1)
	RECEIVE PACKET:C104($doc;$ligne;<>ZCR)
	If ($ligne#"@_@")
		ALERT:C41("Désolé, le fichier ouvert n'est pas le bon")
	Else 
		ARRAY TEXT:C222(TbGhislaine;0)
		ARRAY TEXT:C222(TbNumLaboGS;0)
		Repeat 
			$pos:=Position:C15(<>ZTAB;$ligne)
			$premièrecellule:=Substring:C12($ligne;1;$pos-1)
			$pos2:=Position:C15("_";$premièrecellule)
			If ($pos2=0)
				$NumLabo:=$premièrecellule
			Else 
				$NumLabo:=Substring:C12($premièrecellule;1;$pos2-1)
			End if 
			$ResteLigne:=Replace string:C233(Substring:C12($ligne;$pos+1);Char:C90(10);"")
			If ($NumLabo#"") & ($ResteLigne#(<>ZTab+"@"))
				APPEND TO ARRAY:C911(TbNumLaboGS;$NumLabo)
				APPEND TO ARRAY:C911(TbGhislaine;$ResteLigne)
			End if 
			RECEIVE PACKET:C104($doc;$ligne;<>ZCR)
			$ligne:=Replace string:C233($ligne;Char:C90(10);"")
		Until ($ligne="")
	End if 
	CLOSE DOCUMENT:C267($doc)
End if 
USE CHARACTER SET:C205(*;1)

  // calcul des tableaux similaires pour les données Web
QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=VarNumRaema;*)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
DISTINCT VALUES:C339([WebConnexions:13]CodeConnexion:4;$TbUUIDLabo)
$TT:=Size of array:C274($TbUUIDLabo)
ARRAY TEXT:C222(TbWeb;0)
ARRAY TEXT:C222(TbNumLaboWeb;0)
$Rapport:=""
$Fichier:=""
For ($salé;1;$TT)
	QUERY:C277([WebConnexions:13];[WebConnexions:13]CodeConnexion:4=$TbUUIDLabo{$salé};*)
	QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
	ORDER BY:C49([WebConnexions:13];[WebConnexions:13]NumEnvoi:9;<)
	$pos:=Position:C15(<>ZTAB;[WebConnexions:13]TexteMail:6)
	$premièrecellule:=Substring:C12([WebConnexions:13]TexteMail:6;1;($pos-1))
	$reste:=Substring:C12([WebConnexions:13]TexteMail:6;$pos+1)
	APPEND TO ARRAY:C911(TbNumLaboWeb;$premièrecellule)
	APPEND TO ARRAY:C911(TbWeb;$reste)
	$Fichier:=$Fichier+[WebConnexions:13]TexteMail:6+<>ZCR
End for 

  // comparaison des tableaux
COPY ARRAY:C226(TbNumLaboGS;$TbGSSeule)

For ($salé;1;$TT)
	$L:=Find in array:C230(TbNumLaboGS;TbNumLaboWeb{$salé})
	If ($L=-1)  // On n'a pas trouvé le labo dans GS
		  // le labo existe dans le Web mais pas dans GS
	Else   // On a trouvé le labo dans GS
		
		  // Notons qu'on a trouvé de labo
		$L2:=Find in array:C230($TbGSSeule;TbNumLaboWeb{$salé})
		DELETE FROM ARRAY:C228($TbGSSeule;$L2)
		
		$ligneGS:=TbGhislaine{$L}
		$ligneWeb:=TbWeb{$salé}
		If ($ligneGS#$ligneWeb)
			  //FIXER TEXTE DANS CONTENEUR($ligneGS)
			  //FIXER TEXTE DANS CONTENEUR($ligneWeb)
			$Compteur:=1
			Repeat 
				$PosGS:=Position:C15(<>ZTab;$ligneGS)
				$CelluleGS:=Substring:C12($ligneGS;1;($PosGS-1))
				$ligneGS:=Substring:C12($ligneGS;($PosGS+1))
				$PosWeb:=Position:C15(<>ZTab;$ligneWeb)
				If ($PosWeb>0)
					$CelluleWeb:=Substring:C12($ligneWeb;1;($PosWeb-1))
				Else 
					$CelluleWeb:=$ligneWeb
				End if 
				If ($CelluleWeb="")
					$CelluleWeb:="NaN"
				End if 
				$ligneWeb:=Substring:C12($ligneWeb;($PosWeb+1))
				$Compteur:=$Compteur+1
				If ($CelluleGS#$CelluleWeb)
					$Pb:=True:C214
					If ($CelluleWeb[[1]]="0")  // cas des cases à cocher 
						  // tentative de reformatage
						$Format:="0"*Length:C16($CelluleWeb)
						$CelluleGS:=String:C10(Num:C11($CelluleGS);$Format)
						$Pb:=($CelluleGS#$CelluleWeb)
					End if 
					If ($Pb)
						$Rapport:=$Rapport+"Labo "+TbNumLaboWeb{$salé}+" Colonne "+String:C10($Compteur)+" : "+$CelluleGS+" (GS) / "+$CelluleWeb+" (Web)"+<>ZCR
					End if 
				End if 
			Until ($PosWeb=0)
			  //Si ($ligneGS#TbWeb{$Compteur+1})
			  //$Rapport:=$Rapport+"Colonne "+chaine($Compteur+1)+" : "+$CelluleGS+" (GS) / "+TbWeb{$Compteur+1}+" (Web)"
			  //fin de si
			  // Le labo existe dans GS et dans le Web mais n'a pas le même contenu
		End if 
	End if 
End for 
If (Size of array:C274($TbGSSeule)>0)
	$s:=Num:C11(Size of array:C274($TbGSSeule)>1)*"s"
	$onta:=(Num:C11(Size of array:C274($TbGSSeule)>1)*"ont")+(Num:C11(Size of array:C274($TbGSSeule)=1)*"a")
	$Rapport:=$Rapport+<>ZCR2+"ATTENTION : "+String:C10(Size of array:C274($TbGSSeule))+"labo"+$s+" ("+ZTableauVersTexte (->$TbGSSeule;", ")
	$Rapport:=$Rapport+") "+$onta+" été compté"+$s+" plusieurs fois"
End if 
  //FIXER TEXTE DANS CONTENEUR($Rapport)
$CD:=Get 4D folder:C485(Dossier base:K5:14)+"fichierraema.txt"
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
USE CHARACTER SET:C205("ISO-8859-1";0)  // Filtre iso-latin
$doc:=Create document:C266($CD)
SEND PACKET:C103($doc;$Fichier)
CLOSE DOCUMENT:C267($doc)
USE CHARACTER SET:C205(*;0)
OBJECT SET VISIBLE:C603(BouEnvoiFichier;True:C214)
