//%attributes = {}
Case of 
	: (BRI=1)
		[RetoursFiches:24]Domaine:6:="Informatique"
		COPY ARRAY:C226(PUMClassInfo;PUMClassifRetour)
	: (BRT=1)
		[RetoursFiches:24]Domaine:6:="Technique"
		COPY ARRAY:C226(PUMClassTech;PUMClassifRetour)
	: (BRA=1)
		[RetoursFiches:24]Domaine:6:="Administratif"
		COPY ARRAY:C226(PUMClassAdmi;PUMClassifRetour)
	: (BRS=1)
		[RetoursFiches:24]Domaine:6:="Statistique"
		COPY ARRAY:C226(PUMClassStat;PUMClassifRetour)
	: (BRQ=1)
		[RetoursFiches:24]Domaine:6:="Qualité"
		COPY ARRAY:C226(PUMClassQual;PUMClassifRetour)
End case 
OBJECT SET VISIBLE:C603(PUMClassifRetour;True:C214)
