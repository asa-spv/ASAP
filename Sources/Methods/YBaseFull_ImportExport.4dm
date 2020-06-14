//%attributes = {}
If (False:C215)
	  // Generic Export/Import of whole database as XML files
	  // handles automatically all field types, including blobs or subtables
	  // command must be called BEFORE Set Field Titles is used - else only fields from that list, specially for subtables, are used...
	
	  //call it as:
	  // ALERTE(SUPPORT_FULL_ImportExport ("Import";""))
	  // or
	  // ALERTE(SUPPORT_FULL_ImportExport ("Import";"C:\\myxmlfolder"))
	  // or similar to export:
	  // ALERTE(SUPPORT_FULL_ImportExport ("Export";""))
	
	  // IMPORTANT: specially for large databases you should disable 4D's logfile (for backup integration)
	  // before you start importing. Else all operations are written to the logfile, which makes import slower
	  // if you include this method for your customer into your application, you can check using the command Log File if a log file is used.
	  // don't forget to alert the user to enable the logfile (run a full backup + create logfile) after reimport is completed!
	
	  //  XML documents are named with the table name, field names are used for XML Tags
	  // invalid character in table/field names are replaced by "_", also leading numbers (like [table]3field)
	  // this may lead to non unique field names. To avoid that it is possible to use table/field numbers as identifiers
	  // to enable that call the routine like:
	  //  ALERT(SUPPORT_FULL_ImportExport ("Import";"C:\\myxmlfolder";->OK;1))  ` use 0 for names, 1 for numbers - similar for Export
	  //  parameter 3 is an unused pointer to any existing variable, you may use the system variable OK
	  // note: using table/field names allow a reorganization of the structure. A new build structure with different table/field order
	  // can be used to reimport, because field names are used as identifiers. 
	
	  // even XML Files can be on XP larger than 2 GB this produces problems on Mac OS X, so created xml files are segmented to stay smaller than 2 GB
	
	  // copy into Compiler_xxx method to allow compilations with all variables are typed:
	  //C_TEXT(ExportImport ;$0;$1;$2)
	  //C_POINTER(ExportImport ;$3)
	  //C_LONGINT(ExportImport ;$4)
	  //C_BOOLEAN($EXPORTIMPORT_STOP)  ` this is the only project variable, to allow an external stop through a dialog/Even call
	
	  // written by Thomas Maul, 4D Germany, January 2006. to be used with 4D 2004.3 or newer
	  // note: it can be used starting with 2004.1, but large databases (SAX commands) can lead to a memory leak, fixed in 2004.3.
	  // version: 2006-02-16
	
	  // $result:=SUPPORT_FULL_ImportExport("job";$textpara;$blobparapointer;$longintpara)
End if 

C_TEXT:C284($0;$1;$2;$result;$job;$textpara)
C_POINTER:C301($3;$blobpara)  // mulitpurpose parameter, also used for pointer on field
C_LONGINT:C283($4;$longintpara)

C_BOOLEAN:C305($EXPORTIMPORT_STOP;$End)  // this is the only global variable

C_BLOB:C604($internalrecord;$SaveIndex;$blob)
C_TIME:C306($refdoc)
C_LONGINT:C283($tablenr;$fieldnr;$length;$reccounter;$vlchar;$newseqnumber;$loop;$loopfields;$subloop)
C_LONGINT:C283($pos;$pos2;$index;$i;$fieldlength;$fieldtyp;$vlascii;$total)
C_LONGINT:C283($findpos;$myevent;$subtablefield;$tablecount;$count;$maxloop;$table;$xmllevel;$segment)
C_PICTURE:C286($pict;$pictvariable)
C_POINTER:C301($tableptr;$tbl;$subfieldptr;$field;$fieldptr;$Table_Pointer)
C_TEXT:C284($result2;$name;$Filename;$vname;$vprefix;$t;$t2;$vschar;$value;$dummytext;$message;$dirsymbol)
C_TEXT:C284($subtablename;$return;$directory)
C_BOOLEAN:C305($isIndex;$readwrite)

C_LONGINT:C283($MaxExportSize)
$MaxExportSize:=1500*1024*1024  // size in Megabyte - used to segment created XML files
$End:=False:C215

