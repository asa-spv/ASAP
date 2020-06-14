//%attributes = {}

  //----------------------------------------------------
  //Nom utilisateur : cgm
  //Date et heure : 23/9/16, 16:30:41
  //----------------------------------------------------
  //Méthode : RaemaTrouveNumCampagneParAn
  //Description
  //Transforme l'année(numérique)
  //en numéro de la première campagne RAEMA ou le rang si $2 présent
  //  (62=2016)
  //Paramètres :$1=année concernée sur 4 chiffres en numérique   {$2}=rang du Raema
  //----------------------------------------------------
C_LONGINT:C283($1)
  // $AnA:=Chaine($1)
$AnN:=$1
$CalculAn:=2*($AnN-1986+1)
If (Count parameters:C259=1)
	$0:=String:C10($CalculAn)
Else 
	$Rang:=$2
	Case of 
		: ($Rang=1)
			$0:=String:C10($CalculAn)
			
		: ($Rang=2)
			$0:=String:C10($CalculAn)+"A"
			
		: ($Rang=3)
			$0:=String:C10($CalculAn+1)
			
		: ($Rang=4)
			$0:=String:C10($CalculAn+1)+"A"
			
	End case 
	
End if 