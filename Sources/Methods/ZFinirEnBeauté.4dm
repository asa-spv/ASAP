//%attributes = {"publishedWeb":true}
  // ZFinirEnBeauté V11 du 09/08/2010
  //  permet d'éviter de quitter brutalement

ON EVENT CALL:C190("")

C_LONGINT:C283($i)
C_LONGINT:C283($LApplicationType)
C_LONGINT:C283($LNumberOfProcesses)
C_LONGINT:C283($LProcessState)
C_LONGINT:C283($LStartingProcess)
<>ZFinirEnBeauté:=True:C214
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
		: ($LProcessState=Suspendu:K13:6)
			RESUME PROCESS:C320($i)
			
		: ($LProcessState=Endormi:K13:2)
			RESUME PROCESS:C320($i)
	End case 
End for 
ZAmnistieInternationale 

FLUSH CACHE:C297  //Cela ne peut pas faire de mal

QUIT 4D:C291  //il fallait bien le faire une jour      