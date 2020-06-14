  // Modifié par : Association QualiSoft (04/05/2018)
  // 

If (Form event code:C388=Sur chargement:K2:1)
	
	OBJECT SET FONT:C164(<>ZQuiCode;"%PassWord")
	OBJECT SET FONT:C164(*;"ZVarMdP";"%PassWord")
	
	If (ZDuPrem)
		ZObjet_Set_Info ("ZVarBonjour";"")
		ZObjet_Set_Info ("ZVarMdP";"")
		
		<>ZQuiCode:=""
		OBJECT SET ENTERABLE:C238(<>ZQuiCode;True:C214)
		OBJECT SET ENTERABLE:C238(*;"ZVarMdP";False:C215)
		
	Else 
		ZObjet_Set_Info ("ZVarBonjour";<>ZCR2+"Erreur: recommencez SVP…")
		ZObjet_Set_Info ("ZVarMdP";"")
		OBJECT SET ENTERABLE:C238(<>ZQuiCode;True:C214)
		OBJECT SET ENTERABLE:C238(*;"ZVarMdP";True:C214)
		GOTO OBJECT:C206(*;"ZVarMdP")
	End if 
	
End if 