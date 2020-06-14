//%attributes = {}
  // Méthode : ZPDFInitPrinter V11 du 10/08/2010
  // 
  // Paramètres
  //$1 : Nom du fichier
  //$2 : Chemin du dossier d'impression

  // Nécessite, sur Windows, que PDFCreator soit installé comme Imprimante
  // ----------------------------------------------------

C_TEXT:C284($NomFic;$1;$NomDossierPDF;$2;$VnomDocument;$NomDossierPDF;$FL)

  // ----------------------------------------------------

$Guillemet:=Char:C90(34)
$FL:=Char:C90(13)+Char:C90(10)

If ($2#"")
	$NomDossierPDF:=$2  // le repertoire de destination
Else 
	$NomDossierPDF:=<>PermCheDosPdf
End if 

$NomDossierREG:=Temporary folder:C486
$VnomDocument:=Uppercase:C13($1)  // le nom désiré du document et au Cas où il n'est pas déjà en majuscule

If (Test path name:C476($NomDossierPDF)#Est un dossier:K24:2)  // si document existe, on vire c'est un vieux
	CREATE FOLDER:C475($NomDossierPDF)
End if 

  // Quoiqu'il arrive
$NomFic:=$NomDossierPDF+$VnomDocument

  //Gérons maintenant le Système (Mac ou PC)
If (<>ZPC)  //On est Sur PC
	  //On est sur PC
	  // test d'existence de PDFCreator
	ARRAY TEXT:C222($TabNoms;500)  //500 imprimantes, il faut être fou! 
	PRINTERS LIST:C789($tabNoms)
	$a:=Find in array:C230($tabNoms;"PDFCreator")
	
	If ($a>0)
		ImprimanteCourante:=Get current printer:C788
		  // sauvegarde de l'imprimante courante
		SET CURRENT PRINTER:C787(PDFCreator nom imprimante:K47:13)
		SET PRINT OPTION:C733("PDFInfo:Reset standard options";0)  // Réinitaialisation de toutes les options
		SET PRINT OPTION:C733(Option nom document à imprimer:K47:10;$VnomDocument)
		SET PRINT OPTION:C733(Option masquer progression impr:K47:12;1)  // 0 = Afficher; 1 = Masquer 
		SET PRINT OPTION:C733(Option destination:K47:7;3;$NomFic)
	Else 
		ALERT:C41("Désolé, je ne peux rien faire car PDFCreator n'est pas installé")
	End if 
Else 
	SET PRINT OPTION:C733(Option destination:K47:7;3;$NomFic)  // Syntaxe qui fonctionne sur Mac par Defaut
End if 

