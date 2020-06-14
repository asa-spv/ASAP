C_LONGINT:C283($Verrou)

$Verrou:=ZObjet_Get_Num ("verrou")
If ($Verrou=0)  // Le verrou est bloqué, il faut le débloquer
	$Verrou:=1
Else   // Le verrou est débloqué, il faut le bloquer
	$Verrou:=0
End if 

ZObjet_Set_Num ("verrou";$Verrou)
OBJECT SET ENTERABLE:C238(*;"CheminCloud";($verrou=1))