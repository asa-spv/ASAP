//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 07:02:56
  // ----------------------------------------------------
  // Méthode : ASAPImporte1RAEMA4ValeursSup
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


C_TEXT:C284($Var)
C_DATE:C307($Date)
C_TIME:C306($Heure)
C_LONGINT:C283($Rang;$NumLabo)
C_BLOB:C604($Blob)

READ WRITE:C146([RAEMAValeurs:23])

SET CHANNEL:C77(13;"")
If (OK=1)
	RECEIVE VARIABLE:C81($Var)  // encore
	While ($Var="Encore")
		RECEIVE VARIABLE:C81($Var)
		If (Length:C16($Var)>5)
			$Pos:=Position:C15("&";$Var)
			$UUID:=Substring:C12($Var;1;($Pos-1))  // [RAEMAValeurs]UUID
			$Var:=Substring:C12($Var;($Pos+1))
			
			
			$Pos:=Position:C15("&";$Var)
			$TipsFr:=Substring:C12($Var;1;($Pos-1))
			$TipsFr:=Replace string:C233($TipsFr;"§";<>ZCR)
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15(<>ZCR;$Var)
			$TipsEn:=Substring:C12($Var;1;($Pos-1))
			$TipsEn:=Replace string:C233($TipsEn;"§";<>ZCR)
			
			RECEIVE VARIABLE:C81($Blob)
			ARRAY TEXT:C222($TbN;0)
			ARRAY TEXT:C222($TbV;0)
			ZBlobVersVariable (->$Blob;->$TbN;->$TbV)
			$Milieu:=""
			$Fabricant:=""
			If (BLOB size:C605($Blob)>0)
				$L:=Find in array:C230($TbN;"Milieu")
				If ($L>0)
					$Milieu:=$TbV{$L}
				End if 
				$L:=Find in array:C230($TbN;"Fabricant")
				If ($L>0)
					$Fabricant:=$TbV{$L}
				End if 
			End if 
			
			QUERY BY ATTRIBUTE:C1331([RAEMAValeurs:23];[RAEMAValeurs:23]Arguments:6;"IDValeur";=;$UUID)
			If (Records in selection:C76([RAEMAValeurs:23])=1)
				If ($TipsFr#"")
					OB SET:C1220([RAEMAValeurs:23]Arguments:6;"TipsFr";$TipsFr)
				End if 
				If ($TipsEn#"")
					OB SET:C1220([RAEMAValeurs:23]Arguments:6;"TipsEn";$TipsEn)
				End if 
				If ($Milieu#"")
					OB SET:C1220([RAEMAValeurs:23]Arguments:6;"Milieu";$Milieu)
				End if 
				If ($Fabricant#"")
					OB SET:C1220([RAEMAValeurs:23]Arguments:6;"Fabricant";$Fabricant)
				End if 
				
				SAVE RECORD:C53([RAEMAValeurs:23])
			End if 
		End if 
		
		RECEIVE VARIABLE:C81($Var)  // encore ou fin
	End while 
	SET CHANNEL:C77(11)
	ZAmnistieInternationale 
End if 
