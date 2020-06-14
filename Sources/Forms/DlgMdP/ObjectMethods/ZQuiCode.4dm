  // Méthode objet de <>ZQuiCode  V11 du 15/08/2010
  // 

QUERY:C277([XUtilisateurs:2];[XUtilisateurs:2]Initiales:4=<>ZQuiCode)
$Objet:="ZVarBonjour"
$txt:=""

If (Records in selection:C76([XUtilisateurs:2])=1)
	$txt:="Bonjour, Vous êtes bien "+<>ZCR+[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2+"?"
	$txt:=$txt+<>ZCR2+"Veuillez taper votre mot de passe SVP… "
	OBJECT SET ENTERABLE:C238(*;"ZVarMdP";True:C214)
	GOTO OBJECT:C206(*;"ZVarMdP")
Else 
	<>ZQuiCode:=""
	$txt:="Désolé: aucune personne n'a ce code"
	GOTO OBJECT:C206(<>ZQuiCode)
End if 
ZObjet_Set_Info ($Objet;$txt)
