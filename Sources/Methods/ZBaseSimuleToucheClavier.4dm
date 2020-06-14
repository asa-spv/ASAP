//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // project method : env_POST_KEY
  // ID[71F53A836CF347A781A599D945BEF20A]
  // created 15/06/12 by Vincent de Lachaux
  // 4DPOP
  // ----------------------------------------------------
  // description:
  //
  // ----------------------------------------------------
  // declarations

C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_visible)
C_LONGINT:C283($Lon_i;$Lon_origin;$Lon_parameters;$Lon_statut;$Lon_time;$Lon_UID)
C_TEXT:C284($Txt_key;$Txt_processName)

If (False:C215)
	C_TEXT:C284(ZBaseSimuleToucheClavier ;$1)
End if 

  // ----------------------------------------------------
  // initialisations

$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	$Txt_key:=$1
Else 
	ABORT:C156
End if 

  // ----------------------------------------------------

For ($Lon_i;1;Count tasks:C335;1)
	
	PROCESS PROPERTIES:C336($Lon_i;$Txt_processName;$Lon_statut;$Lon_time;$Boo_visible;$Lon_UID;$Lon_origin)
	
	If ($Lon_origin=Process développement:K36:9)
		POST KEY:C465(Character code:C91($Txt_key);0 ?+ Bit touche commande:K16:2;$Lon_i)
		$Lon_i:=MAXLONG:K35:2-1
	End if 
	
End for 

  // ----------------------------------------------------
  // end
