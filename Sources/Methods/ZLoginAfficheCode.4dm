//%attributes = {"publishedWeb":true}
  // ----------------------------------------------------
  // nom utilisateur : cgm
  // date et heure : 10/04/18, 06:15:16
  // ----------------------------------------------------
  // méthode : ZLoginAfficheCode
  // description
  // historique
  // ZTestCode  V11 du 15/08/2010
  // méthode qui affiche le dialogue "DlgMdP" d'entrée des codes
  // (initiales et mot de passe) si
  // ----------------------------------------------------

C_TEXT:C284(QuelEstTonNom;$QVL)
C_BOOLEAN:C305(ZDuPrem;ZOnAChangé)
C_LONGINT:C283(ZFT)

OnEstPasse:=False:C215
$NbPassage:=1
<>ZFenetreIdentification:=True:C214
$QVL:=<>ZQuiVaLà
ZDuPrem:=True:C214  // vrai au premier essai du mot de passe, faux après
Repeat 
	ZOuvrirFenetre ("DlgMdP")
	$NbPassage:=$NbPassage+1
	If ($NbPassage=4)
		QUIT 4D:C291
	End if 
	ZDuPrem:=False:C215
Until (OnEstPasse)
If (<>ZQuiVaLà#$QVL)
	ZOnAChangé:=True:C214
	QuelEstTonNom:=Choose:C955(<>zQuiVaLà="";"Pas de gestion des accès";<>zQuiVaLà)
Else 
	ZOnAChangé:=False:C215
End if 
If (Macintosh command down:C546)
	CHANGE CURRENT USER:C289(2;"")
Else 
	GET USER LIST:C609($nomsUtil;$réfUtil)
	  //si($L>0)
	$L:=Find in array:C230($nomsUtil;<>ZQuiCode)
	$NumUtil:=$réfUtil{$L}
	CHANGE CURRENT USER:C289($NumUtil;"")
	  //Fin de si 
End if 
<>ZFenetreIdentification:=False:C215

REGISTER CLIENT:C648(Current machine:C483)
GET REGISTERED CLIENTS:C650($TbCli;$TbMet)

