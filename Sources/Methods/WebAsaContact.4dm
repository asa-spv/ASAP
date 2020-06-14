//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/01/16, 14:30:16
  // ----------------------------------------------------
  // Méthode : WebAsaContact
  // Description
  // Reçoit une requete AJAX de type "asacontact42"
  //  
  // Paramètre : $1 = requête
  // ----------------------------------------------------


$NumAC:=Substring:C12($1;11)
READ WRITE:C146([XData:1])
ARRAY TEXT:C222(<>TbAsaContactIP;0)
ARRAY DATE:C224(<>TbAsaContactDate;0)
$Test:="WebAsaContact"+$NumAC
QUERY:C277([XData:1];[XData:1]XNom:2=$Test;*)
QUERY:C277([XData:1]; & [XData:1]XType:3="ACo")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:=$Test
	[XData:1]XType:3:="ACo"
	[XData:1]XValeur:7:=Num:C11($NumAC)
	ZVariableVersBlob (->[XData:1]XBlob:13;-><>TbAsaContactIP;-><>TbAsaContactDate)
	SAVE RECORD:C53([XData:1])
Else 
	ZBlobVersVariable (->[XData:1]XBlob:13;-><>TbAsaContactIP;-><>TbAsaContactDate)
End if 
If (Find in array:C230(<>TbAsaContactIP;IP)<0)
	[XData:1]XEntier:6:=[XData:1]XEntier:6+1
	APPEND TO ARRAY:C911(<>TbAsaContactIP;IP)
	APPEND TO ARRAY:C911(<>TbAsaContactDate;Current date:C33)
	ZVariableVersBlob (->[XData:1]XBlob:13;-><>TbAsaContactIP;-><>TbAsaContactDate)
	SAVE RECORD:C53([XData:1])
	<>WebAsaContact:=AsaContactCompte 
End if 
  // APPELER PROCESS(-1)
ZAmnistiePartielle (->[XData:1];True:C214)