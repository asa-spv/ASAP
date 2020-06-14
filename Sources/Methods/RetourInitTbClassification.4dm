//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Admin
  // Date et heure : 29/09/16, 14:32:19
  // ----------------------------------------------------
  // Méthode : RetourInitTbClassification
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
QUERY:C277([XData:1];[XData:1]XNom:2="Classification des retours";*)
QUERY:C277([XData:1]; & [XData:1]XType:3="ClassificationRetours")
If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:="Classification des retours"
	[XData:1]XType:3:="ClassificationRetours"
	ARRAY TEXT:C222(PUMClassInfo;14)
	PUMClassInfo{1}:="I1-Problème de saisie des résultats"
	PUMClassInfo{2}:="I2-Problème de téléchargement des rapports"
	PUMClassInfo{3}:="I3-N’a pas reçu le mail pour le téléchargement des rapports"
	PUMClassInfo{4}:="I4-Problème de réception du mail d’information"
	PUMClassInfo{5}:="I5-Problème de mot de passe"
	PUMClassInfo{6}:="I6-Problème de connexion  au site"
	PUMClassInfo{7}:="I7-Demande d'accusé de réception"
	PUMClassInfo{8}:="I8-Demande info niveaux anticipés"
	PUMClassInfo{9}:="I9-Problème ouverture fichier récapitulatif des résultats"
	PUMClassInfo{10}:="I10-Problème de sauvegarde des données"
	PUMClassInfo{11}:="I11-Problème bon de commande RAEMA Gel"
	PUMClassInfo{12}:="I12-Problème ouverture liens dans mail"
	PUMClassInfo{13}:="I13-Problème attestation"
	$ListeInfo:=New list:C375
	ARRAY TO LIST:C287(PUMClassInfo;$ListeInfo)
	PUMClassInfo{14}:="Ajouter une valeur"
	
	ARRAY TEXT:C222(PUMClassTech;30)
	PUMClassTech{1}:="T1-Correspondance numéro d’échantillon/colis"
	PUMClassTech{2}:="T2-Demande de précision du protocole"
	PUMClassTech{3}:="T3-Demande de précision de la conservation"
	PUMClassTech{4}:="T4-Demande s’il on communique une fourchette de dilution"
	PUMClassTech{5}:="T5-Demande de modification du rapport suite à une erreur de saisie"
	PUMClassTech{6}:="T6-Demande comment tester plusieurs méthodes"
	PUMClassTech{7}:="T7-Réception de pots non conforme"
	PUMClassTech{8}:="T8-Demande de fichier Excel"
	PUMClassTech{9}:="T9-Problème microbiologique"
	PUMClassTech{10}:="T10-Demande si propose d'autres EIL"
	PUMClassTech{11}:="T11-Matériaux de référence"
	PUMClassTech{12}:="T12-Envoi des résultats en version papier"
	PUMClassTech{13}:="T13-Demande aide pour saisie"
	PUMClassTech{14}:="T14-Synthèse de résultats"
	PUMClassTech{15}:="T15-Problème de n° d'échantillon"
	PUMClassTech{16}:="T16-Retour sur méthode"
	PUMClassTech{17}:="T17-Gestion analyses"
	PUMClassTech{18}:="T18-Demande infos matrice"
	PUMClassTech{19}:="T19-Retour sur saisie"
	PUMClassTech{20}:="T20-Retour sur conditions de stockage"
	PUMClassTech{21}:="T21-Demande précision sur rapport"
	PUMClassTech{22}:="T22-Demande infos sur les souches"
	PUMClassTech{23}:="T23-Demande rapports antérieurs"
	PUMClassTech{24}:="T24-Retour sur résultats"
	PUMClassTech{25}:="T25-Demande niveau contamination"
	PUMClassTech{26}:="T26-Demande infos/solutions suite mauvais résultats"
	PUMClassTech{27}:="T27-Demande échantillons pour test méthodes"
	PUMClassTech{28}:="T28-Précision comparaison interlaboratoire"
	PUMClassTech{29}:="T29-Demande infos sur les paramètres à analyser"
	$ListeTech:=New list:C375
	ARRAY TO LIST:C287(PUMClassTech;$ListeTech)
	PUMClassTech{30}:="Ajouter une valeur"
	
	ARRAY TEXT:C222(PUMClassQual;4)
	PUMClassQual{1}:="Q1-Demande d’attestation COFRAC de l’ASA"
	PUMClassQual{2}:="Q2-Evaluation des fournisseurs"
	PUMClassQual{3}:="Q3-Conformité RAEMA aux exigences EIL accrédité"
	$ListeQual:=New list:C375
	ARRAY TO LIST:C287(PUMClassQual;$ListeQual)
	PUMClassQual{4}:="Ajouter une valeur"
	
	ARRAY TEXT:C222(PUMClassStat;8)
	PUMClassStat{1}:="S1-Correspondance groupe/milieu"
	PUMClassStat{2}:="S2-Demande d’information sur les groupes"
	PUMClassStat{3}:="S3-Demande de valeurs statistiques supplémentaires"
	PUMClassStat{4}:="S4-Demande de précision suite à la lecture rapports"
	PUMClassStat{5}:="S5-Demande infos pour les calculs"
	PUMClassStat{6}:="S6-Demande rapport pour audit"
	PUMClassStat{7}:="S7-Erreur rapport"
	$ListeStat:=New list:C375
	ARRAY TO LIST:C287(PUMClassStat;$ListeStat)
	PUMClassStat{8}:="Ajouter une valeur"
	
	ARRAY TEXT:C222(PUMClassAdmi;41)
	PUMClassAdmi{1}:="A1-Demande de délai supplémentaire pour la saisie"
	PUMClassAdmi{2}:="A2-Problème de réception du mail d’information"
	PUMClassAdmi{3}:="A3-Problème d’acheminement des échantillons"
	PUMClassAdmi{4}:="A4-Envoi d’échantillon supplémentaire lié à un problème du laboratoire"
	PUMClassAdmi{5}:="A5-Demande d’attestation"
	PUMClassAdmi{6}:="A6-Demande de tarifs"
	PUMClassAdmi{7}:="A7-Demande des dates de campagne"
	PUMClassAdmi{8}:="A8-Demande des dates de mise en ligne des rapports"
	PUMClassAdmi{9}:="A9-Demande de confirmation d’inscription"
	PUMClassAdmi{10}:="A10-Problème de mot de passe"
	PUMClassAdmi{11}:="A11-N’a pas reçu le mail suite à un changement d’interlocuteur"
	PUMClassAdmi{12}:="A12-Mise à jour de la raison sociale"
	PUMClassAdmi{13}:="A13-Demande du numéro de tracking"
	PUMClassAdmi{14}:="A14-Problème d’accusé de réception"
	PUMClassAdmi{15}:="A15-Résiliation"
	PUMClassAdmi{16}:="A16-Facturation"
	PUMClassAdmi{17}:="A17-Demande renouvellement de l’abonnement RAEMA"
	PUMClassAdmi{18}:="A18-Demande de renseignement RAEMA poudre"
	PUMClassAdmi{19}:="A19-Demande de renseignement RAEMA gel"
	PUMClassAdmi{20}:="A20-Demande de renseignement colis supplémentaire"
	PUMClassAdmi{21}:="A21-Demande de renseignement boite isotherme"
	PUMClassAdmi{22}:="A22-Demande de transporteur particulier"
	PUMClassAdmi{23}:="A23-Demande de code"
	PUMClassAdmi{24}:="A24-Demande date de mise en ligne des niveaux anticipés"
	PUMClassAdmi{25}:="A25-Facture proforma"
	PUMClassAdmi{26}:="A26-Demande de confirmation de réception des résultats"
	PUMClassAdmi{27}:="A27-Envoi colis supplémentaire suite a un mauvais résultat"
	PUMClassAdmi{28}:="A28-Mise à jour fournisseur"
	PUMClassAdmi{29}:="A29-Modification de l'abonnement RAEMA"
	PUMClassAdmi{30}:="A30-Erreur de commande"
	PUMClassAdmi{31}:="A31-Ne rendra pas ses résultats"
	PUMClassAdmi{32}:="A32-Erreur de livraison par rapport à la commande"
	PUMClassAdmi{33}:="A33-Problème de réception de colis suite à une facture impayée"
	PUMClassAdmi{34}:="A34-Retour sur date (rendu des résultats)"
	PUMClassAdmi{35}:="A35-Demande dépôt documents légaux"
	PUMClassAdmi{36}:="A36-Retour sur personnes contact"
	PUMClassAdmi{37}:="A37-Demande devis RAEMA Gel"
	PUMClassAdmi{38}:="A38-Demande confirmation de paiement"
	PUMClassAdmi{39}:="A39-Demande document accompagnement"
	PUMClassAdmi{40}:="A40-Demande rapport"
	$ListeAdm:=New list:C375
	ARRAY TO LIST:C287(PUMClassAdmi;$ListeAdm)
	PUMClassAdmi{41}:="Ajouter une valeur"
	
	$ListeClass:=New list:C375
	APPEND TO LIST:C376($ListeClass;"Administratif";1;$ListeAdm;False:C215)
	APPEND TO LIST:C376($ListeClass;"Informatique";2;$ListeInfo;False:C215)
	APPEND TO LIST:C376($ListeClass;"Qualité";3;$ListeQual;False:C215)
	APPEND TO LIST:C376($ListeClass;"Statistique";4;$ListeTech;False:C215)
	APPEND TO LIST:C376($ListeClass;"Technique";5;$ListeTech;False:C215)
	LIST TO BLOB:C556($ListeClass;[XData:1]XBlob:13)
	
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Administratif";PUMClassAdmi)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Informatique";PUMClassInfo)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Qualité";PUMClassQual)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Statistique";PUMClassStat)
	OB SET ARRAY:C1227([XData:1]XObjet:18;"Technique";PUMClassTech)
	
	SAVE RECORD:C53([XData:1])
Else 
	ARRAY TEXT:C222(PUMClassAdmi;0)
	ARRAY TEXT:C222(PUMClassInfo;0)
	ARRAY TEXT:C222(PUMClassQual;0)
	ARRAY TEXT:C222(PUMClassStat;0)
	ARRAY TEXT:C222(PUMClassTech;0)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"Administratif";PUMClassAdmi)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"Informatique";PUMClassInfo)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"Qualité";PUMClassQual)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"Statistique";PUMClassStat)
	OB GET ARRAY:C1229([XData:1]XObjet:18;"Technique";PUMClassTech)
	ListeClass:=BLOB to list:C557([XData:1]XBlob:13)
End if 
OBJECT SET VISIBLE:C603(*;"BouDelClass";False:C215)