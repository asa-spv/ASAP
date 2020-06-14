//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 12/02/14, 15:32:02
  // ----------------------------------------------------
  // Méthode : RapRemetCourrielsAGauche
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

OB SET:C1220([CampagneParticipations:17]Arguments:5;"MailDisponibilitéEnvoyé";False:C215)
$H:="Modification manuelle de la liste des laboratoires ayant reçu le mail le "
$H:=$H+String:C10(Current date:C33;3)+" à "+String:C10(Current time:C178)+<>ZCR
$H:=$H+"Passage manuel global du statut mail envoyé au statut de non envoyé"+<>ZCR
[CampagneParticipations:17]TexteParticipation:4:=[CampagneParticipations:17]TexteParticipation:4+<>ZCR2+$H
