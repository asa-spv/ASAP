//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/12/18, 10:41:41
  // ----------------------------------------------------
  // Paramètres : $1 = N° de campagne  
  // $2 = propriéte de l'argument [CampagneParticipations]Arguments 
  // $3 = Valeur prise par la propriéte
  // {$4}  = vrai si case à cocher
  // ----------------------------------------------------
  // Méthode : ASAPActualiseTbParticipation
  // Description : permet de réparer le tableau général des participations

C_TEXT:C284(NumCampagne;$1;$Propriété;$2)
C_LONGINT:C283($Valeur;$3)
$Valeur:=$3
$NumCampagne:=$1  // 
$Propriété:=$2
$Valeur:=$3
$Test:=String:C10(VarNumLabo)+"_"+$NumCampagne+"_@"
$L:=Find in array:C230(<>TbXtéArgumentParticipation;$Propriété)
$Pt:=<>TbPtTbParticipation{$L}
$L:=0
Repeat 
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test;($L+1))
	If ($L#-1)
		If (Count parameters:C259=4)
			$Pt->{$L}:=($Valeur=1)
		Else 
			$Pt->{$L}:=$Valeur
		End if 
	End if 
Until ($L<0)
