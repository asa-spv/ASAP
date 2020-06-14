C_LONGINT:C283($L;$LT)
C_POINTER:C301($Pt)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		$Pt:=OBJECT Get pointer:C1124
		$Pt->:=""
		
	: ($evt=Sur après frappe clavier:K2:26)
		C_LONGINT:C283($Salé;1;$TT)
		$TE:=Get edited text:C655
		GET TEXT KEYWORDS:C1141($TE;$TbMots)
		$TT:=Size of array:C274($TbMots)
		For ($Salé;1;$TT)
			$ME:=$TbMots{$Salé}
			$Test:="@"+$ME+"@"
			$LT:=Length:C16(Get edited text:C655)
			$OnATrouvé:=False:C215
			$NomEnsemble:="$Res"+String:C10($Salé)
			CREATE EMPTY SET:C140([Personnes:12];$NomEnsemble)
			
			If (String:C10(Num:C11($ME))=$ME)  // on a saisi un nombre
				$L:=Find in array:C230(<>TbPerNumLaboRAEMA;Num:C11($ME))
				If ($L>0)
					GOTO RECORD:C242([Personnes:12];<>TbPerNumEnr{$L})
					$OnATrouvé:=True:C214
					ADD TO SET:C119([Personnes:12];$NomEnsemble)
				End if 
			Else 
				
				If ($LT>1)  // deux caractères tapés
					$Soundex:=ZSoundexFrance ($ME)
					QUERY:C277([Personnes:12];[Personnes:12]ChampRecherche:6=$Test;*)
					QUERY:C277([Personnes:12]; | ;[Personnes:12]ChampRecherche:6%$Soundex)
					$OnATrouvé:=(Records in selection:C76([Personnes:12])>0)
					CREATE SET:C116([Personnes:12];"$ResME")
					UNION:C120($NomEnsemble;"$ResME";$NomEnsemble)
				End if 
			End if 
			
			QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Laboratoire")
			CREATE SET:C116([Personnes:12];"$Res")
			For ($Salé;1;$TT)
				$NomEnsemble:="$Res"+String:C10($Salé)
				INTERSECTION:C121("$Res";$NomEnsemble;"$Res")
			End for 
			USE SET:C118("$Res")
		End for 
		
		ASAPPerFabriqueTb 
		ZNbEnr:=Size of array:C274(TbPerNum)
		ZFenetreActualiseTitre 
End case 

