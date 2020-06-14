If (CaCFactureMultiple=0)
	FSCasa1:=0
	FSCasa2:=0
	FSCasa3:=0
	FSCasa4:=0
	FSCasa5:=0
	FSCasa6:=0
	FSCasa7:=0
	FSCasa8:=0
	FSCasa9:=0
	FSCasa10:=0
	FSCasa11:=0
	FSCasa12:=0
	OB REMOVE:C1226([Personnes:12]Arguments:7;"PayeDeuxFois")
Else 
	OB SET:C1220([Personnes:12]Arguments:7;"PayeDeuxFois";"Vrai")
	FSCasa5:=1
	FSCasa12:=1
End if 
GA13AffecteCodeFacturation 

OBJECT SET VISIBLE:C603(*;"FSCas@";(CaCFactureMultiple=1))