//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/02/18, 18:11:40
  // ----------------------------------------------------
  // Méthode : ZLBListeSupprimerTout
  // Description
  // Historique : ZAdieuSel V11 du 10/08/2010
  //  MP de destruction de la sélection courante
  //
  // Paramètre {$1} = si existe s'adresse à la gestion LB
  // ----------------------------------------------------

C_LONGINT:C283($FT;$Salé;$Reste)  // compteurs
C_TEXT:C284($Pluriel)  //accord orthographique (s)
C_TEXT:C284($Sémaphore)  // sémaphore de destruction sur le fichier


  // Modifié par : Patrick EMANUEL (10/05/12)
If (Count parameters:C259=1)
	$LB:=True:C214
Else 
	$LB:=False:C215
End if 

If (ZSupprime)
	$Ft:=Records in selection:C76(ZPtTable->)
	MonSémaphore:="Adieu"+String:C10(Table:C252(ZPtTable))  // un sémaphore par fichier
	If (ZTestSemaphore (MonSemaphore;"Une destruction est en cours sur un autre poste…"))
		
		ZFenetreModaleAuCentre (450;60)
		  // tentons de détruire la sélection
		READ WRITE:C146(ZPtTable->)
		
		  // Modifié par : Patrick EMANUEL (10/05/12)
		If ($LB)
			COPY SET:C600("ZFichesSurlignees";ZNomEnsembleAvant)  // Recopie de l'ensemble sélection LB sur ZNomEnsembleAvant
		Else 
			CREATE SET:C116(ZPtTable->;ZNomEnsembleAvant)
		End if 
		
		CREATE EMPTY SET:C140(ZPtTable->;"Sauves")
		CREATE SET:C116(ZPtTable->;"Peloton")
		
		START TRANSACTION:C239
		For ($salé;1;$FT)
			FIRST RECORD:C50(ZPtTable->)
			If (ZVerrouTester (ZPtTable))
				If (ZBoumProc#"")
					MESSAGE:C88(<>ZCR2+"         Actualisation des enregistrements liés à …"+ZPtChamp->)
					EXECUTE FORMULA:C63(ZBoumProc)
				End if 
				MESSAGE:C88(<>ZCR2+"         Suppression de l'enregistrement…"+ZPtChamp->)
				ZLBDetruitEnregistrement 
				USE SET:C118("Peloton")
			End if 
			
		End for 
		  //test de résistance comparée des fiches et de l'utilisateur…
		OK:=1
		While ((Records in set:C195("LockedSet")#0) & (OK=1))
			MESSAGE:C88(<>ZCR2+"         Traitement des fiches verrouillées…")
			
			DELETE SELECTION:C66(ZPtTable->)
			$Reste:=Records in set:C195("LockedSet")
			If ($Reste#0)
				$Pluriel:=(Num:C11($Reste>1))*"s"
				$Mess:="Il reste "+String:C10($Reste)+" enregistrement"+$Pluriel
				$Mess:=$Mess+" vérouillé"+$Pluriel+": voulez-vous attendre??"
				CONFIRM:C162($Mess)
				
				If (OK=0)
					CANCEL TRANSACTION:C241
				End if 
				
			End if 
		End while 
		
		CLOSE WINDOW:C154
		VALIDATE TRANSACTION:C240
		
	End if 
	
	CLEAR SEMAPHORE:C144($Sémaphore)
	USE SET:C118(ZNomEnsembleAvant)
	
	If (Records in selection:C76(ZPtTable->)=0)
		ALL RECORDS:C47(ZPtTable->)
	End if 
	
Else 
	ALERT:C41("Désolé : vous ne pouvez détruire cette sélection")
End if 