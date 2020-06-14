//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 13/08/19, 06:19:13
  // ----------------------------------------------------
  // Méthode : ASAPFabriqueObjetConnexion
  // Description
  // Méthode qui met dans l'objet [WebConnexions]Arguments
  //  les tableaux recueillis sur le Web  : TbNumEch TbNumEchT TbNumEnrRaemaRetenu
  //   TbNomsP2 TbValeursP2 TbNomsP3 TbValeursP3 TbTexteResume TbPJMailRaema)
  // ----------------------------------------------------
ARRAY TEXT:C222($TbNumEch;0)
ARRAY TEXT:C222($TbNumEchT;0)
ARRAY TEXT:C222($TbNomsP2;0)
ARRAY TEXT:C222($TbValeursP2;0)
ARRAY TEXT:C222($TbNomsP3;0)
ARRAY TEXT:C222($TbValeursP3;0)
ARRAY LONGINT:C221($TbNumEnrRaemaRetenu;0)
ARRAY TEXT:C222($TbTexteResume;0)
ARRAY TEXT:C222($TbPJMailRaema;0)

ZBlobVersVariable (->[WebConnexions:13]BlobConnexion:11;->$TbNumEch;->$TbNumEchT;->$TbNumEnrRaemaRetenu;->$TbNomsP2;->$TbValeursP2;->$TbNomsP3;->$TbValeursP3;->$TbTexteResume;->$TbPJMailRaema)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbNumEch";$TbNumEch)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbNumEchT";$TbNumEchT)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbNumEnrRaemaRetenu";$TbNumEnrRaemaRetenu)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbNomsP2";$TbNomsP2)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbValeursP2";$TbValeursP2)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbNomsP3";$TbNomsP3)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbValeursP3";$TbValeursP3)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbTexteResume";$TbTexteResume)
OB SET ARRAY:C1227([WebConnexions:13]Arguments:15;"TbPJMailRaema";$TbPJMailRaema)