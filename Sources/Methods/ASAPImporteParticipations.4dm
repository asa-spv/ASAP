//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 17/06/18, 19:26:42
  // ----------------------------------------------------
  // Méthode : ASAPImporteParticipations 
  // Description
  // méthode pour récupérer les [XDonnees] de Biblio
  //  incluant les connexions Web de réponse des laboratoires
  // ----------------------------------------------------

C_TEXT:C284($Var)
C_DATE:C307($Date)
C_TIME:C306($Doc)
C_LONGINT:C283($Fumé;$Pos;$FT;$TT;$Salé;$SFT)

PAUSE INDEXES:C1293([CampagneParticipations:17])

$Doc:=Open document:C264("";Mode lecture:K24:5)
If (OK=1)
	
	RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
	If (Ligne#"ParticipationRAEMA@")
		ALERT:C41("Désolé, il semble que le fichier ouvert ne corresponde pas aux Participations RAEMA")
	Else 
		  // le rapport de non confomité
		$Rapport:=""
		ARRAY LONGINT:C221($TbNumLaboPb;0)
		ARRAY TEXT:C222($TbComLaboPb;0)
		
		
		READ WRITE:C146([CampagneParticipations:17])
		ALL RECORDS:C47([CampagneParticipations:17])
		DELETE SELECTION:C66([CampagneParticipations:17])
		
		$Pos:=Position:C15("_";Ligne)
		$TT:=Num:C11(Substring:C12(Ligne;($Pos+1)))
		$debutLigne:=Substring:C12(Ligne;1;($Pos-1))
		$FT:=Num:C11(Substring:C12($debutLigne;9))
		
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
		
		For ($Fumé;1;$FT)
			ARRAY TEXT:C222($TbDescription;$TT)  // recueil des valeurs exportées
			$SFT:=Size of array:C274($TbDescription)-1
			For ($Salé;1;$SFT)
				YImportFichierLitColonne (->$TbDescription;$Salé)
			End for 
			$TbDescription{$SFT+1}:=Ligne
			If (False:C215)
				  // $TbDescription{1} = NumLaboRaema (alpha)
				  // $TbDescription{2} = Titre  (type "Historique connexion du labo xx pour le RAEMA xx")  INUTILE
				  // $TbDescription{3} = AEnvoyerAGestAsa  (Vrai ou Faux) INUTILE
				  // $TbDescription{4} = TexteParticipation1  // Le texte avec des £ à la place des CR qui résume les différentes connexions  
				  // $TbDescription{5} = TexteParticipation2  // résumé de la saisie des résultats type Germe / méthode\tN° échantillon\tRésultat\r\r\rMICRO-ORGANISMES AEROBIES MESOPHILES par la méthode 3 - AFNOR 3M-01/1-09/89 (Petrifilm)\r\t133624\t-3\r\t185045\t-3\r\t311573\t-3\r\t357785\t-3\r\t628890\t-3\r\t133624\t89000\r\t185045\t91000\r\t311573\t117000\r\t357785\t93000\r\t628890\t120000\r\r\rENTEROBACTERIES par la méthode 3 - AFNOR 3M-01/6-09/97 (Petrifilm)\r\t133624\t-1\r\t185045\t-1\r\t311573\t-1\r\t357785\t-1\r\t628890\t-1\r\t133624\t800\r\t185045\t750\r\t311573\t1100\r\t357785\t880\r\t628890\t960\r\r\rCOLIFORMES TOTAUX par la méthode 3 - AFNOR 3M (Petrifilm)\r\t133624\t-1\r\t185045\t-1\r\t311573\t-1\r\t357785\t-1\r\t628890\t-1\r\t133624\t670\r\t185045\t600\r\t311573\t800\r\t357785\t700\r\t628890\t900\r\r\rCOLIFORMES THERMOTOLERANTS par la méthode 3 - AFNOR 3M (Petrifilm)\r\t133624\t-1\r\t185045\t-1\r\t311573\t-1\r\t357785\t-1\r\t628890\t-1\r\t133624\t200\r\t185045\t200\r\t311573\t180\r\t357785\t250\r\t628890\t230\r\r\rESCHERICHIA COLI par la méthode 3 - AFNOR 3M (Petrifilm)\r\t133624\t-1\r\t185045\t-1\r\t311573\t-1\r\t357785\t-1\r\t628890\t-1\r\t133624\t200\r\t185045\t180\r\t311573\t190\r\t357785\t190\r\t628890\t190\r\r\rANAEROBIES SULFITO-REDUCTEURS par la méthode 1 - NF V 08-061\r\t133624\tNaN\r\t185045\t-1\r\t311573\tNaN\r\t357785\t-1\r\t628890\t-1\r\t133624\t0.1\r\t185045\t320\r\t311573\t0.1\r\t357785\t360\r\t628890\t350\r\r\rCLOSTRIDIUM PERFRINGENS par la méthode 1 - NF EN ISO 7937 (NF V 08-019)\r\t133624\tNaN\r\t185045\t-1\r\t311573\tNaN\r\t357785\t-1\r\t628890\t-1\r\t133624\t0.1\r\t185045\t290\r\t311573\t0.1\r\t357785\t290\r\t628890\t300\r\r\rSTAPHYLOCOQUES A COAGULASE POSITIVE par la méthode 1 - NF V 08-057-1 (avec confirmation)\r\t133624\t-1\r\t185045\t-1\r\t311573\t-1\r\t357785\t-1\r\t628890\t-1\r\t133624\t1950\r\t185045\t2100\r\t311573\t2300\r\t357785\t2080\r\t628890\t2400\r\r\rSALMONELLES par la méthode 1 - AFNOR BIO-12/16-09/05 (VIDAS Easy Salmonella)\r\t133624\t2 - Non\r\t185045\t2 - Non\r\t311573\t2 - Non\r\t357785\t1 - Oui\r\t628890\t1 - Oui\r\r\rLISTERIA MONOCYTOGENES RECHERCHE par la méthode 5 - AFNOR AES-10/03-09/00 (ALOA one day)\r\t133624\t1 - Oui\r\t185045\t1 - Oui\r\t311573\t2 - Non\r\t357785\t1 - Oui\r\t628890\t1 - Oui\r\r\rLISTERIA MONOCYTOGENES DENOMBREMENT par la méthode 4 - AFNOR AES-10/5-09/06 (ALOA Count)\r\t133624\t-1\r\t185045\t-1\r\t311573\tNaN\r\t357785\t-1\r\t628890\t-1\r\t133624\t2830\r\t185045\t3040\r\t311573\t0.1\r\t357785\t2950\r\t628890\t3100\r
				  // $TbDescription{6} = NumCampagne  // N° de campagne
				  // $TbDescription{7} = HorsInternet  // VRAI si envoi feuille EXCEL
				  // $TbDescription{8} = TailleRapport  // Taille du Blob      INUTILE
				  // $TbDescription{9} = Identifiant  // Combinaison NumCampagne + NumLabo     INUTILE
				  // $TbDescription{10} = RapportsPris  // VRAI si le rapport a été téléchargé
				  // $TbDescription{11} = MailEnvoiOK  // VRAI si on a envoyé le mail d'information de la disponibilité du rapport
				  // $TbDescription{12} = AdresseMailEnvoi  // Adresse mail où envoyer le mail d'information de la disponibilité du rapport
				  // $TbDescription{13} = DateEnvoiCourriel  // Date d'envoi du mail d'information de la disponibilité du rapport
				  // $TbDescription{14} = CourrielEnvoiOK  INUSITE donc INUTILISABLE
				  // $TbDescription{15} = ReponseLaboEnvoiOK  // VRAI si les résultats du laboratoire ont ete envoyés à l'ASA
				  // $TbDescription{16} = Questionnaire  // Participation au questionnaire de satisfaction
				  // $TbDescription{17} = ParticipationKO  // VRAI si le laboratoire a abandonné l'idée de participer au RAEMA alors qu'il était inscrit
				  // $TbDescription{18} = NumLaboEntier  // N° du laboratoire sous forme initiale numérique
				  // $TbDescription{19} = Sauvage        // VRAI si le laboratoire n'était pas prévu dans le loto
				  // $TbDescription{20} = IndiceCasParticulier  // Motif sous forme de ligne du PUM (Retard =1, Abandon =2)
			End if 
			$OnStocke:=True:C214
			$NumLaboRaemaA:=$TbDescription{1}
			$L:=Find in array:C230(<>TbPerNumLaboRAEMAA;$NumLaboRaemaA)  // est-ce un n° laboratoire  normal ou maître
			$L2:=ASAPTestLaboRaemaLié ($NumLaboRaemaA)  // renvoie le n° de la ligne des tableaux généraux des personnes et -1 s'il ne la trouve pas
			If ($L<0) & ($L2<0)  // le laboratoire n'existe plus 
				$OnStocke:=False:C215
				If ($L<0)
					$Com:="Le laboratoire qui existait lors de la campagne "+$TbDescription{6}+" avec le n° de RAEMA "+$NumLaboRaemaA+" n'est plus dans la liste ASAP."
					$LCom:=Find in array:C230($TbNumLaboPb;Num:C11($TbDescription{1}))
				Else 
					$Com:="Le laboratoire qui existait lors de la campagne "+$TbDescription{6}+" comme RAEMA lié à un colis supplémentaire avec rapport n'est pas noté comme tel."
					$LCom:=Find in array:C230($TbNumLaboPb;Num:C11($TbDescription{1}))
				End if 
				If ($LCom<0)
					APPEND TO ARRAY:C911($TbNumLaboPb;Num:C11($TbDescription{1}))
					APPEND TO ARRAY:C911($TbComLaboPb;$Com)
				Else 
					$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
				End if 
				
			Else   // le laboratoire existe encore
				CREATE RECORD:C68([CampagneParticipations:17])
				[CampagneParticipations:17]NumCampagne:3:=$TbDescription{6}
				[CampagneParticipations:17]TexteParticipation:4:=Replace string:C233($TbDescription{4};"£";<>ZCR)
				If ($L2>0)  // laboratoire bidon lié à un laboratoire maître
					$UUID:=<>TbPerUUID{$L2}
					$CodeLoginRaemaLié:=ASAPTrouveCodeRaemaLié ($L2;$TbDescription{1})
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"CodeRaemaLié";$CodeLoginRaemaLié)
				Else   // C'est un laboratoire maître (envoi principal)
					$UUID:=<>TbPerUUID{$L}
				End if 
				
				[CampagneParticipations:17]UUIDPersonne:2:=$UUID
				
				  // Les propriétés de [CampagneParticipation]Arguments
				  // Sauvage
				$Sauvage:=$TbDescription{19}
				If ($Sauvage="VRAI")
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"Sauvage";True:C214)
				End if 
				
				  // MailEnvoyé = réponse du laboratoire 
				$MailDisponibilitéEnvoyé:=$TbDescription{11}
				If ($MailDisponibilitéEnvoyé="VRAI")
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"MailDisponibilitéEnvoyé";True:C214)
				End if 
				
				  // DateEnvoiCourriel
				$DateEnvoiCourriel:=Date:C102($TbDescription{13})
				If ($DateEnvoiCourriel#!00-00-00!)
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"DateMailDisponibilité";$DateEnvoiCourriel)
				End if 
				
				  // ParticipeKO
				$ParticipeKO:=$TbDescription{17}
				If ($ParticipeKO="VRAI")
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"ParticipeKO";True:C214)
				End if 
				
				  // RapportPris
				$RapportPris:=$TbDescription{10}
				If ($RapportPris="VRAI")
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"RapportPris";True:C214)
				End if 
				
				  // AdresseMailRaema
				$AdresseMailRaema:=$TbDescription{12}
				If ($AdresseMailRaema#"")
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"AdresseMailRaema";$AdresseMailRaema)
				End if 
				
				  // IndiceCasParticulier
				$IndiceCasParticulier:=Num:C11($TbDescription{20})
				If ($IndiceCasParticulier>0)
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"IndiceCasParticulier";$IndiceCasParticulier)
				End if 
				
				  // Chemin du document
				$CDRapport:=<>PermCheDosRap+$TbDescription{1}+Séparateur dossier:K24:12+"RI"+$TbDescription{6}+"_"+$TbDescription{1}+".pdf"
				$RapportEstLa:=(Test path name:C476($CDRapport)=Est un document:K24:1)  // Prise des rapports
				If ($RapportEstLa)
					OB SET:C1220([CampagneParticipations:17]Arguments:5;"CheminDocument";$CDRapport)
				Else 
					If ($RapportPris="VRAI")
						$Com:="Le laboratoire qui était noté comme ayant récupéré son rapport lors de la campagne "+$TbDescription{6}\
							+" n'a pas ce rapport dans son dossier."
						$LCom:=Find in array:C230($TbNumLaboPb;Num:C11($TbDescription{1}))
						If ($LCom<0)
							APPEND TO ARRAY:C911($TbNumLaboPb;Num:C11($TbDescription{1}))
							APPEND TO ARRAY:C911($TbComLaboPb;$Com)
						Else 
							$TbComLaboPb{$LCom}:=$TbComLaboPb{$LCom}+<>ZCR+$Com
						End if 
					End if 
				End if 
				
				ASAPLaveHistoriqueParticipe 
				
				SAVE RECORD:C53([CampagneParticipations:17])
			End if   // Fin de si ($L<0)
			
			RECEIVE PACKET:C104($Doc;Ligne;<>ZCR)
			
		End for 
		RESUME INDEXES:C1294([CampagneParticipations:17])
		
		CLOSE DOCUMENT:C267($Doc)
		
		SORT ARRAY:C229($TbNumLaboPb;$TbComLaboPb;>)
		$FT:=Size of array:C274($TbComLaboPb)
		$Rapport:=""
		For ($Salé;1;$FT)
			$Rapport:=$Rapport+String:C10($TbNumLaboPb{$Salé})+<>ZCR+$TbComLaboPb{$Salé}+<>ZCR2
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
	End if 
