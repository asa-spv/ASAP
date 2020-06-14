C_LONGINT:C283($L;$LT)
C_POINTER:C301($Pt)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		$Pt:=OBJECT Get pointer:C1124
		$Pt->:=""
		
	: ($evt=Sur après frappe clavier:K2:26)
		$TE:=Get edited text:C655
		$Test:="@"+$TE+"@"
		$LT:=Length:C16(Get edited text:C655)
		$OnATrouvé:=False:C215
		CREATE EMPTY SET:C140([Personnes:12];"Res")
		If (String:C10(Num:C11($TE))=$TE)  // on a saisi un nombre
			$L:=Find in array:C230(<>TbPerNumLaboRAEMA;Num:C11($TE))
			If ($L>0)
				GOTO RECORD:C242([Personnes:12];<>TbPerNumEnr{$L})
				$OnATrouvé:=True:C214
				ADD TO SET:C119([Personnes:12];"Res")
			End if 
		End if 
		
		If ($LT>1)  // deux caractères tapés
			QUERY:C277([Personnes:12];[Personnes:12]ChampRecherche:6=$Test)
			$OnATrouvé:=(Records in selection:C76([Personnes:12])>0)
			CREATE SET:C116([Personnes:12];"Res2")
			UNION:C120("Res";"Res2";"Res")
		End if 
		If ($OnATrouvé)
			USE SET:C118("Res")
			CLEAR SET:C117("Res")
			CLEAR SET:C117("Res2")
			ASAPPerFabriqueTb 
			ZNbEnr:=Size of array:C274(TbPerNum)
			ZFenetreActualiseTitre 
		End if 
End case 

