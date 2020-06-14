C_OBJECT:C1216(VarObjetDescriptifInital;VarObjetDescriptifFinal)
C_TEXT:C284(VarRapportComparaison)
VarObjetDescriptifInital:=OB Get:C1224([PersonnesModifications:29]ObjetModification:7;"DescriptifInital")
VarObjetDescriptifFinal:=OB Get:C1224([PersonnesModifications:29]ObjetModification:7;"DescriptifFinal")
ASAPLaboObjetDescriptifCompare 
[PersonnesModifications:29]TexteModification:6:=VarRapportComparaison