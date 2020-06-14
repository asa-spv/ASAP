//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/01/19, 07:00:02
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouRetours
  // Description
  // Méthode de gestion standard des retours

ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)

$Chemin:="Images/Buttons/Reclamation.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)

ALL RECORDS:C47([RetoursFiches:24])
ORDER BY:C49([RetoursFiches:24];[RetoursFiches:24]NumFiche:2;<)
$DerNum:=[RetoursFiches:24]NumFiche:2
SELECTION TO ARRAY:C260([RetoursFiches:24]NumFiche:2;TbNumFicheRetour)
If (Substring:C12($DerNum;1;2)=<>ZPermMille)
	DerNumActuelRetour:=$DerNum
	$Test:=String:C10(Num:C11(<>ZPermMille)-1)+"@"
	$L:=Find in array:C230(TbNumFicheRetour;$Test)
	DerNumAnMoinsUnRetour:=TbNumFicheRetour{$L}
Else   // on n'a pas rempli les fiches de l'année
	DerNumActuelRetour:=<>ZPermMille+"/000"
	DerNumAnMoinsUnRetour:=$DerNum
End if 
OB SET:C1220($ObParam\
;"Champ significatif";->[RetoursFiches:24]NumFiche:2\
;"Champ clefs";->[RetoursFiches:24]Recherche:11\
;"Chemin logo";$CDImage\
;"Saisie";"Saisie"\
;"Sortie";"Liste"\
;"Fiche";"Saisie"\
;"Avant";"ASAPRetourSurChargement"\
;"Après";"ASAPRetourSurValidation"\
;"Méthode lapin";"Recherche par laboratoire:ASAPRetourChercheParLabo;Revue de direction:ASAPRetourRevueDirection;Groupe consultatif:ASAPRetourGroupeConsultatif"\
;"Gestion ensemble";True:C214\
;"Sens du tri";"<")
ZLBGèreListe ($ObParam)