//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/01/18, 09:14:04
  // ----------------------------------------------------
  // Méthode : ZVerrouAttendre
  // Description
  //  Historique : ZAttendVerrou V11 du 10/08/2010
  //   MP qui oblige l'utilisateur à attendre 50 s qu'un enregistrement soit libéré
  //  A n'utiliser que dans les cas où l'attente est réduite à quelques secondes
  // sinon préférer ZVerrouTester qui laisse le choix à l'utilisateur
  //  ATTENTION doit être appelé AVANT toute modification des données
  //  sinon le CHARGER ENREGISTREMENT($1->) bouzille lesnouveautés
  // Paramètres
  //   $1 = Pt sur fichier considéré
  // ----------------------------------------------------



C_BOOLEAN:C305($ZCourantDair)
READ WRITE:C146($1->)
LOAD RECORD:C52($1->)
$ZCourantDair:=False:C215  //  booléen d'ouverture de fenetre
If (Locked:C147($1->))
	$ZCourantDair:=True:C214
	  //  déclencher la procédure d'info du verrouilleur= A FAIRE
	ZFenetreModaleAuCentre (400;50)
End if 
$Compteur:=0
While (Locked:C147($1->) & ($Compteur<10))
	$Mess:="J'attends la libération de l'enregistrement de "+Table name:C256($1)
	MESSAGE:C88(<>ZCR2+$Mess+<>ZCR)
	DELAY PROCESS:C323(Current process:C322;300)
	LOAD RECORD:C52($1->)
	$Compteur:=$Compteur+1
End while 
If ($ZCourantDair)
	CLOSE WINDOW:C154
End if 
If ($Compteur=10)
	LOCKED BY:C353($1->;$Process;$Machine;$Utilisateur;$NomProcess)
	If ($Process=-1)
		$Mess:="Désolé, l'enregistrement vient d'être supprimé"
	Else 
		$mess:="Enregistrement occupé par "+$Utilisateur+<>ZCR+"Process "+String:C10($Process)+" "+$NomProcess+<>ZCR+" sur l'ordinateur "+$Machine
		$mess:=$mess+<>ZCR+"Prévenez le développeur de l'incident, SVP"
	End if 
	ALERT:C41($mess)
End if 