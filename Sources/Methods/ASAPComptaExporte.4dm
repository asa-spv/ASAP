//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 25/02/19, 06:56:11
  // ----------------------------------------------------
  // Méthode : ASAPComptaExporte
  // Description
  //   Exporte les factures de 4D vars EBP
  // ----------------------------------------------------

USE CHARACTER SET:C205("latin1";0)
$Doc:=Create document:C266("")
$AnEnCour:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))
If (OK=1)
	VarManque:=""
	CREATE SET:C116([Ventes:16];"exportcompta")
	QUERY SELECTION:C341([Ventes:16];[Ventes:16]NumFacture:2="")
	ASAPComptaExporteVersEBPSansFac ($Doc)
	USE SET:C118("exportcompta")
	QUERY SELECTION:C341([Ventes:16];[Ventes:16]NumFacture:2#"")
	ASAPComptaExporteVersEBPAvecFac ($Doc)
	
	CLOSE DOCUMENT:C267($Doc)
	If (VarManque#"")
		SET TEXT TO PASTEBOARD:C523(VarManque)
	End if 
End if 
ALERT:C41("Export achevé")
USE CHARACTER SET:C205(*;0)