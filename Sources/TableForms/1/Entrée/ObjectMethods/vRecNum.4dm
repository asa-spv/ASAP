C_TEXT:C284($vRecNum)
$vRecNum:=Choose:C955(Selected record number:C246(Current form table:C627->)<0;"";String:C10(Selected record number:C246(Current form table:C627->))+" / "+String:C10(Records in selection:C76(Current form table:C627->)))
(OBJECT Get pointer:C1124(Objet nommé:K67:5;"vRecNum"))->:=$vRecNum