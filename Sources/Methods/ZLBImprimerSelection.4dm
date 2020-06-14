//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/03/18, 07:05:57
  // ----------------------------------------------------
  // Méthode : ZLBImprimerSelection
  // Description
  // Méthode projet d'impression d'une sélection
  // qui permet de choisir entre une impression liste, page étiquette ou état
  // ----------------------------------------------------
C_LONGINT:C283($LargeurImpression;$HauteurPapier;$LargeurPapier;OnAffichePbLargeur)
If (GestionTableau)
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
	$LBAffiche:="Lb_Tableaux"
	$LBImprime:="LB_TableauxImpression"
	$LBFormImpression:="LBImpressionTableaux"
Else 
	$LBAffiche:="Lb_Selection"
	$LBImprime:="LB_ListeImpression"
	$LBFormImpression:="LBImpressionListe"
End if 
ZFenetreModaleAuCentre (250;170)
$LargeurImpression:=ZLBLargeurImpressionLB ($LBAffiche)
  //FORM CHARGER("LBImpression")  // Charge le formulaire projet et exécute son Sur chargement
GET PRINTABLE AREA:C703($HauteurPapier;$LargeurPapier)
  //FORM LIBÉRER
Case of 
	: (($LargeurImpression<($LargeurPapier-10)))  // TVB
		OnAffichePbLargeur:=0
		
	: (($LargeurImpression<($HauteurPapier-10)))  // TVB si impression en paysage
		OnAffichePbLargeur:=1
		
	Else   // recours aux options obligatoire
		OnAffichePbLargeur:=2
End case 
NbSel:=Records in set:C195("$ZFichesSurlignees")

DIALOG:C40("DlgImpressionSelection")
If (BouOK=1)
	ZLBImprimeDecritLB ($LBAffiche)  // actualisation des options
	$Surlignées:=(PortBRSel=1)
	If ($Surlignées)
		$NomSelection:="Imression"+ZnomTable
		CUT NAMED SELECTION:C334(ZPtTable->;$NomSelection)
		USE SET:C118("$ZFichesSurlignees")
	End if 
	CLOSE WINDOW:C154
	Case of 
		: (BouImageImpListe=1)
			ZLBImprimeLaListe ($LBFormImpression;"Liste des personnes: "+String:C10(Records in selection:C76(ZPtTable->));$LBImprime)
			
		: (BouImageImpFiche=1)
			FORM SET OUTPUT:C54(ZPtTable->;ZNomForImpEnr)
			_O_PAGE SETUP:C299(ZPtTable->;ZNomForImpEnr)
			PRINT SELECTION:C60(ZPtTable->)
			
		: (BouImageImpEtiquette=1)
			PRINT LABEL:C39(ZPtTable->;Char:C90(1))
			
		: (BouImageImpEtat=1)
			QR REPORT:C197(ZPtTable->;Char:C90(1))
			
	End case 
	If ($Surlignées)  // restitution de la sélection de départ
		USE NAMED SELECTION:C332($NomSelection)
	End if 
End if 
