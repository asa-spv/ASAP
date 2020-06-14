
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		$Pt:=OBJECT Get pointer:C1124
		$Pt->:=""
		
	: ($evt=Sur après frappe clavier:K2:26)
		$TestSimple:=Get edited text:C655+"@"
		$TestEtendu:="@"+$TestSimple
		
		If (Length:C16($TestSimple)>0)
			If (Is nil pointer:C315(ZPtChampClefs))  // pas de champ qui stocke le descriptif de ZPtTable
				  // On va tester tous les champs texte
				$L:=Find in array:C230(<>TbNumChampTableBase;ZNumTable)
				QUERY:C277(ZPtTable->;<>TbPtChampBase{$L}->=$TestEtendu;*)
				Repeat 
					$L:=Find in array:C230(<>TbNumChampTableBase;ZNumTable;($L+1))
					If ($L>0)
						If (Type:C295(<>TbPtChampBase{$L}->)=Est un texte:K8:3) | (Type:C295(<>TbPtChampBase{$L}->)=Est un champ alpha:K8:1)
							QUERY:C277(ZPtTable->; | <>TbPtChampBase{$L}->=$TestEtendu;*)
						End if 
					End if 
				Until ($L=-1)
				QUERY:C277(ZPtTable->)
			Else 
				$Soundex:=ZSoundexFrance (Get edited text:C655)
				If (Length:C16($TestSimple)>0)
					QUERY:C277(ZPtTable->;ZPtChampClefs->%$TestSimple;*)
					QUERY:C277(ZPtTable->; | ZPtChampClefs->%$Soundex)
					ZFenetreActualiseTitre 
				End if 
			End if 
		End if 
End case 

