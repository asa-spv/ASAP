//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 22/07/19, 08:27:34
  // ----------------------------------------------------
  // Méthode : ZMOBouFactures
  // Description
  //   Méthode de gestion des factures de l'ASA
  //
  // Paramètres
  // ----------------------------------------------------
ARRAY TEXT:C222(TbMethodeLapin;0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)


$Chemin:="Images/Buttons/Logo facture.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin;"/";Séparateur dossier:K24:12)
$MethodesLapîn:="Facturer le RAEMA Poudre:ASAPFactureRAEMAPoudre;Facturer le RAEMA Gel:ASAPFactureRAEMAGel;-:;Envoyer un courriel:ASAPEnvoiCourrielLabo"\


QUERY:C277([Factures:15];[Factures:15]NumFacture:3=(<>ZPermMille+"@"))
If (Records in selection:C76([Factures:15])=0)
	QUERY:C277([Factures:15];[Factures:15]NumFacture:3="17@")
End if 
ORDER BY:C49([Factures:15];[Factures:15]NumFacture:3;>)
  // Calcul des bilans financiers
OB SET:C1220($ObParam\
;"Champ significatif";->[Factures:15]NumFacture:3\
;"Champ clefs";->[Factures:15]ChampRecherche:11\
;"Chemin logo";$CDImage\
;"Saisie";"Entrée"\
;"Sortie";"Liste"\
;"Fiche";"Facture"\
;"Avant";"ASAPFactureSurChargement"\
;"Après";"ASAPFactureSurValidation"\
;"Sur destruction";"ZBoumFacture"\
;"Gestion ensemble";True:C214\
;"Méthode lapin";$MethodesLapîn\
;"Dialogue";"LBTableauxFactures"\
;"Méthode qui remplit les tableaux";"ASAPFabriqueTbFactures"\
;"Gestion tableaux";True:C214)
ZLBGèreListe ($ObParam)