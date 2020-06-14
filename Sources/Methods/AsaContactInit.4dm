//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 05/12/14, 08:14:06
  // ----------------------------------------------------
  // Méthode : AsaContactInit
  // Description
  // Initialise dans ZDéclareVarDiamant
  // les éléments de gestion detéléchargement d'AsaDia
  // ----------------------------------------------------
$ChemDos:=Get 4D folder:C485(Dossier base:K5:14)+"pages_Web"+Séparateur dossier:K24:12+"pdf"+Séparateur dossier:K24:12
ARRAY TEXT:C222($TbNomFicPdf;0)
DOCUMENT LIST:C474($ChemDos;$TbNomFicPdf)
SORT ARRAY:C229($TbNomFicPdf;<)
$L:=Find in array:C230($TbNomFicPdf;"ASAContact@")
<>VarDerAsaContactA:=Substring:C12($TbNomFicPdf{$L};11;2)
ARRAY TEXT:C222(<>TbAsaContactIP;0)
ARRAY DATE:C224(<>TbAsaContactDate;0)
QUERY:C277([XData:1];[XData:1]XNom:2="WebAsaContact37";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="ACo")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="WebAsaContact37"
	[XData:1]XType:3:="ACo"
	ZVariableVersBlob (->[XData:1]XBlob:13;-><>TbAsaContactIP;-><>TbAsaContactDate)
Else 
	ZBlobVersVariable (->[XData:1]XBlob:13;-><>TbAsaContactIP;-><>TbAsaContactDate)
End if 
SAVE RECORD:C53([XData:1])
<>WebAsaContact:=AsaContactCompte 
