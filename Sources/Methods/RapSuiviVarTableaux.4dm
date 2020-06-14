//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 15/02/16, 15:27:37
  // ----------------------------------------------------
  // Méthode : RapSuiviVarTableaux
  // Description
  // Remplit la description des tableau de suivi 
  // ainsi que les cadrans de la page 5 de "DlgPrincipal"
  // ----------------------------------------------------
VarCouNonEnv:=RapInitEti (->TbRapMailNonEnvoi)
VarCouEnv:=RapInitEti (->TbRapMailEnvoi)
VarRapObt:=RapInitEti (->TbRapportsPris)
VarRapNonObt:=RapInitEti (->TbRapportsNonPris)
VarRapRetenus:=RapInitEti (->TbRapportsRetenus)
VarCouNonParticip:=RapInitEti (->TbRapMailNonParticipation)
RapRegleCadran   // MAJ des cadrans d'avancement