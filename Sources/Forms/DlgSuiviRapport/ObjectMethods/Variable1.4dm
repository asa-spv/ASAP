READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XNom:2="Texte du courriel";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="Rap")
[XData:1]XTexte:9:=VarTexteCourriel
[XData:1]XAlpha:8:=VarObjetCourriel
SAVE RECORD:C53([XData:1])

QUERY:C277([XData:1];[XData:1]UUID:1="Texte du courriel2";*)
QUERY:C277([XData:1]; & [XData:1]XHeure:5="Rap")
[XData:1]XTexte:9:=VarTexteCourriel2
[XData:1]XAlpha:8:=VarObjetCourriel2
SAVE RECORD:C53([XData:1])
ZAmnistiePartielle (->[XData:1])