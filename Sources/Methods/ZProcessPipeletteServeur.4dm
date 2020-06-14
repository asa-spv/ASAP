//%attributes = {"executedOnServer":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 02/05/18, 15:51:45
  // ----------------------------------------------------
  // Méthode : ZProcessPipeletteServeur
  // Description
  // Boucle infernale sur le serveur qui gère le changement de date du jour,
  // les tâches de fond, modifications apportées par un client WEB
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($compteur)
C_OBJECT:C1216($Ob)

$compteur:=-1
ASAPFabriqueTbRAEMACourant 
ASAPActualisePersonnes 
$Date:=Current date:C33

While (True:C214)
	
	$compteur:=$compteur+1
	If (<>ZNewsActifs)
		ZNewsActualise 
	End if 
	If (Current date:C33#$Date)
		  // Actualisation des tableaux de gestion du RAEMA
		RaemaInitPUMCampagne 
		ASAPFabriqueTbCampagnesToutes 
		ASAPFabriqueTbParticipe 
		ASAPFabriqueTbCampagneUne 
		ASAPFabriqueTbPrestations (True:C214)
		
		  // Gestion du changement de date du jour
		ZLeJourSeLève 
	End if 
	  // Gestion périodique
	ZPipeletteServeurScrute 
	
	
	
	If (($compteur=6) | ($compteur=0))
		$compteur:=0
		  // -------------
		
		OB SET:C1220($ob;"Structure";Structure file:C489)
		OB SET:C1220($ob;"Data";Data file:C490)
		OB SET:C1220($ob;"TailleBase";Get document size:C479(Data file:C490))
		OB SET:C1220($ob;"IP";ZTrouveIPExterne )
		OB SET:C1220($ob;"RacineWeb";Get 4D folder:C485(Dossier racine HTML:K5:20;*))
		OB SET:C1220($ob;"DossierActif";Get 4D folder:C485(Dossier 4D actif:K5:10;*))
		OB SET:C1220($ob;"DossierRessources";Get 4D folder:C485(Dossier Resources courant:K5:16;*))
		
		READ WRITE:C146([XData:1])
		QUERY:C277([XData:1];[XData:1]XNom:2="Passeport";*)
		QUERY:C277([XData:1]; & [XData:1]XType:3="Papiers")
		
		If (Records in selection:C76([XData:1])=0)
			CREATE RECORD:C68([XData:1])
			[XData:1]XNom:2:="Passeport"
			[XData:1]XType:3:="Papiers"
		End if 
		
		[XData:1]XObjet:18:=$Ob
		SAVE RECORD:C53([XData:1])
		ZAmnistiePartielle (->[XData:1])
		
		
		
	End if 
	
	
	  // Gestion de la tache de fond
	
	ZTacheDeFondAccomplir ("serveur")
	
	
	
	  // Modifications apportées par un client WEB
	
	
	
	$date:=Current date:C33
	DELAY PROCESS:C323(Current process:C322;5*60)  // Toutes les 5 secondes
	
End while 