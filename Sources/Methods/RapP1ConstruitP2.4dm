//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/08/18, 04:05:54
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RapP1ConstruitP2  <= WebTelechargeDocument
  // Description
  // Construit la page 1 = choix des campagnes


C_LONGINT:C283($Salé;$FT;$Pos)
$PtTbListeDocuments:=$1
$MotDePasseActuel:=$2
$NumAdhA:=$3
$Spc:=Char:C90(160)
$THTML:=ResRaemaCréationET ("Récupération des documents")
$THTML:=$THTML+"<br /><br /><br />"
If (TypeDemande#"Fac")
	$THTML:=$THTML+"<form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil+"Post"+<>ZGuil+" action="+<>ZGuil+"RapP2MF"+TypeDemande+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"  <p> "+<>ZCR
	$THTML:=$THTML+"    <input type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hiddenField"+<>ZGuil+" value="+<>ZGuil+$MotDePasseActuel+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"  </p>"+<>ZCR
End if 
$TitrePage:=(Num:C11(TypeDemande="Fac")*"FACTURES")+(Num:C11(TypeDemande="Rap")*"RAPPORTS")+(Num:C11(TypeDemande="Att")*"ATTESTATIONS")
$THTML:=$THTML+"<p class="+<>ZGuil+"hautpage bleu"+<>ZGuil+">TELECHARGEMENT DES "+$TitrePage+" </font> </p><br /><br />"+<>ZCR
Case of 
		
	: (TypeDemande="Rap") | (TypeDemande="Att")
		
		  //$NomCourt:="RI"+NumLaboActuelA+".pdf"
		  //$DossierPageWeb:=<>PermCheDosRap
		  //$DocChemin:=$DossierPageWeb+$Nomcourt
		  //$DocEstLa:=Vrai
		$THTML:=$THTML+"  <p class="+<>ZGuil+"textecentre xdtitrelivre"+<>ZGuil+">"
		$Dep:="48"  // première campagne avec récupération du rapport informatique
		
		  //TRIER TABLEAU($PtTbNomRapport->;<)
		  // Annonce de l'accès aux rapports antérieurs sur  la page Web
		  //$THTML:=$THTML+"  <p>&nbsp;</p> <p>&nbsp;</p>"+◊ZCR
		$THTML:=$THTML+"  <p class="+<>ZGuil+"textecentre xdtitrelivre"+<>ZGuil+">"
		If (TypeDemande="Rap")
			$THTML:=$THTML+" Accès aux rapports des campagnes disponibles</p><br /><br />"+<>ZCR  // Annonce de l'accès aux rapports généraux antérieurs sur  la page Web
		Else 
			$THTML:=$THTML+" Accès aux attestations des campagnes disponibles</p><br /><br />"+<>ZCR  // Annonce de l'accès aux attestations antérieures sur  la page Web
		End if 
		$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR  // ouverture du paragraphe
		  //$THTML:=$THTML+"<p class="+<>ZGuil+"xdtitrelivre"+<>ZGuil+">Rapport disponibles</p>"+<>ZCR
		  // $FT:=Taille tableau($PtTbNomRapport->)
		$FT:=Size of array:C274($PtTbListeDocuments->)
		For ($Salé;1;$FT)
			$Br:=Num:C11($Salé%10=0)*" <br /> "
			  // Les noms des fichiers des rapports individuels sont de type RI58A_28.pdf
			$NumRaema:=$PtTbListeDocuments->{$Salé}
			  //$Pos:=Position("_";$NumRaema)
			  //Si ($Pos>2)  // Elimination des fichiers autres que dossier
			  //$NumRaema:=Sous chaîne($NumRaema;1;($Pos-1))  // Elimination au delà de l'underscore = 58A
			$THTML:=$THTML+"<input type="+<>ZGuil+"checkbox"+<>ZGuil+" name="+<>ZGuil+$NumRaema+<>ZGuil\
				+" value="+<>ZGuil+$NumRaema+<>ZGuil+" /> "+$NumRaema+($Spc*4)+$Br+<>ZCR  // écriture des cases à cocher existantes
			  // Fin de si 
		End for 
		  // mettons le bouton pour valider 
		$THTML:=$THTML+"<br /><br /><input class="+<>ZGuil+"hautpage"+<>ZGuil+" type="+<>ZGuil+"submit"+<>ZGuil
		$THTML:=$THTML+" value="+<>ZGuil+"Demander les campagnes sélectionnées"+<>ZGuil+" />"
		
		$THTML:=$THTML+"</p>"+<>ZCR  // fermeture du paragraphe
		
		$THTML:=$THTML+"   <br /><br /><br /><br />"+<>ZCR
		$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage bleu"+<>ZGuil+">"
		$THTML:=$THTML+"     Pour toutes questions, n'hésitez pas à contacter l'ASA"
		$THTML:=$THTML+"  </p>"+<>ZCR  // Annonce de l'accès aux rapports généraux antérieurs sur  la page Web
		
		$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"
		$THTML:=$THTML+"    <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">Envoyer un mail à l'ASA</a>"
		$THTML:=$THTML+"  </p>"+<>ZCR
		
		$THTML:=$THTML+"</form>"+<>ZCR
		
		
		
	: (TypeDemande="Fac")
		SORT ARRAY:C229($PtTbListeDocuments->;<)
		  // Annonce de l'accès aux rapports antérieurs sur  la page Web
		  //$THTML:=$THTML+"  <p>&nbsp;</p> <p>&nbsp;</p>"+◊ZCR
		$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR  // ouverture du paragraphe
		  //$THTML:=$THTML+"<p class="+<>ZGuil+"xdtitrelivre"+<>ZGuil+">Rapport disponibles</p>"+<>ZCR
		$FT:=Size of array:C274($PtTbListeDocuments->)
		For ($Salé;1;$FT)
			$FichierCourant:=$PtTbListeDocuments->{$Salé}
			$Pos:=Position:C15(".pdf";$FichierCourant)
			$AnneeFacture:="20"+Substring:C12($FichierCourant;1;2)
			$RTRC:=Substring:C12($FichierCourant;4;2)
			$PoudreGel:=(Num:C11($RTRC="RT")*"RAEMA Poudre")+(Num:C11($RTRC="RC")*"RAEMA Gel")
			If ($Pos>0)  // Elimination des fichiers autres que dossier
				$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+$PoudreGel+" "+$AnneeFacture+" :"+<>ZCR
				$THTML:=$THTML+"  <a href="+<>ZGuil+"PDF/Factures/"+$NumAdhA+"/"+$FichierCourant+<>ZGuil+"> "+$FichierCourant+"</a><p/><br />"+<>ZCR
			End if 
		End for 
		$THTML:=$THTML+"   <br /><br /><br /><br />"+<>ZCR
		$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage bleu"+<>ZGuil+">"
		$THTML:=$THTML+"     Pour toutes questions, n'hésitez pas à contacter l'ASA"
		$THTML:=$THTML+"  </p>"+<>ZCR  // Annonce de l'accès aux rapports généraux antérieurs sur  la page Web
		
		$THTML:=$THTML+"  <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"
		$THTML:=$THTML+"    <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">Envoyer un mail à l'ASA</a>"
		$THTML:=$THTML+"  </p>"+<>ZCR
		$THTML:=$THTML+"   <br /><br /><br /><br />"+<>ZCR
End case 



$THTML:=$THTML+ResRaemaCréationPied 
  //FIXER TEXTE DANS CONTENEUR($THTML)
$Pragma:="pragma: no-cache"
WEB SET HTTP HEADER:C660($Pragma)
WEB SEND TEXT:C677($THTML)
