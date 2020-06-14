//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 05/05/18, 07:18:23
  // ----------------------------------------------------
  // Paramètres :
  // $1 = Objet descriptif de la tâche de fond  (voir plus bas)
  // {$2} = Blob à faire passer à la tâche de fond
  // ----------------------------------------------------
  // Méthode : ZTacheDeFondLancer
  // Description
  // Méthode qui permet de lancer une tâche de fond
  //  c'est-à-dire decrééer un enregistrement de [XTachesDeFond]
  //  qui sera repris soit sur le serveur dans ZServeurPipelette, soit par ZPipelette local

If (False:C215)
	
	  // Descriptif type d'un Objet [XTachesDeFond]ObjetTdF
	  // [ 
	  //   NomTâche:"",------------------> identification du type de tâche
	  //   NomMéthode:"",----------------> nom de la méthode à effectuer
	
	  // Etendue de l'action : Enregistrement et sélection courante
	  //   NumTable:0,---------> numéro de la table de travail
	  //   NumEnr:0,---------------------> numéro de l'enregistrement courant
	  //   TbNumEnrSélection:TbNumEnr,---> permet de recréer la sélection courante
	
	  // FACULTATIFS
	  // Persistance
	  //   Destructible=Faux,------------> suppression ou non après accomplissement
	  // Machine exécutante
	  //   Destinataire:="", ------------> local ou serveur voire ordinateur logué sur le serveur
	  // Résultat
	  //   NomVariableOK:="",------------> variable de bon accomplissement de la méthode
	
	  // CREATIONS AUTOMATIQUES  
	  // Accomplissement : sera actualisée après éxécution réussie
	  //   Accompli:Faux,----------------> booléen d'exécution réussie (création automatique)
	  // Dates et heures de création, début et fin d'exécution
	  //   DateHeureCréation:Date,-------> format ISO date GMT pour faire les calculs de temps de latence (création automatique)
	  // ] 
	  // CREATIONS ULTERIEURES  
	  // DateHeureDebutExécution:Date ---> format ISO date GMT pour faire les calculs de temps d'exécution (création à l'exécution)
	  // DateHeureFinExécution:Date -----> format ISO date GMT pour faire les calculs de temps d'exécution (création à l'exécution)
	
End if 


C_OBJECT:C1216($1;$Objet)
C_BOOLEAN:C305($Valeur)
C_LONGINT:C283($Table)
C_TEXT:C284($Méthode;$ValeurBis;$ValeurDéfaut)
ARRAY TEXT:C222($TbNomMéthodes;0)

$Objet:=$1
If (Count parameters:C259=2)
	C_BLOB:C604($2)
End if 

$Méthode:=OB Get:C1224($Objet;"NomMéthode";Est un texte:K8:3)
METHOD GET NAMES:C1166($TbNomMéthodes)

$Table:=OB Get:C1224($Objet;"NumTable";Est un entier long:K8:6)
$NumEnrKO:=Not:C34(OB Is defined:C1231($Objet;"NumEnr"))
$TbNumEnrKO:=Not:C34(OB Is defined:C1231($Objet;"TbNumEnrSélection"))
Case of 
	: (Find in array:C230($TbNomMéthodes;$Méthode)<0)
		ALERT:C41("Désolé, la méthode "+$Méthode+" n'existe pas dans la base...")
		
	: (Find in array:C230(<>TbNumChampTableBase;$Table)<0)
		ALERT:C41("Désolé, la table n°"+String:C10($Table)+" n'existe pas dans la base...")
		
		
	: ($NumEnrKO & $TbNumEnrKO)
		ALERT:C41("Désolé, la portée de la méthode n'est pas définie...")
		
	Else 
		  // création d'une fiche de [TachesDeFond]
		CREATE RECORD:C68([XTachesDeFond:10])
		
		  // Création de valeurs automatiques
		OB SET:C1220($Objet;"DateHeureCréation";Current date:C33)  // La date et heure de création
		OB SET:C1220($Objet;"Accompli";False:C215)  // accompli (pas encore) mais sera sélectionnable plus tard
		
		  // Création des valeurs optionnelles
		  // Persisitance
		$Valeur:=OB Get:C1224($Objet;"Destructible";Est un booléen:K8:9)  // Non détruit si pas noté
		OB SET:C1220($Objet;"Destructible";$Valeur)  // stockage la valeur notée
		
		  // Machine exécutante
		$ValeurDéfaut:=(Num:C11(<>ZClient)*"serveur")+(Num:C11(Not:C34(<>ZClient))*"local")
		$ValeurBis:=OB Get:C1224($Objet;"Destinataire";Est un texte:K8:3)  // Un destinataire a t'il été prévu ?
		If ($ValeurBis="")  // pas d'idée préconçue
			$ValeurBis:=$ValeurDéfaut  // valeur par défaut
		Else 
			ARRAY TEXT:C222($TblisteClients;0)
			GET REGISTERED CLIENTS:C650($TblisteClients;$TbNb)
			If (Find in array:C230($TblisteClients;$Valeur)<0)
				If ($ValeurBis#"local") & ($ValeurBis#"serveur")  // Personne pour exécuter la [XTachesDeFond]
					$ValeurBis:=$ValeurDéfaut  // valeur par défaut
				End if 
			End if 
		End if 
		OB SET:C1220($Objet;"Destinataire";$ValeurBis)
		
		If (Count parameters:C259=2)
			C_BLOB:C604($2)
			[XTachesDeFond:10]BlobTdF:3:=$2
		End if 
		
		[XTachesDeFond:10]ObjetTdF:2:=$Objet
		
		SAVE RECORD:C53([XTachesDeFond:10])
		ZAmnistiePartielle (->[XTachesDeFond:10])
End case 
