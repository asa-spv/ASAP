//%attributes = {"invisible":true}

Begin SQL
	/*
	Name: REGEX_RemoveWhiteSpace
	Path: REGEX_RemoveWhiteSpace
	
	Purpose: Remove all leading and trailing white space
	
	$0 - TEXT - Outout text
	$1 - TEXT - Input text
	*/
End SQL

C_TEXT:C284($MethodName_T)
$MethodName_T:=Current method name:C684
  //===================== Declare Variables ==================================
  //method_parameters_declarations
C_TEXT:C284($myString;$1)
C_TEXT:C284($0;$resultString)
  //--------------------------------------------------------------------------
  //method_wide_constants_declarations
  //--------------------------------------------------------------------------
  //local_variable_declarations
C_LONGINT:C283($Params_L)
C_TEXT:C284($pattern)
C_LONGINT:C283($start;$position;$length)
C_BOOLEAN:C305($foundFlag)

  //====================== Initialize and Setup ================================

$Params_L:=Count parameters:C259
$myString:=$1

  //======================== Method Actions ==================================

$start:=1
$foundFlag:=False:C215

  //regex pattern for leading white spaces
  //^ -- search the beginging of the string
  //\s+ -- search for one or more white spaces
$pattern:="^\\s+"

If (Match regex:C1019($pattern;$myString;$start;$position;$length))
	$resultString:=Substring:C12($myString;$length+1)
Else 
	$resultString:=$myString
End if 

  //regex pattern for trailing white spaces
  //$ -- search the end of the string
$pattern:="\\s+$"

If (Match regex:C1019($pattern;$resultString;$start;$position;$length))
	$resultString:=Substring:C12($resultString;$start;$position-1)
End if 

  //======================== Clean up and Exit =================================

$0:=$resultString