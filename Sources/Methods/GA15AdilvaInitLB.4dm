//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 16/03/18, 10:34:39
  // ----------------------------------------------------
  // Méthode : GA15AdilvaInitLB
  // Description
  // Vide la listBox de l'ADILVA
  //  initialise les tableaux textes ColRGAi (i de 1 à 39)
  // ----------------------------------------------------

LISTBOX DELETE ROWS:C914(ListBoxAperçu;1;LISTBOX Get number of rows:C915(ListBoxAperçu))
ARRAY TEXT:C222(ColRGA1;0)
ARRAY TEXT:C222(ColRGA2;0)
ARRAY TEXT:C222(ColRGA3;0)
ARRAY TEXT:C222(ColRGA4;0)
ARRAY TEXT:C222(ColRGA5;0)
ARRAY TEXT:C222(ColRGA6;0)
ARRAY TEXT:C222(ColRGA7;0)
ARRAY TEXT:C222(ColRGA8;0)
ARRAY TEXT:C222(ColRGA9;0)
ARRAY TEXT:C222(ColRGA10;0)
ARRAY TEXT:C222(ColRGA11;0)
ARRAY TEXT:C222(ColRGA12;0)
ARRAY TEXT:C222(ColRGA13;0)
ARRAY TEXT:C222(ColRGA14;0)
ARRAY TEXT:C222(ColRGA15;0)
ARRAY TEXT:C222(ColRGA16;0)
ARRAY TEXT:C222(ColRGA17;0)
ARRAY TEXT:C222(ColRGA18;0)
ARRAY TEXT:C222(ColRGA19;0)
ARRAY TEXT:C222(ColRGA20;0)
ARRAY TEXT:C222(ColRGA21;0)
ARRAY TEXT:C222(ColRGA22;0)
ARRAY TEXT:C222(ColRGA23;0)
ARRAY TEXT:C222(ColRGA24;0)
ARRAY TEXT:C222(ColRGA25;0)
ARRAY TEXT:C222(ColRGA26;0)
ARRAY TEXT:C222(ColRGA27;0)
ARRAY TEXT:C222(ColRGA28;0)
ARRAY TEXT:C222(ColRGA29;0)
ARRAY TEXT:C222(ColRGA30;0)
ARRAY TEXT:C222(ColRGA31;0)
ARRAY TEXT:C222(ColRGA32;0)
ARRAY TEXT:C222(ColRGA33;0)
ARRAY TEXT:C222(ColRGA34;0)
ARRAY TEXT:C222(ColRGA35;0)
ARRAY TEXT:C222(ColRGA36;0)
ARRAY TEXT:C222(ColRGA37;0)
ARRAY TEXT:C222(ColRGA38;0)
ARRAY TEXT:C222(ColRGA40;0)
OBJECT SET VISIBLE:C603(*;"Adilva@";False:C215)
VarCDFichier:=""