[RetoursFiches:24]DateRetour:3:=vDate
$AnDate:=Year of:C25(vDate)
If ($AnDate=Year of:C25(Current date:C33))
	[RetoursFiches:24]NumFiche:2:=Substring:C12(DerNumActuelRetour;1;3)+String:C10(Num:C11(Substring:C12(DerNumActuelRetour;4))+1;"000")
Else 
	$Test:=Substring:C12(String:C10($AnDate);3;2)+"@"
	$L:=Find in array:C230(TbNumFicheRetour;$Test)
	$DerNumAn:=TbNumFicheRetour{$L}
	[RetoursFiches:24]NumFiche:2:=Substring:C12($DerNumAn;1;3)+String:C10(Num:C11(Substring:C12($DerNumAn;4))+1;"000")
End if 
RetourAfficheCampagne 