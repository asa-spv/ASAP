//%attributes = {"publishedWeb":true}
  //  ZDétruitPas V11 du 14/08/2010
  // MP appelée sur erreur de ZAdieuEnr

gerror:=error
gOK:=OK

CANCEL TRANSACTION:C241
ADD TO SET:C119(ZPtTable->;"Sauves")
DIFFERENCE:C122("Peloton";"sauves";"Peloton")
