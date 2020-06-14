//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 08/07/18, 10:20:33
  // ----------------------------------------------------
  // Méthode : ASAPImporteTexteMailDispo
  // Description
  // Importation des textes des mails 
  //  de mise à disposition des rapports qui sont mis  
  //  dans des [XData] [XData]XType="Rap"
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($Ligne)

READ WRITE:C146([XData:1])

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	If ($Ligne#"Texte des mails@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux valeurs possibles des textes des mails d'avertissement")
	Else 
		For ($Salé;1;2)
			RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Nom:=Substring:C12($Ligne;1;($Pos-1))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Texte1:=Replace string:C233(Substring:C12($Ligne;1;($Pos-1));"£";<>ZCR)
			$Texte2:=Replace string:C233(Substring:C12($Ligne;($Pos+1));"£";<>ZCR)
			QUERY:C277([XData:1];[XData:1]XType:3="Rap";*)
			QUERY:C277([XData:1]; & [XData:1]XNom:2=$Nom)
			If (Records in selection:C76([XData:1])=0)
				[XData:1]XNom:2:=$Nom
				[XData:1]XType:3:="Rap"
			End if 
			[XData:1]XTexte:9:=$Texte1
			[XData:1]XTexteSup:10:=$Texte2
			SAVE RECORD:C53([XData:1])
		End for 
		
		
	End if 
End if 
CLOSE DOCUMENT:C267($Doc)
ZAmnistieInternationale 
ALERT:C41("Import des textes achevé...")
