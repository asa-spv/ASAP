//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/07/18, 07:04:59
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ResP2NumEchantillonsOK <= ResP2Preambule <= ResP2MF
  // Fonction qui renvoie Vrai si les n° des échantillons notés
  // par le laboratoire est compatible avec l'ordre du RAEMA
  // ----------------------------------------------------

C_BOOLEAN:C305($0)
$0:=True:C214
  //  WebActualiseConnexion (NumLaboActuelA;Faux;Vrai)  // Récupération de TbNumEchT
  // allons voir le chiffre significatif
$ChiffreSignificatif:=<>TbCampagnesRang{LigneRaemaCourant}

  // Test de la longueur des n° d'échantillons en cas de JS désactivé
For ($Salé;1;5)
	If (Length:C16(TbNumEch{$Salé})#6)  // test de 6 chiffres
		$0:=False:C215
	End if 
End for 

  // respect du rang
Case of 
	: (TbNumEchT{1}[[$ChiffreSignificatif]]#"0") & (TbNumEchT{1}[[$ChiffreSignificatif]]#"1")
		$0:=False:C215
		
	: (TbNumEchT{2}[[$ChiffreSignificatif]]#"2") & (TbNumEchT{2}[[$ChiffreSignificatif]]#"3")
		$0:=False:C215
		
	: (TbNumEchT{3}[[$ChiffreSignificatif]]#"4") & (TbNumEchT{3}[[$ChiffreSignificatif]]#"5")
		$0:=False:C215
		
	: (TbNumEchT{4}[[$ChiffreSignificatif]]#"6") & (TbNumEchT{4}[[$ChiffreSignificatif]]#"7")
		$0:=False:C215
		
	: (TbNumEchT{5}[[$ChiffreSignificatif]]#"8") & (TbNumEchT{5}[[$ChiffreSignificatif]]#"9")
		$0:=False:C215
		
End case 

