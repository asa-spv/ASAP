//%attributes = {}
  // ----------------------------------------------------
  // Method: SUPPORT_Clear_LB_Colonnes
  // Description
  // Clear every Columns of a specified ListBox
  //
  // Parameters
  // $1 -> $sListBoxName
  // ----------------------------------------------------


  //Parameters Assignation ------------------------------------------------------------------
C_TEXT:C284($1;$sListBoxName)
$sListBoxName:=$1
  //Other Variables Declarations ------------------------------------------------------------
  //
  //----------------------------------------------------------------------------------------------------

LISTBOX DELETE COLUMN:C830(*;$sListBoxName;1;LISTBOX Get number of columns:C831(*;$sListBoxName))