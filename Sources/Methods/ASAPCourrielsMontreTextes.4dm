//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/01/19, 07:12:00
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPCourrielsMontreTextes
  // Description
  // Ecrit dans la zone de texte stylé le contenu de la lettre type
  // ou dans la variable LeMessageBrut 
  // si le destinataire ne souhaite recevoir un courriel stylé.
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;VarNbEMail)
C_TEXT:C284(Le_message_Style)

If (VarNbEMail=0)
	ALERT:C41("Sélectionnez d'abord les destinataires des courriels.")
Else 
	ZEntêteLettre:=[CourrielsTypes:28]Descriptif:3
	VarObjetMail:=[CourrielsTypes:28]NomLettre:2
	$PtrRichTextArea:=OBJECT Get pointer:C1124(Objet nommé:K67:5;"RTA_Text")
	$PtrRichTextArea->:=[CourrielsTypes:28]TexteType:5
	Le_message_Style:=$PtrRichTextArea->
	LeMessageBrut:=ST Get plain text:C1092($PtrRichTextArea->)
	ASAPCourrielsRenseigneChamps (TbMailPerUUID{1})
	ST COMPUTE EXPRESSIONS:C1285(Le_message_Style)
	ST COMPUTE EXPRESSIONS:C1285($PtrRichTextArea->)
End if 
