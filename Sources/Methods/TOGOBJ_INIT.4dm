//%attributes = {"invisible":true}
  // method: TOGOBJ_INIT
  // initialze Toggle Button Object
  // $1 (Text) - Button Object Name
  // $2 (Text) - Container Object Name
  // ($3) (Picture) - Left Picture
  // ($4) (Picture) - Right Picture
  // ($5) (Picture) - Button Picture

C_OBJECT:C1216($0;$togObj)
C_TEXT:C284($1;$button;$2;$container)
C_PICTURE:C286($3;$buttonPic;$4;$lPic;$5;$rPic)
$button:=$1
$container:=$2

OB SET:C1220($togObj;"Container";$container;"Button";$button;"Dragging";False:C215;"Tracking";False:C215;"Position";0)

If (Count parameters:C259>=3)
	
	$lPic:=$3
	
	If (Count parameters:C259>=4)
		
		$rPic:=$4
		
		If (Count parameters:C259>=5)
			$buttonPic:=$5
		End if 
		
	End if 
End if 

If (Picture size:C356($lPic)#0) | (Picture size:C356($rPic)#0) | (Picture size:C356($buttonPic)#0)
	TOGOBJ_SET_IMAGES ($togObj;$lPic;$rPic;$buttonPic)
End if 

$0:=$togObj
