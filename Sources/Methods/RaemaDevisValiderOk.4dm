//%attributes = {}
READ WRITE:C146([CampagneParticipations:17])
READ WRITE:C146([CampagneGelGermes:25])
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGMai;*)
QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGDec;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)  // sélection des [CampagneGelGermes]
DELETE SELECTION:C66([CampagneGelGermes:25])
DELETE SELECTION:C66([CampagneParticipations:17])
READ ONLY:C145([CampagneParticipations:17])
READ ONLY:C145([CampagneGelGermes:25])

If (Size of array:C274(TbNomGermeMai)>0)
	ASAPDevisCreationCampagne (<>CampagneDevisRGMai)
End if 

If (Size of array:C274(TbNomGermeDec)>0)
	ASAPDevisCreationCampagne (<>CampagneDevisRGDec)
End if 

READ WRITE:C146([PersonnesDevis:30])
GOTO RECORD:C242([PersonnesDevis:30];Colonne2N{LigneCliqueDansBDDevis})
[PersonnesDevis:30]Valide:8:=True:C214
[PersonnesDevis:30]QuiValideQuand:10:=[PersonnesDevis:30]QuiValideQuand:10+"Le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)+" le devis a été validé par "+<>ZQuiVaLa
SAVE RECORD:C53([PersonnesDevis:30])
  // GA15RaemaGelActualiseLoto(VarPermMilleRaemaGel)

  // Rendre caducs les devis du même laboratoire
  //$Pivot:=Date("15/12/"+Chaîne(Num(VarPermMilleRaemaGel)-1))
$UUID:=ASAPTrouveUUIDLaboParNumero (Colonne1EC{Colonne1EC})
QUERY:C277([PersonnesDevis:30];[PersonnesDevis:30]UUIDPersonne:6=$UUID;*)  // même labo
  // CHERCHER([XData];&[XData]XDate>$Pivot;*)
QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Valide:8=False:C215;*)
QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Caduc:7="")
APPLY TO SELECTION:C70([PersonnesDevis:30];[PersonnesDevis:30]Caduc:7:="Caduc par doublon")

  //LISTBOX SUPPRIMER LIGNES(ListBoxNumLabo;ListBoxNumLabo)
ZViderSelectionCourante (->[PersonnesDevis:30])

  // ZAmnistieInternationale 
GA13RaemaGelGrilleInit 
GA15FabriqueTbDevisRAEMAGel 
LISTBOX SELECT ROW:C912(*;"ListBoxNumLabo";0;lk supprimer de sélection:K53:3)