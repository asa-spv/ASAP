//%attributes = {"invisible":true,"shared":true}
  // =========================================== 
  // PROJECT METHOD: HELP_ScreenshotToFile 
  // PARAMETERS: $0 = path to file containing screenshot 
  // DESCRIPTION: Take a screenshot in PNG format of the screen where the frontmost 
  // window is located and returns the path to the file containing it. 
  // macOS support for multiple screens. On Windows you get all screens. 

  // CREATED BY: Tim Nevels, Innovative Solutions ©2018 
  // DATE: 1/5/18 
  // LAST MODIFIED: 
  // By Patrick EMANUEL
  // ============================================ 
  // http://4d.1045681.n5.nabble.com/ScreenshotToFile-Method-td5756240.html
  // see also: http://www.nirsoft.net/utils/nircmd.html
  // see also: http://dailymactips.com/take-screenshots-on-your-mac-using-the-terminal-application/


C_TEXT:C284($0;$filePath_t;$1)

C_TEXT:C284($fileName_t;$screenRectOption_t;$command_t;$inputStream_t;$outputStream_t;$errorStream_t)
C_LONGINT:C283($left;$top;$right;$bottom)

  // create temporary file path 
$fileName_t:="Screenshot "+String:C10(Current date:C33;ISO date:K1:8;Current time:C178)+".png"
$fileName_t:=Replace string:C233($fileName_t;"/";"-")  // replace slashes with dashes in file name 
$fileName_t:=Replace string:C233($fileName_t;":";".")  // replace colons with periods in file name 
$filePath_t:=Get 4D folder:C485(Dossier Logs:K5:19;*)+$fileName_t

  // Add the possibility to define your own folder to receive screenshots
If (Count parameters:C259=1)
	If (Test path name:C476($1)=Est un dossier:K24:2)
		$filePath_t:=$1+$fileName_t
	End if 
End if 

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")

If (Not:C34(<>ZPC))  // Mac
	
	  // Options available with ScreenCapture command line
	Begin SQL
		/*
		All Of The Flags You Can Use With The Screencapture Command
		Below is a list of all of the flags that you can use in conjunction with the scr
		
		usage: screencapture [-icMPmwsWxSCUtoa] [files]
		-c force screen capture to go to the clipboard
		-C capture the cursor as well as the screen. only in non-interactive modes
		-d display errors to the user graphically
		-i capture screen interactively, by selection or window
		control key – causes screen shot to go to clipboard
		space key – toggle between mouse selection and
		window selection modes
		escape key – cancels interactive screen shot
		-m only capture the main monitor, undefined if-i is set
		-M screen capture output will go to a new Mail message
		-o in window capture mode, do not capture the shadow of the window
		-P screen capture output will open in Preview
		-s only allow mouse selection mode
		-S in window capture mode, capture the screen not the window
		-t image format to create, default is png(other options include pdf, jpg, tiff and other formats)
		-T Take the picture after a delay of , default is 5
		-w only allow window selection mode
		-W start interaction in window selection mode
		-x do not play sounds
		-a do not include windows attached to selected windows
		-r do not add dpi meta data to image
		-l capture this windowsid
		-R capture screen rect
		*/
	End SQL
	
	  // get screen coordinates 
	  //SCREEN COORDINATES($left;$top;$right;$bottom;GetCurrentScreenNumber)
	SCREEN COORDINATES:C438($left;$top;$right;$bottom;Menu bar screen:C441)
	$screenRectOption_t:="-R"+String:C10($left)+","+String:C10($top)+","+String:C10($right)+","+String:C10($bottom)
	
	  // get screenshot 
	$command_t:="screencapture "+$screenRectOption_t+" '"+Convert path system to POSIX:C1106($filePath_t)+"'"
	LAUNCH EXTERNAL PROCESS:C811($command_t;$inputStream_t;$outputStream_t;$errorStream_t)
	
Else   // Windows 
	
	$Path:=Get 4D folder:C485(Dossier Resources courant:K5:16)+"nircmd"+Séparateur dossier:K24:12+"nircmdc.exe"
	If (Test path name:C476($Path)=Est un document:K24:1)
		
		  // get screenshot 
		$command_t:=Get 4D folder:C485(Dossier Resources courant:K5:16)+"nircmd"+Séparateur dossier:K24:12+"nircmdc.exe savescreenshotfull "+Char:C90(Guillemets:K15:41)+$filePath_t+Char:C90(Guillemets:K15:41)
		LAUNCH EXTERNAL PROCESS:C811($command_t;$inputStream_t;$outputStream_t;$errorStream_t)
		
		If ($errorStream_t#"")
			ALERT:C41("Nircmdc.exe screen capture problem.\n"+$errorStream_t;"Error")
		End if 
		
	Else 
		ALERT:C41("Nircmdc.exe program is missing. Install it in the Ressources folder in the folder : 'nircmd'.\\You can download the programm from www.nirsoft.net")
	End if 
End if 

  // return file path 
$0:=$filePath_t