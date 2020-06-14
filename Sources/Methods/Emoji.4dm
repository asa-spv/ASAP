//%attributes = {}
  //Emoji method
  //Emoji Char := Emoji (Unicode Code Point in Hex)
  //Ex : ALERT(&quot;Don&#39;t do that &quot;+Emoji(&quot;270B&quot;)+&quot; if you care!&quot;)
$char:=""
  //C_RÉEL($real;$valueR)
  //C_ENTIER LONG($l;$i;$long;$sign)
  //TRACE
  //$unicode:=$1
  //$unicode:=Remplacer chaîne($unicode; & quot;U+ & quot;; & quot; & quot;)
  //$char:= & quot; & quot;
  //Si (Longueur($unicode) & gt;2)
  //  //Converts a Hex string into a real one
  //$valueR:=0
  //$l:=Longueur($unicode)
  //Si ($l & gt;0)
  //$unicode:=Majusc($unicode)
  //$digit:=0
  //$sign:=1
  //Boucle ($i;1;$l)
  //$asc:=Code de caractère($unicode[[$i]])
  //$good:=Vrai
  //Si (($asc & gt;47) & amp;($asc & lt;58))
  //$digit:=$asc-48
  //Sinon 
  //Si (($asc & gt;64) & amp;($asc & lt;71))
  //$digit:=$asc-55
  //Sinon 
  //$good:=Faux
  //Fin de si 
  //Fin de si 
  //Si (($l=8) & amp;($i=1))  //uLong8 -&gt; Have to test the sign bit
  //Si ($digit & gt;7)
  //$sign:=-1
  //$digit:=$digit-8
  //Fin de si 
  //Fin de si 
  //Si ($good)
  //$real:=($digit*(16^($l-$i)))
  //$valueR:=$valueR+$real
  //Fin de si 
  //Fin de boucle 
  //Si ($sign=-1)
  //$valueR:=($valueR-MAXLONG-1)
  //Fin de si 
  //Fin de si 

  //$char:= & quot; & quot;
  //Au cas ou 
  //: (($valueR & gt;0) & amp;($valueR & lt;=55295))  //U+0000 to U+D7FF
  //$char:=Caractère($valueR)
  //: (($valueR & gt;=55296) & amp;($valueR & lt;=57343))  //U+D800 to U+DFFF
  //  //No encoding
  //: (($valueR & gt;=57344) & amp;($valueR & lt;=65535))  //U+E000 to U+FFFF
  //$char:=Caractère($valueR)
  //: (($valueR & gt;=65536) & amp;($valueR & lt;=1114111))  //U+10000 to U+10FFFF
  //$valueR:=$valueR-0x00010000  //because this is the way it works...

  //$high:=($valueR & gt; & gt;10)+0xD800  //top 10 bits for for the high char+0xD800

  //$low:=($valueR & amp;0x03FF)+0xDC00  //56320 or 0xDC00 or 1101 1100 0000 0000 for the low char

  //$char:=Caractère($high)+Caractère($low)
  //Sinon   //No encoding
  //Fin de cas 
  //Fin de si 
$0:=$char