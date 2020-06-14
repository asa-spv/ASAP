CONFIRM:C162("Voulez-vous VRAIMENT supprimer la valeur "+PUMClassifRetour{PUMClassifRetour}+" ?????")
If (OK=1)
	READ WRITE:C146([XData:1])
	QUERY:C277([XData:1];[XData:1]XNom:2="Classification des retours";*)
	QUERY:C277([XData:1]; & [XData:1]XType:3="ClassificationRetours")
	
	Case of 
		: ([RetoursFiches:24]Domaine:6="Administratif")
			DELETE FROM ARRAY:C228(PUMClassAdmi;PUMClassifRetour)
			OB SET ARRAY:C1227([XData:1]XObjet:18;"Administratif";PUMClassAdmi)
			COPY ARRAY:C226(PUMClassAdmi;PUMClassifRetour)
			
		: ([RetoursFiches:24]Domaine:6="Informatique")
			DELETE FROM ARRAY:C228(PUMClassInfo;PUMClassifRetour)
			OB SET ARRAY:C1227([XData:1]XObjet:18;"Informatique";PUMClassInfo)
			COPY ARRAY:C226(PUMClassInfo;PUMClassifRetour)
			
		: ([RetoursFiches:24]Domaine:6="Qualité")
			DELETE FROM ARRAY:C228(PUMClassQual;PUMClassifRetour)
			OB SET ARRAY:C1227([XData:1]XObjet:18;"Qualité";PUMClassQual)
			COPY ARRAY:C226(PUMClassQual;PUMClassifRetour)
			
			
		: ([RetoursFiches:24]Domaine:6="Statistique")
			DELETE FROM ARRAY:C228(PUMClassStat;PUMClassifRetour)
			OB SET ARRAY:C1227([XData:1]XObjet:18;"Statistique";PUMClassStat)
			COPY ARRAY:C226(PUMClassStat;PUMClassifRetour)
			
			
		: ([RetoursFiches:24]Domaine:6="Technique")
			DELETE FROM ARRAY:C228(PUMClassTech;PUMClassifRetour)
			OB SET ARRAY:C1227([XData:1]XObjet:18;"Technique";PUMClassTech)
			COPY ARRAY:C226(PUMClassTech;PUMClassifRetour)
			
	End case 
	PUMClassifRetour:=Size of array:C274(PUMClassifRetour)-1
	
	$ListeAdm:=New list:C375
	ARRAY TO LIST:C287(PUMClassAdmi;$ListeAdm)
	$ListeInfo:=New list:C375
	ARRAY TO LIST:C287(PUMClassInfo;$ListeInfo)
	$ListeQual:=New list:C375
	ARRAY TO LIST:C287(PUMClassQual;$ListeQual)
	$ListeStat:=New list:C375
	ARRAY TO LIST:C287(PUMClassStat;$ListeStat)
	$ListeTech:=New list:C375
	ARRAY TO LIST:C287(PUMClassTech;$ListeTech)
	
	$ListeClass:=New list:C375
	APPEND TO LIST:C376($ListeClass;"Administratif";1;$ListeAdm;False:C215)
	APPEND TO LIST:C376($ListeClass;"Informatique";2;$ListeInfo;False:C215)
	APPEND TO LIST:C376($ListeClass;"Qualité";3;$ListeQual;False:C215)
	APPEND TO LIST:C376($ListeClass;"Statistique";4;$ListeTech;False:C215)
	APPEND TO LIST:C376($ListeClass;"Technique";5;$ListeTech;False:C215)
	LIST TO BLOB:C556($ListeClass;[XData:1]XBlob:13)
	
	SAVE RECORD:C53([XData:1])
	ZAmnistiePartielle (->[XData:1])
	
End if 