//%attributes = {}
  //  YTesteValiditeCourriel
  // $1 = adresse mail
$Email:=$1
$pos:=Position:C15("@";$Email)
$0:=True:C214
If ($Pos>0)
	$Domaine:=Substring:C12($Email;($Pos+1))
	$Pos2:=Position:C15(".";$Domaine)
	If ($Pos2=0)
		$0:=False:C215
		AlerteMail:=AlerteMail+"Il n'y a pas de nom de domaine dans l'adresse "+$Email+<>ZR
	End if 
Else 
	AlerteMail:=AlerteMail+"Il n'y a d'@ dans l'adresse "+$Email
	$0:=False:C215
End if 