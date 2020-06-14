//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/09/16, 08:09:09
  // ----------------------------------------------------
  // Méthode : WebMajDatesAsaContact
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="Aco")
SELECTION TO ARRAY:C260([XData:1]XNom:2;$TbNom;[XData:1]XEntier:6;$TbNb)
LONGINT ARRAY FROM SELECTION:C647([XData:1];$TbNumEnr)
$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	Repeat 
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$NumA:=Substring:C12($Ligne;1;($Pos-1))
		$Date:=Date:C102(Substring:C12($Ligne;($Pos+1)))
		$Test:="WebAsaContact"+$NumA
		$L:=Find in array:C230($TbNom;$Test)
		If ($L=-1)
			CREATE RECORD:C68([XData:1])
			[XData:1]XType:3:="ACo"
			[XData:1]XNom:2:=$Test
		Else 
			GOTO RECORD:C242([XData:1];$TbNumEnr{$L})
		End if 
		[XData:1]XDate:4:=$Date
		SAVE RECORD:C53([XData:1])
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	Until ($Ligne="")
	QUERY:C277([XData:1];[XData:1]XType:3="Aco";*)
	QUERY:C277([XData:1]; & [XData:1]XDate:4=!00-00-00!)
	DELETE SELECTION:C66([XData:1])
End if 