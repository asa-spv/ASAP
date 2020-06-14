//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 20/03/20, 14:33:44
  // ----------------------------------------------------
  // Méthode : TransfertDataDemDev
  // Description
  // Transfère les données contenues dans XDate de XType=Demdev
  // vers la table PersonneDevis
  // ----------------------------------------------------
READ WRITE:C146([PersonnesDevis:30])
ALL RECORDS:C47([PersonnesDevis:30])
DELETE SELECTION:C66([PersonnesDevis:30])

QUERY:C277([XData:1];[XData:1]XType:3="Demdev")
If (Records in selection:C76([XData:1])>0)
	$FT:=Records in selection:C76([XData:1])
	For ($Salé;1;$FT)
		  // LECTURE ÉCRITURE([PersonnesDevis])
		CREATE RECORD:C68([PersonnesDevis:30])
		[PersonnesDevis:30]AnneeDevis:5:=[XData:1]XValeur:7
		[PersonnesDevis:30]DateDevis:3:=[XData:1]XDate:4
		[PersonnesDevis:30]HeureDevis:4:=[XData:1]XHeure:5
		[PersonnesDevis:30]NomLabo:2:=[XData:1]XNom:2
		[PersonnesDevis:30]Valide:8:=[XData:1]XBool:14
		[PersonnesDevis:30]QuiValideQuand:10:=[XData:1]XTexte:9
		ARRAY TEXT:C222($TbNoms;0)
		ARRAY TEXT:C222($TbValeurs;0)
		ZBlobVersVariable (->[XData:1]XBlob:13;->$TbNoms;->$TbValeurs)
		If ([XData:1]XAlpha:8="Caduc@")
			[PersonnesDevis:30]Caduc:7:=[XData:1]XAlpha:8
		End if 
		
		If ([XData:1]XNom:2="Demande de devis labo ") | ([XData:1]XAlpha:8="Caduc@")
			NEXT RECORD:C51([XData:1])
		Else 
			[PersonnesDevis:30]UUIDPersonne:6:=[XData:1]XAlpha:8
			OB SET ARRAY:C1227([PersonnesDevis:30]Arguments:9;"TbNoms";$TbNoms)
			OB SET ARRAY:C1227([PersonnesDevis:30]Arguments:9;"TbValeurs";$TbValeurs)
			
			  //[PersonnesDevis]Arguments:=[XData]XBlob
			SAVE RECORD:C53([PersonnesDevis:30])
			NEXT RECORD:C51([XData:1])
		End if 
		
	End for 
End if 
ALERT:C41("Transformation effectuée")
ZAmnistieInternationale 