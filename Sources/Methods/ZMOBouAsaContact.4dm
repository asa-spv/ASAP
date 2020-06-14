//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/10/17, 08:39:55
  // ----------------------------------------------------
  // Méthode : ZMOBouAsaContact
  // Description
  // Gère les AsaContacts existants
  // ----------------------------------------------------

AsaContactScrute 
READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="FichiersAC")
ORDER BY:C49([XData:1];[XData:1]XEntier:6;<)
$F:=Open form window:C675("DlgAsaContact")
DIALOG:C40("DlgAsaContact")
CLOSE WINDOW:C154
ZAmnistiePartielle (->[XData:1])