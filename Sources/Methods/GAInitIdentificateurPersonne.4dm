//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/06/18, 19:21:21
  // ----------------------------------------------------
  // Méthode : GAInitIdentificateurPersonne  (CréationCodeSaisieInternet)
  // Description
  // fonction qui renvoit une chaine de caractere (mot de passe)
  // identifiant la personne loguee sur le site internet 
  // par son n° d'adhérent et par son code RAEMA
  // ----------------------------------------------------


C_TEXT:C284($0;$A;$R;$CA)
C_LONGINT:C283(VarNumPersonne;VarNumLaboRAEMA)

$CA:=String:C10(VarNumPersonne)
Case of 
	: (Length:C16($CA)=1)
		$A:="H"+Char:C90(112+Num:C11($CA))+Char:C90(ZBaseNombreHasardEncadré (80;90))+Char:C90(ZBaseNombreHasardEncadré (65;72))+Char:C90(ZBaseNombreHasardEncadré (74;78))
		
	: (Length:C16($CA)=2)
		$PC:=$CA[[1]]
		$DC:=$CA[[2]]
		$A:="U"+Char:C90(112+Num:C11($PC))+Char:C90(80+Num:C11($DC))+Char:C90(ZBaseNombreHasardEncadré (80;90))+Char:C90(ZBaseNombreHasardEncadré (65;72))
		
	: (Length:C16($CA)=3)
		$PC:=$CA[[1]]
		$DC:=$CA[[2]]
		$TC:=$CA[[3]]
		$A:="F"+Char:C90(112+Num:C11($PC))+Char:C90(80+Num:C11($DC))+Char:C90(80+Num:C11($TC))+Char:C90(ZBaseNombreHasardEncadré (80;90))
		
		
	: (Length:C16($CA)=4)
		$PC:=$CA[[1]]
		$DC:=$CA[[2]]
		$TC:=$CA[[3]]
		$QC:=$CA[[4]]
		$A:="G"+Char:C90(112+Num:C11($PC))+Char:C90(80+Num:C11($DC))+Char:C90(80+Num:C11($TC))+Char:C90(80+Num:C11($QC))
End case 


If (VarNumLaboRAEMA#0)
	$CA:=String:C10(VarNumLaboRAEMA)
	Case of 
		: (Length:C16($CA)=1)
			$A:=$A+"R"+Char:C90(112+Num:C11($CA))+Char:C90(ZBaseNombreHasardEncadré (80;90))+Char:C90(ZBaseNombreHasardEncadré (65;72))+Char:C90(ZBaseNombreHasardEncadré (74;78))
			
		: (Length:C16($CA)=2)
			$PC:=$CA[[1]]
			$DC:=$CA[[2]]
			$A:=$A+"P"+Char:C90(112+Num:C11($PC))+Char:C90(80+Num:C11($DC))+Char:C90(ZBaseNombreHasardEncadré (80;90))+Char:C90(ZBaseNombreHasardEncadré (65;72))
			
		: (Length:C16($CA)=3)
			$PC:=$CA[[1]]
			$DC:=$CA[[2]]
			$TC:=$CA[[3]]
			$A:=$A+"S"+Char:C90(112+Num:C11($PC))+Char:C90(80+Num:C11($DC))+Char:C90(80+Num:C11($TC))+Char:C90(ZBaseNombreHasardEncadré (80;90))
			
			
		: (Length:C16($CA)=4)
			$PC:=$CA[[1]]
			$DC:=$CA[[2]]
			$TC:=$CA[[3]]
			$QC:=$CA[[4]]
			$A:=$A+"Z"+Char:C90(112+Num:C11($PC))+Char:C90(80+Num:C11($DC))+Char:C90(80+Num:C11($TC))+Char:C90(80+Num:C11($QC))
			
	End case 
End if 
$0:=$A
