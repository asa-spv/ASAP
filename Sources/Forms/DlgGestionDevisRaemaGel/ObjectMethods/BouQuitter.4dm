  // Méthode : DlgGestionDevisRaemaGel.BouQuitter
  // Description : met à jour la propriété "Loto" de [RAEMACampagnes]Arguments
  // // Suite à la validation des devis

C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($TbUUIDLaboPart;0)
ARRAY OBJECT:C1221($TbArgumentsPart;0)
<>ActualiseTbParticipation:=True:C214

ASAPCalculeLotoCampagne (<>CampagneDevisRGMai)
ASAPCalculeLotoCampagne (<>CampagneDevisRGDec)
