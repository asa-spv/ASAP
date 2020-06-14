//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/01/19, 15:00:06
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouAdhPerso
  // Description
  // méthode qui permet la gestion srandard des adhérents
  // à titre personnel

ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)

If (Macintosh command down:C546)
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Testeur")
	$MéthodeAvant:="ASAPSurChargementSaisieAdh"
Else 
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Individu";*)
	QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=False:C215)
	$MéthodeAvant:="ASAPSurChargementSaisieAdh"
End if 
$Chemin:="Images/Buttons/Personnel.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
$MethodesLapîn:="Adhérents à jour:ASAPAdhAfficheAJour;Envoyer un courriel:ASAPEnvoiCourrielLabo"\



OB SET:C1220($ObParam\
;"Champ significatif";->[Personnes:12]NomLong:2\
;"Champ clefs";->[Personnes:12]ChampRecherche:6\
;"Chemin logo";$CDImage\
;"Saisie";"SaisieAdh"\
;"Sortie";"Liste"\
;"Fiche";"Fiche"\
;"Avant";$MéthodeAvant\
;"Après";"ASAPSurValidationSaisieLabo"\
;"Sur destruction";"ZBoumAdh"\
;"Gestion ensemble";True:C214\
;"Méthode lapin";$MethodesLapîn\
;"Dialogue";"LBTableauxPerso"\
;"Méthode qui remplit les tableaux";"ASAPPerFabriqueTb"\
;"Gestion tableaux";True:C214)
ZLBGèreListe ($ObParam)
