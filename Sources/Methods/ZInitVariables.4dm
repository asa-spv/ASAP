//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/04/18, 07:44:12
  // ----------------------------------------------------
  // Paramètre
  // Pas de paramètres
  // ----------------------------------------------------
  // Méthode : ZInitVariables
  // Description
  // Méthode qui initialise les variables standard
  //. ou non standard = utiliser ZMAJDeclareVar pour les mises à jour
  // ----------------------------------------------------


  // gestion des 20 colonnes des LB d'affichage de sélection
C_LONGINT:C283(tLB1;tLB2;tLB3;tLB4;tLB5;tLB6;tLB7;tLB8;tLB9;tLB10;tLB11;tLB12;tLB13;tLB14;tLB15;tLB16;tLB17;tLB18;tLB19;tLB20)

  // Les Tableaux standard non <> sinon ZDéclareVarDiamant
ZInitPopUp 


  // Les variables de ASAP

  //  ZMAJDéclareVar 6.0 du 27/8/98
  //   sert à placer les déclaration des variables crées hors standard



  //pour autoriser la saisie du RAEMA
QUERY:C277([XData:1];[XData:1]XNom:2="SaisieRaema";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="SRA")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="SaisieRaema"
	[XData:1]XType:3:="SRA"
	[XData:1]XBool:14:=True:C214
	[XData:1]XDate:4:=Current date:C33
	SAVE RECORD:C53([XData:1])
End if 
CaseSaisieRaema:=Num:C11([XData:1]XBool:14)
<>SaisieOK:=[XData:1]XBool:14
SaisieOK:=[XData:1]XBool:14

  // pour pouvoir débrayer les actions Internet
QUERY:C277([XData:1];[XData:1]XNom:2="CourrielOK";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="COK")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="CourrielOK"
	[XData:1]XType:3:="COK"
	[XData:1]XBool:14:=True:C214
	[XData:1]XDate:4:=Current date:C33
	SAVE RECORD:C53([XData:1])
End if 
CaseCourrielKO:=Num:C11(Not:C34([XData:1]XBool:14))
<>PermCourrielOK:=[XData:1]XBool:14
  // APPELER PROCESS(-1)

QUERY:C277([XData:1];[XData:1]XNom:2="JavaScript";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="Jav")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="JavaScript"
	[XData:1]XType:3:="Jav"
	[XData:1]XBool:14:=True:C214
	[XData:1]XDate:4:=Current date:C33
	SAVE RECORD:C53([XData:1])
End if 
<>PermJavaScript:=[XData:1]XBool:14
  // test de l'existence (voire de création) des dossiers de mail

ZMAJDeclareVar 

ASAPInitFAM 