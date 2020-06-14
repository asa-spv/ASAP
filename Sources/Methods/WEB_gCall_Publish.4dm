//%attributes = {"invisible":true}
C_TEXT:C284($0;$1;$2;$3)
C_TEXT:C284($event;$type;$uri;$dataToSend)

  //event a envoyer
$event:=$1
$type:=$2
$uri:=$3
  //login
  //$dataToSend:="Email=cpisterman@gmail.com&Passwd=dkydc0454&source=exampleCo-exampleApp-1&service=cl"
$dataToSend:="Email="+<>CalendarCompte+"&Passwd="+<>CalendarMDP+"&source=App."+<>ParamNom+"&service=cl"
  //recuperation token
$httpRes:=WEB_com_http_request ("www.google.com";"/accounts/ClientLogin";$dataToSend;True:C214;"";"POST")

  //tool_logThis ($httpRes;"dev.log";Nom methode courante)

If (WEB_com_http_request_GestRescod ($httpRes)="200 OK")
	
	ARRAY INTEGER:C220($foundPos;0)
	ARRAY INTEGER:C220($foundLen;0)
	
	  //parsing tocken
	$res:=WEB_com_http_request_remove_hea ($httpRes)
	$start:=1
	$reg:=Match regex:C1019("Auth=(.*)$";$res;$start;$foundPos;$foundLen)
	$authToken:=Substring:C12($res;$foundPos{1};$foundLen{1})
	
	$tocken:=$authToken
	  //tool_logThis ($authToken;"dev.log";Nom methode courante)
	
	  //contact avec le tocken en envoyant l'event
	$httpRes:=WEB_com_http_request ("www.google.com";$uri;$event;True:C214;$authToken;$type)
	
	  //tool_logThis ($httpRes;"dev.log";Nom methode courante)
	
	  //verification requette
	$res:=WEB_com_http_request_GestRescod ($httpRes)
	
	If ($res="302 Moved Temporarily")
		
		  //parsing sessionid
		$res:=WEB_com_http_request_remove_hea ($httpRes;$res)
		$reg:=Match regex:C1019("gsessionid=(.*)\"";$res;$start;$foundPos;$foundLen)
		$gSessionId:=Substring:C12($res;$foundPos{1};$foundLen{1})
		
		  //envoi final
		$httpRes:=WEB_com_http_request ("www.google.com";$uri+"?gsessionid="+$gSessionId;$event;True:C214;$authToken;$type)
		
		  //tool_logThis ($httpRes;"dev.log";Nom methode courante)
	End if 
	
Else 
	ALERT:C41(Get localized string:C991("GoogleAgendaKO"))
	
End if 
$0:=$httpRes