//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/04/18, 05:21:23
  // ----------------------------------------------------
  // Méthode : ZLBSupprimerSelection
  // Description
  // Méthode qui s'applique à toute suppression d'enregistrement(s)
  //  dans le cadre d'une gestion LB Standard
  // ----------------------------------------------------

C_POINTER:C301(ZPtTable)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_LONGINT:C283($Salé;$FT)
		If (GestionTableau)
			CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
		End if 
		$FT:=Records in selection:C76(ZPtTable->)
		$s:=Num:C11($FT>1)*"s"
		
		If (GestionTableau)
			$FT:=Size of array:C274(Lb_Tableaux)
			ARRAY LONGINT:C221($TbNumEnrUserSet;0)
			For ($Salé;1;$FT)
				If (Lb_Tableaux{$Salé})
					APPEND TO ARRAY:C911($TbNumEnrUserSet;TbNumEnr{$Salé})
				End if 
			End for 
			CREATE SET FROM ARRAY:C641(ZPtTable->;$TbNumEnrUserSet;"ZFichesSurlignees")
			NomEnsembleUserSet:="ZFichesSurlignees"
		Else 
			NomEnsembleUserSet:="$ZFichesSurlignees"
		End if 
		$SFT:=Records in set:C195(NomEnsembleUserSet)
		ARRAY TEXT:C222($TbLignesMenu;1)
		$TbLignesMenu{1}:="Supprimer la séléction soit "+String:C10($FT)+" enregistrement"+$s
		If ($SFT>0)
			If ($SFT=1)
				APPEND TO ARRAY:C911($TbLignesMenu;"Supprimer l'enregistrement désigné")
			Else 
				APPEND TO ARRAY:C911($TbLignesMenu;"Supprimer les "+String:C10($SFT)+" enregistrements désignés")
			End if 
		End if 
		$Menu:=ZTableauVersTexte (->$TbLignesMenu;";")
		$vlChoixUtilisateur:=Pop up menu:C542($Menu)
		If ($vlChoixUtilisateur>0)
			Case of 
				: ($vlChoixUtilisateur=1)
					ZLBDetruitEnregistrement (True:C214)
					
				: ($vlChoixUtilisateur=2)
					ZLBDetruitEnregistrement 
			End case 
			If (GestionTableau)
				$NomLB:="Lb_Tableaux"
			Else 
				$NomLB:="Lb_Selection"
			End if 
			LISTBOX SELECT ROW:C912(*;$NomLB;0;lk supprimer de sélection:K53:3)
			ZFenetreActualiseTitre 
		End if 
End case 

