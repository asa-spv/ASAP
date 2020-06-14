//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 08/05/17, 18:16:40
  // ----------------------------------------------------
  // Paramètres $1=rang (alpha) de la boite à cocher  {$2}=Vrai si RaemaGel
  // ----------------------------------------------------
  // Méthode : ResP1SortValeurBoiteP2
  // Description
  // Permet d'initialiser la boite de choix de programme
  // selon une saisie antérieure

C_TEXT:C284($1;$Rang)
$Rang:=$1
$T:=(Num:C11(Count parameters:C259=2)*"Rg")+"CB"+$Rang  // Name de la boite
$L:=Find in array:C230(TbNomsP2;$T)  // la boîte était-elle cochée ?
$0:=Num:C11($L>0)*(" checked="+<>ZGuil+"checked"+<>ZGuil)  // Cochage pertinent
