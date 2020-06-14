//%attributes = {}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 02/05/18, 16:29:07
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // méthode : ZProcessIdentification
  // description
  //
  // <>PermDuréeInactif = nombre de minutes


C_LONGINT:C283($DeltaTemps;$HC;$HDA)
C_BOOLEAN:C305(<>ZFinirEnBeauté;<>ZFenetreIdentification;$AutorisationVerrouillage)

<>ZFinirEnBeauté:=False:C215
<>ZFenetreIdentification:=False:C215
  // ZLeJourSeLève 

ZAmnistieInternationale 
QUERY:C277([XData:1];[XData:1]XNom:2="Temps max identification";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="Temps")

If (Records in selection:C76([XData:1])=0)
	
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="Temps max identification"
	[XData:1]XEntier:6:=5
	[XData:1]XType:3:="Temps"
	SAVE RECORD:C53([XData:1])
	
End if 

<>ZPermDuréeInactif:=[XData:1]XEntier:6
ZAmnistiePartielle (->[XData:1])

Repeat   // boucle infernale
	
	  // gestion du dialogue d'identification
	<>ZPermDuréeInactifMdP:=60*<>ZPermDuréeInactif
	
	If (Not:C34(<>ZFinirEnBeauté))
		
		$AutorisationVerrouillage:=False:C215
		
		Case of 
				  //: (Frontmost process=Process number(Get indexed string(170;3)))
			: (Frontmost process:C327=ZBaseEstProcessStructure )
				  // …il ne faut pas vérouiller si on n'est pas en utilisation
			: (<>ZToutNeuf=True:C214)  // sans mot de passe, inutile de vérouiller la base !
			: (<>ZPermDuréeInactifMdP=0)  // pas de délai de vérouillage dans les préférences
			: (<>ZFenetreIdentification)  // sans que ce soit deja la fenetre d'identification
				
			Else 
				$AutorisationVerrouillage:=True:C214
		End case 
		
		If ($AutorisationVerrouillage)  // toutes les conditions sont réunies pour un éventuel vérouillage
			
			$HC:=Current time:C178+1
			$HDA:=<>ZHeureDerniereAction+1
			$DeltaTemps:=($HC-$HDA)
			
			If ($DeltaTemps>=<>ZPermDuréeInactifMdP)
				
				  // l'utilisateur est resté trop longtemps inactif
				BRING TO FRONT:C326(<>ZNPM)  // met au premier plan le process principal
				ZLoginAfficheCode 
				<>TempsDerniereAction:=Tickcount:C458
				
			End if   // $AutorisationVerrouillage
		End if 
	End if 
	
	DELAY PROCESS:C323(Current process:C322;600)  // 10 secondes pour souffler un peu
	
Until (<>ZFinirEnBeauté)  // condition mise à vrai si nécessaire
