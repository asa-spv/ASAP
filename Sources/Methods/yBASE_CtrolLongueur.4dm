//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick
  // Date et heure : 21/10/11
  // ----------------------------------------------------
  // Méthode : Base_CtrolLongueur
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($1;$Lmax)

$Lmax:=$1

Case of 
	: (Form event code:C388=Sur après frappe clavier:K2:26)
		
		If (Length:C16(ST Get plain text:C1092(OBJECT Get pointer:C1124(Objet courant:K67:2)->))>($Lmax-1))
			
			yBASE_Alerte (Get localized string:C991("longueur atteinte")+String:C10($Lmax)+Get localized string:C991("caracteres"))
			
			GOTO OBJECT:C206(OBJECT Get pointer:C1124(Objet courant:K67:2)->)
			  // Attention à l'écriture de la ligne ci-dessous :-)
			(OBJECT Get pointer:C1124(Objet courant:K67:2))->:=Substring:C12(ST Get plain text:C1092(OBJECT Get pointer:C1124(Objet courant:K67:2)->);1;58)
			HIGHLIGHT TEXT:C210(OBJECT Get pointer:C1124(Objet courant:K67:2)->;1;Length:C16(OBJECT Get pointer:C1124(Objet courant:K67:2)->)+1)
			
		End if 
End case 
