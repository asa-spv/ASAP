//%attributes = {"invisible":true}
  //Ptr_isArray (varPtr) -> bool
  //returns true if $1 points a one dim array
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_LONGINT:C283($lType)
  //_
$0:=False:C215
If (Count parameters:C259<1)
	  //manage error
Else 
	If (Is a variable:C294($1))
		$lType:=Type:C295($1->)
		$0:=(($lType>13) & ($lType<23))  // tableaux une dim
	End if 
End if 