$evt:=Form event code:C388

Case of 
	: ($evt=Sur double clic:K2:5)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxVentes";$C;$L)
		READ WRITE:C146([Factures:15])
		QUERY:C277([Factures:15];[Factures:15]NumFacture:3=TbNumFacture{$L})
		FORM SET INPUT:C55([Factures:15];"Entrée")
		MODIFY RECORD:C57([Factures:15];*)
		If (OK=1)
			QUERY:C277([Factures:15];[Factures:15]UUIDPersonne:2=[Personnes:12]UUID:1)
			RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)
			SELECTION TO ARRAY:C260([Ventes:16]NumFacture:2;TbNumFacture;[Ventes:16]DateVente:4;TbDateF;[Ventes:16]Intitule:3;TbIntituleF;[Ventes:16]PrixTotalHT:7;TbPrixF)
			LONGINT ARRAY FROM SELECTION:C647([Ventes:16];TbNumEnrF)
			
			$FT:=Size of array:C274(TbNumFacture)
			ARRAY TEXT:C222(TbPayeF;$FT)
			SORT ARRAY:C229(TbNumFacture;TbDateF;TbIntituleF;TbPrixF;TbNumEnrF;TbPayeF;<)
			
			ARRAY LONGINT:C221(TbCouleursF;$FT)
			ARRAY LONGINT:C221(TbCouleursRegle;$FT)
			$GrisClair:=0x00D0CECE  // Gris clair
			$BleuClair:=0x00E0EBF6  // Bleu clair
			$BleuFoncé:=0x00A4C2E4  //  Bleu foncé
			$OrangeSombre:=0x00FF8000  // Orange sombre
			$Vert:=0xFF00  // Vert franc
			For ($Salé;1;$FT)
				If ($Salé=1)
					TbCouleursF{$Salé}:=$BleuFoncé
				Else 
					If (TbNumFacture{$Salé}=TbNumFacture{$Salé-1})  // même facture
						TbCouleursF{$Salé}:=TbCouleursF{$Salé-1}  // même couleur
					Else 
						If (TbCouleursF{$Salé-1}=$BleuClair)
							TbCouleursF{$Salé}:=$BleuFoncé  //  couleur alterne
						Else 
							TbCouleursF{$Salé}:=$BleuClair  //  couleur alterne
						End if 
					End if 
				End if 
				
				Case of 
					: (TbNumFacture{$Salé}="@A") | (TbNumFacture{$Salé}="@D")
						TbPayeF{$Salé}:="NC"
						TbCouleursRegle{$Salé}:=$GrisClair
						
					: (TbDateF{$Salé}=!00-00-00!)
						TbPayeF{$Salé}:="NON"
						TbCouleursRegle{$Salé}:=$OrangeSombre
						
					Else 
						TbPayeF{$Salé}:="OUI"
						TbCouleursRegle{$Salé}:=$Vert
				End case 
			End for 
		End if 
		ZAmnistiePartielle (->[Factures:15])
End case 