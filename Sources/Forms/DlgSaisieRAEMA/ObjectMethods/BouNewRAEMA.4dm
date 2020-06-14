$Compteur:=1
$Gel:=(TbNR{TbNR}="@A")
Repeat 
	$ProchRaema:=String:C10(Num:C11(TbNR{TbNR})+$Compteur)+(Num:C11($Gel)*"A")
	$Compteur:=$Compteur+1
	$L:=Find in array:C230(TbNR;$ProchRaema)
Until ($L<0)  // le premier n° de RAEMA de même type et non existant

$Dem:=Request:C163("Quel n° donner à cette campagne?";$ProchRaema)
If (OK=1) & ($Dem#"")
	If (Find in array:C230(TbNR;$Dem)>0)
		ALERT:C41("Le numéro de campagne "+$Dem+" existe déjà...")
	Else 
		CREATE RECORD:C68([RAEMACampagnes:20])
		[RAEMACampagnes:20]NumCampagne:2:=$Dem
		[RAEMACampagnes:20]DateEnvoiColis:3:=!00-00-00!
		[RAEMACampagnes:20]DateLimiteReponse:4:=!00-00-00!
		[RAEMACampagnes:20]DateMiseEnLigne:5:=!00-00-00!
		[RAEMACampagnes:20]NbParticipants:6:=0
		OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Sous accréditation";True:C214)
		SAVE RECORD:C53([RAEMACampagnes:20])
		INSERT IN ARRAY:C227(TbNR;1)
		TbNR{1}:=$Dem
		INSERT IN ARRAY:C227(TbUUIDCampagne;1)
		TbUUIDCampagne{1}:=[RAEMACampagnes:20]UUID:1
		
		  //RaemaSchemaAffichePUMTbNR 
		TbNR:=Find in array:C230(TbNR;$Dem)
		RaemaSchemaPUMCampagne 
	End if 
Else 
	ALERT:C41("Très bien, on annule tout...")
End if 
