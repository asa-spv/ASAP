//%attributes = {"publishedWeb":true}
  // ZfETL   V11 du 14/08/2010
  //Fonction qui remplace un chiffre par sa valeur en toute lettre
  // $1 = chiffre à transformer 
  //{$2} = unité entière sinon euro
  //{$3}=unité décimale sinon centime
  // {$4} = arrondi 0 ,1, 2 ou 3
  // appelle la fonction ZfETL3


$0:=""
  // détermination du séparateur et des chaines entières et décimales
$dec:=1/3
$Sep:=Substring:C12(String:C10($Dec);2;1)
If (Count parameters:C259=4)
	$Arrondissement:=$4
Else 
	$Arrondissement:=2
End if 
$ChaineNb:=String:C10(Round:C94($1;$Arrondissement))
$Pos:=Position:C15($Sep;$ChaineNb)
If ($Pos=0)
	ChaineNbE:=$ChaineNb
	ChaineNbD:=""
Else 
	ChaineNbE:=Substring:C12($ChaineNb;1;$Pos-1)
	ChaineNbD:=Substring:C12($ChaineNb;$Pos+1)
	$L:=Length:C16(ChaineNbD)
	ChaineNbD:=ChaineNbD+(($Arrondissement-$L)*"0")
End if 

  // recueil des unités
If (Count parameters:C259=1)
	$Unité:="euro"
	$Fraction:="centime"
Else 
	$Unité:=$2
	If (Count parameters:C259>2)
		$Fraction:=$3
	Else 
		$Fraction:=""
	End if 
End if 

If (Length:C16(ChaineNbE)>12)
	ALERT:C41("La fonction est limitée à 999 milliards !!")
Else 
	$CAT:=(12-Length:C16(ChaineNbE))*"0"+ChaineNbE
	  // les milliards
	$SCAT:=Substring:C12($CAT;1;3)
	If ($SCAT#"000")
		$0:=ZfEtl3 ($SCAT)+" milliard"+(Num:C11($SCAT#"001")*"s")+" "
	End if 
	
	  // les millions  
	$SCAT:=Substring:C12($CAT;4;3)
	If ($SCAT#"000")
		$0:=$0+ZfEtl3 ($SCAT)+" million"+(Num:C11($SCAT#"001")*"s")+" "
	End if 
	
	  // les milliers  
	$SCAT:=Substring:C12($CAT;7;3)
	If ($SCAT#"000")
		$AjoutMille:=ZfEtl3 ($SCAT)
		If ($AjoutMille=" un")
			$0:=$0+" mille "
		Else 
			$0:=$0+$AjoutMille+" mille "
		End if 
	End if 
	
	  // les unités  
	$SCAT:=Substring:C12($CAT;10;3)
	If ($SCAT#"000")
		$0:=$0+ZfEtl3 ($SCAT)
	End if 
	If ($0#"")
		$0:=$0+" "+$Unité+(Num:C11(chaineNbE#"1")*"s")
	Else 
	End if 
	  //les décimales
	If (ChaineNbD#"")
		If ($Fraction#"")
			$0:=$0+" et"+ZfEtl3 (ChaineNbD)+" "+$Fraction+(Num:C11(chaineNbD#"1")*"s")
		Else 
			$0:=$0+" et"+ZfEtl3 (ChaineNbD)
		End if 
	End if 
End if 

If (Substring:C12($0;1;1)=" ")
	$0:=Substring:C12($0;2;Length:C16($0)-1)
End if 

