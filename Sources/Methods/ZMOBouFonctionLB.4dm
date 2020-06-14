//%attributes = {}

$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233("Images/Buttons/Fonctions.png/";"/";Séparateur dossier:K24:12)
C_OBJECT:C1216($ObParam)
OB SET:C1220($ObParam\
;"Champ significatif";->[XFonctions:3]NomFonction:2\
;"Chemin logo";$CDImage\
;"Saisie";"Entrée"\
;"Fiche";"Fiche"\
;"Sortie";"Sortie"\
;"Avant";"ZLBFonctionSurChargement"\
;"Après";"ZLBFonctionSurValidation"\
;"Sur destruction";""\
;"Méthode lapin";"Tables sensibles:ZAfficheTablesSensibles")
ZLBGèreListe ($ObParam)