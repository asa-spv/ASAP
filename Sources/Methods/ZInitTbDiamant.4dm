//%attributes = {"publishedWeb":true}
  // ZInitTbDiamant V11 du 20/07/2010
  // Modifié par : Association QualiSoft (03/05/2018)

ASAPInitTableauxGenerauxDiamant 
ZInitSaintsCalendrier 


  // Tableau des valeurs autorisées pour les dilutions
ARRAY TEXT:C222(<>TbDilution;0)
QUERY:C277([XData:1];[XData:1]XType:3="dilution autorisée")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="dilution autorisée"
	[XData:1]XNom:2:="dilution autorisée"
	ARRAY TEXT:C222(<>TbDilution;10)
	<>TbDilution{1}:="-1"
	<>TbDilution{2}:="-2"
	<>TbDilution{3}:="-3"
	<>TbDilution{4}:="-4"
	<>TbDilution{5}:="-5"
	<>TbDilution{6}:="-6"
	<>TbDilution{7}:="1/4"
	<>TbDilution{8}:="1/40"
	<>TbDilution{9}:="1/400"
	<>TbDilution{10}:="1/4000"
	ZVariableVersBlob (->[XData:1]XBlob:13;-><>TbDilution)
	SAVE RECORD:C53([XData:1])
End if 
ZBlobVersVariable (->[XData:1]XBlob:13;-><>TbDilution)


  // Gestion des tables sensibles
READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="Tables sensibles")  // L'enregistrement contenant les tableaux de correspondance
If (Records in selection:C76([XData:1])=0)  // La toute toute première fois
	CREATE RECORD:C68([XData:1])
	[XData:1]XType:3:="Tables sensibles"
	[XData:1]XNom:2:="Gestion des tables sensibles"
	SAVE RECORD:C53([XData:1])
End if 

  // Tables existantes
ARRAY LONGINT:C221($TbNumTable;0x0000)
ARRAY BOOLEAN:C223($TbSensible;0x0000)
C_OBJECT:C1216($Ob)
$ob:=[XData:1]XObjet:18
OB GET ARRAY:C1229($Ob;"Sensible";$TbSensible)
OB GET ARRAY:C1229($Ob;"NumTable";$TbNumTable)

$TT:=Get last table number:C254
For ($Salé;1;$TT)  // Pour chaque table valide
	If (Is table number valid:C999($Salé))
		If (Find in array:C230($TbNumTable;$Salé)<0)
			APPEND TO ARRAY:C911($TbNumTable;$Salé)
			APPEND TO ARRAY:C911($TbSensible;False:C215)
		End if 
	End if 
End for 

OB SET ARRAY:C1227($Ob;"Sensible";$TbSensible)
OB SET ARRAY:C1227($Ob;"NumTable";$TbNumTable)
[XData:1]XObjet:18:=$ob
SAVE RECORD:C53([XData:1])

ARRAY BOOLEAN:C223(<>TbSensible;0x0000)
ARRAY LONGINT:C221(<>TbNumTableSensible;0x0000)
COPY ARRAY:C226($TbSensible;<>TbSensible)
COPY ARRAY:C226($TbNumTable;<>TbNumTableSensible)


  // Méthode dans laquelle sont définies les tableaux interprocess
  // variables de mails
C_LONGINT:C283($Salé;$FT)
ALL RECORDS:C47([XMails:9])
ARRAY TEXT:C222(<>TbMailAdA;0)
ARRAY TEXT:C222(<>TbMailAdDe;0)
SELECTION TO ARRAY:C260([XMails:9]MailA:4;<>TbMailAdA;[XMails:9]MaillDe:3;<>TbMailAdDE)
$FT:=Size of array:C274(<>TbMailAdDE)
For ($Salé;1;$FT)
	APPEND TO ARRAY:C911(<>TbMailAdA;<>TbMailAdDE{$Salé})
End for 

  //Variables universelles
  // Tableau des jours
ARRAY TEXT:C222(<>ZTbNomDuJour;7)
<>ZTbNomDuJour{1}:="Dimanche"
<>ZTbNomDuJour{2}:="Lundi"
<>ZTbNomDuJour{3}:="Mardi"
<>ZTbNomDuJour{4}:="Mercredi"
<>ZTbNomDuJour{5}:="Jeudi"
<>ZTbNomDuJour{6}:="Vendredi"
<>ZTbNomDuJour{7}:="Samedi"

  // Tableau des mois
ARRAY TEXT:C222(<>ZTbNomDuMois;12)
<>ZTbNomDuMois{1}:="Janvier"
<>ZTbNomDuMois{2}:="Février"
<>ZTbNomDuMois{3}:="Mars"
<>ZTbNomDuMois{4}:="Avril"
<>ZTbNomDuMois{5}:="Mai"
<>ZTbNomDuMois{6}:="Juin"
<>ZTbNomDuMois{7}:="Juillet"
<>ZTbNomDuMois{8}:="Août"
<>ZTbNomDuMois{9}:="Septembre"
<>ZTbNomDuMois{10}:="Octobre"
<>ZTbNomDuMois{11}:="Novembre"
<>ZTbNomDuMois{12}:="Décembre"

  //Ensemble de tableaux utilisés pour l'expression un nom en toutes lettres
ARRAY TEXT:C222(<>ZTBETLUnité;4)
<>ZTBETLUnité{1}:=""
<>ZTBETLUnité{2}:="mille"
<>ZTBETLUnité{3}:="million"
<>ZTBETLUnité{4}:="milliard"

ARRAY TEXT:C222(<>ZTBETLVingt;20)
<>ZTBETLVingt{1}:="un"
<>ZTBETLVingt{2}:="deux"
<>ZTBETLVingt{3}:="trois"
<>ZTBETLVingt{4}:="quatre"
<>ZTBETLVingt{5}:="cinq"
<>ZTBETLVingt{6}:="six"
<>ZTBETLVingt{7}:="sept"
<>ZTBETLVingt{8}:="huit"
<>ZTBETLVingt{9}:="neuf"
<>ZTBETLVingt{10}:="dix"
<>ZTBETLVingt{11}:="onze"
<>ZTBETLVingt{12}:="douze"
<>ZTBETLVingt{13}:="treize"
<>ZTBETLVingt{14}:="quatorze"
<>ZTBETLVingt{15}:="quinze"
<>ZTBETLVingt{16}:="seize"
<>ZTBETLVingt{17}:="dix-sept"
<>ZTBETLVingt{18}:="dix-huit"
<>ZTBETLVingt{19}:="dix-neuf"
<>ZTBETLVingt{20}:="vingt"

ARRAY TEXT:C222(<>ZTBETLDix;10)
<>ZTBETLDix{1}:="dix"
<>ZTBETLDix{2}:="vingt"
<>ZTBETLDix{3}:="trente"
<>ZTBETLDix{4}:="quarante"
<>ZTBETLDix{5}:="cinquante"
<>ZTBETLDix{6}:="soixante"
<>ZTBETLDix{7}:="soixante-dix"
<>ZTBETLDix{8}:="quatre-vingt"
<>ZTBETLDix{9}:="quatre-vingt dix"
<>ZTBETLDix{10}:="cent"

ARRAY TEXT:C222(<>Alphabet;27)
STRING LIST TO ARRAY:C511(21004;<>Alphabet)


ASAPInitTbDiamantPays 