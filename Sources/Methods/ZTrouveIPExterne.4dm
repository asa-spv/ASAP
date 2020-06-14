//%attributes = {}
  // ================================================================================
  // @4ddoc-start en
  // @name ENV_publicIpGet
  // @scope public
  // @deprecated no
  // @description This function returns the public ip address
  // @parameter[0-OUT-publicIp-TEXT] public ip v4 address
  //@notes the value is set in a interprocess cache, uses"http://api.ipify.org/"
  // @example ENV_publicIpGet
  // secured Web connection:
  // version type 1.00.00
  // @author Bruno LEGAY(BLE)- Copyrights A&C Consulting- 2008
  // @history CREATION Bruno LEGAY(BLE)- 08/04/2016, 200231- v1.00.00
  // @4ddoc-end
  // ================================================================================

C_TEXT:C284($0;$vt_myPublicIp)

If (Length:C16($vt_myPublicIp)=0)
	
	$Txt_CurrentMethodError:=Method called on error:C704
	
	If ($txt_CurrentMethodError="")
		ON ERR CALL:C155("ZBaseErreurNulle")
	End if 
	
	
	C_TEXT:C284($vt_url)
	$vt_url:="http://api.ipify.org/?format=text"  /// returns public ip in form"xxx.xxx.xxx.xxx", fast
	
	  //$vt_url:="http://ifconfig.me/ip"// returns public ip in form"xxx.xxx.xxx.xxx\n", can sometimes be slow, don't hammer it
	
	C_LONGINT:C283($vl_httpStatus)
	C_TEXT:C284($vt_reponse)
	$vl_httpStatus:=HTTP Get:C1157($vt_url;$vt_reponse)
	
	If (Asserted:C1132($vl_httpStatus=200;"http status : "+String:C10($vl_httpStatus)+" calling \""+$vt_url+"\""))
		$vt_myPublicIp:=Replace string:C233($vt_reponse;"\n";"")
	End if 
	
	ON ERR CALL:C155($Txt_CurrentMethodError)
	
End if 

$0:=$vt_myPublicIp
