//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/07/18, 17:37:39
  // ----------------------------------------------------
  // Méthode : GAFabriqueTableauRaemaGel
  // Description
  // 
  //
  // Paramètre : $1=Vrai si on fixe l'année en cours comme référence 
  // et faux si on tient compte du PUMAn
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)


$AnCourantA:=PUMAnRaemaGel{PUMAnRaemaGel}
$AnCourantN:=Num:C11($AnCourantA)
CampagneMai:=RaemaTrouveNumCampagneParAn ($AnCourantN;2)
$Titre:="Mai ("+CampagneMai+")"
OBJECT SET TITLE:C194(*;"ZdGMai";$Titre)
$NumLabo:=WebTrouveValeurParNom ([Personnes:12]Identificateur:4;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMAA)
$TestMai:=$NumLabo+"_"+CampagneMai+"_"+"@"
$LigneMai:=Find in array:C230(<>TbLotoIdentifiantParticipation;$TestMai)
CampagneDécembre:=RaemaTrouveNumCampagneParAn ($AnCourantN;4)
$Titre:="Décembre ("+CampagneDécembre+")"
OBJECT SET TITLE:C194(*;"ZdGDecembre";$Titre)
$TestDécembre:=$NumLabo+"_"+CampagneDécembre+"_"+"@"
$LigneDécembre:=Find in array:C230(<>TbLotoIdentifiantParticipation;$TestDécembre)

  // Le modèle de Proforma Gel
PUMProformaGel:=1  // pas de modèle a priori
$Proforma:=WebTrouveValeurParNom ($TestMai;-><>TbLotoIdentifiantParticipation;-><>TbLotoProformaGel)
If ($Proforma="")
	$Proforma:=WebTrouveValeurParNom ($TestDécembre;-><>TbLotoIdentifiantParticipation;-><>TbLotoProformaGel)
End if 
If ($Proforma="")
	$Proforma:=OB Get:C1224([Personnes:12]Arguments:7;"ProformaRG";Est un texte:K8:3)
End if 
If ($Proforma#"")
	PUMProformaGel:=Find in array:C230(PUMProformaGel;$Proforma)
End if 

  // Le bon de commande Gel
VarNumBdCGel:=OB Get:C1224([Personnes:12]Arguments:7;"RGNumBonCommande"+$AnCourantA;Est un texte:K8:3)

  // Le transporteur
VarMaiTransport:=OB Get:C1224([Personnes:12]Arguments:7;"RGTransporteur"+CampagneMai;Est un texte:K8:3)
VarDecembreTransport:=OB Get:C1224([Personnes:12]Arguments:7;"RGTransporteur"+CampagneDécembre;Est un texte:K8:3)

  // LES GERMES
  // Mai
  // Fabrication des tableaux des RAEMA gel (TbNomGermeMai, TbNbGelSSRMai, TbNbGelSARMai)
  // Initialisons les  tableaux 
ARRAY TEXT:C222(TbNomGermeMai;0)
ARRAY LONGINT:C221(TbNbGelSSRMai;0)
ARRAY LONGINT:C221(TbNbGelSARMai;0)

  // remplissons les tableaux
ASAPPerFabriqueTbGel (CampagneMai)
ASAPPerFabriqueTbGel (CampagneDécembre)

If (False:C215)
	  // Décembre (idem Mai)
	ARRAY TEXT:C222(TbNomGermeDec;0)
	ARRAY LONGINT:C221(TbNbGelSSRDec;0)
	ARRAY LONGINT:C221(TbNbGelSARDec;0)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=CampagneDécembre;*)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";=;Null:C1517)
	RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)
	SELECTION TO ARRAY:C260([CampagneGelGermes:25]NomDuGerme:3;TbNomGermeDec\
		;[CampagneGelGermes:25]NbreColisSupAvecRapport:5;TbNbGelSARDec\
		;[CampagneGelGermes:25]NbreColisSupSansRapport:4;TbNbGelSSRDec)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=CampagneDécembre;*)
	QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
	VarDecNRL:=""
	If (Records in selection:C76([CampagneParticipations:17])>0)
		ARRAY OBJECT:C1221($TbArgument;0)
		SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArgument)
		$FT:=Size of array:C274($TbArgument)
		
		For ($Salé;1;$FT)
			VarDecNRL:=VarDecNRL+","+OB Get:C1224($TbArgument{$Salé};"CodeRaemaLié";Est un texte:K8:3)
		End for 
		VarDecNRL:=Substring:C12(VarDecNRL;2)
	End if 
	OBJECT SET VISIBLE:C603(*;"VarDecNRL@";(VarDecNRL#""))
	
End if 

