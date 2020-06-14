$Doc:=Open document:C264("";Mode lecture:K24:5)
$Texte:=""
$Compteur:=0
Repeat 
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	$Ligne:=Replace string:C233($Ligne;Char:C90(Retour à la ligne:K15:40);"")
	If (Length:C16($Ligne)=6)
		$Texte:=$Texte+$Ligne+<>ZCR
		$Compteur:=$Compteur+1
	End if 
Until ($Ligne="revu@")
ALERT:C41(String:C10($Compteur)+" lignes")
TexteSup:=$Texte