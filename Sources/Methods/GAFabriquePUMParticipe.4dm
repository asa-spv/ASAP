//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 25/08/18, 05:16:34
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : GAFabriquePUMParticipe
  // Description
  // 

C_LONGINT:C283($Salé;$FT)
$FT:=Size of array:C274(<>PUMAnRaemaPoudre)*4
ARRAY TEXT:C222(PUMRaemaParticipe;$FT)
$AnCourantN:=Num:C11(<>PUMAnRaemaPoudre{1})  // L'année la plus récente
$Rang:=0
For ($Salé;1;$FT)
	If ($Salé%4=0)
		PUMRaemaParticipe{$Salé}:=RaemaTrouveNumCampagneParAn ($AnCourantN;4)
		$Rang:=0
		$AnCourantN:=$AnCourantN-1
	Else 
		$Rang:=$Rang+1
		PUMRaemaParticipe{$Salé}:=RaemaTrouveNumCampagneParAn ($AnCourantN;$Rang)
	End if 
End for 
SORT ARRAY:C229(PUMRaemaParticipe;<)

