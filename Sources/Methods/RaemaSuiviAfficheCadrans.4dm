//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 11/08/16, 15:56:47
  // ----------------------------------------------------
  // Méthode : RaemaSuiviAfficheCadrans
  // Description
  // Valorise des cadrans d'avancement des différents 
  // statuts des laboratoires
  // ----------------------------------------------------
VarAvancementAbsence:=Records in set:C195("absence")
Cadran1:=Records in set:C195("absence")*100/Size of array:C274(TbParticipantN)

VarAvancementEncours:=Records in set:C195("encours")
Cadran2:=Records in set:C195("encours")*100/Size of array:C274(TbParticipantN)

VarAvancementEnvoyée:=Records in set:C195("envoyé")
Cadran3:=Records in set:C195("envoyé")*100/Size of array:C274(TbParticipantN)
