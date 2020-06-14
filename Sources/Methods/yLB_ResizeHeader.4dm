//%attributes = {"invisible":true}
  //Given a listbox and a column, this method will split a header label at spaces when the column width becomes
  //too small. It also resizes the header height to accomodate the header with the most lines. It works no matter
  //the font, size, style, or how high the header is. It will simply split on spaces when necessary and put as
  //much of the label as possible in the header area.

  //This can be called when setting up a listbox. It can also be called during On Column Resize..

  // http://forums.4d.com/Post/FR/23867797/1/23867798#23867798
  // Cannon SMITH


C_POINTER:C301($1;$pLB)  //A pointer to the listbox

$pLB:=$1

C_TEXT:C284($tLabel;$tFont)
C_LONGINT:C283($x;$y;$lWidth;$lSize;$lStyle;$lMaxLines;$lExtraWidth)
ARRAY TEXT:C222($atColNames;0)
ARRAY TEXT:C222($atHeadNames;0)
ARRAY POINTER:C280($apColVars;0)
ARRAY POINTER:C280($apHeadVars;0)
ARRAY BOOLEAN:C223($afVisible;0)
ARRAY POINTER:C280($apStyles;0)
ARRAY TEXT:C222($atLines;0)

  //Loop through every visible column in the listbox, splitting the label into lines based on the current
  //width of the column. Also, keep track of the column with the greatest number of lines.
$lMaxLines:=1
LISTBOX GET ARRAYS:C832($pLB->;$atColNames;$atHeadNames;$apColVars;$apHeadVars;$afVisible;$apStyles)
For ($x;1;Size of array:C274($atColNames))
	If ($afVisible{$x}=True:C214)
		  //If (Is a variable($apHeadVars{$x}))
		  //$lExtraWidth:=Choose($apHeadVars{$x}->>0;15;5)  //Need extra room, more if there is a sort indicator
		  //Else 
		  //$lExtraWidth:=15
		  //End if 
		$lExtraWidth:=15  // To have enough place for the sort indicator
		$lWidth:=LISTBOX Get column width:C834(*;$atColNames{$x})-$lExtraWidth
		$tLabel:=Replace string:C233(OBJECT Get title:C1068(*;$atHeadNames{$x});"\r";" ")
		$tLabel:=Choose:C955(Position:C15(" ";$tLabel)>0;$tLabel;ZTexteEnCamelCaseEspacé ($tLabel))  //add spaces to Text To Array can do its business
		$tFont:=OBJECT Get font:C1069(*;$atHeadNames{$x})
		$lSize:=OBJECT Get font size:C1070(*;$atHeadNames{$x})
		$lStyle:=OBJECT Get font style:C1071(*;$atHeadNames{$x})
		TEXT TO ARRAY:C1149($tLabel;$atLines;$lWidth;$tFont;$lSize;$lStyle)
		
		$tLabel:=""
		For ($y;1;Size of array:C274($atLines))
			$tLabel:=$tLabel+$atLines{$y}+Choose:C955($y<Size of array:C274($atLines);"\r";"")
		End for 
		OBJECT SET TITLE:C194(*;$atHeadNames{$x};$tLabel)
		
		$lMaxLines:=Choose:C955(Size of array:C274($atLines)<=$lMaxLines;$lMaxLines;Size of array:C274($atLines))
		
	End if 
End for 

  //Change the listbox header height if it needs to be different than it is
If (LISTBOX Get headers height:C1144($pLB->;lk lignes:K53:23)#$lMaxLines)
	LISTBOX SET HEADERS HEIGHT:C1143($pLB->;$lMaxLines;lk lignes:K53:23)
End if 