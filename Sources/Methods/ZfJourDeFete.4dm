//%attributes = {"publishedWeb":true}
  //ZfJourDeFete 
  // décrit, pour une année donnée les jours de fête français
ARRAY DATE:C224(TbDatesFériées;12)
VarPaques:=ZFeteDePaques (VarAnnée)
TbDatesFériées{1}:=VarPaques
VarLundiDePaques:=VarPaques+1
TbDatesFériées{2}:=VarLundiDePaques
VarAscension:=VarPaques+39
TbDatesFériées{3}:=VarAscension
VarPendecote:=VarPaques+49
TbDatesFériées{4}:=VarPendecote
VarLundiDePendecote:=VarPendecote+1
TbDatesFériées{5}:=VarLundiDePendecote
$An:=String:C10(VarAnnée)
VarNouvelAn:=Date:C102("01/01/"+$An)
TbDatesFériées{6}:=VarNouvelAn
VarPermierMai:=Date:C102("01/05/"+$An)
TbDatesFériées{7}:=VarPermierMai
VarHuitMai:=Date:C102("08/05/"+$An)
TbDatesFériées{8}:=VarHuitMai
VarQuinzeAout:=Date:C102("15/08/"+$An)
TbDatesFériées{9}:=VarQuinzeAout
VarOnzeNovembre:=Date:C102("11/11/"+$An)
TbDatesFériées{10}:=VarOnzeNovembre
VarNoel:=Date:C102("25/12/"+$An)
TbDatesFériées{11}:=VarNoel
Var14Juillet:=Date:C102("14/07/"+$An)
TbDatesFériées{12}:=Var14Juillet
VarJDLA:=<>ZTbNomDuJour{Day number:C114(VarNouvelAn)}
VarPM:=<>ZTbNomDuJour{Day number:C114(VarPermierMai)}
VarHM:=<>ZTbNomDuJour{Day number:C114(VarHuitMai)}
VarQA:=<>ZTbNomDuJour{Day number:C114(VarQuinzeAout)}
VarON:=<>ZTbNomDuJour{Day number:C114(VarOnzeNovembre)}
VarN:=<>ZTbNomDuJour{Day number:C114(VarNoel)}
varQJ:=<>ZTbNomDuJour{Day number:C114(Var14Juillet)}