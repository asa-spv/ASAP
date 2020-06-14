//%attributes = {"invisible":true}
  // method: UTIL_PIC_TO_B64_TEXT
  // return base64 text of given picture
  // $1 (Picture) - Picture
  // $0 (Text) - Base64 text

C_PICTURE:C286($1;$pic)
C_TEXT:C284($0;$encodedText)
C_BLOB:C604($picBlob)
C_LONGINT:C283($picSize)
$pic:=$1

$picSize:=Picture size:C356($pic)
$codec:=".png"

If ($picSize>0)
	
	PICTURE TO BLOB:C692($pic;$picBlob;$codec)
	BASE64 ENCODE:C895($picBlob;$encodedText)
	$0:=$encodedText
	
End if 
