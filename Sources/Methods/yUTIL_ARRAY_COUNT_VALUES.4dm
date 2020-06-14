//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method: UTIL_ARRAY_COUNT_VALUES
  // Description
  //   Utility method used to get distinct values of an array along with
  //   the number of occurrences of each distinct value
  //
  // Parameters
  //   $1 (Pointer) - Pointer to a 1-dimensional text array
  //   $2 (Pointer) - Pointer to a 2-dimensional text array where the distinct values
  //                  and the count for the number of occurrences will be stored
  // ----------------------------------------------------
  // http://kb.4d.com/assetid=76777

C_POINTER:C301($1;$array_ptr)
C_POINTER:C301($2;$distinctVals_ptr)
C_LONGINT:C283($arrSize_l)
C_LONGINT:C283($i;$pos)

$array_ptr:=$1
$distinctVals_ptr:=$2
$arrSize_l:=Size of array:C274($array_ptr->)

$i:=1

While ($i<=$arrSize_l)
	  //check to see if we have already encountered this value
	$pos:=Find in array:C230($distinctVals_ptr->{1};$array_ptr->{$i})
	
	  //if the value is not already stored in the distinct values array, add it
	If ($pos=-1)
		APPEND TO ARRAY:C911($distinctVals_ptr->{1};$array_ptr->{$i})
		APPEND TO ARRAY:C911($distinctVals_ptr->{2};String:C10(1))
		
		  //if the value already exists in the distinct values array, 
		  //increase the count for the number of occurrences
	Else 
		$distinctVals_ptr->{2}{$pos}:=String:C10(Num:C11($distinctVals_ptr->{2}{$pos})+1)
	End if 
	
	$i:=$i+1
End while 