//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 16:38:56
  // ----------------------------------------------------
  // Paramètres
  // $1 - Listbox name
  // $2 - Array to return values
  // $3 - "columns" , "headers", or "footers"
  // $0 - current width or height of a form
  // ----------------------------------------------------
  // http://kb.4d.com/assetid=77132

  // example
  // LB_GetNames("Listbox_Name";->$arrColumns;"Columns")
  // LB_GetNames("Listbox_Name";->$arrHeaders;"Headers")
  // LB_GetNames ("Listbox_Name";->$arrFooters;"Footers")

If (Count parameters:C259=3)
	
	C_LONGINT:C283($choice;$selectElement)
	C_POINTER:C301($2;$arrNames)
	C_TEXT:C284($3)
	C_TEXT:C284($1;$Listbox_Name)
	$Listbox_Name:=$1
	$arrNames:=$2
	ARRAY TEXT:C222($arrAllObjects;0x0000)
	LISTBOX GET OBJECTS:C1302(*;$Listbox_Name;$arrAllObjects)
	
	Case of 
			
		: ($3="footers")
			$choice:=0
			
		: ($3="headers")
			$choice:=1
			
		: ($3="columns")
			$choice:=2
			
	End case 
	
	For ($i;1;Size of array:C274($arrAllObjects))
		$selectElement:=Mod:C98($i;3)
		If ($selectElement=0)
			APPEND TO ARRAY:C911($arrNames->;$arrAllObjects{$i-$choice})
		End if 
	End for 
	
End if 
