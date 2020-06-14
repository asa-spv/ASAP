//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : Yf_Get_OffSetsWindow
  // Created 22/04/98 by Vincent de Lachaux for 4DPOP
  // ----------------------------------------------------
  // Description
  // Retourne l'offset pour chaque type de fenêtre
  // ----------------------------------------------------

C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($Boo_Windows)
C_LONGINT:C283($Lon_dH;$Lon_dV;$Lon_Type)

$Boo_Windows:=<>ZPC

$Lon_Type:=Window kind:C445

If (Count parameters:C259>=1)
	$Lon_Type:=$1
	If (Count parameters:C259>=2)
		$Boo_Windows:=$2
	End if 
End if 

$Lon_Type:=Abs:C99($1)  // Valeure absolue du type de fenêtre , offsets identiques pour les palettes

If ($Boo_Windows)  //Window
	Case of 
		: ($Lon_Type=Fenêtre standard sans zoom:K34:1) | ($Lon_Type=Fenêtre standard:K34:13)
			$Lon_dH:=6
			$Lon_dV:=28
		: ($Lon_Type=Fenêtre standard de taille fixe:K34:6) | ($Lon_Type=Fenêtre à coins arrondis:K34:8) | ($Lon_Type=Dialogue modal déplaçable:K34:7)
			$Lon_dH:=6
			$Lon_dV:=27
		: ($Lon_Type=Dialogue modal:K34:2)
			$Lon_dH:=6
			$Lon_dV:=9
		: ($Lon_Type=Dialogue simple:K34:4) | ($Lon_Type=Dialogue ombré:K34:5)
			$Lon_dH:=4
			$Lon_dV:=6
		Else   // Palette flottante
			$Lon_dH:=3
			$Lon_dV:=20
	End case 
Else   // Macintosh
	Case of 
		: ($Lon_Type=Fenêtre standard sans zoom:K34:1) | ($Lon_Type=Fenêtre standard de taille fixe:K34:6) | ($Lon_Type=Fenêtre standard:K34:13) | ($Lon_Type=Fenêtre à coins arrondis:K34:8)
			$Lon_dH:=3
			$Lon_dV:=21
		: ($Lon_Type=Dialogue modal:K34:2)
			$Lon_dH:=10
			$Lon_dV:=10
		: ($Lon_Type=Dialogue simple:K34:4) | ($Lon_Type=Dialogue ombré:K34:5)
			$Lon_dH:=3
			$Lon_dV:=4
		: ($Lon_Type=Dialogue modal déplaçable:K34:7)
			$Lon_dH:=8
			$Lon_dV:=25
		Else   // Palette flottante
			$Lon_dH:=3
			$Lon_dV:=13
	End case 
End if 

$0:=($Lon_dH << 16)+$Lon_dV

