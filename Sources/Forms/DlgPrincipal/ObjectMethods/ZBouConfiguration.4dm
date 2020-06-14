C_OBJECT:C1216($Config)
QUERY BY FORMULA:C48([XData:1];([XData:1]XType:3="Configuration") & ([XData:1]XNom:2="Configuration"))
$Config:=OB Copy:C1225([XData:1]XObjet:18)
ZOuvrirFenetre ("DlgParametresBase";Form dialogue modal:K39:7;->$Config)