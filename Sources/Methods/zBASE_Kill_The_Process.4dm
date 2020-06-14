//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // ----------------------------------------------------
  // Méthode : Base_FermeLesProcess
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

If (<>OnContinue)
	
	<>FinirEnBeauté:=True:C214  // Au cas où !
	IDLE:C311
	
	ON EVENT CALL:C190("")
	
	C_LONGINT:C283($i)
	C_LONGINT:C283($LApplicationType)
	C_LONGINT:C283($LNumberOfProcesses)
	C_LONGINT:C283($LProcessState)
	C_LONGINT:C283($LStartingProcess)
	
	$LNumberOfProcesses:=Count user processes:C343
	
	$LApplicationType:=Application type:C494
	
	Case of 
		: ($LApplicationType=4D mode local:K5:1)
			$LStartingProcess:=3
		: ($LApplicationType=4D mode distant:K5:5)
			$LStartingProcess:=2
		: ($LApplicationType=4D Server:K5:6)
			$LStartingProcess:=4
	End case 
	
	For ($i;$LStartingProcess;$LNumberOfProcesses)
		$LProcessState:=Process state:C330($i)
		Case of 
			: ($LProcessState=Détruit:K13:1)  // -1
				
			: ($LProcessState=Inexistant:K13:3)  // -100
				
			: ($LProcessState=Endormi:K13:2)  // 1
				RESUME PROCESS:C320($i)
				
			: ($LProcessState=En exécution:K13:4)  // 0
				RESUME PROCESS:C320($i)
				
			: ($LProcessState=_o_Dialogue caché:K13:5)  // 6
				BRING TO FRONT:C326($i)
				
			: ($LProcessState=Suspendu:K13:6)  // 5
				RESUME PROCESS:C320($i)
				
			: ($LProcessState=En attente entrée sortie:K13:7)  // 3
				RESUME PROCESS:C320($i)
				
			: ($LProcessState=En attente drapeau interne:K13:8)  // 4
				RESUME PROCESS:C320($i)
				
			: ($LProcessState=En attente événement:K13:9)  // 2
				BRING TO FRONT:C326($i)
				RESUME PROCESS:C320($i)
				
		End case 
	End for 
End if 