//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick
  // Date et heure : 24/08/11
  // ----------------------------------------------------
  // Méthode : ZLBMFListes
  // Description
  // Méthode du formulaire projet LBSelection 
  //  qui permet de gérer de façon standard 
  //  la sélection d'une table (ZLBGèreListe)
  // ----------------------------------------------------

C_BOOLEAN:C305(vl_b_print;tri)
C_LONGINT:C283($C;$L)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		$Sep:=Séparateur dossier:K24:12
		tri:=True:C214
		CREATE EMPTY SET:C140(ZPtTable->;"$ZFichesSurlignees")
		ZFenetreActualiseTitre 
		ZLBAfficheListe 
		$PtLogo:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"VarLogoTable")
		READ PICTURE FILE:C678(VarCDLogo;$PtLogo->)
		OBJECT SET VISIBLE:C603(*;"imp@";ZImprime)
		OBJECT SET VISIBLE:C603(*;"sup@";ZSupprime)
		OBJECT SET VISIBLE:C603(*;"ens@";ZGereEnsemble)
		OBJECT SET VISIBLE:C603(*;"lapin@";(Size of array:C274(TbMethodeLapin)>0))
		
End case 