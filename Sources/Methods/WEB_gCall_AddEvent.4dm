//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : 
  // Date et heure : 13/12/10, 09:09:46
  // ----------------------------------------------------
  // Méthode : WEB_gCall_AddEvent
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;$2;$3;$UTCDateTime_t)
C_DATE:C307($4;$5)
C_TIME:C306($6;$7)
C_DATE:C307($Now_d;$NowUTC_d)
C_TIME:C306($Now_h;$NowUTC_h)

$title:=$1
$desc:=$2
$place:=$3

$Now_d:=$4
$Now_h:=$6
  // $UTCDateTime_t:=@XX_AP Timestamp to GMT($Now_d;$Now_h;$NowUTC_d;$NowUTC_h)
$UTCDateTime_t:=String:C10($Now_d;ISO date GMT:K1:10;$Now_h)

$start:=String:C10($NowUTC_d;ISO date:K1:8)
$pos:=Position:C15("T";$Start)
$heure:=String:C10($NowUTC_h)
$start:=Substring:C12($start;1;$pos)+$heure+".000Z"

$Now_d:=$5
$Now_h:=$7
  // $UTCDateTime_t:=@XX_AP Timestamp to GMT($Now_d;$Now_h;$NowUTC_d;$NowUTC_h)
$UTCDateTime_t:=String:C10($Now_d;ISO date GMT:K1:10;$Now_h)
$end:=String:C10($NowUTC_d;ISO date:K1:8)
$pos:=Position:C15("T";$end)
$heure:=String:C10($NowUTC_h)
$end:=Substring:C12($end;1;$pos)+$heure+".000Z"

$event:="<entry xmlns='http://www.w3.org/2005/Atom' xmlns:gd='http://schemas.google.com/g/2005'>"
$event:=$event+"<category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/g/2005#event'></category>"
$event:=$event+"<title type='text'>"+$title+"</title>"
$event:=$event+"<content type='text'>"+$desc+"</content>"
$event:=$event+"<gd:transparency value='http://schemas.google.com/g/2005#event.opaque'></gd:transparency>"
$event:=$event+"<gd:eventStatus value='http://schemas.google.com/g/2005#event.confirmed'></gd:eventStatus>"
$event:=$event+"<gd:where valueString='"+$place+"'></gd:where>"
$event:=$event+"<gd:when startTime='"+$start+"' endTime='"+$end+"'></gd:when>"
$event:=$event+"</entry>"

$editUri:="/calendar/feeds/default/private/full"
$res:=WEB_gCall_Publish ($event;"POST";$editUri)
$resCode:=WEB_com_http_request_GestRescod ($res)

