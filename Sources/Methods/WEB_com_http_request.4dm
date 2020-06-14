//%attributes = {"invisible":true}
  // ----------------------------------------------------

  // Date et heure : 31/07/09, 11:45:53
  // ----------------------------------------------------
  // Méthode : web_com_http_request
  // Description
  // Envoi un blob dans une variable post
  // Recois un blob dans le $0
  // Paramètres
  // $1 = DATA a envoyer
  // $2 = Ip du server a contacter EX : "192.168.12.26"
  // $3 = Fichier sur le server a taper EX : "4D/service_clean_client.php"
  // $0 = DATA de réponse de la requette HTTP (Contient les HEADERS HTTP à retirer avec d_t_http_remove_headers)
  // ----------------------------------------------------

C_TEXT:C284($header)

C_LONGINT:C283($lPayloadlength;$errorCode;$state;$tcpStream;$lPort;$iTCPConnectionType)
C_TEXT:C284($CRLF)
C_TEXT:C284($tDir;$tHost;$tUsername;$tPassword)

C_TEXT:C284($3;$data)
C_TEXT:C284($1;$tHost)
C_TEXT:C284($2;$tDir)

C_TEXT:C284($0;$result)

C_BOOLEAN:C305($4;$https)

C_BLOB:C604($cblob)

  // - Output
C_BOOLEAN:C305($exit)
  // - Variables
$exit:=False:C215

$tXMLMessage:=""

$CRLF:=Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40)
$errorCode:=0
$state:=0
$tcpStream:=0

$tHost:=$1
$tDir:=$2
$data:=$3
$https:=$4

If (Count parameters:C259>=5)
	
	C_TEXT:C284($token;$5)
	
	$token:=$5
	
Else 
	
	C_TEXT:C284($token)
	$token:=""
	
End if 


If (Count parameters:C259>=6)
	
	C_TEXT:C284($requestType;$6)
	
	$requestType:=$6
	
Else 
	
	C_TEXT:C284($requestType)
	$requestType:="POST"
	
End if 

  //$data:="xmlMsg="+$data

  //d_m_logthis_serv ($data;"dev.log";Nom methode courante)

  //VARIABLE VERS BLOB($data;$cblob)

TEXT TO BLOB:C554($data;$cblob;UTF8 texte sans longueur:K22:17)
  //TEXTE VERS BLOB($data2;$cblob2;UTF8 Texte sans longueur )
  //d_m_logthis_blob_serv ($cblob;"dev.log";Nom methode courante)

$lPayloadlength:=BLOB size:C605($cblob)  //longueur du message


If ($https=True:C214)
	$lPort:=443
Else 
	$lPort:=80
End if 


  // $lPort:=443  //SSL`80 = default , 443 = SSL
$iTCPConnectionType:=2  //0 = default, `2 =Synchronous SSL
$tUsername:=<>CalendarCompte  // ""
$tPassword:=<>CalendarMDP  // ""
$errorCode:=IT_SetTimeOut (5)

