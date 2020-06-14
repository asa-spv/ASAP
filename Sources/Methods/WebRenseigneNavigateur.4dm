//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/07/18, 07:08:26
  // ----------------------------------------------------
  // Paramètre : {$1}= contexte du login
  // ----------------------------------------------------
  // Méthode : WebRenseigneNavigateur
  // Description
  // Note l'en-tête de l'URL du visiteur
  // NavigateurLabo = $2 dans la méthode de base Sur connexion Web

C_TEXT:C284($0;$1;$Contexte;$MdP;$NavigateurLabo)
C_LONGINT:C283($Pos)
If (Count parameters:C259=1)
	$Contexte:=$1
Else 
	$Contexte:=""
End if 

$RensSysNav:=""
$DateHeure:="Le "+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)
$NavigateurLabo:=NavigateurLabo
$Pos:=Position:C15("User-Agent";$NavigateurLabo)
If ($Pos>0)
	$NavigateurLabo:=Substring:C12($NavigateurLabo;$Pos)
	$Pos:=Position:C15(<>ZCR;$NavigateurLabo)
	If ($Pos>0)
		$NavigateurLabo:=Substring:C12($NavigateurLabo;1;($Pos-1))
		Case of 
				
			: ($NavigateurLabo="@macintosh@")
				$Pos:=Position:C15("macintosh";$NavigateurLabo)
				$NavigateurLabo:=Substring:C12($NavigateurLabo;$Pos)
				$Pos:=Position:C15(")";$NavigateurLabo)
				$Systeme:=Substring:C12($NavigateurLabo;1;$Pos-1)
				
			: ($NavigateurLabo="@Windows@")
				$Pos:=Position:C15("Windows";$NavigateurLabo)
				$Systeme:=Substring:C12($NavigateurLabo;$Pos;11)
				
			: ($NavigateurLabo="@Ubuntu@")
				$Systeme:="Linux"
				
			Else 
				$Systeme:="Inconnu"
		End case 
		
		
		Case of 
				
			: ($NavigateurLabo="@MSIE@")
				$Pos:=Position:C15("MSIE";$NavigateurLabo)
				$Navigateur:=Substring:C12($NavigateurLabo;$Pos;7)
				
				
			: ($NavigateurLabo="@FireFox@")
				$Pos:=Position:C15("FireFox";$NavigateurLabo)
				$Navigateur:=Substring:C12($NavigateurLabo;$Pos;12)
				
			: ($NavigateurLabo="@Chrome@")
				$Pos:=Position:C15("Chrome";$NavigateurLabo)
				$Navigateur:=Substring:C12($NavigateurLabo;$Pos;9)
				
			Else 
				$Navigateur:="Autre"
		End case 
		$RensSysNav:=$DateHeure+" : "+$Contexte+" sur "+$Systeme+" avec "+$Navigateur
	Else 
		$RensSysNav:=$DateHeure+" : "+$Contexte+" avec comme en-tête "+NavigateurLabo
	End if 
Else 
	$RensSysNav:=$DateHeure+" : "+$Contexte+" avec comme en-tête "+NavigateurLabo
End if 
$0:=$RensSysNav