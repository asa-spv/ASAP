//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 14/06/20, 14:23:36
  // ----------------------------------------------------
  // Méthode : CalculTotalFacture
  // Description
  // Méthode qui calcule les montants de la facture
  //   à partir des [Ventes]
  // ----------------------------------------------------
[Factures:15]TotalHT:8:=Sum:C1([Ventes:16]PrixTotalHT:7)
[Factures:15]TotalTVA:9:=Sum:C1([Ventes:16]PrixTotalHT:7)*(<>PermTVA/100)
[Factures:15]TotalTTC:10:=[Factures:15]TotalHT:8+[Factures:15]TotalTVA:9
SAVE RECORD:C53([Factures:15])