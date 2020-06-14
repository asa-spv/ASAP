//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 24/09/19, 09:45:33
  // ----------------------------------------------------
  // Méthode : ASAPFactureGereReglement
  // Description
  // Met le booléen [Factures]Regle à Vrai ou Faux
  //   en fonction des [Ventes]DateReglement 
  //   qui  sont liées à la facture courante
  // ----------------------------------------------------

RELATE MANY:C262([Factures:15]NumFacture:3)  // Raooel des ventes
SELECTION TO ARRAY:C260([Ventes:16]DateReglement:12;$TbDateRéglement)
[Factures:15]Regle:12:=(Find in array:C230($TbDateRéglement;!00-00-00!)=-1)
  // Si on trouve une date nulle c'est que le réglrment n'est pas complet donc chercher dans tableau vaut qualque chose
  // Si on ne trouve as de date nulle c'est que tout a été réglé et chercher dans tableau vaut -1
  // [Factures]Regle prend donc qu'on ne trouve pas de vente non réglée