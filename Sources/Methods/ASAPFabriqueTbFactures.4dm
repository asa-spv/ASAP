//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 23/07/19, 18:13:10
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueTbFactures
  // Description
  // Méthode qui fabrique les tableaux  
  //   de gestion stantard des factures
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)

SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;TbNumFactureASA\
;[Factures:15]DateFacture:4;TbDateFactureASA\
;[Factures:15]TotalHT:8;TbHTFactureASA\
;[Factures:15]TotalTTC:10;TbTTCFactureASA\
;[Factures:15]TotalTVA:9;TbTVAFactureASA\
;[Factures:15]Regle:12;$TbRegléeFactureASA\
;[Factures:15]UUIDPersonne:2;$TbUUIDFactureASA)
LONGINT ARRAY FROM SELECTION:C647([Factures:15];TbNumEnr)

$FT:=Size of array:C274($TbUUIDFactureASA)
ARRAY TEXT:C222(TbNomPersonneFacture;$FT)
ARRAY TEXT:C222(TbRegléeFactureASA;$FT)
ARRAY LONGINT:C221(TbCouleurFondReglefacture;$FT)
$GrisClair:=0x00D0CECE  // Gris clair
$OrangeSombre:=0x00FF8000  // Orange sombre
$Vert:=0xFF00  // Vert franc

For ($Salé;1;$FT)
	
	  // Affichage du nom de la personne
	$L:=Find in array:C230(<>TBPERUUID;$TbUUIDFactureASA{$Salé})
	If ($L>0)
		TbNomPersonneFacture{$Salé}:=<>TBPERNOMLONG{$L}
	Else 
		TbNomPersonneFacture{$Salé}:=""
	End if 
	
	  // Affichege du réglement de la facture
	Case of 
		: (TbNumFactureASA{$Salé}="@A")
			TbRegléeFactureASA{$Salé}:="AVOIR"
			TbCouleurFondReglefacture{$Salé}:=$GrisClair
			
			
		: (TbNumFactureASA{$Salé}="@D")
			TbRegléeFactureASA{$Salé}:="DEVIS"
			TbCouleurFondReglefacture{$Salé}:=$GrisClair
			
			
		: ($TbRegléeFactureASA{$Salé})
			TbRegléeFactureASA{$Salé}:="OUI"
			TbCouleurFondReglefacture{$Salé}:=$Vert
		Else 
			TbRegléeFactureASA{$Salé}:="NON"
			TbCouleurFondReglefacture{$Salé}:=$OrangeSombre
	End case 
	
End for 
