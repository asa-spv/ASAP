//%attributes = {"invisible":true}
  //Ptr_isTable (varPtr) -> bool
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($sNomVar)
C_LONGINT:C283($lNoTable;$lNoChamp)
  //_
$0:=False:C215
If (Count parameters:C259<1)
	  //manage error
Else 
	RESOLVE POINTER:C394($1;$sNomVar;$lNoTable;$lNoChamp)
	$0:=($sNomVar="") & ($lNoTable>0) & ($lNoChamp=0)
End if 