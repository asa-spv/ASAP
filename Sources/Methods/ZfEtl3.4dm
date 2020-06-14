//%attributes = {"publishedWeb":true}
  // ZfETL  V11 du 14/08/2010
  //Appelée par ZfETL
  // $1 = chaine de 3 chiffres
  //écrit en toute lettre une  chaine de 3 chiffres
  //Utilise les tableaux <>ZtbETL initialisé par ZInitTbDiamants


  // formatons $1
$CAT:=("0"*(3-Length:C16($1)))+$1
  // initialisons chacun ces termes
$Car1:=Substring:C12($CAT;1;1)
$Car2:=Substring:C12($CAT;2;1)
$Car3:=Substring:C12($CAT;3;1)


  //les centaines
$Pluriel:=""
If ($car1="0")
	$ETL1:=""
Else 
	If ($car1="1")
		$ETL1:="cent"
	Else 
		$ETL1:=<>ZTbETLVingt{Num:C11($Car1)}+" cent"
		$Pluriel:="s"
	End if 
End if 

  // les deux autres
$Valeur:=Num:C11($Car2+$Car3)
If ($Valeur<21)
	$ETL2:=<>ZTbETLVingt{$Valeur}
Else 
	Case of 
		: ($Valeur=71)
			$ETL2:="soixante et onze"
			
		: ($Valeur=80)
			$ETL2:="quatre-vingts"
			
		: (($Car2="7") | ($Car2="9"))
			$ETL2:=<>ZTbETLDix{Num:C11($Car2)-1}+"-"+<>ZTbETLVingt{Num:C11("1"+$Car3)}
			
		: ($Car3="1") & ($Car2#"8")
			$ETL2:=<>ZTbETLDix{Num:C11($Car2)}+" et "+<>ZTbETLVingt{Num:C11($Car3)}
			
		Else 
			$ETL2:=<>ZTbETLDix{Num:C11($Car2)}+" "+<>ZTbETLVingt{Num:C11($Car3)}
	End case 
End if 

$0:=$ETL1+($Pluriel*Num:C11($ETL2=""))+" "+$ETL2
