//%attributes = {}

C_LONGINT:C283($Salé;$FT)


  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/02/19, 09:37:23
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPPlaceFactureWeb
  // Description
  // Méthode qui fait les pDF et les place aux bons endroits du Web 
  // = n°de facture avec / remplacée par _ +.pdf dans le dossier de l'année concernée
ALL RECORDS:C47([Factures:15])
$TitreF:=Get window title:C450
$FT:=Records in selection:C76([Factures:15])
For ($Salé;1;$FT)
	$NomFacture:=Replace string:C233([Factures:15]NumFacture:3;"/";"_")+".pdf"
	$L:=Find in array:C230(<>TbPerUUID;[Factures:15]UUIDPersonne:2)
	If ($L>0)
		$NumAdhA:=String:C10(<>TbPerNumPersonne{$L})
		$An:="Année "+String:C10(Year of:C25([Factures:15]DateFacture:4))
		$CDDos:=<>PermCheDosFac+$NumAdhA+Séparateur dossier:K24:12
		If (Test path name:C476($CDDos)#Est un dossier:K24:2)
			CREATE FOLDER:C475($CDDos)
		End if 
		$CDFac:=$CDDos+$NomFacture
		If (Test path name:C476($CDFac)=Est un document:K24:1)
			DELETE DOCUMENT:C159($CDFac)
		End if 
		SET WINDOW TITLE:C213($NomFacture)
		ZPDFImprimer ($NomFacture;$CDDos;"ASAPImprimeFacture")
	Else 
		TRACE:C157
	End if 
	NEXT RECORD:C51([Factures:15])
End for 
SET WINDOW TITLE:C213($TitreF)