If (Count parameters:C259<1)  // usefull for testing in user mode
	CONFIRM:C162("Export ou Import?\nATTENTION : un Import écrase TOUTES les données existantes !";"Export";"Import")
	If (OK=1)
		$job:="Export"
	Else 
		
		CONFIRM:C162("vous êtes sur le point de vouloir IMPORTER des données directement dans la base")
		
		If (OK=1)
			CONFIRM:C162("vous ne pourrez pas revenir en arrière !")
			
			If (BouOK=1)  //Il est OK pour réimprimer une quittance
				$job:="Import"
			Else 
				$End:=True:C214
				
			End if 
			
		Else 
			$End:=True:C214
			
		End if 
		
	End if 
	
Else 
	$job:=$1
End if 

If (Not:C34($End))
	
	$result:=""
	If (Count parameters:C259>1)
		$textpara:=$2
	Else 
		$textpara:=""
	End if 
	If (Count parameters:C259>2)
		$blobpara:=$3
	Else 
		$blobpara:=->$internalrecord
	End if 
	If (Count parameters:C259>3)
		$longintpara:=$4
	Else 
		$longintpara:=0
	End if 
	
	
	Case of 
		: ($job="Export")  //  **********************************  EXPORT ***********************************************
			$result:="Export successfull"
			If ($textpara="")
				$textpara:=Select folder:C670("Selectionner le répertoire cible")
			End if 
			If ($textpara#"")
				$dirSymbol:=YBaseFull_ImportExport ("DirSymbol")
				If ($textpara=("@"+$dirSymbol))
					$textpara:=Substring:C12($textpara;1;Length:C16($textpara)-1)
				End if 
				$refs:=Test path name:C476($textpara)
				If ($refs=0)
					$EXPORTIMPORT_STOP:=False:C215
					$tablecount:=Get last table number:C254
					For ($i;1;$tablecount)
						If (Is table number valid:C999($i))
							If (Not:C34($EXPORTIMPORT_STOP))
								If ($longintpara=1)
									$name:="Table_"+String:C10($i)
								Else 
									$name:=YBaseFull_ImportExport ("ReplaceChar";Table name:C256($i);$blobpara;1)
								End if 
								$segment:=1
								$filename:=$textpara+$dirSymbol+$name+".xml"
								If (Test path name:C476($filename)>0)
									DELETE DOCUMENT:C159($filename)
								End if 
								$refdoc:=Create document:C266($filename)
								$tbl:=Table:C252($i)
								SAX SET XML DECLARATION:C858($refdoc;"ISO-8859-1";True:C214)
								$NewSeqNumber:=Get database parameter:C643($tbl->;Numéro automatique table:K37:31)
								SAX OPEN XML ELEMENT:C853($refdoc;"Table_"+$name;"Sequenceno";String:C10($NewSeqNumber);"Total";String:C10(Records in table:C83($tbl->)))
								$readWrite:=Read only state:C362($tbl->)
								READ ONLY:C145($tbl->)
								ALL RECORDS:C47($tbl->)
								$maxloop:=Records in selection:C76($tbl->)
								For ($loop;1;$maxloop)
									If (($loop%100)=1)
										$message:=Table name:C256($i)+" ("+String:C10($i)+"/"+String:C10($tablecount)+")"+": "+String:C10($loop)+" / "+String:C10($maxloop)
										YBaseFull_ImportExport ("Message";$message)
										If (Get document position:C481($refdoc)>$MaxExportSize)  //  create a new segment
											$segment:=$segment+1
											CLOSE DOCUMENT:C267($refdoc)
											$filename:=$textpara+$dirSymbol+$name+"-"+String:C10($segment)+".xml"
											If (Test path name:C476($filename)>0)
												DELETE DOCUMENT:C159($filename)
											End if 
											$refdoc:=Create document:C266($filename)
											$tbl:=Table:C252($i)
											SAX SET XML DECLARATION:C858($refdoc;"ISO-8859-1";True:C214)
											SAX OPEN XML ELEMENT:C853($refdoc;"Table_"+$name;"Total";String:C10(Records in table:C83($tbl->)))
										End if 
									End if 
									SAX OPEN XML ELEMENT:C853($refdoc;"T_"+$name)
									  // now loop through all fields
									For ($loopfields;1;Get last field number:C255($tbl))
										If (Is field number valid:C1000($tbl;$loopfields))
											$fieldptr:=Field:C253($i;$loopfields)
											If ($longintpara=1)
												$vname:="F_"+String:C10($loopfields)
												$result2:=YBaseFull_ImportExport ("ExportField";$vname;$fieldptr;$refdoc+0)
											Else 
												$result2:=YBaseFull_ImportExport ("ExportField";"";$fieldptr;$refdoc+0)
											End if 
											If ($result2#"")
												$EXPORTIMPORT_STOP:=True:C214
												$result:=$result2
											End if 
											If ($EXPORTIMPORT_STOP)
												$loopfields:=Get last field number:C255($tbl)+1
											End if 
										End if 
									End for 
									SAX CLOSE XML ELEMENT:C854($refdoc)
									If (Process aborted:C672)
										$EXPORTIMPORT_STOP:=True:C214
									End if 
									If ($EXPORTIMPORT_STOP)
										$loop:=$maxloop+1
									End if 
									NEXT RECORD:C51($tbl->)
									
								End for 
								SAX CLOSE XML ELEMENT:C854($refdoc)
								REDUCE SELECTION:C351($tbl->;0)
								If (Not:C34($readWrite))
									READ WRITE:C146($tbl->)
								End if 
								CLOSE DOCUMENT:C267($refdoc)
							End if 
							If ($EXPORTIMPORT_STOP)
								$i:=Get last table number:C254+1
							End if 
						End if 
					End for 
				Else 
					$result:="ExportImport: Erreur -Chemin cible invalide"
				End if 
			End if 
			
			
		: ($job="Import")  //  **********************************  IMPORT ***********************************************
			$result:="Import successfull"
			If ($textpara="")
				$textpara:=Select folder:C670("Désigner le répertoire contenant les fichiers d'Exports XML")
			End if 
			If ($textpara#"")
				$dirSymbol:=YBaseFull_ImportExport ("DirSymbol")
				If ($textpara=("@"+$dirSymbol))
					$textpara:=Substring:C12($textpara;1;Length:C16($textpara)-1)
				End if 
				$refs:=Test path name:C476($textpara)
				If ($refs=0)
					$EXPORTIMPORT_STOP:=False:C215
					For ($table;1;Get last table number:C254)
						If (Is table number valid:C999($table))
							If (Not:C34($EXPORTIMPORT_STOP))
								If ($longintpara=1)
									$name:="Table_"+String:C10($i)
								Else 
									$name:=YBaseFull_ImportExport ("ReplaceChar";Table name:C256($table);$blobpara;1)
								End if 
								$filename:=$textpara+$dirSymbol+$name+".xml"
								If (Test path name:C476($filename)=1)
									SET BLOB SIZE:C606($SaveIndex;0)
									YBaseFull_ImportExport ("GetAllIndex";"";->$SaveIndex;$table)
									YBaseFull_ImportExport ("SetIndex";"Clear";->$SaveIndex;$table)
									$Table_Pointer:=Table:C252($table)
									$readWrite:=Read only state:C362($Table_Pointer->)
									READ WRITE:C146($Table_Pointer->)
									ALL RECORDS:C47($Table_Pointer->)
									If (Records in selection:C76($Table_Pointer->)>0)
										DELETE SELECTION:C66($Table_Pointer->)
									End if 
									$maxloop:=Get last field number:C255($Table_Pointer)
									ARRAY TEXT:C222($fieldnames;$maxloop)
									$Reccounter:=1
									For ($loopfields;1;$maxloop)
										If ($longintpara=1)
											$fieldnames{$loopfields}:="F_"+String:C10($loop)
										Else 
											$fieldnames{$loopfields}:=YBaseFull_ImportExport ("ReplaceChar";Field name:C257($table;$loopfields);$blobpara;1)
										End if 
									End for 
									$xmllevel:=0
									$total:=0
									$segment:=1
									
									Repeat 
										If ($segment>1)  // only for additional segments - large XML files
											$filename:=$textpara+$dirSymbol+$name+"-"+String:C10($segment)+".xml"
										End if 
										If (Test path name:C476($filename)=1)
											$refdoc:=Open document:C264($filename;"TEXT";Mode lecture:K24:5)
											Repeat 
												$MyEvent:=SAX Get XML node:C860($refdoc)
												Case of 
													: ($MyEvent=XML début document:K45:7)
														  // nothing?
													: ($MyEvent=XML début élément:K45:10)
														SAX GET XML ELEMENT:C876($refdoc;$vName;$vPrefix;$attrName;$attrvalue)
														Case of 
															: ($xmllevel=0)  // start of XML file, main level
																If ($vName#("table_"+$name))
																	$result:="Erreur Majeure de contenu "+$vName+" - Table_"+$name
																	$EXPORTIMPORT_STOP:=True:C214
																Else 
																	$xmllevel:=1
																	$NewSeqNumber:=0
																	$findpos:=Find in array:C230($attrName;"Sequenceno")
																	If ($findpos>0)
																		$NewSeqNumber:=Num:C11($attrvalue{$findpos})
																	End if 
																	$findpos:=Find in array:C230($attrName;"Total")
																	If ($findpos>0)
																		$total:=Num:C11($attrvalue{$findpos})
																	End if 
																End if 
															: ($xmllevel=1)  // start of new record, check table name
																If ($vName#("T_"+$name))
																	$result:="Erreur dans le nom de la Table "+$vName+" T_"+$name
																	$EXPORTIMPORT_STOP:=True:C214
																Else 
																	$xmllevel:=2
																	CREATE RECORD:C68($Table_Pointer->)
																	$Reccounter:=$Reccounter+1
																	If (($Reccounter%10)=1)
																		$message:=Table name:C256($table)+" "+String:C10($Reccounter)+" / "+String:C10($total)
																		YBaseFull_ImportExport ("Message";$message)
																	End if 
																End if 
																
															: ($xmllevel>=2)  // subtable? `EST ENCORE LE CAS EN V11
																If ($vName="Sub_@")
																	$subtablename:=Substring:C12($vName;5)  // remove "Sub_"
																	$loopfields:=Find in array:C230($fieldnames;$subtablename)
																	If ($loopfields>0)
																		  // create array subtables ...
																		$fieldptr:=Field:C253($table;$loopfields)
																		GET FIELD TITLES:C804($fieldptr->;$subnames;$subid)
																		If ($longintpara=1)  // use numbers, not field names
																			For ($i;1;Size of array:C274($subnames))
																				$subnames{$i}:="Sub_"+String:C10($i)
																			End for 
																		End if 
																		_O_CREATE SUBRECORD:C72($fieldptr->)
																		$subtablefield:=$loopfields
																	End if 
																End if 
																$xmllevel:=$xmllevel+1
														End case   // $MyEvent=XML Start Element 
														
													: ($MyEvent=XML CDATA:K45:13)
														If ($xmllevel=3)
															$loopfields:=Find in array:C230($fieldnames;$vName)
															If ($loopfields>0)
																SAX GET XML CDATA:C878($refdoc;$blob)
																If (OK=1)
																	BASE64 DECODE:C896($blob)
																	$fieldptr:=Field:C253($table;$loopfields)
																	$Fieldtyp:=Type:C295($fieldptr->)
																	Case of 
																		: ($Fieldtyp=Est un BLOB:K8:12)
																			$fieldptr->:=$blob
																			SET BLOB SIZE:C606($blob;0)
																		: ($Fieldtyp=Est une image:K8:10)
																			BLOB TO VARIABLE:C533($blob;$pictVariable)
																			SET BLOB SIZE:C606($blob;0)  // to free up memory
																			$fieldptr->:=$pictVariable
																	End case 
																End if 
															End if 
														End if 
														
													: ($MyEvent=XML DATA:K45:12)
														Case of 
															: ($xmllevel=3)
																  // Name of element is already in $vName
																$loopfields:=Find in array:C230($fieldnames;$vName)
																If ($loopfields>0)
																	  // known field, get field value and assign
																	SAX GET XML ELEMENT VALUE:C877($refdoc;$value)
																	$result2:=YBaseFull_ImportExport ("ImportField";$value;Field:C253($table;$loopfields);$refdoc+0)
																	If ($result2#"")
																		$EXPORTIMPORT_STOP:=True:C214
																		$result:=$result2
																	End if 
																End if 
																
															: ($xmllevel=4)  // subtable
																  // Name of element is already in $vName
																$loopfields:=Find in array:C230($subnames;$vName)
																If ($loopfields>0)
																	  // known field, get field value and assign
																	SAX GET XML ELEMENT VALUE:C877($refdoc;$value)
																	$subfieldptr:=Field:C253($table;$subtablefield;$subid{$loopfields})
																	$result2:=YBaseFull_ImportExport ("ImportField";$value;$subfieldptr;$refdoc+0)
																	If ($result2#"")
																		$EXPORTIMPORT_STOP:=True:C214
																		$result:=$result2
																	End if 
																End if 
														End case 
														
													: ($MyEvent=XML fin élément:K45:11)
														$xmllevel:=$xmllevel-1
														Case of 
															: ($xmllevel=1)
																SAVE RECORD:C53($Table_Pointer->)
															: ($xmllevel=0)  // table ready
																If ($NewSeqNumber#0)
																	SET DATABASE PARAMETER:C642($Table_Pointer->;Numéro automatique table:K37:31;$NewSeqNumber)
																End if 
														End case 
												End case 
												If (Process aborted:C672)
													$EXPORTIMPORT_STOP:=True:C214
												End if 
											Until (($MyEvent=XML fin document:K45:15) | ($EXPORTIMPORT_STOP))
											CLOSE DOCUMENT:C267($refdoc)
											$segment:=$segment+1
										Else   // last segment used - but still data missing!
											ALERT:C41("Import de la table "+Table name:C256($table)+" incomplet !\n"+String:C10($Reccounter)+" de "+String:C10($total)+" importés.")
										End if 
									Until (($Reccounter>=$Total) | ($EXPORTIMPORT_STOP))
									
									REDUCE SELECTION:C351($Table_Pointer->;0)
									YBaseFull_ImportExport ("SetIndex";"Set";->$SaveIndex;$table)
									If (Not:C34($readWrite))
										READ WRITE:C146($Table_Pointer->)
									End if 
									
									If (Process aborted:C672)
										$EXPORTIMPORT_STOP:=True:C214
									End if 
									If ($EXPORTIMPORT_STOP)
										$loop:=$maxloop+1
									End if 
								End if 
							End if 
							If ($EXPORTIMPORT_STOP)
								$i:=Get last table number:C254+1
							End if 
						End if 
					End for 
				Else 
					$result:="SUPPORT_FULL_ImportExport: Erreur - Le chemin Target n'est pas correct,"
				End if 
			End if 
			
			
			  //  **********************************  INTERNAL CALLS - NOT FOR DIRECT USAGE ***********************************************
			
		: ($job="ImportField")  //  **********************************  ImportField ***********************************************
			$fieldptr:=$blobpara
			$refdoc:=?00:00:00?+$longintpara
			$Fieldtyp:=Type:C295($fieldptr->)
			
			If ($fieldtyp#Est une sous table:K8:11)
				Case of 
					: ($fieldtyp=Est un champ alpha:K8:1)
						GET FIELD PROPERTIES:C258($fieldptr;$fieldtyp;$Fieldlength)
						If ($Fieldlength=0)  // subfield, checking is not possible, as long as export is unmodified it will work perfect
							$fieldptr->:=$textpara  // may need character conversation, depends on ACI0043259
							  //   $fieldptr->:=SUPPORT_FULL_ImportExport ("ReplaceCharBack";$textpara;$blobpara;0)
						Else 
							$fieldptr->:=Substring:C12($textpara;1;$Fieldlength)
							  // may need character conversation, depends on ACI0043259
						End if 
					: ($fieldtyp=Est un texte:K8:3)
						$fieldptr->:=$textpara  // may need character conversation, depends on ACI0043259
						  //   $fieldptr->:=SUPPORT_FULL_ImportExport ("ReplaceCharBack";$textpara;$blobpara;0)
					: (($fieldtyp=Est un entier:K8:5) | ($fieldtyp=Est un entier long:K8:6))
						$fieldptr->:=Num:C11($textpara)
					: ($fieldtyp=Est un numérique:K8:4)
						If (String:C10(1.2)="1,2")  // system use comma, not point
							$textpara:=Replace string:C233($textpara;".";",")
						End if 
						$fieldptr->:=Num:C11($textpara)
					: (($fieldtyp=Est une date:K8:7))
						$fieldptr->:=Date:C102($textpara)
					: (($fieldtyp=Est une heure:K8:8))
						$fieldptr->:=Time:C179($textpara)
					: (($fieldtyp=Est un booléen:K8:9))
						$fieldptr->:=(Num:C11($textpara)=1)
					: (($fieldtyp=Est un BLOB:K8:12) | ($fieldtyp=Est une image:K8:10))
						If ($textpara#"")
							$result:="SUPPORT_FULL_ImportExport: Internal Error, found Blob without CData"+Field name:C257($fieldptr)
						End if 
						$fieldptr->:=$textpara
				End case 
			Else   //subtable, oops
				$result:="SUPPORT_FULL_ImportExport: Internal Error, found Subtable "+Field name:C257($fieldptr)
			End if 
			
			
		: ($job="ExportField")  //  **********************************  ExportField ***********************************************
			$fieldptr:=$blobpara
			$refdoc:=?00:00:00?+$longintpara
			  // check the type to convert the content
			  //  GET FIELD PROPERTIES($fieldptr;$Fieldtyp)
			$Fieldtyp:=Type:C295($fieldptr->)
			If ($textpara#"")
				$name:=YBaseFull_ImportExport ("ReplaceChar";$textpara;$blobpara;1)
			Else 
				$name:=YBaseFull_ImportExport ("ReplaceChar";Field name:C257($fieldptr);$blobpara;1)
			End if 
			If ($fieldtyp#Est une sous table:K8:11)
				If (YBaseFull_ImportExport ("CheckFieldEmpty";"";$fieldptr;$Fieldtyp)="0")
					SAX OPEN XML ELEMENT:C853($refdoc;$name)
					Case of 
						: (($fieldtyp=Est un champ alpha:K8:1) | ($fieldtyp=Est un texte:K8:3))
							SAX ADD XML ELEMENT VALUE:C855($refdoc;YBaseFull_ImportExport ("ReplaceChar";$fieldptr->;$blobpara;0))
							  // conversation maybe not needed, depends on ACI0043259
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: ($fieldtyp=Est un numérique:K8:4)
							$dummytext:=String:C10($fieldptr->)
							$dummytext:=Replace string:C233($dummytext;",";".")  // needed if used on a system with decimal comma
							SAX ADD XML ELEMENT VALUE:C855($refdoc;$dummytext)
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: (($fieldtyp=Est un entier:K8:5) | ($fieldtyp=Est un entier long:K8:6))
							SAX ADD XML ELEMENT VALUE:C855($refdoc;String:C10($fieldptr->))
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: (($fieldtyp=Est une date:K8:7))
							SAX ADD XML ELEMENT VALUE:C855($refdoc;String:C10($fieldptr->;8))  // XML Date format
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: (($fieldtyp=Est une heure:K8:8))
							SAX ADD XML ELEMENT VALUE:C855($refdoc;String:C10($fieldptr->;8))  // XML Date format
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: (($fieldtyp=Est un booléen:K8:9))
							SAX ADD XML ELEMENT VALUE:C855($refdoc;String:C10(Num:C11($fieldptr->)))
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: ($fieldtyp=Est un BLOB:K8:12)
							$blob:=$fieldptr->
							If (BLOB size:C605($blob)#0)
								BASE64 ENCODE:C895($blob)
								SAX ADD XML CDATA:C856($refdoc;$blob)
							End if 
							SAX CLOSE XML ELEMENT:C854($refdoc)
						: ($fieldtyp=Est une image:K8:10)
							$pict:=$fieldptr->
							VARIABLE TO BLOB:C532($pict;$blob)
							If (BLOB size:C605($blob)#0)
								BASE64 ENCODE:C895($blob)
								SAX ADD XML CDATA:C856($refdoc;$blob)
							End if 
							SAX CLOSE XML ELEMENT:C854($refdoc)
						Else 
							$result:="SUPPORT_FULL_ImportExport: Internal Error - Unkown Fieldtyp - cannot handle "+Field name:C257($fieldptr)
					End case 
				End if 
			Else   //subtable, oops
				_O_ALL SUBRECORDS:C109($fieldptr->)
				ARRAY TEXT:C222($subnames;0)
				ARRAY LONGINT:C221($subid;0)
				GET FIELD TITLES:C804($fieldptr->;$subnames;$subid)
				If ($textpara#"")
					For ($i;1;Size of array:C274($subnames))
						$subnames{$i}:="Sub_"+String:C10($i)
					End for 
				End if 
				$tablenr:=Table:C252($fieldptr)
				$fieldnr:=Field:C253($fieldptr)
				While (Not:C34(_O_End subselection:C37($fieldptr->)))
					SAX OPEN XML ELEMENT:C853($refdoc;"Sub_"+$name)
					For ($subloop;1;Size of array:C274($subnames))
						$subfieldptr:=Field:C253($tablenr;$fieldnr;$subid{$subloop})
						$result:=YBaseFull_ImportExport ("ExportField";$subnames{$subloop};$subfieldptr;$refdoc+0)
						If ($result#"")
							$EXPORTIMPORT_STOP:=True:C214
						End if 
					End for 
					SAX CLOSE XML ELEMENT:C854($refdoc)
					If (Process aborted:C672)
						$EXPORTIMPORT_STOP:=True:C214
					End if 
					If ($EXPORTIMPORT_STOP)
						_O_LAST SUBRECORD:C201($fieldptr->)
					End if 
					_O_NEXT SUBRECORD:C62($fieldptr->)
				End while 
			End if 
			
			
		: ($job="CheckFieldEmpty")  //  **********************************  CheckFieldEmpty ***********************************************
			$result:="0"
			$fieldtyp:=$longintpara
			$fieldptr:=$blobpara
			Case of 
				: (($fieldtyp=Est un champ alpha:K8:1) | ($fieldtyp=Est un texte:K8:3))
					If ($fieldptr->="")
						$result:="1"
					End if 
				: (($fieldtyp=Est un numérique:K8:4) | ($fieldtyp=Est un entier:K8:5) | ($fieldtyp=Est un entier long:K8:6))
					If ($fieldptr->=0)
						$result:="1"
					End if 
				: (($fieldtyp=Est une date:K8:7))
					If ($fieldptr->=!00-00-00!)
						$result:="1"
					End if 
				: (($fieldtyp=Est une heure:K8:8))
					If ($fieldptr->=?00:00:00?)
						$result:="1"
					End if 
				: (($fieldtyp=Est un booléen:K8:9))
					  // nothing
				: ($fieldtyp=Est un BLOB:K8:12)
					If (BLOB size:C605($fieldptr->)=0)
						$result:="1"
					End if 
				: ($fieldtyp=Est une image:K8:10)
					If (Picture size:C356($fieldptr->)=0)
						$result:="1"
					End if 
			End case 
			
		: ($job="Message")  //  **********************************  Message ***********************************************
			MESSAGE:C88($textpara)
			REDRAW WINDOW:C456
			
		: ($job="DirSymbol")  //  **********************************  DirSymbol ***********************************************
			  //PROPRIETES PLATE FORME($vlPlatform;$vlSystem;$vlMachine)
			If (<>ZPC)
				$Directory:="\\"
			Else 
				$Directory:=":"
			End if 
			$result:=$Directory
			
		: ($job="ReplaceChar")  //  **********************************  ReplaceChar ***********************************************
			$t:=$textpara
			If ($longintpara#0)  //  remove
				$return:=""
				If (Length:C16($t)>0)
					$vlAscii:=Character code:C91($t[[1]])
					If (($vlAscii>=48) & ($vlAscii<=58))
						$return:="_"
					End if 
				End if 
				For ($vlChar;1;Length:C16($t))
					$vlAscii:=Character code:C91($t[[$vlChar]])
					Case of 
						: (($vlAscii>=127) | ($vlAscii<=31))
							$vsChar:="_"
						: (Position:C15(Char:C90($vlAscii);":<>&%=' ()[]{}"+Char:C90(34))>0)
							$vsChar:="_"
						Else 
							$vsChar:=Char:C90($vlAscii)
					End case 
					$return:=$return+$vsChar
				End for 
			Else 
				$return:=""
				For ($vlChar;1;Length:C16($t))
					$vsChar:=$t[[$vlChar]]
					Case of 
						: (Position:C15($vsChar;"<>&\r\n\t")>0)  //  &#9;
							$return:=$return+"&#"+String:C10((Character code:C91($vsChar)))+";"
						: (Character code:C91($vsChar)<32)
							  // filter char!!!
						: (Character code:C91($vsChar)>127)  //  &#9;
							  //  $return:=$return+"&#"+String((Ascii($vsChar)))+";"
							$return:=$return+$vsChar
						Else 
							$return:=$return+$vsChar
					End case 
				End for 
			End if 
			$result:=$return
			
		: ($job="ReplaceCharBack")  //  **********************************  ReplaceCharBack ***********************************************
			$result:=$textpara
			$pos2:=0
			Repeat 
				If ($pos2>0)
					$result2:=Substring:C12($result;$pos2)
				Else 
					$result2:=$result
				End if 
				$pos:=Position:C15("&#";$result2)
				If ($pos>0)
					$pos:=$pos+$pos2
					$t2:=Substring:C12($result;$pos)
					$pos2:=Position:C15(";";$t2)
					$t2:=Substring:C12($t2;1;$pos2)
					$vsChar:=Substring:C12($t2;3;Length:C16($t2)-3)
					$vlAscii:=Num:C11($vsChar)
					$result:=Replace string:C233($result;$t2;Char:C90($vlAscii))
					$pos2:=$pos+1
				End if 
			Until ($pos<1)
			$result:=Replace string:C233($result;"&lt;";"<")
			$result:=Replace string:C233($result;"&gt;";">")
			$result:=Replace string:C233($result;"&amp;";"&")
			
		: ($job="GetAllIndex")  //  **********************************  GetAllIndex ***********************************************
			  // returns Blob (Boolean) Area with all index fields for the table $longintpara in $blobpara (Pointer expected)
			$tableptr:=Table:C252($longintpara)
			$count:=Get last field number:C255($tableptr)
			ARRAY BOOLEAN:C223($indexfields;$count)
			For ($loop;1;Get last field number:C255($tableptr))
				If (Is field number valid:C1000(Table:C252($tableptr);$loop))
					GET FIELD PROPERTIES:C258(Table:C252($tableptr);$loop;$fieldtyp;$length;$IsIndex)
					$indexfields{$loop}:=$IsIndex
				End if 
			End for 
			VARIABLE TO BLOB:C532($indexfields;$blobpara->)
			
		: ($job="SetIndex")  //  **********************************  SetIndex ***********************************************
			  // uses Blob (Boolean) Area with all index fields for the table $longintpara from $blobpara (Pointer expected)
			  //  $textpara="set" or "clear"
			$TablePtr:=Table:C252($longintpara)
			ARRAY BOOLEAN:C223($Indexfields;0)
			BLOB TO VARIABLE:C533($blobpara->;$Indexfields)
			For ($index;1;Size of array:C274($indexfields))
				If ($indexfields{$index})
					$field:=Field:C253(Table:C252($tableptr);$index)
					If ($textpara="set")
						SET INDEX:C344($field->;True:C214;50)
					Else 
						SET INDEX:C344($field->;False:C215;50)
					End if 
				End if 
			End for 
			
		Else 
			$result:="SUPPORT_FULL_ImportExport: Wrong call - invalid job ID"
	End case 
	
	If (Count parameters:C259<1)  // debug, call from user mode or design mode
		ALERT:C41($result)
	Else 
		$0:=$result
	End if 
End if 
CLEAR VARIABLE:C89($EXPORTIMPORT_STOP)
