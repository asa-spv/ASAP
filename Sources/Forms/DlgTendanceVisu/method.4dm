$evt:=Form event code:C388
If ($evt=Sur chargement:K2:1)
	ARRAY TEXT:C222(TbNR;10)
	
	ARRAY TEXT:C222(Colonne9;0)
	ARRAY LONGINT:C221(Colonne10N;0)
	ARRAY LONGINT:C221(Colonne11N;0)
	ARRAY LONGINT:C221(Colonne12N;0)
	
	ALL RECORDS:C47([RAEMACampagnes:20])
	SELECTION TO ARRAY:C260([RAEMACampagnes:20]NumCampagne:2;$Tb)
	SORT ARRAY:C229($Tb;<)
	For ($salé;1;10)
		TbNR{$salé}:=$Tb{$salé}
	End for 
	TbNR:=1
	RaemaTendanceTbPLTousRAEMA 
	RaemaTendancePUM 
End if 

