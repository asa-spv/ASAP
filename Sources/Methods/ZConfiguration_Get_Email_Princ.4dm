//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/05/18, 15:06:12
  // ----------------------------------------------------
  // Paramètres
  // $1 = Pointeur sur SMTP principal
  // $2 = Pointeur sur Expéditeur
  // $3 = Pointeur sur Destinataire
  // ----------------------------------------------------
  // Méthode : Configuration_Get_Email_Princip
  // Description
  //  


C_OBJECT:C1216($Config)
C_POINTER:C301($1;$2;$3;$STMP;$De;$A)
C_LONGINT:C283($Pos)

$STMP:=$1
$De:=$2
$A:=$3

QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
$Config:=[XData:1]XObjet:18

ARRAY TEXT:C222($TbSMTPHost;0x0000)
ARRAY LONGINT:C221($TbComptePrincipal;0x0000)

OB GET ARRAY:C1229($Config;"TbSMTPHost";$TbSMTPHost)
OB GET ARRAY:C1229($Config;"TbComptePrincipal";$TbComptePrincipal)
ZConfiguration_Get_Param ("sec_de";$De;1)
ZConfiguration_Get_Param ("sec_a";$A;1)

$Pos:=Find in array:C230($TbComptePrincipal;1)

$1->:=$TbSMTPHost{$Pos}


$2->:=$De->
$3->:=$A->