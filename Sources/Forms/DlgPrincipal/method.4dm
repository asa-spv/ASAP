$evt:=Form event code:C388
C_TEXT:C284($Date)

Case of 
	: ($evt=Sur chargement:K2:1)
		ZLeJourSeLève 
		$Date:=String:C10(<>ZDateDuJour;3)
		$Date:=Uppercase:C13($Date[[1]])+Substring:C12($Date;2)
		
		(OBJECT Get pointer:C1124(Objet nommé:K67:5;"VarDonneeDate"))->:=$Date+<>ZCR+<>JPlusX+", "+<>SemNum
		OBJECT SET VISIBLE:C603(*;"ZNews";<>ZNewsActifs)
		
		VarJourParticulier:=""
		ALL RECORDS:C47([XUtilisateurs:2])
		SELECTION TO ARRAY:C260([XUtilisateurs:2]Anniversaire:6;$TbAniv\
			;[XUtilisateurs:2]Prenom:3;$TbPrénom\
			;[XUtilisateurs:2]Initiales:4;$TbInitiales)
		$L:=Find in array:C230($TbPrénom;<>LeSaintDuJour)
		If ($L>0)
			If (<>ZQuiCode=$TbInitiales{$L})
				VarJourParticulier:=VarJourParticulier+"Bonne fête, "+$TbPrénom{$L}+<>ZCR2
			Else 
				VarJourParticulier:=VarJourParticulier+"N'oubliez pas de souhaiter une bonne fête à "+$TbPrénom{$L}+<>ZCR2
			End if 
		End if 
		$DateAnniv:=String:C10(Day of:C23(Current date:C33);"00")+"/"+String:C10(Month of:C24(Current date:C33);"00")
		$L:=0
		$L:=Find in array:C230($TbAniv;$DateAnniv;($L+1))
		While ($L>0)
			If (<>ZQuiCode=$TbInitiales{$L})
				VarJourParticulier:=VarJourParticulier+"Bon anniversaire, "+$TbPrénom{$L}+<>ZCR
				
			Else 
				VarJourParticulier:=VarJourParticulier+"N'oubliez pas de souhaiter un bon anniversaire à "+$TbPrénom{$L}+<>ZCR
			End if 
			$L:=Find in array:C230($TbAniv;$DateAnniv;($L+1))
		End while 
		
		If (Current user:C182="Concepteur") | (Current user:C182="Administrateur")
			
			OBJECT SET VISIBLE:C603(*;"LogActive";True:C214)
			OBJECT SET VISIBLE:C603(*;"container1";True:C214)
			OBJECT SET VISIBLE:C603(*;"button1";True:C214)
			OBJECT SET VISIBLE:C603(*;"ZBouConfiguration";True:C214)
			
		End if 
		
End case 