$NomDoc:=Select document:C905("";"*";"Sélectionnez le document à joindre";0)
If (OK=1) & ($NomDoc#"")
	$NomDoc:=Replace string:C233($NomDoc;" ";"_")
	$Cible:=<>PermCheDosPJCourrielSource+$NomDoc
	If (Test path name:C476($Cible)=Est un document:K24:1)
		DELETE DOCUMENT:C159($Cible)
	End if 
	COPY DOCUMENT:C541(document;$Cible)
	$Lien:="https://association.asa-spv.fr/PJCourriels/"+$NomDoc
	$Mess:="Le chemin à mettre dans le courriel pour la PJ est : "+$Lien
	$Mess:=$Mess+<>ZCR+"Il a été copié dans le presse-papier"
	ALERT:C41($Mess)
	SET TEXT TO PASTEBOARD:C523($Lien)
End if 