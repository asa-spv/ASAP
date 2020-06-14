//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 12:13:41
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouUtilLB
  // Description
  // Anciennement
  // ZGèreListeLB (->[XUtilisateurs]Nom;$CDImage;"Entrée";"Fiche";"")

ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)

  // ZGereEnsemble:=True
$Chemin:="Images/Buttons/Personnel.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)

OB SET:C1220($ObParam\
;"Champ significatif";->[XUtilisateurs:2]Nom:2\
;"Champ clefs";->[XUtilisateurs:2]MotsClefs:10\
;"Chemin logo";$CDImage\
;"Saisie";"Entrée"\
;"Sortie";"Sortie"\
;"Fiche";"Fiche"\
;"Avant";"ZLBUtilSurChargement"\
;"Après";"ZLBUtilSurValidation"\
;"Sur destruction";"ZBoumUtilisateur"\
;"Gestion ensemble";True:C214\
;"Méthode lapin";""\
;"Gestion tableaux";False:C215)

If (Macintosh option down:C545)
	OB SET:C1220($ObParam;"Gestion tableaux";True:C214)
End if 
ZLBGèreListe ($ObParam)