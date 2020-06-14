$Ligne:=LISTBOX Get number of rows:C915(*;"ListBoxDistribution")+1
LISTBOX INSERT ROWS:C913(*;"ListBoxDistribution";$Ligne)
EDIT ITEM:C870(TbMailsDistribution{$Ligne})