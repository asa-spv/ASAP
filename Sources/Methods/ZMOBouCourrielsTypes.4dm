//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/01/19, 06:42:05
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouCourrielsTypes
  // Description
  // Permet la gestion standard de [CourrielsTypes]

C_OBJECT:C1216($ObParam)
  // Sélection des prestations de l'année courante de tarification

$Chemin:="Images/Buttons/Lettre type.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
OB SET:C1220($ObParam\
;"Champ significatif";->[CourrielsTypes:28]NomLettre:2\
;"Chemin logo";$CDImage\
;"Avant";"ASAPCourrielsSurChargement"\
;"Après";"ASAPCourrielsSurValidation"\
;"Sortie";"Sortie")
ZLBGèreListe ($ObParam)
