//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 25/07/18, 05:25:40
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RaemaSchemaMFDlgChargement
  // Description
  // 

C_LONGINT:C283($Salé;$FT)
ZAmnistieInternationale 
RaemaSchemaAffichePUMTbNR 

  // Trouvons la prochaine campagne
OBJECT SET VISIBLE:C603(*;"poudre@";(<>NumCampagneEnCoursSaisie#"@a"))
$Contavisible:=(TbNR{TbNR}="@a") & (<>NumCampagneEnCoursSaisie=TbNR{TbNR})
OBJECT SET VISIBLE:C603(*;"gel@";$Contavisible)
If (<>NumCampagneEnCoursSaisie="@a")
	$ProchCampagne:=String:C10(Num:C11(<>NumCampagneEnCoursSaisie)+1)
Else 
	$ProchCampagne:=<>NumCampagneEnCoursSaisie+"A"
End if 
TbNR:=Find in array:C230(TbNR;$ProchCampagne)
If (TbNR=-1)
	TbNR:=Find in array:C230(TbNR;<>NumCampagneEnCoursSaisie)
End if 
RaemaSchemaPUMCampagne 
ARRAY LONGINT:C221(TbNECopierLigne;0)
ARRAY LONGINT:C221(TbNECopierValeur;0)


  // Page 4 = tableaux de correspondance des noms de germe du RAEMA gel
$FT:=Size of array:C274(<>TbNomGermeSchémaGEL)
ARRAY TEXT:C222(TbParticipeGermeGEL;$FT)
ARRAY TEXT:C222(TbLotoGermeGELNCGSR;$FT)
ARRAY TEXT:C222(TbLotoGermeGELNCGAR;$FT)
For ($Salé;1;$FT)
	RESOLVE POINTER:C394(<>TbPtTbParticipeGermeGEL{$Salé};$nomVar;$NumTable;$NumChamp)
	TbParticipeGermeGEL{$Salé}:=$nomVar
	RESOLVE POINTER:C394(<>TbPtTbLotoGermeGELNCGSR{$Salé};$nomVar;$NumTable;$NumChamp)
	TbLotoGermeGELNCGSR{$Salé}:=$nomVar
	RESOLVE POINTER:C394(<>TbPtTbLotoGermeGELNCGAR{$Salé};$nomVar;$NumTable;$NumChamp)
	TbLotoGermeGELNCGAR{$Salé}:=$nomVar
End for 
ALL RECORDS:C47([RAEMAGermes:21])
SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;TbTousLesNomsDeGermes)

$TT:=Size of array:C274(TbNomGermeFr)
If ($TT=0)
	OBJECT SET VISIBLE:C603(*;"@Comp";False:C215)
End if 





