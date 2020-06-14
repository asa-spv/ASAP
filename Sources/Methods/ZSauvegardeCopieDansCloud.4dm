//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/05/18, 10:26:56
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZSauvegardeCopieDansCloud
  // Description
  // Permet de 
  //
  // ----------------------------------------------------

  //`Repérer le bon fichier de sauvegarde
$Pref:=Get 4D file:C1418(Fichier dernière sauvegarde:K5:30)

  //  TRACE

If (<>Ajar)  // sauvegarde dans le DropBox uniquememnt si on est chez AJAR
	$CDDropBox:=<>PermCheDropBox+"SynchroBases"+Séparateur dossier:K24:12+"Sauve ASAP"+Séparateur dossier:K24:12+"sauvestandard.txt"
	$OK:=Yv18Zipf ($Pref;$CDDropBox;"asaraema")
End if 