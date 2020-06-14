//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/08/18, 05:26:20
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : RapP2MF
  // Description
  // Méthode qui affiche les liens 
  //  pour télécharger les rapports, attestations et factures

C_LONGINT:C283($Fumé;$FT)
ARRAY TEXT:C222($TbNomsP2b;0)
ARRAY TEXT:C222($TbValeursP2b;0)
$Spc:=Char:C90(160)
WEB GET VARIABLES:C683($TbNomsP2b;$TbValeursP2b)

$L:=Find in array:C230($TbNomsP2b;"hiddenField")
If ($L=-1)
	MotifErreur1:="Après vérification des informations que vous avez saisies, "+<>ZCR
	MotifErreur2:="il apparaît qu'une erreur s'est produite lors de l'identification"+<>ZCR
	MotifErreur3:="Merci de bien vouloir vous reloguer ultérieurement"
	RapAffichePb ("Erreur d'identification";"VERIFICATION DES DONNEES";MotifErreur1;MotifErreur2;MotifErreur3)
Else 
	
	If (Size of array:C274($TbNomsP2b)=1)  // il n'a pas demandé de rapport
		MotifErreur1:="Après vérification des informations que vous avez saisies, "+<>ZCR
		MotifErreur2:="il apparaît que le formulaire est incorrect pour la raison suivante : "+<>ZCR
		MotifErreur3:="Vous n'avez pas choisi de campagne à télécharger"
		RapAffichePb ("Pas de choix";"VERIFICATION DES DONNEES";MotifErreur1;MotifErreur2;MotifErreur3)
	Else 
		MotDePasseActuel:=WebTrouveValeurParNom ("hiddenField";->$TbNomsP2b;->$TbValeursP2b)  // mot de passe
		NumLaboActuelA:=WebTrouveValeurParNom (MotDePasseActuel;-><>TbPerIdentificateur;-><>TbPerNumLaboRAEMAA)  // N° du labo
		$UUIDLabo:=ASAPTrouveUUIDLaboParNumero (Num:C11(NumLaboActuelA))
		$THTML:=ResRaemaCréationET ("Choix des documents")
		
		$THTML:=$THTML+"<br /><br />"+<>ZCR
		$THTML:=$THTML+"            <p class="+<>ZGuil+"hautpage bleu"+<>ZGuil+">TELECHARGEMENT DES DOCUMENTS </p>"+<>ZCR
		
		$THTML:=$THTML+"            <div id="+<>ZGuil+"warning"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                <p class="+<>ZGuil+"grandtitrepage"+<>ZGuil+">Nota bene</p>"+<>ZCR
		$THTML:=$THTML+"                <p class="+<>ZGuil+"textebanal"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                    Pour télécharger le document désiré, veuillez cliquer sur le lien du n° de RAEMA souhaité.<br />"+<>ZCR
		$THTML:=$THTML+"                    <b>En cas de difficultés</b>, utilisez le <span class="+<>ZGuil+"textebanalgrand plus"+<>ZGuil+">clic droit </span>pour faire apparaître un menu local dans lequel vous demanderez"+<>ZCR
		$THTML:=$THTML+"                    à <span class="+<>ZGuil+"textebanalgrand plus"+<>ZGuil+">enregistrer la cible du lien</span> pour pouvoir choisir"+<>ZCR
		$THTML:=$THTML+"                    l'emplacement où vous pourrez retrouver facilement le fichier pdf correspondant."+<>ZCR
		$THTML:=$THTML+"                </p>"+<>ZCR
		$THTML:=$THTML+"            </div>"+<>ZCR
		
		$THTML:=$THTML+"            <div id="+<>ZGuil+"mailto"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"                <br /><br /><br /><br /><br /><br />"+<>ZCR
		$THTML:=$THTML+"                <p class="+<>ZGuil+"hautpage bleu"+<>ZGuil+"> Pour toutes questions, n'hésitez pas à contacter l'ASA"+<>ZCR
		$THTML:=$THTML+"                  </p>"+<>ZCR
		$THTML:=$THTML+"                  <p class="+<>ZGuil+"hautpage"+<>ZGuil+"><a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+">Envoyer un mail à l'ASA</a>"+<>ZCR
		$THTML:=$THTML+"                  </p>"+<>ZCR
		$THTML:=$THTML+"            </div>"+<>ZCR
		
		$FT:=Size of array:C274($TbNomsP2b)-1
		Case of 
			: (TypeDemande="Rap")
				$THTML:=$THTML+"            <div id="+<>ZGuil+"contenu2"+<>ZGuil+">"+<>ZCR
				$THTML:=$THTML+"                    <br /><br />"+<>ZCR
				$THTML:=$THTML+"                    <p class="+<>ZGuil+"xdtitrelivre"+<>ZGuil+">Rapports individuels disponibles"+<>ZCR
				$THTML:=$THTML+"                    </p>"+<>ZCR
				$THTML:=$THTML+"                    <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
				ARRAY TEXT:C222(TableauNomFichiers;0)  // permet d'éviter de donner 2 fois le même nom de fichier aux différents rapport individuels
				$CDLabo:=<>PermCheDosFac+NumLaboActuelA+Séparateur dossier:K24:12
				
				For ($Fumé;1;$FT)
					$RI:="telechargementRI"+$TbNomsP2b{$Fumé+1}+"_"+$UUIDLabo+".pdf"  // telechargementRI67A_UUIDLabo.pdf
					$THTML:=$THTML+" <a href="+<>ZGuil+$RI+<>ZGuil+"> "+$TbNomsP2b{$Fumé+1}+"</a> "+(3*$Spc)
				End for 
				$THTML:=$THTML+"                    </p>"+<>ZCR2
				$THTML:=$THTML+"                    <br /><br />"+<>ZCR
				$THTML:=$THTML+"                    <p class="+<>ZGuil+"xdtitrelivre"+<>ZGuil+">Rapports généraux correspondants</p>"+<>ZCR
				$THTML:=$THTML+"                    <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
				For ($salé;1;$FT)
					$CD:=<>PermCheDosPdf+$TbNomsP2b{$Salé+1}+".pdf"  // lien vers le rapport général considéré
					$RG:="pdf/"+"RG"+$TbNomsP2b{$Salé+1}+".pdf"
					$THTML:=$THTML+" <a href="+<>ZGuil+$RG+<>ZGuil+"> "+$TbNomsP2b{$salé+1}+"</a> "+(3*$Spc)
				End for   // écriture du lien vers le rapport général"
				$THTML:=$THTML+"                    </p>"+<>ZCR2
				$THTML:=$THTML+"                    <br /><br />"+<>ZCR
				
				
			: (TypeDemande="Att")
				$THTML:=$THTML+"                    <p class="+<>ZGuil+"xdtitrelivre"+<>ZGuil+">Attestations de participation</p>"+<>ZCR
				$THTML:=$THTML+"                    <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
				For ($Fumé;1;$FT)
					$RI:="telechargementAt"+$TbNomsP2b{$Fumé+1}+"_"+$UUIDLabo+".pdf"  // telechargementAtt67A_UUIDLabo.pdf
					$THTML:=$THTML+" <a href="+<>ZGuil+$RI+<>ZGuil+"> "+$TbNomsP2b{$Fumé+1}+"</a> "+(3*$Spc)
				End for 
				$THTML:=$THTML+"                    </p>"+<>ZCR2
				$THTML:=$THTML+"                    <br /><br />"+<>ZCR
				$THTML:=$THTML+"                    </p>"+<>ZCR
				$THTML:=$THTML+"                    <br /><br />"+<>ZCR2
				
		End case 
		
		$THTML:=$THTML+"                    <br /><br /><br /><br />"+<>ZCR2
		
		$THTML:=$THTML+"            </div>"+<>ZCR
		
		$THTML:=$THTML+"        </div>"+<>ZCR
		
		$THTML:=$THTML+ResRaemaCréationPied 
		$Pragma:="pragma: no-cache"
		WEB SET HTTP HEADER:C660($Pragma)
		WEB SEND TEXT:C677($THTML)
		  // FIXER TEXTE DANS CONTENEUR($THTML)
	End if 
End if 

