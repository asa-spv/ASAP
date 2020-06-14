//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/08/18, 07:56:03
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPLaveHistoriqueParticipe
  // Description
  // 
$NumLabo:=WebTrouveValeurParNom ([CampagneParticipations:17]UUIDPersonne:2;-><>TbPerUUID;-><>TbPerNumLaboRAEMAA)
$ChaineObsolète:="Numéro de labo : "+$NumLabo+<>ZCR
[CampagneParticipations:17]TexteParticipation:4:=Replace string:C233([CampagneParticipations:17]TexteParticipation:4;$ChaineObsolète;"")
