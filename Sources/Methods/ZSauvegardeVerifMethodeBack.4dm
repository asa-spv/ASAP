//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/05/18, 10:34:12
  // ----------------------------------------------------
  // Paramètres
  // $1(Entier long): 
  //  si = 1 $3 = MESSAGE (Message de progression)
  //  si = 2 $3 = Vérification terminée Texte du message OK 
  //(sauf que ce n'est pas envoyé avec Tout Vérifier)
  //  si = 3 $3 = Message d'erreur sur n° $4 = table si $2=4, = index si $2=8
  //  si = 4 $3 = Fin d’exécution ("Done")
  //  si = 5 $3 = Message de Warning sur n° $4 = table si $2=4, = index si $2=8 
  // ----------------------------------------------------
  // Méthode : ZSauvegardeVerifMethodeBack
  // Description
  // Permet de savoir comment la vérification s'est passée



C_LONGINT:C283($1;$2;$4;$5)
C_TEXT:C284($3)

Case of 
	: ($1=3) | ($1=5)  // Erreur ou Warning
		If ($3#"")  // Il existe un message d'erreur 
			$NatureErreur:=(Num:C11($1=3)*"Problème sur ")+(Num:C11($1=5)*"Warning sur ")
			Case of 
				: ($2=0)  // objet indéterminé
					$NatureErreur:=$NatureErreur+"objet indéterminé"
					
				: ($2=4)
					$NatureErreur:=$NatureErreur+"enregistrements de la table "+String:C10($4)
					
				: ($2=8)
					$NatureErreur:=$NatureErreur+"index n° "+String:C10($4)
					
				: ($2=16)
					$NatureErreur:=$NatureErreur+"objet structure (contrôle préliminaire du fichier de données)"
			End case 
			Retour:=Retour+$NatureErreur+" : "+$3+"\n"
		End if 
		
	: ($1=4)  // Récupération du message de fin d'exécution ("Done.")
		
		Retour:=Retour+$3
		
		
End case 