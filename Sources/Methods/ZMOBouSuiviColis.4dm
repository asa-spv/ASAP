//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/01/19, 15:00:06
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouSuiviColis
  // Description
  // méthode qui permet la gestion srandard des [CampagneParticipations]

ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)

ALL RECORDS:C47([CampagneParticipations:17])
$Chemin:="Images/Buttons/Stock.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
$MethodesLapîn:="Imprimer les proforma:ASAPLaboImprimeProforma"



OB SET:C1220($ObParam\
;"Champ significatif";->[CampagneParticipations:17]UUIDPersonne:2\
;"Champ clefs";->[Personnes:12]ChampRecherche:6\
;"Chemin logo";$CDImage\
;"Saisie";"Visu"\
;"Sortie";"Sortie"\
;"Fiche";"Fiche"\
;"Avant";"ASAPSurChargementSaisiePar"\
;"Après";"ASAPSurValidationSaisiePar"\
;"Sur destruction";"ZBoumPar"\
;"Gestion ensemble";True:C214\
;"Méthode lapin";$MethodesLapîn\
;"Dialogue";"LBTableauxParticipation"\
;"Méthode qui remplit les tableaux";"ASAPParFabriqueTbEnvoiColis"\
;"Gestion tableaux";True:C214)
ZLBGèreListe ($ObParam)
