//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : IMacASA
  // Date et heure : 23/05/14, 13:29:57
  // ----------------------------------------------------
  // Méthode : LEP_Escape
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($1;$0)

If (Count parameters:C259=1)
	
	C_LONGINT:C283($platform_l;$i)
	_O_PLATFORM PROPERTIES:C365($platform_l)
	
	If ($platform_l=Windows:K25:3)
		
		$value_t:=$1
		
		  //$value_t:=Replace string($value_t;"\\";"\\\\";*)
		  //$value_t:=Replace string($value_t;"\"";"\\\"";*)
		
		If (Position:C15(" ";$value_t;*)#0)
			$value_t:="\""+$value_t+"\""
		End if 
		
		$0:=$value_t
		
	Else 
		
		$value_t:=$1
		
		$metacharacters_t:="\\!\"#$%&'()=~|<>?;*`[]"
		For ($i;1;Length:C16($metacharacters_t))
			$metacharacter_t:=Substring:C12($metacharacters_t;$i;1)
			$value_t:=Replace string:C233($value_t;$metacharacter_t;"\\"+$metacharacter_t;*)
		End for 
		
		$0:=$value_t
		
	End if 
	
End if 
