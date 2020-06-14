//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 10/05/12,
  // ----------------------------------------------------
  // Méthode : ZLBColonnesSauve
  // Description
  // Méthode qui stocke la listBox de la sélection
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($0)
C_OBJECT:C1216($Ob)
$NomListeCourante:=$1
  // Recherche de la bonne [XData]
READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XNom:2=ZNomListeXData;*)
QUERY:C277([XData:1]; & [XData:1]XType:3="LB"+ZNomTable;*)
QUERY:C277([XData:1]; & [XData:1]XAlpha:8=$NomListeCourante)
If (Records in selection:C76([XData:1])=1)  // La fiche existe déjà, mettons là à jour
	[XData:1]XDate:4:=Current date:C33
	[XData:1]XObjet:18:=ZLBFabriqueObjetLB   // Affectation des caractéristiques de la LB
	[XData:1]XEntier:6:=OB Get:C1224($Ob;"NbColonne")
	SAVE RECORD:C53([XData:1])
Else   // C'est la première fois, créons la fiche
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:=ZNomListeXData
	[XData:1]XType:3:="LB"+ZNomTable
	[XData:1]XDate:4:=Current date:C33
	$Ob:=ZLBFabriqueObjetLB   // Affectation des caractéristiques de la LB
	[XData:1]XEntier:6:=OB Get:C1224($Ob;"NbColonne")
	[XData:1]XObjet:18:=OB Copy:C1225($Ob)
	[XData:1]XAlpha:8:=$NomListeCourante
	[XData:1]XTexte:9:=<>ZQuiCode
	SAVE RECORD:C53([XData:1])
End if 
$0:=[XData:1]UUID:1
ZAmnistiePartielle (->[XData:1];True:C214)