//%attributes = {}
C_LONGINT:C283($percent;$1)
$percent:=$1
Progress SET TITLE (progressID;"Compression en cours....")
Progress SET PROGRESS (progressID;Num:C11($percent/100);String:C10($percent)+" %")
