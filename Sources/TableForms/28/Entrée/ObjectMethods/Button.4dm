  // **************************************************************************************
  // This button should be deleted once its script has been executed.
  // Its goal is to copy certain resources from the 4D application into your database
  // The resources are used inside the buttons and in the color menu. Some .xlf files
  // **************************************************************************************


C_LONGINT:C283($j;$k;$m;$n)
C_TEXT:C284($4DResourcesFolder;$4dRsrFolder;$4dSubfolder)
C_TEXT:C284($LocalResourcesFolder;$localRsrFolder;$LocalSubfolder)
C_TEXT:C284($4dXlif;$localXlif)

_O_PLATFORM PROPERTIES:C365($platform)
If ($platform=Windows:K25:3)
	$4DResourcesFolder:=Application file:C491
	$n:=Length:C16($4DResourcesFolder)
	Repeat 
		$n:=$n-1
	Until ($4DResourcesFolder[[$n]]=Séparateur dossier:K24:12)
	$4DResourcesFolder:=Substring:C12($4DResourcesFolder;1;$n)+"Resources"+Séparateur dossier:K24:12+"ObjectLib.4DLibrary"+Séparateur dossier:K24:12+"Resources"+Séparateur dossier:K24:12
Else 
	$4DResourcesFolder:=Application file:C491+Séparateur dossier:K24:12+"Contents"+Séparateur dossier:K24:12+"Resources"+Séparateur dossier:K24:12+"ObjectLib.4DLibrary"+Séparateur dossier:K24:12+"Resources"+Séparateur dossier:K24:12
End if 

$LocalResourcesFolder:=Get 4D folder:C485(Dossier Resources courant:K5:16)

If (Test path name:C476($4DResourcesFolder)=Est un dossier:K24:2)
	
	  //#1 copy .lproj folder
	ARRAY TEXT:C222($_Folders;0)
	ARRAY TEXT:C222($_Files;0)
	FOLDER LIST:C473($4DResourcesFolder;$_Folders)
	
	For ($i;1;Size of array:C274($_Folders))
		Case of 
				
			: ($_Folders{$i}="@.lproj")
				$4dRsrFolder:=$4DResourcesFolder+$_Folders{$i}+Séparateur dossier:K24:12+"RTA4D"+Séparateur dossier:K24:12+"Styles"+Séparateur dossier:K24:12
				
				If (Test path name:C476($4dRsrFolder)=Est un dossier:K24:2)
					
					$localRsrFolder:=$LocalResourcesFolder+$_Folders{$i}+Séparateur dossier:K24:12
					If (Test path name:C476($localRsrFolder)#Est un dossier:K24:2)
						CREATE FOLDER:C475($localRsrFolder)
					End if 
					$localRsrFolder:=$localRsrFolder+"RTA4D"+Séparateur dossier:K24:12
					If (Test path name:C476($localRsrFolder)#Est un dossier:K24:2)
						CREATE FOLDER:C475($localRsrFolder)
					End if 
					$localRsrFolder:=$localRsrFolder+"Styles"+Séparateur dossier:K24:12
					If (Test path name:C476($localRsrFolder)#Est un dossier:K24:2)
						CREATE FOLDER:C475($localRsrFolder)
					End if 
					
					ARRAY TEXT:C222($_Files;0)
					DOCUMENT LIST:C474($4dRsrFolder;$_Files)
					For ($j;1;Size of array:C274($_Files))
						If (Test path name:C476($localRsrFolder+$_Files{$j})#Est un document:K24:1)
							COPY DOCUMENT:C541($4dRsrFolder+$_Files{$j};$localRsrFolder+$_Files{$j})
						End if 
					End for 
					
				End if 
				
				$4dXlif:=$4DResourcesFolder+$_Folders{$i}+Séparateur dossier:K24:12+"RTA4D.xlf"
				$localXlif:=$LocalResourcesFolder+$_Folders{$i}+Séparateur dossier:K24:12+"RTA4D.xlf"
				If (Test path name:C476($4dXlif)=Est un document:K24:1) & (Test path name:C476($localXlif)#Est un document:K24:1)
					COPY DOCUMENT:C541($4dXlif;$localXlif)
				End if 
				
			: ($_Folders{$i}="RTA4D")
				
				$4dRsrFolder:=$4DResourcesFolder+"RTA4D"+Séparateur dossier:K24:12
				$localRsrFolder:=$LocalResourcesFolder+"RTA4D"+Séparateur dossier:K24:12
				
				If (Test path name:C476($localRsrFolder)#Est un dossier:K24:2)
					CREATE FOLDER:C475($localRsrFolder)
				End if 
				
				ARRAY TEXT:C222($_Subfolders;0)
				FOLDER LIST:C473($4dRsrFolder;$_Subfolders)  // Functions, Styles…
				
				For ($k;1;Size of array:C274($_Subfolders))
					
					$4dSubfolder:=$4dRsrFolder+$_Subfolders{$k}+Séparateur dossier:K24:12
					$LocalSubfolder:=$localRsrFolder+$_Subfolders{$k}+Séparateur dossier:K24:12
					If (Test path name:C476($LocalSubfolder)#Est un dossier:K24:2)
						CREATE FOLDER:C475($LocalSubfolder)
					End if 
					
					DOCUMENT LIST:C474($4dRsrFolder+$_Subfolders{$k};$_Files)
					
					For ($m;1;Size of array:C274($_Files))
						If (Test path name:C476($LocalSubfolder+$_Files{$m})#Est un document:K24:1)
							COPY DOCUMENT:C541($4dSubfolder+$_Files{$m};$LocalSubfolder+$_Files{$m})
						End if 
					End for 
					
				End for 
		End case 
		
		
	End for 
	
End if 
