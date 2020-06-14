//%attributes = {"publishedWeb":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/02/19, 17:42:12
  // ----------------------------------------------------
  // Méthode : ZProcessPipeletteLocal
  // Description
  // créée par ZEcran
  // réveillée de façon systématique et périodique de manière à
  // s'informer des nouveautés// 
  // ----------------------------------------------------


C_BOOLEAN:C305(<>ZFinirEnBeauté)
C_TEXT:C284(<>ZSaintDuJour)
C_LONGINT:C283($Compteur)


  // le temps de permettre au programme de manière à intercepter Zpipelette
DELAY PROCESS:C323(Current process:C322;60*60*5)  // 5 minutes pour prendre la main  

$Compteur:=0





Repeat   // boucle infernale
	  // autres Traitements répétitifs
	$Compteur:=$Compteur+1
	
	If ($Compteur>30)  // Action à réaliser toutes les 5  minutes
		$Compteur:=0
		  // ---------
		ZInfoBase 
		
		
	End if 
	  // Reposes toi un peu avant de travailler, car tu vas en avoir besoin
	$Date1:=Current date:C33
	DELAY PROCESS:C323(Current process:C322;10*60)  // 10 secondes
	
	
	
	  // test quotidien : moins intéressant que sur le serveur cas suppose qu'on travaille tard
	$Date2:=Current date:C33
	If ($Date1#$Date2)
		  // traitement à faire à minuit ...
		ZLeJourSeLève 
	End if 
	
Until (<>ZFinirEnBeauté)  // condition peu probable = boucle continue
