//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/01/19, 07:19:31
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsGereContexte
  // Description
  // Méthode qui affecte [CourrielsTypes]ContexteLettre et affiche les expressions
  // le contexte de la lettre est
  // 11 si Adhérent sans facturation , 12 si Adhérent avec facturation
  // 21 si RAEMA sans facturation , 22 si RAEMA avec facturation
  // 31 si les deux sans facturation , 32 si les deux avec facturation

C_LONGINT:C283($Salé;$FT)

[CourrielsTypes:28]ContexteLettre:4:=(Num:C11(RadAdh=1)*11)+(Num:C11(RadRaema=1)*21)+(Num:C11(RadDeux=1)*31)+(Num:C11(RadFac=1))

COPY ARRAY:C226(TbValeursCourrielChamp;$TbValeursCourrielChamp)
COPY ARRAY:C226(TbContexteCourriel;$TbContexteCourriel)
COPY ARRAY:C226(TbTableCourriel;$TbTableCourriel)
COPY ARRAY:C226(TbExpressionsCourriel;$TbExpressionsCourriel)
COPY ARRAY:C226(TbValeursCourrielChamp;TbValeurs)
COPY ARRAY:C226(TbExpressionsCourriel;TbExpressionsCourriel)
$Ft:=Size of array:C274(TbTableCourriel)
For ($Salé;1;$FT)
	$Rang:=$FT-$Salé+1
	$Contexte:=TbContexteCourriel{$Rang}
	$Table:=TbTableCourriel{$Rang}
	$PasFac:=(RadFac=0) & ($Table="Factures")
	$PasAdh:=(RadRaema=1) & ($Contexte="Adhérent")
	$PasRaema:=(RadAdh=1) & ($Contexte="RAEMA")
	If ($PasFac | $PasAdh | $PasRaema)
		DELETE FROM ARRAY:C228(TbValeurs;$Rang)
		DELETE FROM ARRAY:C228(TbExpressionsCourriel;$Rang)
	End if 
End for 