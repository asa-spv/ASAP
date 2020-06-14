//%attributes = {"publishedWeb":true}
  // ZfNuméroDeSemaine   V11 du 14/08/2010
  // fonction qui renvoie le n° de semaine précédé du millésime
  // ----------------------------------------------------
  // Paramètres
  // $1= date pour le n° de semaine
  // {$2}= jour de départ de la semaine
  // ----------------------------------------------------

C_LONGINT:C283($AC;$JD;$Abscisse;$Délai)
$AC:=Year of:C25($1)
$Millésime:=Substring:C12(String:C10($AC);3;2)
$MilPrec:=Substring:C12(String:C10($AC-1);3;2)
$PJ:=Date:C102("01/01/"+String:C10($AC))  // la date du premier jour de l'année en cours

If (Count parameters:C259=2)
	$JD:=$2
Else 
	$JD:=1
End if 

$Abscisse:=(7-Day number:C114($PJ)+$JD)%7
$Délai:=$1-$PJ+$Abscisse

Case of 
	: ($1-$PJ<$Abscisse)
		$0:=("99/"*(Num:C11($Millésime="00")))+(($MilPrec+"/")*(Num:C11($Millésime#"00")))+"52"
		
	: ($1-$PJ=$Abscisse)
		$0:=$Millésime+"/"+String:C10(Int:C8($Délai/7)+1;"00")
		
	Else 
		$0:=$Millésime+"/"+String:C10(Int:C8($Délai+1/7);"00")
End case 
