//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/08/18, 06:33:01
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : ResP3ControleDates
  // Description
  // Test de cohérence entre les dates 
  // de démarrage de la campagne obtenue par AJAX
  // Celle de réception du colis et de début des analyses
  // Ceinture ET bretelles car normalement trapsé par JS

QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=<>NumCampagneEnCoursSaisie)
$DateEnvoiColis:=[RAEMACampagnes:20]DateEnvoiColis:3
$DateReception:=Date:C102(WebTrouveValeurParNom ("Champ0101";->TbNomsP3;->TbValeursP3))
$DateAnalyse:=Date:C102(WebTrouveValeurParNom ("Champ0103";->TbNomsP3;->TbValeursP3))
$DatesNonVides:=($DateReception#!00-00-00!) & ($DateAnalyse#!00-00-00!)
$Ecran:=RaemaTraducUtiliseTableau (82)  // Texte d'alerte en différentes langues
Case of 
	: (($DateReception<$DateEnvoiColis) & ($DatesNonVides))
		MauvaisSyntaxe:=True:C214
		MotifRefus:="La date de réception de peut être inférieure à celle de l'envoi des échantillons"
		WEB SEND FILE:C619($Ecran)
		
	: (($DateAnalyse<$DateEnvoiColis) & ($DatesNonVides))
		MauvaisSyntaxe:=True:C214
		MotifRefus:="La date de début des analyses de peut être inférieure à celle de l'envoi des échantillons"
		WEB SEND FILE:C619($Ecran)
		
	: (($DateAnalyse<$DateReception) & ($DatesNonVides))
		MauvaisSyntaxe:=True:C214
		MotifRefus:="La date de début des analyses de peut être inférieure à celle de réception des échantillons"
		WEB SEND FILE:C619($Ecran)
		
	: ((($DateReception-$DateEnvoiColis)>40) & ($DatesNonVides))
		MauvaisSyntaxe:=True:C214
		MotifRefus:="La date de réception de peut être aussi éloignée de celle de l'envoi des échantillons"
		WEB SEND FILE:C619($Ecran)
		
	: ((($DateAnalyse-$DateEnvoiColis)>40) & ($DatesNonVides))
		MauvaisSyntaxe:=True:C214
		MotifRefus:="La date de début des analyses de peut être aussi éloignée de celle de l'envoi des échantillons"
		WEB SEND FILE:C619($Ecran)
End case 

$0:=Not:C34(MauvaisSyntaxe)