//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 11:59:50
  // ----------------------------------------------------
  // Paramètres
  // $0 = Booléen
  // $1 = Pointeur sur la variable
  // $2 = Pointer sur texte Texte retourné filté
  // {$3} = liste des caractères autorisés
  // ----------------------------------------------------
  // Méthode : ZBaseTrappeFrappeClavier ( ->zoneFrappe ; ->varSpool { ; carAcceptes) -> bool
  // Description
  // masquage de la frappe dans un champ
  // retourne si nouvelle valeur du champ
  //----------------------------------------------------
  // Maurice Inzirillo * 19/11/08 * 4DBB
  // arnaud * 06/03/10 * port4Dv11, améliorations (gestion des touches)
  //----------------------------------------------------


C_BOOLEAN:C305($0)
C_POINTER:C301($1;$pZoneSaisie)
C_POINTER:C301($2;$pVarSpool)
C_TEXT:C284($3)
C_LONGINT:C283($lCodeCar)
C_LONGINT:C283($lDebut)
C_LONGINT:C283($lFin)
C_TEXT:C284($tFrappeClavier)
C_TEXT:C284($tNouvelleValeur)
C_TEXT:C284($tAcceptChars)

Case of 
	: (Count parameters:C259<2) | (Is nil pointer:C315($1)) | (Is nil pointer:C315($2))
		
	Else 
		$pZoneSaisie:=$1
		$pVarSpool:=$2
		$tAcceptChars:="abcdefghjiklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_0123456789@$%&#"  //convient pour mot de passe
		If (Count parameters:C259>2)  //Il a sa propre chaine de caractères autorisés
			$tAcceptChars:=$3
		End if 
		
		  //récupérer le texte sélectionné dans la zone saisissable
		GET HIGHLIGHT:C209($pZoneSaisie->;$lDebut;$lFin)
		  //on part de la valeur spoolée
		$tNouvelleValeur:=$pVarSpool->
		
		$tFrappeClavier:=Keystroke:C390
		$lCodeCar:=Character code:C91($tFrappeClavier)
		
		Case of   //actualiser varSpool selon la frappe...
				
			: ($lCodeCar=127)  //touche Suppr, Supprimer le ou les caractères sélectionnés à droite du curseur
				If ($lDebut=$lFin)
					$tNouvelleValeur:=Substring:C12($tNouvelleValeur;1;$lDebut-1)+Substring:C12($tNouvelleValeur;$lDebut+1)
				Else 
					$tNouvelleValeur:=Substring:C12($tNouvelleValeur;1;$lDebut-1)+Substring:C12($tNouvelleValeur;$lFin)
				End if 
				
			: ($lCodeCar=Touche retour arrière:K12:29)  //Supprimer le ou les caractères sélectionnés à gauche du curseur
				If ($lDebut=$lFin)
					$tNouvelleValeur:=Substring:C12($tNouvelleValeur;1;$lDebut-2)+Substring:C12($tNouvelleValeur;$lFin)
				Else 
					$tNouvelleValeur:=Substring:C12($tNouvelleValeur;1;$lDebut-1)+Substring:C12($tNouvelleValeur;$lFin)
				End if 
				
				  //touches flèches, laisser passer la Frappe
			: ($lCodeCar=Touche gauche:K12:16)
			: ($lCodeCar=Touche droite:K12:17)
			: ($lCodeCar=Touche haut:K12:18)
			: ($lCodeCar=Touche bas:K12:19)
				
			: (Position:C15($tFrappeClavier;$tAcceptChars)>0)  //caractère accepté
				
				If ($lDebut#$lFin)  //effacer sélection
					$tNouvelleValeur:=Substring:C12($tNouvelleValeur;1;$lDebut-1)+$tFrappeClavier+Substring:C12($tNouvelleValeur;$lFin)
					
				Else   //point d'insertion
					Case of 
						: ($lDebut<=1)  //au début du texte
							$tNouvelleValeur:=$tFrappeClavier+$tNouvelleValeur
							
						: ($lDebut>Length:C16($tNouvelleValeur))  //à la fin du text
							$tNouvelleValeur:=$tNouvelleValeur+$tFrappeClavier
							
						Else   //dans le texte, insérer le nouveau caractère
							$tNouvelleValeur:=Substring:C12($tNouvelleValeur;1;$lDebut-1)+$tFrappeClavier+Substring:C12($tNouvelleValeur;$lDebut)
					End case 
				End if 
				
			Else   //caractère non accepté
				FILTER KEYSTROKE:C389("")
				
		End case   //actualiser varSpool selon la frappe...
		
		  //Est-ce que la valeur est maintenant différente ?
		$0:=($tNouvelleValeur#$pVarSpool->)
		  //Retourner la valeur pour la gestion de la prochaine Frappe Clavier
		$pVarSpool->:=$tNouvelleValeur
		$pZoneSaisie->:=$tNouvelleValeur
End case 