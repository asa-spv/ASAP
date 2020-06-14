$evt:=Form event code:C388
If ($evt=Sur chargement:K2:1)
	VarNumRaema:=<>NumCampagneEnCoursSaisie
	C_PICTURE:C286(VarGraphe)
	ARRAY TEXT:C222(PUMMotifsCP;2)
	PUMMotifsCP{1}:="Délai supplémentaire"
	PUMMotifsCP{2}:="Ne répondra pas"
	PUMMotifsCP:=1
	RaemaSuiviAfficheTbParticipant 
	OBJECT SET VISIBLE:C603(BouEnvoiFichier;False:C215)
End if 