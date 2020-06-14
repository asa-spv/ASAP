$AdresseEmail:=(OBJECT Get pointer:C1124(Objet courant:K67:2))->
ZCapitaliseChamp (->$AdresseEmail;False:C215)

If ((Not:C34(ZfCheck_Email ($AdresseEmail)) & ($AdresseEmail#"")))
	ALERT:C41("Adresse mail non valide.\nVérifier votre saisie.")
Else 
	OBJECT SET VISIBLE:C603(*;"checkOK_Email2";True:C214)
End if 

