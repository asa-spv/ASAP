Case of 
	: (Form event code:C388=Sur clic:K2:4)
		C_OBJECT:C1216($togObj)
		C_LONGINT:C283($pos)
		C_POINTER:C301($valPtr;$fieldPtr)
		$togObj:=togObj1
		$fieldPtr:=-><>ZNewsActifs
		TOGCTN_HANDLE_CLICK ($togObj)
		TOGOBJ_GET_VAL ($togObj;"Position";->$pos)
		$valPtr:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"val1")
		
		<>ZNewsActifs:=Not:C34(<>ZNewsActifs)
		C_OBJECT:C1216($Config)
		$Config:=(OBJECT Get pointer:C1124(Objet nommé:K67:5;"EnCours"))->
		OB SET:C1220($Config;"option_news_actifs";Num:C11(<>ZNewsActifs))
		
		OBJECT SET VISIBLE:C603(*;"@2";<>ZNewsActifs)
		If (Not:C34(<>ZNewsActifs))
			<>ZNews:=False:C215
			OB SET:C1220($Config;"option_news";Num:C11(<>ZNews))
		End if 
		
End case 