//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/01/18, 17:14:45
  // ----------------------------------------------------
  // Méthode : GA15InitTbDevisRAEMAGel
  // Description
  // Initialise les tableaux du formulaire projet DlgGestionDevisRaemaGel 
  //   contenant les devis à faire et les devis faits.
  // ----------------------------------------------------
C_LONGINT:C283($TT;$Salé;$FT)
$Normal:=Not:C34(Macintosh command down:C546)
  // $Pivot:=Date("15/12/"+Chaîne(Num(VarPermMilleRaemaGel)-1))
QUERY:C277([PersonnesDevis:30];[PersonnesDevis:30]AnneeDevis:5=<>AnCourantDevisRGN;*)
If ($Normal)
	QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Caduc:7#"Caduc@";*)
End if 
QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Valide:8=False:C215)
SELECTION TO ARRAY:C260([PersonnesDevis:30]UUIDPersonne:6;$Colonne1EC)
$FT:=Size of array:C274($Colonne1EC)
ARRAY LONGINT:C221(Colonne1EC;$FT)
For ($Salé;1;$FT)
	Colonne1EC{$Salé}:=Num:C11(ASAPTrouveNumeroLaboParUUID ($Colonne1EC{$Salé}))
End for 

LONGINT ARRAY FROM SELECTION:C647([PersonnesDevis:30];Colonne2N)
SORT ARRAY:C229(Colonne1EC;Colonne2N;>)
$TT:=Size of array:C274(Colonne1EC)
If ($TT=0)
	VarNbDevis:="Aucun devis"
Else 
	VarNbDevis:=String:C10($TT)+" devis"
End if 
  // CHERCHER([XData]; & [XData]XValeur=<>AnCourantDevisRGN;*)
QUERY:C277([PersonnesDevis:30];[PersonnesDevis:30]Caduc:7#"Caduc@";*)
QUERY:C277([PersonnesDevis:30]; & [PersonnesDevis:30]Valide:8=True:C214)

SELECTION TO ARRAY:C260([PersonnesDevis:30]UUIDPersonne:6;$TbDevisOK)
$FT:=Size of array:C274($TbDevisOK)
ARRAY LONGINT:C221(TbDevisOK;$FT)
For ($Salé;1;$FT)
	TbDevisOK{$Salé}:=Num:C11(ASAPTrouveNumeroLaboParUUID ($TbDevisOK{$Salé}))
End for 
LONGINT ARRAY FROM SELECTION:C647([PersonnesDevis:30];TbNumEnrOK)
SORT ARRAY:C229(TbDevisOK;TbNumEnrOK;>)

  // les ADILVA
QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"Association";=;"Adilva")
SELECTION TO ARRAY:C260([Personnes:12]Identificateur:4;$TbIdentificateur)
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGMai;*)
QUERY:C277([CampagneParticipations:17]; | [CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGDec)
QUERY SELECTION WITH ARRAY:C1050([CampagneParticipations:17]UUIDPersonne:2;$TbIdentificateur)
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLabo)
$FT:=Size of array:C274($TbUUIDLabo)
ARRAY LONGINT:C221(TbNumEnrDevisAdilva;$FT)
For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbPerUUID;$TbUUIDLabo{$Salé})
	TbNumEnrDevisAdilva{$Salé}:=<>TbPerNumLaboRAEMA{$L}
End for 
SORT ARRAY:C229(TbNumEnrDevisAdilva;>)

  // les compteurs
$TT:=Size of array:C274(TbDevisOK)
VarNbOK:=(Num:C11($TT>0)*(String:C10($TT)+" devis"))+(Num:C11($TT=0)*("Aucun devis"))
$TT:=Size of array:C274(TbNumEnrDevisAdilva)
VarNbAdilva:=(Num:C11($TT>0)*(String:C10($TT)+" devis"))+(Num:C11($TT=0)*("Aucun devis"))
VarNbTotal:=$TT+Size of array:C274(TbDevisOK)

LISTBOX SELECT ROW:C912(ListBoxNumLabo;0;lk supprimer de sélection:K53:3)
LISTBOX SELECT ROW:C912(ListBoxNumOK;0;lk supprimer de sélection:K53:3)
LISTBOX SELECT ROW:C912(ListBoxNumOK;0;lk supprimer de sélection:K53:3)