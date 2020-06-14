
C_LONGINT:C283($Salé;$FT)
$FT:=Size of array:C274(ListBoxListes)
ARRAY LONGINT:C221($TbPeloton;0)
READ WRITE:C146([XData:1])
For ($Salé;1;$FT)
	$Rang:=$FT-$Salé+1
	If (ListBoxListes{$Rang})
		GOTO RECORD:C242([XData:1];TbNumEnrListe{$Rang})
		DELETE RECORD:C58([XData:1])
	End if 
End for 
QUERY:C277([XData:1];[XData:1]XNom:2=ZNomListeXData;*)
QUERY:C277([XData:1]; & [XData:1]XAlpha:8#"Liste par défaut";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="LB"+ZNomTable)
SELECTION TO ARRAY:C260([XData:1]XDate:4;TbDateListe\
;[XData:1]XEntier:6;TbNbListe\
;[XData:1]XAlpha:8;TbNomListe)
LONGINT ARRAY FROM SELECTION:C647([XData:1];TbNumEnrListe)
LISTBOX SELECT ROW:C912(*;"ListBoxListes";0;lk supprimer de sélection:K53:3)

ZAmnistiePartielle (->[XData:1])
