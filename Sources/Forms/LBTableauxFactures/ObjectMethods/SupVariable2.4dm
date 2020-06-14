
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/04/18, 05:21:23
  // ----------------------------------------------------
  // Méthode : MO héritée de ZLBSupprimerSelection
  // Description
  // Méthode qui s'applique à toute suppression d'enregistrement(s)
  //  dans le cadre d'une gestion LB Standard
  // ----------------------------------------------------

C_POINTER:C301(ZPtTable)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_LONGINT:C283($Salé;$FT)
		$OC:=True:C214
		
		If (GestionTableau)
			CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
		End if 
		CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)  // Utile en cas de gestion de liste pour  Ajouter à sélection
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
				: ($vlChoixUtilisateur=2)
					USE SET:C118(NomEnsembleUserSet)
					FIRST RECORD:C50(ZPtTable->)
					If ([Factures:15]Regle:12)
						ALERT:C41("Désolé, impossible de supprimer une facture déjà réglée")
						$OC:=False:C215
					Else 
						ZLBDetruitEnregistrement (True:C214)
					End if 
					
				: ($vlChoixUtilisateur=1)
					USE SET:C118(NomEnsembleUserSet)
					$SFT1:=Records in set:C195(NomEnsembleUserSet)
					QUERY SELECTION:C341([Factures:15];[Factures:15]Regle:12=False:C215)
					CREATE SET:C116([Factures:15];NomEnsembleUserSet)
					$SFT2:=Records in set:C195(NomEnsembleUserSet)
					If ($SFT1#$SFT2)
						ALERT:C41("ATTENTION, nous ne pouvons pas détruire "+String:C10($SFT1-$SFT2)+" facture(s) déjà réglée(s)")
						CONFIRM:C162("Voulez vous VRAIMENT supprimer les "+String:C10($SFT2)+" facture(s) non réglées(s) ???")
						If (OK=1)
							ZLBDetruitEnregistrement 
						Else 
							$OC:=False:C215
						End if 
					Else 
						ZLBDetruitEnregistrement 
					End if 
			End case 
			If (GestionTableau)
				$NomLB:="Lb_Tableaux"
			Else 
				$NomLB:="Lb_Selection"
			End if 
			USE SET:C118(ZNomEnsembleAvant)
			ASAPFabriqueTbFactures 
			ZNbEnr:=Size of array:C274(TbNumEnr)
			LISTBOX SELECT ROW:C912(*;$NomLB;0;lk supprimer de sélection:K53:3)
			ZFenetreActualiseTitre 
		End if 
End case 
