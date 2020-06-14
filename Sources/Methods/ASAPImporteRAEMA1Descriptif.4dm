//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 07:02:56
  // ----------------------------------------------------
  // Méthode : ASAPImporteRAEMA1Descriptif
  // Description
  //  Première importation des [RAEMA] à réaliser
  // récupère la chaine, structurée par des &, qui est de type Raema n°48&15/04/08\t436\tOuiOui&Faux&20/03/2009&03/03/2009&2&&\r
  // où Raema n°48 = n° de la campagne.   
  //  la chaine suivante [XDonnées]XAlphacomprend 
  //   15/04/08 (Date de mise en ligne des rapports) \t 436 (le nombre de participants) \t Oui (accrétité) Oui  (Présence d'un modèle de rapport individuel)
  //  Faux = [XDonnées]XBool sans signification
  //  20/03/2009 = date limite de réponse
  //  03/03/2009 = date d'envoi des échantillons
  //  Le tableau des contaminations
  //  Les n° d'échantillons distribués
  // Récupère ensuite [XDonnées]XBlob contenant les tableaux de traduction
  //  dispatche le tout dans la nouvelle structure [RAEMACampagnes]
  // ----------------------------------------------------

C_TEXT:C284($Var)
C_LONGINT:C283($Pos;$Pos2)
C_BLOB:C604($Blob)
READ WRITE:C146([RAEMACampagnes:20])

SET CHANNEL:C77(13;"")
If (OK=1)
	RECEIVE VARIABLE:C81($Var)  // encore
	While ($Var="Encore")
		RECEIVE VARIABLE:C81($Var)
		If (Length:C16($Var)>5)
			$Pos:=Position:C15("&";$Var)
			$Nom:=Substring:C12($Var;1;($Pos-1))
			$NumRaema:=Substring:C12($Nom;9)
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15("&";$Var)
			$Alpha:=Substring:C12($Var;1;($Pos-1))  // Date de mise en ligne+<>ZTab+Nb labo+<>ZTab+ accrédité=oui ou non 1 ou 0+<>ZTab+ RI=oui ou non 1 ou 0
			$AlphaOriginel:=$Alpha
			$Pos2:=Position:C15(<>ZTab;$Alpha)
			$DateMiseEnLigne:=Date:C102(Substring:C12($Alpha;1;($Pos2-1)))
			$Alpha:=Substring:C12($Alpha;($Pos2+1))
			$Pos2:=Position:C15(<>ZTab;$Alpha)
			$NbLabos:=Num:C11(Substring:C12($Alpha;1;($Pos2-1)))
			$Alpha:=Substring:C12($Alpha;($Pos2+1))
			If (Length:C16($Alpha)>3)
				$Accrédité:=String:C10($Alpha[[1]]="o")
				$RI:=String:C10($Alpha[[4]]="o")
			Else 
				$Accrédité:=String:C10($Alpha[[1]]="1")
				$RI:=String:C10($Alpha[[2]]="1")
			End if 
			
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15("&";$Var)
			$Envoi:=Substring:C12($Var;1;($Pos-1))
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15("&";$Var)
			$DateLimite:=Date:C102(Substring:C12($Var;1;($Pos-1)))
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15("&";$Var)
			$DateDebut:=Date:C102(Substring:C12($Var;1;($Pos-1)))
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15("&";$Var)
			$Rang:=Num:C11(Substring:C12($Var;1;($Pos-1)))
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15("&";$Var)
			$Contamination:=Substring:C12($Var;1;($Pos-1))
			$Contamination:=Replace string:C233($Contamination;"§";<>ZCR)
			$Var:=Substring:C12($Var;($Pos+1))
			
			$Pos:=Position:C15(<>ZCR;$Var)
			$NumEch:=Substring:C12($Var;1;($Pos-1))
			$NumEch:=Replace string:C233($NumEch;"§";<>ZCR)
			
			RECEIVE VARIABLE:C81($Blob)
			ARRAY TEXT:C222($TbF;0)
			ARRAY TEXT:C222($TbA;0)
			ZBlobVersVariable (->$Blob;->$TbF;->$TbA)
			QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumRaema)
			If (Records in selection:C76([RAEMACampagnes:20])=0)
				CREATE RECORD:C68([RAEMACampagnes:20])
				[RAEMACampagnes:20]NumCampagne:2:=$NumRaema
			End if 
			[RAEMACampagnes:20]DateEnvoiColis:3:=$DateDebut
			[RAEMACampagnes:20]DateLimiteReponse:4:=$DateLimite
			[RAEMACampagnes:20]DateMiseEnLigne:5:=$DateMiseEnLigne
			[RAEMACampagnes:20]NbParticipants:6:=$NbLabos
			
			  // Remplissage de [RAEMACampagnes]Arguments
			If ($NumRaema#"@A")
				OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Rang";$Rang)
			End if 
			If ($NumEch#"")
				OB SET:C1220([RAEMACampagnes:20]Arguments:7;"N° des échantillons";$NumEch)
			End if 
			If ($Contamination#"")
				OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Niveaux de contamination";$Contamination)
			End if 
			If ($Accrédité#"FAUX")
				OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Sous accréditation";True:C214)
			End if 
			If ($RI#"FAUX")
				OB SET:C1220([RAEMACampagnes:20]Arguments:7;"Disponibilité du rapport individuel";True:C214)
			End if 
			If (Size of array:C274($TbF)>0)
				OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbF";$TbF)
			End if 
			If (Size of array:C274($TbA)>0)
				OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbA";$TbA)
			End if 
			If ($NumRaema#"@A")  // Contrôle des dilutions
				OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"TbDilution";<>TbDilution)
			End if 
			SAVE RECORD:C53([RAEMACampagnes:20])
		End if 
		
		RECEIVE VARIABLE:C81($Var)  // encore ou fin
	End while 
	SET CHANNEL:C77(11)
	UNLOAD RECORD:C212([RAEMACampagnes:20])
	READ ONLY:C145([RAEMACampagnes:20])
	ALERT:C41("Importation des campagnes terminé")
	
End if 
