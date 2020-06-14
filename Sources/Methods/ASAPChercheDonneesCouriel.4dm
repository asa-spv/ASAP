//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 28/08/19, 17:19:39
  // ----------------------------------------------------
  // Méthode : ASAPChercheDonneesCouriel
  // Description
  //   Méthode qui va chercher dans la [XData] adéquate
  //   les paramètres du serveur de mail
  // ----------------------------------------------------

C_OBJECT:C1216($Objet)
C_LONGINT:C283($Salé;1;$TT;$CacServeur)

QUERY:C277([XData:1];[XData:1]XNom:2="Données courriel";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="MWb")
ARRAY TEXT:C222($TbMailsDistribution;0)
ARRAY BOOLEAN:C223($TbResDistribution;0)
ARRAY BOOLEAN:C223($TbARDistribution;0)
OB GET ARRAY:C1229([XData:1]XObjet:18;"MailsDistribution";$TbMailsDistribution)
OB GET ARRAY:C1229([XData:1]XObjet:18;"ResDistribution";$TbResDistribution)
OB GET ARRAY:C1229([XData:1]XObjet:18;"ARDistribution";$TbARDistribution)
$TT:=Size of array:C274($TbMailsDistribution)
ARRAY TEXT:C222(TbMailRes;0)
ARRAY TEXT:C222(TbMailAR;0)
For ($Salé;1;$TT)
	If ($TbResDistribution{$Salé})
		APPEND TO ARRAY:C911(TbMailRes;$TbMailsDistribution{$Salé})
	End if 
	If ($TbARDistribution{$Salé})
		APPEND TO ARRAY:C911(TbMailAR;$TbMailsDistribution{$Salé})
	End if 
End for 
$0:=[XData:1]XObjet:18.NomFAM