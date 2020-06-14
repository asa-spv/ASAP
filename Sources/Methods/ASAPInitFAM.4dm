//%attributes = {}
  // ----------------------------------------------------
  // Méthode : ASAPInitPUMFAM
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 28/04/20, 10:59:40
  // Paramètre : aucun

C_LONGINT:C283($salé;$TT)
QUERY:C277([XData:1];[XData:1]XNom:2="Données courriel";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="MWb")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="Données courriel"
	[XData:1]XType:3:="MWb"
	[XData:1]XDate:4:=Current date:C33
	SAVE RECORD:C53([XData:1])
End if 
OB GET PROPERTY NAMES:C1232([XData:1]XObjet:18;$TbPUMFAM)
If (Find in array:C230($TbPUMFAM;"NomFAM")<0)  // pas de fournisseur noté
	$Objet:=New object:C1471("AdresseEnvoi";"asa-spv@wanadoo.fr"\
		;"ServeurEnvoi";"smtp.orange.fr"\
		;"MotDePasseEnvoi";"9nPaL4gSeR;"\
		;"PortEnvoi";587\
		;"ServeurReception";"pop.orange.fr"\
		;"AdresseReception";"asaserveurweb@wanadoo.fr"\
		;"MotDePasseReception";"asaserveurweb"\
		;"PortReception";995)
	OB SET:C1220([XData:1]XObjet:18;"NomFAM";$Objet)
	SAVE RECORD:C53([XData:1])
End if 