Repeat 
	  //TCP_Open to create a connection
	$errorCode:=TCP_Open ($tHost;$lPort;$tcpStream;$iTCPConnectionType)
	
	If ($tcpStream=0)  //couldn't open stream
		$errorCode:=TCP_Listen ($tDir;0;$lPort;20;$tcpStream)
		$errorCode:=TCP_State ($tcpStream;$state)
	End if 
	
	  //====================================
	  //send header
	  //====================================
	If ($errorCode=0)
		
		If ($lPayloadlength=0)
			
			If ($https=True:C214)
				$header:="GET https://"+$tHost+$tDir+" HTTP/1.0"+$CRLF
			Else 
				$header:="GET http://"+$tHost+$tDir+" HTTP/1.0"+$CRLF
			End if 
			
			$header:=$header+"Host: "+$tHost
			$header:=$header+$CRLF+$CRLF
			
		Else 
			
			If ($https=True:C214)
				
				
				
				If ($requestType="DELETE")
					$header:="POST https://"+$tHost+$tDir+" HTTP/1.0"+$CRLF
				Else 
					$header:=$requestType+" https://"+$tHost+$tDir+" HTTP/1.0"+$CRLF
				End if 
				
				
			Else 
				
				$header:=$requestType+" http://"+$tHost+$tDir+" HTTP/1.0"+$CRLF
				
			End if 
			
			
		End if 
		
		$header:=$header+"Host: "+$tHost+$CRLF
		$header:=$header+"Content-length: "+String:C10($lPayloadlength)+$CRLF
		
		If ($token#"") | ($requestType="PUT") | ($requestType="DELETE")
			
			$header:=$header+"Authorization: GoogleLogin auth=\""+$token+"\""+$CRLF
			
			$header:=$header+"Content-type: application/atom+xml"+$CRLF
			
			If ($requestType="PUT") | ($requestType="DELETE")
				
				$header:=$header+"If-Match: *"+$CRLF
				
				If ($requestType="DELETE")
					$header:=$header+"X-HTTP-Method-Override: DELETE"+$CRLF
				End if 
				
			End if 
			
		Else 
			
			$header:=$header+"Content-type: application/x-www-form-urlencoded"+$CRLF
			
		End if 
		
		$header:=$header+$CRLF
		
		ZBaseAjouteTrace (Char:C90(Retour à la ligne:K15:40)+"HTTP REQ -> "+$tHost+$tDir+Char:C90(Retour à la ligne:K15:40)+$header+"SENDING "+$data+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40);"dev.log";Current method name:C684)
		  //$tXMLMessage:=$header
		$errorCode:=TCP_Send ($tcpStream;$header)
		
	Else 
		$exit:=True:C214
		WEB_AdminMail ("Error on d_t_http_request_blob";"Error on TCP_STATE : HEADER, PARAMS ->  HOST: "+$tHost+" DIR:"+$tDir;Current method name:C684)
	End if 
	
	  //====================================
	  //send body
	  //====================================
	If ($errorCode=0)
		
		If ($lPayloadlength>0)
			
			  //d_m_logthis_blob_serv ($cblob;"dev.log";Nom methode courante)
			
			$errorCode:=TCP_SendBLOB ($tcpStream;$cblob)
			
			  //$errorCode:=TCP_SendBLOB ($tcpStream;$cblob2)
			
		End if 
		
	Else 
		$exit:=True:C214
		WEB_AdminMail ("Error on web_com_http_request";"Error on TCP_STATE : BODY, PARAMS ->  HOST: "+$tHost+" DIR:"+$tDir;Current method name:C684)
	End if 
	
	  //====================================
	  //receive response
	  //====================================
	If ($errorCode=0)
		
		C_BLOB:C604($Blob_Reçu;$Blob_Concaténé)
		C_LONGINT:C283($srcpos;$dstpos)
		
		C_TEXT:C284($result)
		
		Repeat 
			
			$errorCode:=TCP_ReceiveBLOB ($tcpStream;$Blob_Reçu)
			$errorCode:=TCP_State ($tcpStream;$state)
			
			$srcpos:=0
			$dstpos:=BLOB size:C605($Blob_Concaténé)
			  //Concaténation des données reçues
			COPY BLOB:C558($Blob_Reçu;$Blob_Concaténé;$srcpos;$dstpos;BLOB size:C605($Blob_Reçu))
			
		Until ($state=0) | ($errorCode#0)
		
		If ($errorcode=0)
			$errorCode:=TCP_Close ($tcpStream)  //TCP_Close to dispose of the con
			
			$result:=""
			
			  //BLOB VERS VARIABLE($Blob_Concaténé;$result)
			$result:=BLOB to text:C555($Blob_Concaténé;UTF8 texte sans longueur:K22:17)
			
			
			ZBaseAjouteTrace (Char:C90(Retour à la ligne:K15:40)+"HTTP RES <- "+$tHost+$tDir+" RESULT: "+Char:C90(Retour à la ligne:K15:40)+$result+Char:C90(Retour à la ligne:K15:40)+Char:C90(Retour à la ligne:K15:40);"dev.log";Current method name:C684)
			ZBaseAjouteTrace ("HTTP END ---------------------------------------------------------------------------------------";"dev.log";Current method name:C684)
			$0:=$result
			$exit:=True:C214
		End if 
	Else 
		$exit:=True:C214
	End if 
	IDLE:C311
Until ($exit)