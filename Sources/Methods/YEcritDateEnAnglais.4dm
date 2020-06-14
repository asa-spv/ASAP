//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/03/16, 11:10:22
  // ----------------------------------------------------
  // Méthode : YEcritDateEnAnglais
  // Description
  // Permet d'écrire une date sous la forme anglaise
  // Tuesday, October 20, 2016 pour le mardi 20 octobre 2016
  // Paramètre : $1 = date
  // ----------------------------------------------------


$date:=$1

ARRAY TEXT:C222($TbMoisAnglais;12)
$TbMoisAnglais{1}:="January"
$TbMoisAnglais{2}:="February"
$TbMoisAnglais{3}:="March"
$TbMoisAnglais{4}:="April"
$TbMoisAnglais{5}:="May"
$TbMoisAnglais{6}:="June"
$TbMoisAnglais{7}:="July"
$TbMoisAnglais{8}:="August"
$TbMoisAnglais{9}:="September"
$TbMoisAnglais{10}:="October"
$TbMoisAnglais{11}:="November"
$TbMoisAnglais{12}:="December"


ARRAY TEXT:C222($TbJoursAnglais;7)
$TbJoursAnglais{1}:="Sunday"
$TbJoursAnglais{2}:="Monday"
$TbJoursAnglais{3}:="Tuesday"
$TbJoursAnglais{4}:="Wednesday"
$TbJoursAnglais{5}:="Thursday"
$TbJoursAnglais{6}:="Friday"
$TbJoursAnglais{7}:="Saturday"

$NumJour:=Day number:C114($date)
$NumMois:=Month of:C24($date)

$0:=$TbJoursAnglais{$NumJour}+", "+$TbMoisAnglais{$NumMois}+" "+String:C10(Day of:C23($date);"#0")+", "+String:C10(Year of:C25($date);"0000")