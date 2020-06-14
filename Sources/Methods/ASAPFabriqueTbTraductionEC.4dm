//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/10/19, 08:36:31
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbTraductionEC
  // Description
  // Méthode qui fabrique le tableau des traductions
  //   des textes présents dans l'espace client
  //   et les mets dans [XData]XObjet de la [XData]
  //   [XData]XNom="Traduction de l'espace client"
  //   [XData]XType="TraductionEC"
  // ----------------------------------------------------
READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="TraductionEC";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Traduction de l'espace client")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="TraductionEC"
	[XData:1]XNom:2:="Traduction de l'espace client"
End if 
USE CHARACTER SET:C205("Macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"Accéder à votre espace client@")
	ALERT:C41("Désolé, le fichier n'est pas le bon...")
Else 
	$Pos:=Position:C15(":";$Ligne)
	ARRAY TEXT:C222($TbFr;0)
	ARRAY TEXT:C222($TbEn;0)
	While ($Pos>0)
		$Fr:=Replace string:C233(Substring:C12($Ligne;1;($Pos-1));Char:C90(10);"")
		$En:=Substring:C12($Ligne;($Pos+1))
		APPEND TO ARRAY:C911($TbFr;$Fr)
		APPEND TO ARRAY:C911($TbEn;$en)
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		$Pos:=Position:C15(":";$Ligne)
	End while 
End if 
OB SET ARRAY:C1227([XData:1]XObjet:18;"Ref";$TbFr)
OB SET ARRAY:C1227([XData:1]XObjet:18;"TbF";$TbFr)
OB SET ARRAY:C1227([XData:1]XObjet:18;"TbA";$TbEn)
SAVE RECORD:C53([XData:1])
CLOSE DOCUMENT:C267($Doc)
USE CHARACTER SET:C205(*;1)

ZAmnistiePartielle (->[XData:1])