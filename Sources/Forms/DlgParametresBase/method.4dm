Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		ZConfiguration_Charge 
		ZConfiguration_Base (1)
		OBJECT SET FONT:C164(*;"MdpCloud";"%password")
		OBJECT SET FONT:C164(*;"Password_t";"%password")
		
		  // Outils et accès spécifiques selon les droits accordés
		
		If (Current user:C182="Concepteur") | (Current user:C182="Administrateur")
			
			ARRAY TEXT:C222($tTxt_Components;0)
			COMPONENT LIST:C1001($tTxt_Components)
			If (Find in array:C230($tTxt_Components;"QS_Toolbox")>0)
				OBJECT SET VISIBLE:C603(*;"CTM_QST";True:C214)
			End if 
			
			OBJECT SET VISIBLE:C603(*;"CTM_Securite";True:C214)
			
		End if 
		
		
	: (Form event code:C388=Sur données modifiées:K2:15) | (Form event code:C388=Sur clic:K2:4)
		ZConfiguration_MAJ_EnCours 
		
End case 