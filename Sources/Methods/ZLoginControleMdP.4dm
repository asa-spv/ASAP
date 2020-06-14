//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 10/04/18, 06:09:25
  // ----------------------------------------------------
  // Méthode : ZLoginControleMdP
  // Description
  // Historique : V11 du 10/08/2010
  // Script de BouOk de [Param];"DlgMdP"
  // Contrôle du mot de passe
  // ----------------------------------------------------


$OnPasse:=True:C214  // Optimiste, va !

If ([XUtilisateurs:2]Passoire:5="") & (Records in selection:C76([XUtilisateurs:2])=1)
	<>ZQuiVaLà:=[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2
	<>ZQuiMdP:=[XUtilisateurs:2]Passoire:5
	<>ZQuiCodeUUID:=[XUtilisateurs:2]UUID:1
	<>ZQuiCode:=[XUtilisateurs:2]Initiales:4
	
Else 
	$vZVarMdP:=ZObjet_Get_Info ("ZVarMdP")
	If ($vZVarMdP#"")  //la touche return a été actionnée
		If ([XUtilisateurs:2]Passoire:5#$vZVarMdP)
			$OnPasse:=False:C215
		Else 
			<>ZQuiVaLà:=[XUtilisateurs:2]Prenom:3+" "+[XUtilisateurs:2]Nom:2
			<>ZQuiMdP:=[XUtilisateurs:2]Passoire:5
			<>ZQuiCodeUUID:=[XUtilisateurs:2]UUID:1
			<>ZQuiCode:=[XUtilisateurs:2]Initiales:4
			$DateAnniversaire:=Date:C102(Substring:C12([XUtilisateurs:2]Anniversaire:6;1;2)+"/"\
				+Substring:C12([XUtilisateurs:2]Anniversaire:6;3;2)+"/"+String:C10(Year of:C25(Current date:C33)))
			If (Current date:C33=$DateAnniversaire)
				ALERT:C41("Bon anniversaire, "+<>ZQuiVaLà)
			End if 
		End if 
	Else 
		OBJECT SET ENTERABLE:C238(*;"ZVarMdP";True:C214)
		GOTO OBJECT:C206(*;"ZVarMdP")
		$OnPasse:=False:C215
	End if 
End if 
CANCEL:C270
$0:=$OnPasse
