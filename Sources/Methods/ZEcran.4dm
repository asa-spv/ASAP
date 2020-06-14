//%attributes = {"publishedWeb":true}
  // Modifié par : Association QualiSoft (03/05/2018)
  // 
  // ZEcran 6.0  du 12/8/98 méthode de démarrage du process majeur
  // appelée par Zdebut
  // lance les méthodes ZDémarre ,  ZAttente , ZDormeur et ZPipelette

C_LONGINT:C283(<>ZNPM;<>ZNPT;<>ZNPA;<>ZNPP)

<>ZNPP:=New process:C317("ZProcessPipeletteLocal";0;"Pipelette";*)

<>ZNPM:=New process:C317("ZProcessDemarre";0;"Majeur";*)

<>ZNPT:=New process:C317("ZProcessTdFLocal";0;"Tache de Fond";*)

<>ZNPI:=New process:C317("ZProcessIdentification";0;"Gestion Identification";*)

BRING TO FRONT:C326(<>ZNPM)  // permet d'afficher le process Majeur
HIDE TOOL BAR:C434