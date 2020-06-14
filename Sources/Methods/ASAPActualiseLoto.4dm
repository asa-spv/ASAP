//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/02/19, 18:59:48
  // ----------------------------------------------------
  // Méthode : ASAPActualiseLoto
  // Description
  // Méthode qui actualise le champ [RAEMACampagnes]Arguments
  //   pour son argument "Loto" en fonction des [CampagneParticipations]
  // ----------------------------------------------------
ALL RECORDS:C47([CampagneParticipations:17])
DISTINCT VALUES:C339([CampagneParticipations:17]NumCampagne:3;$TbNumCampagnes)
$FT:=Size of array:C274($TbNumCampagnes)
READ WRITE:C146([RAEMACampagnes:20])
For ($Salé;1;$FT)
	$NumCampagneCourant:=$TbNumCampagnes{$Salé}
	$L:=0
	$L:=Find in array:C230(<>TbLotoNumCampagne;$NumCampagneCourant;($L+1))
	ARRAY LONGINT:C221($TbLotoN;0)
	While ($L>0)
		If (Find in array:C230($TbLotoN;<>TbLotoNumLaboRAEMA{$L})<0)
			APPEND TO ARRAY:C911($TbLotoN;<>TbLotoNumLaboRAEMA{$L})
		End if 
		$L:=Find in array:C230(<>TbLotoNumCampagne;$NumCampagneCourant;($L+1))
	End while 
	If (Size of array:C274($TbLotoN)>0)
		SORT ARRAY:C229($TbLotoN;>)
		QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagneCourant)
		OB SET ARRAY:C1227([RAEMACampagnes:20]Arguments:7;"Loto";$TbLotoN)
		SAVE RECORD:C53([RAEMACampagnes:20])
	End if 
End for 


