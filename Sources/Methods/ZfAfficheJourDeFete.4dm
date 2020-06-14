//%attributes = {"publishedWeb":true}
  // ZfAfficheJourDeFete V11 le 10/08/2010
  // $1 = Variable ou champ contenant le prénom
  // renvoir la date de la fête en clair (alphanumérique)

C_LONGINT:C283($Salé;$FT;$Fumé)
$SexeSaint:=""
$Résultat:=""

$Dem:=$1

If ($Dem="")
	$0:=""
Else 
	For ($Salé;1;12)
		$MoiCon:=<>ZTbNomDuMois{$Salé}
		$Pt:=Get pointer:C304("ZTbSaints"+$MoiCon)
		$Ligne:=Find in array:C230($Pt->;"saint "+$Dem)
		If ($Ligne>0)
			$Résultat:=$Résultat+<>ZCR+String:C10($ligne)+" "+$MoiCon
		End if 
		$Ligne:=Find in array:C230($Pt->;"sainte "+$Dem)
		If ($Ligne>0)
			$Résultat:=$Résultat+<>ZCR+String:C10($ligne)+" "+$MoiCon
			$SexeSaint:="e"
		End if 
		If ($Résultat="")
			If ($Salé>3)  // cherchons dans les doubles prénoms
				$Test:="@"+$Dem+"@"
				$FT:=Size of array:C274($Pt->)
				For ($fumé;1;$FT)
					If ($Pt->{$Fumé}=$Test)
						$Résultat:=$Résultat+<>ZCR+String:C10($fumé)+" "+$MoiCon
						$SexeSaint:=Substring:C12($Pt->{$Fumé};6;1)
					End if 
				End for 
			End if 
		End if 
	End for 
	If ($Résultat="")
		$0:=""
	Else 
		$0:=Substring:C12($Résultat;2)
	End if 
	
End if 