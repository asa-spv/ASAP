//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/02/16, 16:40:33
  // ----------------------------------------------------
  // Paramètres
  // $1 := n° du labo
  // $2 = stade de la saisie des résultats
  // {$3} = adresse mail à laquelle a été envoyée l'AR
  // ----------------------------------------------------
  // Méthode : WebHistoireConnexionSaisie
  // Description
  // Méthode projet qui permet de tracer les interventions 
  //  des laboratoires du RAEMA lors de la saisie

C_TEXT:C284($H;$NumLabo;$1;$AdresseMail;$3)
C_LONGINT:C283($2)
$NumLabo:=$1
$Stade:=$2

Case of 
		
	: ($NumLabo="0")  // erreur
		$H:="Erreur dans le numéro du labo le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		
	: ($Stade=1)  // Identification saisie des résultats
		$H:="Identification du labo le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+" pour la saisie des résultats"
		  // $H:=$H+<>ZCR+"Numéro de labo : "+NumLaboActuelA+" et mot de passe : "+MotDePasseActuel
		
	: ($Stade=2)  // Envoi de la Page 2 de la saisie des résultats = choix des germes
		$H:="Validation du deuxième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Etendue de la portée des analyses"
		
	: ($Stade=3)  // Enregistrement de la Page 3 de la saisie des résultats sans l'envoyer
		$H:="Validation du troisième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Saisie des analyses et enregistrement des données sans envoi à l'ASA"
		
	: ($Stade=4)  // Envoi de la Page 3 de la saisie des résultats = résultats
		$H:="Validation du troisième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Saisie des analyses et envoi du mail"
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"RéponseEnvoyée";True:C214)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"RésuméRésultats";VarResumeRes)
		
	: ($Stade=5)  // Envoi de la Page 4 de la saisie des résultats = résultats
		$Mail:="."
		If (Count parameters:C259=3)
			$AdresseMail:=$3
			$Mail:=Num:C11($AdresseMail#"")*(" à l'adresse "+$AdresseMail+".")
		End if 
		$H:="Validation du quatrième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Envoi de l'accusé de réception des résultats par mail"+$Mail
		
End case 

[CampagneParticipations:17]TexteParticipation:4:=[CampagneParticipations:17]TexteParticipation:4+<>ZCR2+$H
SAVE RECORD:C53([CampagneParticipations:17])

ZAmnistiePartielle (->[CampagneParticipations:17];True:C214)  // libère l'enregistrement mais le garde en mémoire
