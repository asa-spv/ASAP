


QUERY BY ATTRIBUTE:C1331([XTachesDeFond:10]; & ;[XTachesDeFond:10]ObjetTdF:2;"DateHeureDebutExécution";=;Current date:C33;*)
QUERY BY ATTRIBUTE:C1331([XTachesDeFond:10]; & ;[XTachesDeFond:10]ObjetTdF:2;"NomMéthode";=;"RapPlaceDocumentsDansWeb";*)
QUERY BY ATTRIBUTE:C1331([XTachesDeFond:10]; & ;[XTachesDeFond:10]ObjetTdF:2;"Accompli";=;False:C215;*)
QUERY BY ATTRIBUTE:C1331([XTachesDeFond:10]; & ;[XTachesDeFond:10]ObjetTdF:2;"Destinataire";=;"serveur")

$OC:=True:C214
$Ordre:=0
If (Records in selection:C76([XTachesDeFond:10])>0)
	$Mess:="Une demande d'incorporation de documents a déjà eu lieu aujourd'hui : "
	$Mess:=$Mess+"si vous voulez VRAIMENT réitérer cette demande, cliquez OK, sinon cliquez sur Annuler"
	ALERT:C41($Mess)
	CONFIRM:C162("Voulez-vous VRAIMENT réitérer cette demande ???")
	$OC:=(OK=1)
	$Ordre:=[XTachesDeFond:10]OrdrePassage:4+1
End if 

If ($OC)
	CREATE RECORD:C68([XTachesDeFond:10])
	[XTachesDeFond:10]OrdrePassage:4:=$Ordre
	OB SET:C1220([XTachesDeFond:10]ObjetTdF:2;"DateHeureDebutExécution";Current date:C33)
	OB SET:C1220([XTachesDeFond:10]ObjetTdF:2;"Accompli";False:C215)
	OB SET:C1220([XTachesDeFond:10]ObjetTdF:2;"NomMéthode";"RapPlaceDocumentsDansWeb")
	OB SET:C1220([XTachesDeFond:10]ObjetTdF:2;"Destinataire";"serveur")
	SAVE RECORD:C53([XTachesDeFond:10])
End if 