If (Form event code:C388=Sur après frappe clavier:K2:26)
	$TE:="@"+Get edited text:C655+"@"
	$Longueur:=Length:C16($TE)
	Case of 
		: (Length:C16($TE)=2)
			ALL RECORDS:C47([CourrielsTypes:28])
			
		: (Length:C16($TE)>3)
			QUERY:C277([CourrielsTypes:28];[CourrielsTypes:28]Descriptif:3=$TE;*)
			QUERY:C277([CourrielsTypes:28]; | [CourrielsTypes:28]NomLettre:2=$TE)
			
	End case 
	ASAPCourrielsAfficheCT (True:C214)
	LISTBOX SELECT ROW:C912(*;"LBCT";0;lk supprimer de sélection:K53:3)
	PREVIOUS RECORD:C110([CourrielsTypes:28])
	OBJECT SET VISIBLE:C603(*;"Envoi@";False:C215)
	
End if 