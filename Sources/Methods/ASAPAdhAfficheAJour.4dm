//%attributes = {}

$An:=String:C10(Year of:C25(Current date:C33))
$dem:=Request:C163("Quelle année ?";$An)
CREATE SET:C116([Personnes:12];"ZNomSelectionAvant")
$Cotis:="Cotisation ASA "+$dem
QUERY:C277([Ventes:16];[Ventes:16]Intitule:3=$Cotis)
RELATE ONE SELECTION:C349([Ventes:16];[Personnes:12])
ASAPPerFabriqueTb 
ZFenetreActualiseTitre 
