//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/01/17, 11:10:33
  // ----------------------------------------------------
  // Méthode : GA13RaemaGelValiderDevis
  // Description
  // Valide le devis affiché dans "DlgGestionDevisRaemaGel"
  //  d'après les renseignements communiqués par le Web
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
C_OBJECT:C1216($ArgumentCampagne)
If (VarNom="")
	ALERT:C41("Désignez le laboratoire concerné, SVP...")
Else 
	$NumLabo:=Num:C11(ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1))
	$UUIDLabo:=[Personnes:12]UUID:1
	$L:=Find in array:C230(TbDevisOK;$NumLabo)
	
	Case of 
		: ([Personnes:12]NomLong:2="")  // Nouveau laboratoire
			ASAPDevisCréationNouveauLabo 
			
		: $L>0
			CONFIRM:C162("Un devis a déjà été validé pour ce laboratoire, souhaitez-vous supprimer le devis précédemment validé et valider celui-ci à la place ?")
			If (ok=1)
				DELETE FROM ARRAY:C228(TbDevisOK;$L)
				QUERY:C277([PersonnesDevis:30];[PersonnesDevis:30]UUIDPersonne:6=$UUIDLabo;*)
				QUERY:C277([PersonnesDevis:30]; & ;[PersonnesDevis:30]Valide:8=True:C214)
				READ WRITE:C146([PersonnesDevis:30])
				[PersonnesDevis:30]Valide:8:=False:C215
				[PersonnesDevis:30]Caduc:7:="Caduc par validation d'un nouveau devis"
				SAVE RECORD:C53([PersonnesDevis:30])
				RaemaDevisValiderOk 
			Else 
				ALERT:C41("Conformément à votre demande, le devis du laboratoire sélectionné n'a pas été validé")
			End if 
			
		Else   // le laboratoire existe, supprimons les programmes de mai et de décembre antérieurs
			RaemaDevisValiderOk 
	End case 
End if 