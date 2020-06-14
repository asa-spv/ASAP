//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/07/19, 05:46:49
  // ----------------------------------------------------
  // Paramètre : aucun
  // ----------------------------------------------------
  // Méthode : ASAPInitTbDiamantPays
  // Description
  // Méthode qui place dans les tableaux 
  //  <>TbNomPays, <>TbCodeIso2, <>TbCodeIso3
  //  <>TbCodeIsoNum et <>TbCodeIsoASA les codes internationaux des pays
  // Récupération des codes UPS à partir d'un fichier
ARRAY TEXT:C222(<>TbNomPays;0)
ARRAY TEXT:C222(<>TbCodeIso2;0)
ARRAY TEXT:C222(<>TbCodeIso3;0)
ARRAY LONGINT:C221(<>TbCodeIsoNum;0)
ARRAY TEXT:C222(<>TbCodeIsoASA;0)

QUERY:C277([XData:1];[XData:1]XNom:2="Code ISO 3166_1")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="Code ISO 3166_1"
	USE CHARACTER SET:C205("Macintosh";1)
	$Ref:=Open document:C264("";Mode lecture:K24:5)
	RECEIVE PACKET:C104($Ref;$Ligne;<>ZCR)
	If ($Ligne#"Pays@")
		ALERT:C41("Désolé, le fichier ne semble pas être le bon...")
	Else 
		RECEIVE PACKET:C104($Ref;$Ligne;<>ZCR)
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		While ($Ligne#"")
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$NomPays:=Substring:C12($Ligne;1;($Pos-1))
			$L:=Length:C16($NomPays)
			While ($NomPays[[$L]]=" ")
				$NomPays:=Substring:C12($NomPays;1;($L-1))
				$L:=Length:C16($NomPays)
			End while 
			
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$CodeIso2:=Substring:C12($Ligne;1;($Pos-1))
			$L:=Length:C16($CodeIso2)
			While ($CodeIso2[[$L]]=" ")
				$CodeIso2:=Substring:C12($CodeIso2;1;($L-1))
				$L:=Length:C16($CodeIso2)
			End while 
			
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$CodeIso3:=Substring:C12($Ligne;1;($Pos-1))
			$L:=Length:C16($CodeIso3)
			While ($CodeIso3[[$L]]=" ")
				$CodeIso3:=Substring:C12($CodeIso3;1;($L-1))
				$L:=Length:C16($CodeIso3)
			End while 
			$CodeIsoNum:=Num:C11(Substring:C12($Ligne;($Pos+1)))
			
			APPEND TO ARRAY:C911(<>TbNomPays;Uppercase:C13($NomPays))
			APPEND TO ARRAY:C911(<>TbCodeIso2;$CodeIso2)
			APPEND TO ARRAY:C911(<>TbCodeIso3;$CodeIso3)
			APPEND TO ARRAY:C911(<>TbCodeIsoNum;$CodeIsoNum)
			COPY ARRAY:C226(<>TbCodeIso2;<>TbCodeIsoASA)
			RECEIVE PACKET:C104($Ref;$Ligne;<>ZCR)
			$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		End while 
		CLOSE DOCUMENT:C267($Ref)
		OB SET ARRAY:C1227([XData:1]XObjet:18;"TbNomPays";<>TbNomPays)
		OB SET ARRAY:C1227([XData:1]XObjet:18;"TbCodeIso2";<>TbCodeIso2)
		OB SET ARRAY:C1227([XData:1]XObjet:18;"TbCodeIso3";<>TbCodeIso3)
		OB SET ARRAY:C1227([XData:1]XObjet:18;"TbCodeIsoNum";<>TbCodeIsoNum)
		OB SET ARRAY:C1227([XData:1]XObjet:18;"TbCodeIsoASA";<>TbCodeIsoASA)
		SAVE RECORD:C53([XData:1])
	End if 
	USE CHARACTER SET:C205(*;1)
Else 
	OB GET ARRAY:C1229([XData:1]XObjet:18;"TbNomPays";<>TbNomPays)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"TbCodeIso2";<>TbCodeIso2)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"TbCodeIso3";<>TbCodeIso3)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"TbCodeIsoNum";<>TbCodeIsoNum)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"TbCodeIsoASA";<>TbCodeIsoASA)
End if 


