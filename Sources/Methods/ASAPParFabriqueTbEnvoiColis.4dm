//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 28/01/19, 08:02:48
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPParFabriqueTbEnvoiColis
  // Description
  // Remplit les tableaux du formulaire standard LBTableauxParticipation
  //   spécifique au suivi ces colis




  // Les tableaux intermédiaires
ARRAY TEXT:C222($TbUUIDLabo;0)
ARRAY OBJECT:C1221($TbArg;0)
SELECTION TO ARRAY:C260([CampagneParticipations:17]UUIDPersonne:2;$TbUUIDLabo\
;[CampagneParticipations:17]NumCampagne:3;TbNumCampagne\
;[CampagneParticipations:17]Arguments:5;$TbArg)
LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17];TbNumEnr)
$FT:=Size of array:C274($TbArg)

  // Les 10 tableaux du formulaire "LBTableauxParticipation"
ARRAY TEXT:C222(TbNomLabo;$FT)
ARRAY TEXT:C222(TbNumCampagne;$FT)
ARRAY TEXT:C222(TbTransporteur;$FT)
ARRAY TEXT:C222(TbProforma;$FT)
ARRAY TEXT:C222(TbNumLaboA;$FT)
ARRAY LONGINT:C221(TbNumLaboN;$FT)
ARRAY LONGINT:C221(TbNbColisSR;$FT)
ARRAY LONGINT:C221(TbNbColisAR;$FT)
ARRAY BOOLEAN:C223(TbSansPatho;$FT)

For ($Salé;1;$FT)
	$L:=Find in array:C230(<>TbPerUUID;$TbUUIDLabo{$Salé})
	
	  // N° de la participation
	$NumLaboCourant:=<>TbPerNumLaboRAEMAA{$L}
	$CodeRaemaLié:=OB Get:C1224($TbArg{$Salé};"CodeRaemaLié";Est un texte:K8:3)
	If ($CodeRaemaLié="")
		TbNumLaboA{$Salé}:=$NumLaboCourant
	Else 
		TbNumLaboA{$Salé}:=$NumLaboCourant+"-"+String:C10(RAEMADemoduleMdPWeb ($CodeRaemaLié))
	End if 
	TbNumLaboN{$Salé}:=<>TbPerNumLaboRAEMA{$L}
	  // Nom du labo
	If ($L<0)
		TbNomLabo{$Salé}:="-"
	Else 
		If (<>TbPerNomCourt{$L}="")
			TbNomLabo{$Salé}:=<>TbPerNomLong{$L}
		Else 
			TbNomLabo{$Salé}:=<>TbPerNomCourt{$L}
		End if 
	End if 
	$Identificateur:=<>TbPerNomCourt{$L}
	
	  // Transporteur
	TbTransporteur{$Salé}:=OB Get:C1224($TbArg{$Salé};"Transporteur";Est un texte:K8:3)  // ModeEnvoiColis ?
	If (TbTransporteur{$Salé}="")
		TbTransporteur{$Salé}:=<>TbPAModeEnvoiColis{$L}
	End if 
	
	
	  // Proforma
	If (OB Get:C1224($TbArg{$Salé};"Proforma";Est un texte:K8:3)#"")
		TbProforma{$Salé}:=OB Get:C1224($TbArg{$Salé};"Proforma";Est un texte:K8:3)
	Else 
		TbProforma{$Salé}:=<>TbPAProforma{$L}
	End if 
	TbNbColisSR{$Salé}:=OB Get:C1224($TbArg{$Salé};"NbreColisSupSansRapport";Est un entier:K8:5)
	TbNbColisAR{$Salé}:=OB Get:C1224($TbArg{$Salé};"NbreColisSupAvecRapport";Est un entier:K8:5)
	
	TbSansPatho{$Salé}:=OB Get:C1224($TbArg{$Salé};"SansPathogene";Est un booléen:K8:9)
	
End for 
SORT ARRAY:C229(TbNumLaboN;TbNumLaboA;TbNomLabo;TbNumCampagne;TbTransporteur;TbProforma;TbNbColisSR;TbNbColisAR;TbSansPatho;TbNumEnr;>)
VarNumEnrLabo:=Size of array:C274(TbNumLaboA)
