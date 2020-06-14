//%attributes = {}
  // Méthode : ZPDFRestoreRegistre V11 du10/08/2010
  // Description
  // Permet de Restaurer le Registre pour l'impression en PDF
  //
  // Paramètres
  // ----------------------------------------------------
  // ----------------------------------------------------

C_TEXT:C284($NomFic;$tParam;$tRes;$tErr)
_O_C_STRING:C293(2;$FL;$Guillemet)
C_TIME:C306($RefDoc)

  // ----------------------------------------------------

If (<>ZPC)  //On est Bien sur PC
	
	$Guillemet:=Char:C90(34)
	$FL:=Char:C90(13)+Char:C90(10)
	
	$NomDossierREG:=<>CheminStructureLocal+"temporary files"
	If (Test path name:C476($NomDossierREG)<0)
		CREATE FOLDER:C475($NomDossierREG)
	End if 
	  // on crée un fichier reg
	$NomFic:=$NomDossierREG+<>ZSéparateur+"TempRegeditPDF.reg"
	
	If (Test path name:C476($NomFic)=Est un document:K24:1)  // si document existe, on vire c'est un vieux
		DELETE DOCUMENT:C159($NomFic)
	End if 
	
	$RefDoc:=Create document:C266($NomFic)
	
	If (OK=1)
		  // on crée le document avec le bon format
		  // on passe par ce système pour éviter d'être "emmerdé"
		
		$Pac:="Windows Registry Editor Version 5.00"+$FL+$FL
		SEND PACKET:C103($RefDoc;$Pac)
		SEND PACKET:C103($RefDoc;"["+"HKEY_CURRENT_USER\\SOFTWARE\\PDFCreator\\Program"+"]"+$FL)
		SEND PACKET:C103($RefDoc;$Guillemet+"AutosaveDirectory"+$Guillemet+"="+$Guillemet+$Guillemet+$FL)
		SEND PACKET:C103($RefDoc;$Guillemet+"AutosaveFilename"+$Guillemet+"="+$Guillemet+$Guillemet+$FL)
		SEND PACKET:C103($RefDoc;$Guillemet+"SaveFilename"+$Guillemet+"="+$Guillemet+$Guillemet+$FL)
		SEND PACKET:C103($RefDoc;$Guillemet+"UseAutosave"+$Guillemet+"="+$Guillemet+"0"+$Guillemet+$FL)  //IMPORTANT pour afficher le dialogue de création
		SEND PACKET:C103($RefDoc;$Guillemet+"UseAutosaveDirectory"+$Guillemet+"="+$Guillemet+"0"+$Guillemet+$FL)
		SEND PACKET:C103($RefDoc;$Guillemet+"OptionsVisible"+$Guillemet+"="+$Guillemet+"1"+$Guillemet+$FL)  //1 par defaut dans le Registre
		SEND PACKET:C103($RefDoc;$Guillemet+"LastsaveDirectory"+$Guillemet+"="+$Guillemet+$Guillemet+$FL)
	End if 
	
	CLOSE DOCUMENT:C267($RefDoc)
	LAUNCH EXTERNAL PROCESS:C811("REGEDIT "+" /s "+$Guillemet+$NomFic+$Guillemet;$tParam;$tRes;$tErr)
	DELAY PROCESS:C323(Current process:C322;3*60)
	SET CURRENT PRINTER:C787(ImprimanteCourante)
End if 
