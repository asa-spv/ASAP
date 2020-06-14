//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/08/18, 07:43:02
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : RaemaSuiviGraphe <= RaemaSuiviAfficheTbParticipant <= MO de VarNumRAEMA de "DlgSuiviReponse"
  //                           <= RaemaSuiviAfficheTbParticipant <= MF "DlgSuiviReponse" sur Chargement 
  // Description
  // Réalise le graphe de la campagne en cours
  //

  // Fabrication du graphe
  // Sélection des XDonnées dont type commence par n° de campagne
QUERY:C277([WebConnexions:13];[WebConnexions:13]Campagne:5=VarNumRaema;*)
VarTesteur:=WebTrouveValeurParNom ("testeur";-><>TbPerNomLong;-><>TbPerUUID)
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]UUID:1#VarTesteur;*)  // Elimination du 13
QUERY:C277([WebConnexions:13]; & [WebConnexions:13]BoolEnvoi:8=True:C214)
  //CHERCHER([XData];[XData]XType=(VarNumRaema+"@");*)
  //Si (VarNumRaema#"@A")  // Si Raema poudre la ligne précédente selectionne aussi le RAEMA Gel
  //CHERCHER([XData]; & [XData]XType#(VarNumRaema+"A@");*)  // Elimination du Rama gel
  //Fin de si 
  //CHERCHER([XData]; & [XData]XType#VarNumRaema;*)  // Elimination des connexion sans labo
  //CHERCHER([XData]; & [XData]XType#(VarNumRaema+"13");*)  // Elimination du 13
  //CHERCHER([XData]; & [XData]XBool=Vrai)  // On ne conserve que les connexions envoyées à l'ASA

  // Toutes les [XDonnées] ayant été envoyées à l'ASA pour la campagne en cours
CREATE SET:C116([XData:1];"envoiresasa")

  // Création de tableaux intermédiaires
SELECTION TO ARRAY:C260([WebConnexions:13]DateConnexion:2;TbDate;[WebConnexions:13]CodeConnexion:4;TbType)
LONGINT ARRAY FROM SELECTION:C647([WebConnexions:13];TbNumEnr)
SORT ARRAY:C229(TbDate;TbType;TbNumEnr;<)  // Tri les plus récents d'abord pour ne pas tenir compte des labos déjà comptabilisés

  // Création des tableaux affichés dans le formulaire et bases du graphe
  // initialisation des tableaux définitifs à vide
ARRAY DATE:C224(TbDateGraph;0)  // Les dates de connexion
ARRAY LONGINT:C221(TbCouleurWE;0)  // Couleur des samedis et dimaches
ARRAY LONGINT:C221(TbNbLaboGraph;0)  // Le nombre de labos par date (Y)
ARRAY TEXT:C222(TbTypeGraph;0)  // Conserve la liste des labos pris en compte
ARRAY TEXT:C222(TbXGraph;0)  // Les X = J + i
ARRAY TEXT:C222(TbWE;0)  // Le nom des jours
  // initialisation de la variable image
C_PICTURE:C286(VarGraph)  // Déclaration de la variable image qui contient le graphe sur le formulaire

  // Cherchons la date de début de campagne
  //$Nom:="Raema n°"+VarNumRaema
  //CHERCHER([XData];[XData]XType="Rae";*)
  //CHERCHER([XData];[XData]XNom=$Nom)
  //$DateDebut:=[XData]XDateSup
$L:=Find in array:C230(<>TbCampagnesNumCampagne;VarNumRaema)
$DateDebut:=<>TbCampagnesDateEnvoiColis{$L}-Current date:C33

  // Renseigner les tableaux définitifs à partir des tableaux intermédiaires
