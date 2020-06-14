//%attributes = {}
  // RapRègleCadran
$TTMNE:=Size of array:C274(TbRapMailNonEnvoi)
$TTME:=Size of array:C274(TbRapMailEnvoi)
CadMailNonEnv:=(100*$TTMNE)/($TTMNE+$TTME)
CadMailEnv:=(100*$TTME)/($TTMNE+$TTME)
$TTRNP:=Size of array:C274(TbRapportsNonPris)
$TTRP:=Size of array:C274(TbRapportsPris)
CadRapNonEnv:=0
CadRapEnv:=0
If ($TTRNP>0)
	CadRapNonEnv:=(100*$TTRNP)/($TTRNP+$TTRP)
	CadRapEnv:=(100*$TTRP)/($TTRNP+$TTRP)
End if 