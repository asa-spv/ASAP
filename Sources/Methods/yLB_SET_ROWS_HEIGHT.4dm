//%attributes = {"invisible":true}
  // XXXX - Need to be evaluate
  // method name: LB_SET_ROWS_HEIGHT
  // sets the height of the rows so they fit the listbox
  // $1 - pointer to the listbox
  // ($2) - number of rows to shown
  // http://kb.4d.com/assetid=77457

C_TEXT:C284($1;$Listbox_Name)
C_LONGINT:C283($2;$numRows)
C_LONGINT:C283($rowPixels;$newPixel)
C_LONGINT:C283($left;$top;$right;$bot;$lbHeight)
C_LONGINT:C283($headerHeight;$scrollHeight;$footerHeight)

If (Count parameters:C259>=1)
	
	$Listbox_Name:=$1
	
	If (Count parameters:C259>=2)
		$numRows:=$2
	Else 
		$numRows:=LISTBOX Get number of rows:C915($LB->)
	End if 
	
	$rowPixels:=LISTBOX Get rows height:C836(*;$Listbox_Name;lk pixels:K53:22)
	OBJECT GET COORDINATES:C663(*;$Listbox_Name;$left;$top;$right;$bot)
	$lbHeight:=$bot-$top
	
	$headerHeight:=LISTBOX Get property:C917(*;$Listbox_Name;_o_lk hauteur entête:K53:5)
	$scrollHeight:=LISTBOX Get property:C917(*;$Listbox_Name;lk hauteur barre déf hor:K53:7)
	$footerHeight:=LISTBOX Get property:C917(*;$Listbox_Name;_o_lk hauteur pied:K53:21)
	$lbHeight:=$lbHeight-$headerHeight-$scrollHeight-$footerHeight
	$newPixel:=$lbHeight/$numrows
	LISTBOX SET ROWS HEIGHT:C835(*;$Listbox_Name;$newPixel)
	
End if 
