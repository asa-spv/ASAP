C_LONGINT:C283($Salé;$FT)
ZVerrouAttendre (->[RAEMACampagnes:20])
For ($Salé;1;$FT)
	$Rang:=$FT-$Salé+1
	If (TbDilution{$Rang}="")
		DELETE FROM ARRAY:C228(TbDilution;$Rang)
	End if 
End for 

OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbDilution";TbDilution)
SAVE RECORD:C53([RAEMACampagnes:20])
ZAmnistiePartielle (->[RAEMACampagnes:20])
COPY ARRAY:C226(TbDilution;<>TbDilution)
CLOSE WINDOW:C154
CANCEL:C270