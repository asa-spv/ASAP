//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/02/16, 16:40:33
  // ----------------------------------------------------
  // Méthode : WebHistoireConnexion
  // Description
  // Méthode projet qui permet de tracer les interventions 
  //  des laboratoires du RAEMA
  // Paramètres
  // $1 := n° du labo
  // $2 = n° de la page envoyée
  // {$3} = booléen initiant une phrase complémentaire
  // {$4} = numéro de téléchargement de rapport
  // ----------------------------------------------------

C_TEXT:C284($H;VarResumeRes)
If ($1#"0")
	Case of 
		: ($2=11)
			$NumCampagne:=<>NumCampagneEnCoursInfoOK
			
		: (Count parameters:C259>3)
			$NumCampagne:=$4
			
		Else 
			$NumCampagne:=<>NumCampagneEnCoursSaisie
	End case 
	
End if 

Case of 
		
	: ($1="0")  // erreur
		$H:="Erreur dans le numéro du labo le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		
	: ($2=1)  // Identification saisie des résultats
		$H:="Identification du labo le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+" pour la saisie des résultats"
		$H:=$H+<>ZCR+"Numéro de labo : "+NumLaboActuelA+" et mot de passe : "+MotDePasseActuel
		
	: ($2=2)  // Envoi de la Page 2 de la saisie des résultats = choix des germes
		$H:="Validation du deuxième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Etendue de la portée des analyses"
		
	: ($2=3)  // Envoi de la Page 3 de la saisie des résultats = résultats
		$H:="Validation du troisième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Saisie des analyses et envoi du mail"
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"RéponseEnvoyée";True:C214)
		
	: ($2=4)  // Envoi de la Page 4 de la saisie des résultats = résultats
		$H:="Validation du quatrième écran le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
		$H:=$H+"Envoi de l'accusé de réception des résultats par mail"
		
	: ($2=5)  // envoi par mail du rapport
		  // $H:=WebHistoireConnexionP5($3)
		
	: ($2=6)
		  // $H:=WebHistoireConnexionP6($3)  // Modification manuelle de la liste des rapports pris
		
	: ($2=7)
		  // $H:=WebHistoireConnexionP7($3)  // envoi par mail du lien de téléchargement
		
	: ($2=8)
		$H:=WebHistoireConnexionStocke  // stockage des données page 3 sans envoyer envoi par mail du lien de téléchargement
		
	: ($2=9)
		  // $H:=WebHistoireConnexionP8  // Passage manuel du statut de non téléchargé au statut de retenu
		
		  // Modifié par : cgm (08/09/2016)
		  //: ($2=10)  // remplacé par le scrutage du dossier DR
		
		  //Si (Nombre de parametres=4)
		  //$H:=WebHistoireConnexionRecup ($3)  // téléchargement du rapport
		  //
		  //Sinon 
		  //$H:=WebHistoireConnexionRecup ($3;$5)  // téléchargement du rapport (multiple)
		  //Fin de si 
		  // fin du Modifié par : cgm (08/09/2016)
		
		
	: ($2=11)  // Identification informations sur le RAEMA
		$H:="Identification du labo le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)
		$H:=$H+" pour l'obtention de renseignements sur le RAEMA "+<>NumCampagneEnCoursInfoOK
		$H:=$H+<>ZCR+"Numéro de labo : "+NumLaboActuelA+" et mot de passe : "+MotDePasseActuel
		
		
	: ($2=12)  // Modification manuelle de la liste des laboratoires participants
		  // $H:=WebHistoireConnexionP9($3)  // WebHistoireConnexion ($Lab;12;Vrai si réintègre Faux sinon;$NumRaemaActuel)
		
		
	: ($2=15)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"Résumé";VarResumeRes)
End case 
[CampagneParticipations:17]TexteParticipation:4:=[CampagneParticipations:17]TexteParticipation:4+<>ZCR2+$H
SAVE RECORD:C53([CampagneParticipations:17])
ZAmnistiePartielle (->[CampagneParticipations:17];True:C214)  // libère l'enregistrement mais le garde en mémoire
