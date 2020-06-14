//%attributes = {}
  // Méthode : LEP_Escape_path
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($1;$0)

If (Count parameters:C259=1)
	
	C_LONGINT:C283($platform_l)
	_O_PLATFORM PROPERTIES:C365($platform_l)
	
	$path_t:=$1
	
	If ($platform_l=Mac OS:K25:2)
		
		$path_t:=Replace string:C233($path_t;"/";Char:C90(1);*)
		$path_t:=Replace string:C233($path_t;":";"/";*)
		$path_t:=Replace string:C233($path_t;Char:C90(1);":";*)
		
		$system_folder_t:=System folder:C487(Système:K41:1)  //take care of the /Volumes/ syntax
		$boot_volume_t:=Substring:C12($system_folder_t;1;Position:C15(":";$system_folder_t;*)-1)
		$target_volume_t:=Substring:C12($path_t;1;Position:C15("/";$path_t;*)-1)
		
		If ($boot_volume_t=$target_volume_t)
			$path_t:=Substring:C12($path_t;Position:C15("/";$path_t;*))
		Else 
			$path_t:="/Volumes/"+$path_t
		End if 
		
	End if 
	
	$0:=yLEP_Escape ($path_t)
	
End if 
