//%attributes = {"invisible":true}
  // ----------------------------------------------------------------------
  // name: LB_HIGHLIGHT_CELL
  // description: Method will take the Column and Row position using the
  // OBJECT GET COORDINATES to determine and highlight the cell position
  // of the List Box.
  //
  // parameters:
  // $1 (TEXT) - Object name of the List Box
  // ----------------------------------------------------------------------
  // http://kb.4d.com/assetid=77135
  // EXAMPLES
  // ----------
  // case of
  //: (Form event=On Mouse Move)
  //$ObjectName:=OBJECT Get name(Object with focus)
  //LB_HIGHLIGHT_CELL ($ObjectName)
  // end case

  // ***************
  // READY TO USE
  // ***************

C_TEXT:C284($1;$Listbox_Name)
C_LONGINT:C283($x;$y;$mbutton)  // mouse X, Y, and click state
C_LONGINT:C283($i;$j;$k)
C_LONGINT:C283($left;$top;$right;$bot;$rowNum;$rowHeight;$headerHeight;$footerHeight;$hsHeight;$pos;$offset)
ARRAY TEXT:C222($arrColNames;0x0000)  // list Box Column names
ARRAY TEXT:C222($arrHeaderNames;0x0000)  // list Box
ARRAY TEXT:C222($arrFooterNames;0x0000)  // list Box  Pieds
ARRAY POINTER:C280($arrColVars;0x0000)
ARRAY POINTER:C280($arrHeaderVars;0x0000)
ARRAY POINTER:C280($arrStyles;0x0000)
ARRAY POINTER:C280($arrFooterVars;0x0000)
ARRAY BOOLEAN:C223($arrColsVisible;0x0000)

  // mouse
GET MOUSE:C468($x;$y;$mbutton)

  // list Box object
$Listbox_Name:=$1

  // extract the Column names
LISTBOX GET ARRAYS:C832(*;$Listbox_Name;$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;\
$arrColsVisible;$arrStyles;$arrFooterNames;$arrFooterVars)

  // finding the Row location
OBJECT GET COORDINATES:C663(*;$Listbox_Name;$left;$top;$right;$bot)
$rowHeight:=LISTBOX Get rows height:C836(*;$Listbox_Name;lk pixels:K53:22)
$headerHeight:=LISTBOX Get property:C917(*;$Listbox_Name;_o_lk hauteur entête:K53:5)
$footerHeight:=LISTBOX Get property:C917(*;$Listbox_Name;_o_lk hauteur pied:K53:21)
$hsHeight:=LISTBOX Get property:C917(*;$Listbox_Name;lk hauteur barre déf hor:K53:7)

If (($x>$left) & ($x<$right) & ($y>($top+$headerHeight)) & ($y<($bot-$footerHeight-$hsHeight)))
	
	$pos:=LISTBOX Get property:C917(*;$Listbox_Name;_o_lk position barre déf ver:K53:11)
	$offset:=Mod:C98($pos;$rowHeight)
	$y:=$y+$offset
	$rowNum:=Int:C8((($y-$top-$headerHeight)/$rowHeight))+Int:C8(($pos/$rowHeight))+1
	
Else 
	
	$rowNum:=-1
	
End if 

  // Searching the boundaries of the Column location and highlight the cell
For ($i;1;Size of array:C274($arrColNames))
	OBJECT GET COORDINATES:C663(*;$arrColNames{$i};$left;$top;$right;$bottom)
	
	
	If (($x>=$left) & ($x<=$right))
		
		$columnPtr:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$arrColNames{1})  // Column pointer for size
		
		  // Clear all the Rows
		For ($k;1;Size of array:C274($arrColNames))
			For ($j;1;LISTBOX Get number of rows:C915(*;$Listbox_Name))
				LISTBOX SET ROW COLOR:C1270(*;$arrColNames{$k};$j;0x00FFFFFF;lk couleur de fond:K53:25)
			End for 
		End for 
		
		  // Highlight the particular cell
		LISTBOX SET ROW COLOR:C1270(*;$arrColNames{$i};$rowNum;0x003875D7;lk couleur de fond:K53:25)
		$i:=Size of array:C274($arrColNames)+1
	End if 
End for 
