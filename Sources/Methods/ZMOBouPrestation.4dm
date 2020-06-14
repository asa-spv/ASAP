//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/01/19, 06:19:39
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouPrestation
  // Description
  // // Méthode de gestions de la table [Prestations]

C_OBJECT:C1216($ObParam)
  // Sélection des prestations de l'année courante de tarification
QUERY:C277([Prestations:26];[Prestations:26]AnneePrestation:6=<>AnCourantDevisRGN)

$Chemin:="Images/Buttons/Documents.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
OB SET:C1220($ObParam\
;"Champ significatif";->[Prestations:26]NomPrestation:3\
;"Chemin logo";$CDImage\
;"Sortie";"Sortie"\
;"Méthode lapin";"Prestations RAEMA en cours:ASAPPrestationsAfficheEnCours")
ZLBGèreListe ($ObParam)
