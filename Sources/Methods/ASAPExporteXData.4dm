//%attributes = {}
QUERY:C277([XData:1];[XData:1]XType:3="TraductionEC";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Traduction de l'espace client")
SET CHANNEL:C77(12;"")
$Envoi:="XData"
SEND VARIABLE:C80($Envoi)
SEND RECORD:C78([XData:1])
SET CHANNEL:C77(11)

