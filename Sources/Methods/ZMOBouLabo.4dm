//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/05/18, 12:13:41
  // ----------------------------------------------------
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZMOBouLabo
  // Description
  // Anciennement
  // ZGèreListeLB (->[XUtilisateurs]Nom;$CDImage;"Entrée";"Fiche";"")

ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)
If (Macintosh command down:C546)
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="testeur")
	$SurChargementSaisie:="ASAPSurChargementSaisieAdh"
Else 
	QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="laboratoire";*)
	QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=False:C215)
	$SurChargementSaisie:="ASAPSurChargementSaisieLabo"
End if 

$Chemin:="Images/Buttons/laboratoire.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
$MethodesLapin:="Laboratoire avec RAEMA liés:GATrouveRaemaLies;Accéder au loto:RaemaLotoAffiche;Gestion des demandes de RAEMA Gel:WebDevisGestionDemandes;Envoyer un courriel:ASAPEnvoiCourrielLabo"\




OB SET:C1220($ObParam\
;"Champ significatif";->[Personnes:12]NomLong:2\
;"Champ clefs";->[Personnes:12]ChampRecherche:6\
;"Chemin logo";$CDImage\
;"Saisie";"SaisieLabo"\
;"Sortie";"Liste"\
;"Fiche";"Fiche"\
;"Avant";$SurChargementSaisie\
;"Après";"ASAPSurValidationSaisieLabo"\
;"Sur destruction";"ZBoumPersonne"\
;"Gestion ensemble";True:C214\
;"Méthode lapin";$MethodesLapin\
;"Dialogue";"LBTableauxPerso"\
;"Méthode qui remplit les tableaux";"ASAPPerFabriqueTb"\
;"Gestion tableaux";True:C214)
ZLBGèreListe ($ObParam)