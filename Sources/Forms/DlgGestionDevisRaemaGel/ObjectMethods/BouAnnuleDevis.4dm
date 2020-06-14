If (Colonne1EC=0)
	ALERT:C41("Merci de sélectionner le devis à abandonner...")
Else 
	$NumLaboA:=String:C10(Colonne1EC{Colonne1EC})
	$Message:="ATTENTION : "+<>ZCR+"Vous êtes sur le point d'abandonner le devis du laboratoire n°"+$NumLaboA+"."+<>ZCR
	$Message:=$Message+"Cela signifie que ce laboratoire ne souhaite pas participer au RAEMA "+<>AnCourantDevisRGA
	$Message:=$Message+" et que vous ne voulez plus le voir dans les tableaux des devis."
	$Message:=$Message+<>ZCR2+" Cliquez sur OK pour décider si telle est bien votre volonté"
	ALERT:C41($Message)
	CONFIRM:C162("Abandonner le devis RAEMA gel pour le labo "+$NumLaboA+" ???")
	If (OK=1)
		READ WRITE:C146([PersonnesDevis:30])
		GOTO RECORD:C242([PersonnesDevis:30];Colonne2N{Colonne1EC})
		[PersonnesDevis:30]Valide:8:=False:C215
		[PersonnesDevis:30]Caduc:7:="Caduc par abandon"
		SAVE RECORD:C53([PersonnesDevis:30])
		$UUIDLabo:=ASAPTrouveUUIDLaboParNumero (Num:C11($NumLaboA))
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGMai;*)
		QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGDec;*)
		QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=$UUIDLabo)
		READ WRITE:C146([CampagneGelGermes:25])
		RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)
		DELETE SELECTION:C66([CampagneGelGermes:25])
		DELETE SELECTION:C66([CampagneParticipations:17])
		ZAmnistiePartielle (->[CampagneGelGermes:25])
		ZAmnistiePartielle (->[CampagneParticipations:17])
		GA15FabriqueTbDevisRAEMAGel 
		
		  // Rendre caducs les devis du même laboratoire
		  //$Pivot:=Date("15/12/"+Chaîne(Num(VarPermMilleRaemaGel)-1))
		QUERY:C277([PersonnesDevis:30];[PersonnesDevis:30]UUIDPersonne:6=Colonne1EC{Colonne1EC};*)  // même n° de labo
		  // CHERCHER([XData];&[XData]XDate>$Pivot;*)
		QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Valide:8=False:C215)
		APPLY TO SELECTION:C70([PersonnesDevis:30];[PersonnesDevis:30]Caduc:7:="Caduc par doublon")
		  //LISTBOX SUPPRIMER LIGNES(ListBoxNumLabo;ListBoxNumLabo)
		ZViderSelectionCourante (->[PersonnesDevis:30])
		GA15FabriqueTbDevisRAEMAGel 
		
	End if 
End if 