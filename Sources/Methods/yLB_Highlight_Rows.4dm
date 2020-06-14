//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 23/03/18, 12:13:45
  // ----------------------------------------------------
  // Méthode : LB_Highlight_Rows
  // Description
  //  http://kb.4d.com/assetid=77950
  //
  // Paramètres
  // ----------------------------------------------------

  //$1  // Text, Name of list box
  //$2  // Text, variable for search
  //$3  // Longint, color for highlight
  //$4  // Longint, color for no-highlight (row background color)
  //$5  // Boolean, True to run highlights or False to clear highlights


  // ---------- Example
  //Case of 
  //: (Form event=On After Keystroke)
  //searchValue:=Get edited text
  //If (searchValue#"")
  //lb_Highlight_Rows("ListBox";searchValue;0x00ADD8E6;0x00FFFFFF;True)
  //Else 
  //lb_Highlight_Rows("ListBox";searchValue;0x00ADD8E6;0x00FFFFFF;False)
  //End if 
  //End case 
  // --------------------

C_TEXT:C284($1;$2;$findMe_t;$listBoxName_t)
C_LONGINT:C283($3;$4;$highlightColor_l;$clearColor_l)
C_BOOLEAN:C305($5;$search_b;$found_b)
ARRAY TEXT:C222($colNames_at;0)
ARRAY TEXT:C222($headerNames_at;0)
ARRAY POINTER:C280($colVars_ap;0)
ARRAY POINTER:C280($headerVars_ap;0)
ARRAY BOOLEAN:C223($colsVisible_ab;0)
ARRAY POINTER:C280($styles_ap;0)
C_OBJECT:C1216($foundRows_o)

If (Count parameters:C259=5)
	$listBoxName_t:=$1
	$findMe_t:=Uppercase:C13($2)
	$findMe_t:=".*"+$findMe_t+".*"
	$highlightColor_l:=$3
	$clearColor_l:=$4
	$search_b:=$5
	LISTBOX GET ARRAYS:C832(*;$listBoxName_t;$colNames_at;$headerNames_at;$colVars_ap;\
		$headerVars_ap;$colsVisible_ab;$styles_ap)
	For ($j;1;Size of array:C274($colVars_ap))
		For ($i;1;Size of array:C274($colVars_ap{$j}->))
			$found_b:=Match regex:C1019($findMe_t;Uppercase:C13($colVars_ap{$j}->{$i});1)
			If (($found_b) & ($search_b))
				  // matched, highlight row
				LISTBOX SET ROW COLOR:C1270(*;$listBoxName_t;$i;$highlightColor_l;\
					lk background color)
				OB SET:C1220($foundRows_o;String:C10($i);String:C10($i))
				If ($first_l=0)
					$first_l:=$i
				End if 
			Else 
				  // not matched, or not searching, set to white (default background color)
				If (Not:C34(OB Is defined:C1231($foundRows_o;String:C10($i))))
					LISTBOX SET ROW COLOR:C1270(*;$listBoxName_t;$i;$clearColor_l;\
						lk background color)
				End if 
			End if 
		End for 
	End for 
	If ($first_l=0)
		$first_l:=1
	End if 
	  // scroll to first position found
	OBJECT SET SCROLL POSITION:C906(*;$listBoxName_t;$first_l)
End if 