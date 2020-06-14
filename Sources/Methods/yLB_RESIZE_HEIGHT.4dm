//%attributes = {"invisible":true}
  // XXXX - Need to be evaluate
  // ---------------------------------------------------------------------------
  // name: RESIZE_LISTBOX_HEIGHT
  // description: Method will shrink the number of rows to be visible in a
  // listBox or to a specified number.
  //
  // input:
  // $1 (TEXT) - List Box name
  // $2 (LONGINT) - Number of rows to show (optional)
  // http://kb.4d.com/assetid=77442
  // ---------------------------------------------------------------------------

C_TEXT:C284($1;$listBox)
C_LONGINT:C283($2;$showRows)
C_LONGINT:C283($left;$top;$right;$bottom;$rows;$rowPixels;$headerPixels)

If (Count parameters:C259>0)
	
	$listBox:=$1
	
	OBJECT GET COORDINATES:C663(*;$listBox;$left;$top;$right;$bottom)
	
	$rows:=LISTBOX Get number of rows:C915(*;$listBox)
	$rowPixels:=LISTBOX Get rows height:C836(*;$listBox;lk pixels:K53:22)
	$headerPixels:=LISTBOX Get headers height:C1144(*;$listBox;lk pixels:K53:22)
	
	If (Count parameters:C259=1)
		$bottom:=($rows*$rowPixels)+$headerPixels
	Else 
		$showRows:=$2
		$bottom:=($showRows*$rowPixels)+$headerPixels+$top
	End if 
	
	OBJECT SET COORDINATES:C1248(*;$listBox;$left;$top;$right;$bottom)
	
End if 
