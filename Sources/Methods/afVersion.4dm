//%attributes = {}
C_LONGINT:C283($0)
C_TEXT:C284($UUID)
$0:=2018

If (False:C215)
	$L:=Find in array:C230(<>TbPerUUID;$UUID)
	$NomLabo:=<>TbPerNomLong{$L}
	QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$UUID)
	$NumProcess:=Execute on server:C373("Ma Méthode";0)
	  // Modifié par : iMacASA2017 (16/06/2018)
	  // Création du nouveau programme à partir du standard
End if 