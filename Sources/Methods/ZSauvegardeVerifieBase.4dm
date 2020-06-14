//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/05/18, 10:32:51
  // ----------------------------------------------------
  // Méthode : ZSauvegardeVerifieBase
  // Description
  // 
  // ----------------------------------------------------
C_LONGINT:C283($salé)
C_TEXT:C284(Retour;$MethError;$Message;$MessDonnées;$NomTable;$S)
C_TEXT:C284($VarSMTP;$de;$a)
C_POINTER:C301($PtTable)
C_OBJECT:C1216($Email)

  // test d'intégrité des valeurs par tentative d'écriture 
gError:=0
$MessDonnées:=""
$MethError:=Method called on error:C704
ON ERR CALL:C155("ZBaseErreurs")
READ WRITE:C146(*)
For ($salé;1;Get last table number:C254)
	If (Is table number valid:C999($Salé))
		$PtTable:=Table:C252($Salé)
		ALL RECORDS:C47($PtTable->)
		APPLY TO SELECTION:C70($PtTable->;Field:C253($salé;1)->:=Field:C253($salé;1)->)
		If (gError#0)
			$NomTable:=Table name:C256($salé)
			$MessDonnées:=$MessDonnées+<>ZCR+"La tentative d'écriture sur la table "+$NomTable+" a provoqué l'erreur n° "+String:C10(gError)
			gError:=0
		End if 
	End if 
End for 
ON ERR CALL:C155("")


  // test de vérification des données
Retour:=""
VERIFY CURRENT DATA FILE:C1008(Tout vérifier:K57:1;0;"ZSauvegardeVerifMethodeBack")
ZConfiguration_Get_Email_Princ (->$VarSMTP;->$de;->$a)


If (<>Ajar)  // si on est sur AJAR
	
	Case of 
		: (Retour="Done.") & ($MessDonnées="")  // Aucun problème à signaler
			  // Voir si on envoi un mail quand même
			$S:="Tout va bien braves gens de l'ASA"
			$Message:="A l'instant, les données ASAP ont été vérifiées et ne présentent aucune anomalie."
			
			
		: (Retour="Done.") & ($MessDonnées#"")  //  problème sur ecriture des enregistrements à signaler
			  // Voir si on envoi un mail quand même
			$S:="Truc bizarre : "+<>ZCR
			$Message:="A l'instant, les données du standard ont été vérifiées et ne présentent aucune anomalie "
			$Message:=$Message+"mais le test d'écriture montre "+$MessDonnées+"."
			
		: (Retour="")
			$S:="Impossibilité de vérifier les données du programme"
			$Message:="A l'instant, les données du standard n'ont pas été vérifiées suite à une erreur."
			If ($MessDonnées#"")
				$Message:=$Message+<>ZCR+"De plus, "+$MessDonnées
			End if 
			$Message:=$Message+<>ZCR+"Merci de bien vouloir les vérifier directement"
			
		Else 
			$S:="Problèmes sur les données du programme"
			$Message:="A l'instant, les données du standard ont été vérifiées et présentent les anomalie suivantes :"
			$Message:=$Message+<>ZCR+Retour
			If ($MessDonnées#"")
				$Message:=$Message+<>ZCR+"De plus, "+$MessDonnées
			End if 
			
	End case 
	TRACE:C157
	$Destinataires:="asa-spv@wanadoo.fr,claude.grandmontagne@gmail.com"
	If (False:C215)
		$Email:=New object:C1471
		OB SET:C1220($Email;"to";$Destinataires;"subject";$S;"textBody";$Message)
		$OK:=ASAPEnvoiMailTransporter ($Email)
	Else 
		$Erreur:=SMTP_QuickSend ("smtp.orange.fr";"asadiaweb@orange.fr";$Destinataires;$S;$Message;1;465;"asadiaweb";"1Asa2Raema")
	End if 
Else 
	  // Il n'y a pas de SMTP, faisons une alerte UNIQUEMENT si on n'est pas sur un Serveur !
	If (Application type:C494#4D Server:K5:6)
		ALERT:C41($Message)
	End if 
	
End if 

  // Restitution de la méthode initiale de gestion d'erreur
ON ERR CALL:C155($MethError)