End if 

ASAPAjusteNbColisSupPoudreAR 

  //sinon
  //RÉGLER SÉRIE(13;"")
  //Si (OK=1)
  //RECEVOIR VARIABLE($Var)  // encore
  //Tant que ($Var="Encore")
  //RECEVOIR VARIABLE($Var)
  //$Pos:=Position("&";$Var)
  //$NumRAEMA:=Sous chaîne($Var;1;($Pos-1))
  //$Var:=Sous chaîne($Var;($Pos+1))

  //$Pos:=Position("&";$Var)
  //$NumCampagne:=Sous chaîne($Var;1;($Pos-1))
  //$Var:=Sous chaîne($Var;($Pos+1))

  //$Pos:=Position("&";$Var)
  //$TexteParticipe:=$Var
  //$TexteParticipe:=Remplacer chaîne($TexteParticipe;"§";<>ZCR)

  //$L:=Chercher dans tableau(<>TbPerNumLaboRAEMA;Num($NumRAEMA))
  //Si ($L>0)
  //CRÉER ENREGISTREMENT([CampagneParticipation])
  //[CampagneParticipation]NumCampagne:=$NumCampagne
  //[CampagneParticipation]TexteParticipation:=$TexteParticipe
  //[CampagneParticipation]UUIDPersonne:=<>TbPerUUID{$L}
  //OB FIXER([CampagneParticipation]Arguments;"RéponseEnvoyée";Vrai)  // export des envois à l'ASA seulement
  //STOCKER ENREGISTREMENT([CampagneParticipation])
  //Fin de si 
  //RECEVOIR VARIABLE($Var)  // encore ou fin
  //Fin tant que 
  //RÉGLER SÉRIE(11)
  //Fin de si 
  //Fin de si 
