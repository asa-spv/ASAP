//%attributes = {"invisible":true}
  // method: TOGOBJ_SET_IMAGES
  // set left, right, button image properties into toggle object.
  // $1 (Object) - Toggle object
  // $2 (Picture) - Left picture
  // ($3) (Picture) - Right picture
  // ($4) (Picture) - Button picture

C_OBJECT:C1216($togObj)
C_TEXT:C284($bEnc;$lEnc;$rEnc;$button)
C_PICTURE:C286($2;$lPic;$3;$rPic;$4;$buttonPic)
C_POINTER:C301($buttonPtr)
$togObj:=$1

If (Count parameters:C259>=2)
	
	$lPic:=$2
	$lEnc:=ZConvertImageEnTexteB64 ($lPic)
	TOGCTN_SET_IMAGE ($togObj;$lPic)  // set container background based off button position
	
	If (Count parameters:C259>=3)
		
		$rPic:=$3
		$rEnc:=ZConvertImageEnTexteB64 ($rPic)
		
		If (Count parameters:C259>=4)
			
			$buttonPic:=$4
			
			TOGOBJ_GET_VAL ($togObj;"Button";->$button)
			$buttonPtr:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$button)
			$buttonPtr->:=$buttonPic
			$bEnc:=ZConvertImageEnTexteB64 ($buttonPic)
			
		End if 
	End if 
End if 

OB SET:C1220($togObj;"Button Picture";$bEnc;"Left Picture";$lEnc;"Right Picture";$rEnc)
