//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 12/08/18, 10:46:43
  // ----------------------------------------------------
  // Paramètre aucum
  // ----------------------------------------------------
  // Méthode : ASAPImporteLettresTypes
  // Description : importe le fichier .txt et renseigne la table [CourrielsTypes]
  // La méthode export est dans le Si(Faux)... Fin de si

C_TEXT:C284($Var;$ValeurA)
C_LONGINT:C283($Salé;$FT)
C_BLOB:C604($Blob)

READ WRITE:C146([CourrielsTypes:28])
SET CHANNEL:C77(13;"")
If (OK=1)
	
	RECEIVE VARIABLE:C81($Var)  // "Lettre-type"
	If ($Var#"Lettre-type")
		ALERT:C41("le fichier ne semble pas être le bon...")
	Else 
		ARRAY TEXT:C222($TbChamps;4)
		
		RECEIVE VARIABLE:C81($Var)  // Une autre
		While ($Var="Une autre")
			RECEIVE VARIABLE:C81($ValeurA)
			$TbChamps{1}:=$ValeurA  // $NomLettre 
			
			RECEIVE VARIABLE:C81($ValeurA)
			$TbChamps{2}:=$ValeurA  // $TypePersonne
			
			RECEIVE VARIABLE:C81($ValeurA)
			$TbChamps{3}:=$ValeurA  // $TypeCourrier
			
			RECEIVE VARIABLE:C81($ValeurA)
			$TbChamps{4}:=$ValeurA  // $Descriptif
			
			RECEIVE VARIABLE:C81($Blob)  // Le blob
			
			QUERY:C277([CourrielsTypes:28];[CourrielsTypes:28]NomLettre:2=$TbChamps{1})
			If (Records in selection:C76([CourrielsTypes:28])=0)
				CREATE RECORD:C68([CourrielsTypes:28])
				[CourrielsTypes:28]NomLettre:2:=$TbChamps{1}
			End if 
			[CourrielsTypes:28]ContexteLettre:4:=Num:C11($TbChamps{2})
			[CourrielsTypes:28]Descriptif:3:=$TbChamps{4}
			[CourrielsTypes:28]TexteP2_:6:=$Blob
			SAVE RECORD:C53([CourrielsTypes:28])
			
			RECEIVE VARIABLE:C81($Var)  // "Une autre" ou "Fin"
			
		End while 
		SET CHANNEL:C77(11)
		ZAmnistiePartielle (->[CourrielsTypes:28])
		ALERT:C41("Importation des lettres-types achevée")
		
	End if 
End if 


If (False:C215)
	
	  // ----------------------------------------------------
	  // Nom utilisateur : cgm 
	  // Date et heure : 12/01/19, 14:59:26
	  // ----------------------------------------------------
	  // Méthode : ASAPExporteLettresTypes
	  // Description
	  // Méthode qui exporte vers ASAP
	  //  les lettres-types de GestAsa
	  // ----------------------------------------------------
	
	  //C_ENTIER LONG($Salé;$FT)
	  //C_BLOB($Blob)
	
	  //TOUT SÉLECTIONNER([LettresType])
	  //SÉLECTION VERS TABLEAU([LettresType]NomLettre;$TbNomLettre\
		;[LettresType]TypeAdhérent;$TbTypeAdhérent\
		;[LettresType]TypeCourrier;$TbTypeCourrier\
		;[LettresType]TexteP2_;$TbBlob\
		;[LettresType]Description;$TbDescription)
	  //RÉGLER SÉRIE(12;"")
	  //$Envoi:="Lettre-type"
	  //ENVOYER VARIABLE($Envoi)
	  //$FT:=Enregistrements trouvés([LettresType])
	  //Boucle ($Salé;1;$FT)
	  //$Envoi:="Une autre"
	  //ENVOYER VARIABLE($Envoi)
	
	  //$NomLettre:=$TbNomLettre{$Salé}
	  //ENVOYER VARIABLE($NomLettre)
	
	  //$TypePersonne:=$TbTypeAdhérent{$Salé}
	  //ENVOYER VARIABLE($TypePersonne)
	
	  //$TypeCourrier:=$TbTypeCourrier{$Salé}
	  //ENVOYER VARIABLE($TypeCourrier)
	
	  //$Descriptif:=$TbDescription{$Salé}
	  //ENVOYER VARIABLE($Descriptif)
	
	  //$Blob:=$TbBlob{$Salé}
	  //ENVOYER VARIABLE($Blob)
	
	  //Fin de boucle 
	
	  //$Envoi:="Fin"
	  //ENVOYER VARIABLE($Envoi)
	
	  //RÉGLER SÉRIE(11)
	  //ALERTE("Export achevé")
	
End if 
