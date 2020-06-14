//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 15:46:38
  // ----------------------------------------------------
  // Paramètres
  // $1 = Pointeur sur l'objet contenant les paramètres à utiliser 
  // ----------------------------------------------------
  // Méthode : ZBaseGoogleMaps
  // Description
  //  

  // Structure de l'objet
  // - Adresse
  // - CP
  // - Ville
  // - Pays
  // - longitude
  // - latitude


C_POINTER:C301($1)
C_OBJECT:C1216($Ob)
C_TEXT:C284($Adr;$CP;$Ville;$Longitude;$Latitude)
C_BOOLEAN:C305($Coordonnees)

$Ob:=$1->

$Adr:=OB Get:C1224($ob;"adresse";Est un texte:K8:3)
$Coordonnees:=($Adr="")  // On est en mode coordonnées Long/Lat
$URL:="https://maps.google.fr/maps/place/"

If ($Coordonnees)
	
	$Longitude:=OB Get:C1224($ob;"longitude";Est un texte:K8:3)
	$Latitude:=OB Get:C1224($ob;"latitude";Est un texte:K8:3)
	$address:=$Latitude+","+$Longitude
	
Else 
	
	$CP:=OB Get:C1224($ob;"cp";Est un texte:K8:3)
	$Ville:=OB Get:C1224($ob;"ville";Est un texte:K8:3)
	$Pays:=OB Get:C1224($ob;"pays";Est un texte:K8:3)
	
	If (($Adr#"") & ($CP#"") & ($Ville#""))
		
		If ($Pays#"")
			$address:=Uppercase:C13($Adr+",+"+$CP+",+"+$Ville+",+"+$Pays)
		Else 
			$address:=Uppercase:C13($Adr+",+"+$CP+",+"+$Ville)
		End if 
		
		$address:=Replace string:C233($address;" ";"+")
		
	Else 
		ALERT:C41("Il n'y a pas assez d'information pour faire une géolocalisation avec Google Maps.")
	End if 
	
End if 

$Erreur:=NET_Ping ("www.google.com";"";$actif;3)  // Pour s'assurer que Google est bien là
$txt:=IT_ErrorText ($Erreur)

If ($erreur=0)  // Internet indisponible
	
	$URL:=$URL+$address
	OPEN URL:C673($URL)
	
Else 
	ALERT:C41("Aucune connexion internet n'a été trouvée  :-(")
	
End if 
