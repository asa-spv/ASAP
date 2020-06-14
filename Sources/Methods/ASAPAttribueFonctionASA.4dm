//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/07/19, 06:02:55
  // ----------------------------------------------------
  // Méthode : ASAPAttribueFonctionASA
  // Description
  // 
  //
  // Paramètre : $1 = Nom du groupe (AsaDia, AsaDia Gibier) 
  //                  ou de l'instance (CA, Bureau)
  // ----------------------------------------------------
$Instance:=$1
$Self:=OBJECT Get pointer:C1124(Objet courant:K67:2)
If ($Self->=1)
	OB SET:C1220([Personnes:12]Arguments:7;$Instance;True:C214)
Else 
	OB REMOVE:C1226([Personnes:12]Arguments:7;$Instance)
End if 