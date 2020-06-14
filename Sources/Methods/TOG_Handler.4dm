//%attributes = {"invisible":true}
  // method: Custom_Toggle_Handler
  // custom toggle handler for
  // $1 (Pointer) - Pointer to toggle Object
  // $2 (Text)    - Button Object Name
  // $3 (Text)    - Container Object Name
  // $4 (Pointer) - Pointer to field
  // $5 (Text)    - Return value Object Name
  // $6 (Text)    - Method Path of button (to set container code)

C_POINTER:C301($1;$togPtr;$4;$fieldPtr;$valuePtr)
C_TEXT:C284($2;$button;$3;$container;$5;$val;$6;$currentMethodPath)
C_OBJECT:C1216($togObj)
C_LONGINT:C283($position)
$togPtr:=$1
$button:=$2
$container:=$3
$fieldPtr:=$4
$val:=$5
$currentMethodPath:=$6

If (Not:C34(OB Is defined:C1231($togPtr->)))  // if togObj not defined, initialize
	$togPtr->:=TOGOBJ_INIT ($button;$container)
End if 

$togObj:=$togPtr->
$valuePtr:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$val)

Case of 
		
	: (Form event code:C388=Sur chargement:K2:1)
		C_PICTURE:C286($lPic;$rPic)  // container background images (left pic, right pic)
		C_PICTURE:C286($buttonPic)  // image for toggle button
		
		  // set images -- Can modify here
		$lPic:=ZBaseLireImage ("images/buttons/grayRoundBackground.png")  // container background image when button is on the left
		$rPic:=ZBaseLireImage ("images/buttons/greenRoundBackground.png")  // container background image when button is on the right
		$buttonPic:=ZBaseLireImage ("images/buttons/roundButton.png")  // button image
		
		TOGOBJ_SET_IMAGES ($togObj;$lPic;$rPic;$buttonPic)
		
		If (Not:C34(Is nil pointer:C315($fieldPtr)))
			
			If ($fieldPtr->)
				$position:=1
			Else 
				$position:=0
			End if 
			
		Else 
			
			$position:=0
			
		End if 
		
		TOGOBJ_SET_VAL ($togObj;"Position";->$position)
		TOGOBJ_SET_BUTTON_POSITION ($togObj;$position)
		
		  // programatically edit container code
		TOGCTN_SET_CODE ($currentMethodPath;$togPtr;$button;$container;$val;$fieldPtr)
		
	: (Form event code:C388=Sur clic:K2:4)
		TOGBTN_HANDLE_CLICK ($togObj)
		
		  //: (Form event=On Mouse Move)
		  //TOGBTN_HANDLE_MOVE ($togObj)
		
		  //  // -- V16 --
		  //: (Form event=On Mouse Up)  // On Mouse Up: the mouse button was released
		  //TOGBTN_HANDLE_MOUSE_UP ($togObj)
		
End case 
