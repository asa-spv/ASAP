//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 21/07/19, 05:44:19
  // ----------------------------------------------------
  // Méthode : RaemaTendancePUM
  // Description : Gestion du PUM du DlgTendance
  // ----------------------------------------------------
$Test:=TbNR{TbNR}+"@"
QUERY:C277([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3=$Test)
ORDER BY:C49([RAEMAGermes:21];[RAEMAGermes:21]Identifiant:3;>)
SELECTION TO ARRAY:C260([RAEMAGermes:21]NomFr:4;ZoneChose)
  // SUPPRIMER DANS TABLEAU(ZoneChose;1)
ZoneChose:=0
ARRAY BOOLEAN:C223(TbChoix;Size of array:C274(ZoneChose))

RaemaTendanceTbGenerauxRAEMA 
OBJECT SET TITLE:C194(Campagne1;TbNR{TbNR+4})
OBJECT SET TITLE:C194(Campagne2;TbNR{TbNR+2})