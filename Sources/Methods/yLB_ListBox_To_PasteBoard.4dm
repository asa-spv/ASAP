//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Patrick EMANUEL
  // date et heure : 15/05/14, 21:00:49
  // ----------------------------------------------------
  // méthode : LB_ListBox_To_PasteBoard
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

  // =====================    Declare Variables    ==================================
  // method_parameters_declarations

C_TEXT:C284($1;$lbName_t)
C_TEXT:C284($2;$columnSeparator_t)
C_TEXT:C284($3;$rowSeparator_t)
C_TEXT:C284($theData_t;$Cell)

C_LONGINT:C283($i;$numRows_l;$BarInformation)
C_LONGINT:C283($j;$numCols_l)
C_BOOLEAN:C305($stop)
C_POINTER:C301($ListBox_Ptr)

ARRAY TEXT:C222($colNames_at;0x0000)
ARRAY TEXT:C222($headerNames_at;0x0000)
ARRAY POINTER:C280($colVars_ap;0x0000)
ARRAY POINTER:C280($headerVars_ap;0x0000)
ARRAY BOOLEAN:C223($colsVisible_ab;0x0000)
ARRAY POINTER:C280($styles_ap;0x0000)

  // ======================    Initialize and Setup    ================================

ASSERT:C1129(Count parameters:C259=1;"Required 1 parameter as text")
ASSERT:C1129(Type:C295($1)=Est un texte:K8:3;"$1 should be a text: Listbox name is the attendee.")
$lbName_t:=$1  // Get the Listbox name

If (LISTBOX Get number of columns:C831(*;$lbName_t)>0)
	
	If (Count parameters:C259>1)
		ASSERT:C1129(Count parameters:C259=3;"Required 3 parameter as text")
		ASSERT:C1129(Type:C295($2)=Est un texte:K8:3;"$2 should be a text.")
		ASSERT:C1129(Type:C295($3)=Est un texte:K8:3;"$3 should be a text.")
		$columnSeparator_t:=$2
		$rowSeparator_t:=$3
	Else 
		$columnSeparator_t:=Char:C90(Tabulation:K15:37)
		$rowSeparator_t:=Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40)
	End if 
	
	$ListBox_Ptr:=OBJECT Get pointer:C1124(Objet nommé:K67:5;$lbName_t)  //  now 4D has created a variable for the column and we can get its pointer
	LISTBOX GET ARRAYS:C832(*;$lbName_t;$colNames_at;$headerNames_at;$colVars_ap;$headerVars_ap;$colsVisible_ab;$styles_ap)
	$numRows_l:=Size of array:C274($colVars_ap{1}->)
	$numCols_l:=Size of array:C274($colNames_at)
	
	$theData_t:=""
	
	  // For Progress toolbar
	Case of 
			
		: ($numRows_l>100000)
			$step:=400
			
		: ($numRows_l>10000)
			$step:=200
			
		: ($numRows_l>1000)
			$step:=50
			
		Else 
			
			$step:=25
			
	End case 
	
	  // ========================    Method Actions    ==================================
	$Max:=$numCols_l*$numRows_l
	$pas:=1/($Max+1)
	
	If (Find in array:C230($ListBox_Ptr->;True:C214)=-1)  // Nothing is selected in particulary
		For ($i;1;$numRows_l)
			$ListBox_Ptr->{$i}:=True:C214
		End for 
	End if 
	
	  // set the headers
	For ($i;1;$numCols_l)
		$theData_t:=$theData_t+OBJECT Get title:C1068(*;$headerNames_at{$i})+$columnSeparator_t
	End for 
	
	$theData_t:=$theData_t+$rowSeparator_t
	
	  // set data
	For ($i;1;$numRows_l)
		
		If ($ListBox_Ptr->{$i}=True:C214)
			
			For ($j;1;$numCols_l)
				
				  // if ($colsVisible_ab{$j}=True)
				
				If ($j#1)
					$theData_t:=$theData_t+$columnSeparator_t
				End if 
				
				  // -- Passage n v15
				$Cell:=String:C10($colVars_ap{$j}->{$i})
				$Cell:=Replace string:C233($Cell;Char:C90(Retour chariot:K15:38)+Char:C90(Retour à la ligne:K15:40);" - ")
				$Cell:=Replace string:C233($Cell;Char:C90(Retour chariot:K15:38);" - ")
				$Cell:=Replace string:C233($Cell;Char:C90(Tabulation:K15:37);" -> ")
				
				  // --
				$theData_t:=$theData_t+$Cell
				
				  // end if
				
			End for 
			
			If ($i<$numRows_l)
				$theData_t:=$theData_t+$rowSeparator_t
			End if 
			
		End if 
		
	End for 
	
	  // ========================    Clean up and Exit    =================================
	
	If (Not:C34($stop))
		  //FIXER TEXTE DANS CONTENEUR($theData_t)
	End if 
	
	Progress QUIT ($BarInformation)
	
Else 
	
	ALERT:C41("No data to copy.")
	
End if 
