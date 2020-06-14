//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 09/05/18, 09:07:06
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : ZLBSauveETListe
  // Description
  // Méthode qui actualise les noms des ET
  //  des listes

$L:=Find in array:C230(<>TbNomTableBase;TbNomTable{TbNomTable})
$Propriété:="ET"+String:C10(<>TbNumTableBase{$L})
OB SET ARRAY:C1227(ObjetET;$Propriété;TbNomAffiche)
$Propriété:="RC"+String:C10(<>TbNumTableBase{$L})
OB SET ARRAY:C1227(ObjetET;$Propriété;TbNumChampAffiche)
READ WRITE:C146([XData:1])
QUERY:C277([XData:1];[XData:1]XType:3="NomChampAfficheLB";*)
QUERY:C277([XData:1]; & [XData:1]XNom:2="Nom des ET des ListBox pour "+<>ZQuiCode;*)
QUERY:C277([XData:1]; & [XData:1]XAlpha:8=<>ZQuiCode)
[XData:1]XObjet:18:=OB Copy:C1225(ObjetET)
SAVE RECORD:C53([XData:1])
ZAmnistiePartielle (->[XData:1])