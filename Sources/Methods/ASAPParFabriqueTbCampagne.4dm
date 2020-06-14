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


  // Les 10 tableaux du formulaire "LBTableauxParticipation"
ARRAY TEXT:C222(TbNomLabo;0)
ARRAY TEXT:C222(TbNumCampagne;0)
ARRAY TEXT:C222(TbTransporteur;0)
ARRAY TEXT:C222(TbProforma;0)
ARRAY TEXT:C222(TbNumLaboA;0)
ARRAY LONGINT:C221(TbNumLaboN;0)
ARRAY LONGINT:C221(TbNbColisSR;0)
ARRAY LONGINT:C221(TbNbColisAR;0)
ARRAY LONGINT:C221(TbNumEnr;0)
ARRAY BOOLEAN:C223(TbSansPatho;0)

$NumCampagne:=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
$Test:="@_"+$NumCampagne+"_"
$L:=0
Repeat 
	$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$Test;($L+1))
	If ($L>0)
		APPEND TO ARRAY:C911(TbNumCampagne;$NumCampagne)
		$L2:=Find in array:C230(<>TbPerUUID;<>TbLotoUUIDLabo{$L})
		APPEND TO ARRAY:C911(TbNomLabo;(<>TbPerNomLong{$L2}+" "+<>TbPerAdrLivCP{$L2}+"-"+<>TbPerAdrLivVille{$L2}))
		
		APPEND TO ARRAY:C911(TbNumLaboA;String:C10(<>TbLotoNumLaboRAEMA{$L}))
		APPEND TO ARRAY:C911(TbNumLaboN;<>TbLotoNumLaboRAEMA{$L})
		APPEND TO ARRAY:C911(TbNbColisSR;<>TbLotoNbColisPoudreSR{$L})
		APPEND TO ARRAY:C911(TbNbColisAR;<>TbLotoNbColisPoudreAR{$L})
		APPEND TO ARRAY:C911(TbTransporteur;<>TbLotoTransporteur{$L})
		APPEND TO ARRAY:C911(TbSansPatho;<>TbLotoSansPathogene{$L})
		If ($NumCampagne="@a")
			APPEND TO ARRAY:C911(TbProforma;<>TbLotoProformaGel{$L})
		Else 
			APPEND TO ARRAY:C911(TbProforma;<>TbLotoProformaPoudre{$L})
		End if 
		APPEND TO ARRAY:C911(TbNumEnr;<>TbLotoNumEnrParticipation{$L})
	End if 
Until ($L<0)
SORT ARRAY:C229(TbNumLaboN;TbNumLaboA;TbNomLabo;TbNumCampagne;TbTransporteur;TbProforma;TbNbColisSR;TbNbColisAR;TbSansPatho;TbNumEnr;>)
VarNumEnrLabo:=Size of array:C274(TbNumLaboA)