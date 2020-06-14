NumLaboA:=String:C10(VarNumLaboRAEMA)
CodeRAEMA:=[Personnes:12]Identificateur:4
VarAdresse:=[Personnes:12]NomLong:2
VarAdresse:=VarAdresse+<>ZCR+[PersonnesAdresses:11]LigneAdresse1:3
If ([PersonnesAdresses:11]LigneAdresse2:4#"")
	VarAdresse:=VarAdresse+<>ZCR+[PersonnesAdresses:11]LigneAdresse2:4
End if 
If ([PersonnesAdresses:11]LigneAdresse3:5#"")
	VarAdresse:=VarAdresse+<>ZCR+[PersonnesAdresses:11]LigneAdresse3:5
End if 
If ([PersonnesAdresses:11]Ville:7#"") & ([PersonnesAdresses:11]CodePostal:6#"")
	VarAdresse:=VarAdresse+<>ZCR+[PersonnesAdresses:11]CodePostal:6+" - "+[PersonnesAdresses:11]Ville:7
End if 
If ([PersonnesAdresses:11]Pays:8#"") & ([PersonnesAdresses:11]Pays:8#"France")
	VarAdresse:=VarAdresse+<>ZCR+[PersonnesAdresses:11]Pays:8
End if 