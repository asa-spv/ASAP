//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 20:45:12
  // ----------------------------------------------------
  // Pas de Paramètres
  // ----------------------------------------------------
  // Méthode : ZConfiguration_Annule
  // Description
  //  Annule les saisies de paramètres autres que ceux de la configuration des mails

C_OBJECT:C1216($Config)
C_BOOLEAN:C305($Continue)
C_TEXT:C284($TxtEnCours;$TxtReference)

$Continue:=False:C215

QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
$Config:=OB Copy:C1225([XData:1]XObjet:18)
ZAmnistiePartielle (->[XData:1])


$TxtReference:=JSON Stringify:C1217($Config)
$TxtEnCours:=JSON Stringify:C1217(Form:C1466)

$MD5_1:=Generate digest:C1147($TxtReference;Digest MD5:K66:1)
$MD5_2:=Generate digest:C1147($TxtEnCours;Digest MD5:K66:1)

If ($MD5_1#$MD5_2)
	
	CONFIRM:C162("Attention, vous allez perdre toutes vos modifications réalisées. Etes-vous sur ?")
	$Continue:=(OK=1)
	
Else 
	$Continue:=False:C215  // Pas besoin, il n'y a pas eu de modification
	
End if 

If ($Continue)
	
	  // --------------
	  // Toutes les variables doivent être remises à leur état initiale avant de poursuivre
	  // --------------
	<>ZPermDuréeInactif:=OB Get:C1224(Form:C1466;"sec_inactivité";Est un entier long:K8:6)
	<>ZNews:=(OB Get:C1224(Form:C1466;"option_news";Est un entier long:K8:6)=1)
	<>ZNewsActifs:=(OB Get:C1224(Form:C1466;"option_news_actifs";Est un entier long:K8:6)=1)
	
End if 

CANCEL:C270  // Ferme l'écran