$TT:=Size of array:C274(TbDate)
If ($TT=0)
	OBJECT SET VISIBLE:C603(*;"vSVG@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"vSVG@";True:C214)
	$Max:=0
	ARRAY TEXT:C222(TbNumLaboA;0)
	ARRAY LONGINT:C221(TbNumEnrRetenus;0)
	For ($salé;1;$TT)  // Pour chaque ligne des tableaux intermédiaires
		$TypeCourant:=TbType{$Salé}
		$L2:=Find in array:C230(TbTypeGraph;$TypeCourant)  // si le type n'existe pas déjà
		If ($L2=-1)  // Première fois pour ce labo (type)
			APPEND TO ARRAY:C911(TbNumEnrRetenus;TbNumEnr{$salé})
			$labo:=Substring:C12($TypeCourant;(Length:C16(VarNumRaema)+1))
			APPEND TO ARRAY:C911(TbNumLaboA;$labo)
			  // Est-ce que la date a déjà été créée dans TbDateGraph
			$DateCourante:=TbDate{$Salé}
			$L:=Find in array:C230(TbDateGraph;$DateCourante)
			If ($L=-1)  //Pas trouvée
				$X:=String:C10($DateCourante-$DateDebut)  // Légende des X
				  //mettre du gris pour le week end
				$numjour:=Day number:C114($DateCourante)
				If ($numjour=1) | ($numjour=7)  //1 dimanche et 7 samedi
					$couleur:=0x00CCCCCC
				Else 
					$couleur:=0x00FFFFFF
				End if 
				
				APPEND TO ARRAY:C911(TbCouleurWE;$couleur)
				$NomJour:=Substring:C12(<>ZTbNomDuJour{$numjour};1;2)
				APPEND TO ARRAY:C911(TbWE;$NomJour)
				APPEND TO ARRAY:C911(TbXGraph;$X)  // le jour de connexion J+i
				APPEND TO ARRAY:C911(TbDateGraph;$DateCourante)  // Pour qu'elle apparaisse la prochaine fois
				APPEND TO ARRAY:C911(TbNbLaboGraph;1)  // Met à 1 le nombre de connexion
			Else 
				$ValeurAncienne:=TbNbLaboGraph{$L}
				TbNbLaboGraph{$L}:=$ValeurAncienne+1  // Incrémentation du nbre de labo ce jour
				$Max:=Num:C11(($ValeurAncienne+1)>$max)*($ValeurAncienne+1)
			End if 
			
			
			APPEND TO ARRAY:C911(TbTypeGraph;$TypeCourant)  // repérage d'une première connexion
		End if 
		
	End for 
	SORT ARRAY:C229(TbDateGraph;TbXGraph;TbNbLaboGraph;TbCouleurWE;TbWE;>)
	  // C_IMAGE($Image)
	ARRAY TEXT:C222($Style;12)
	$Style{1}:="black"  //Couleur des axe1
	$Style{2}:="black"  //Couleur des repères (axes sup)
	$Style{3}:="white"  //Couleur de départ du dégradé pour le fond
	$Style{4}:="white"  //Couleur d'arrivée du dégradé pour le fond
	$Style{5}:=String:C10(-90)  //Angle pour le dégradé
	$Style{6}:="black"  //Couleur de la police du titre
	$Style{7}:="none"  //Couleur du cadre de la l√©gende
	$Style{8}:="1000"  //$Img_X
	$Style{9}:="480"  //$Img_Y
	$Style{10}:="1"  //$Marge
	$Style{11}:=""
	  // $Style{11}:="Le titre de mon graphe"
	$Style{12}:="1"  //$Type
	
	$CoulY1:="red"
	$NomY1:="Max="+String:C10($Max)
	
	  //  //Serie Y2 - Sortie de l'association
	  //TABLEAU REEL($y2;0)
	  //Boucle ($a;1;Taille tableau($x))
	  //AJOUTER A TABLEAU($y2;Hasard%100)
	  //Fin de boucle 
	  //$CoulY2:="red"
	  //$NomY2:="Sortie"
	
	MESSAGES ON:C181
	
	  //$Image:=SVG_f_GFX (->$Style;->$x;->$y1;->$CoulY1;->$NomY1;->$y2;->$CoulY2;->$NomY2)
	$Image:=SVG_f_GFX (->$Style;->TbXGraph;->TbNbLaboGraph;->$CoulY1;->$NomY1)
	
	(OBJECT Get pointer:C1124(Objet nommé:K67:5;"vSVG"))->:=$Image
	GRAPH:C169(VarGraph;1;TbXGraph;TbNbLaboGraph)
	LISTBOX SELECT ROW:C912(ListBoxConnexion;0;lk supprimer de sélection:K53:3)
	
End if 