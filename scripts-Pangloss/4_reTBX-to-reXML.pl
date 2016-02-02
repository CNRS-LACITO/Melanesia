#! C:\perl\bin\perl.exe

# Emplacement du fichier d entree
  open (IN, 'a_Tbx-avec-AUDIO/AF_Gaua-pangloss.xml')|| die "Probleme à l'ouverture du fichier d'entrée";

# Emplacement du fichier resultat
  open (OUT, '>b_Fichier-XML_pour-Pangloss/AF_Gaua-pangloss.xml')|| die "Probleme à l'ouverture du fichier de sortie";
  
 print OUT "<ALL>\n";
 
$texte=0;
$phrase=0;
$autretexte="";
$transcription="";
$ref="";

while ($line=<IN>) {	

	if ($texte==0 and $line=~s/<tiGroup>//g){
				$texte=1;
				print "ouidebut\n";
		}
	elsif ($texte==1 and $line=~s/<ti>(.*)<\/ti>//g){
			$texte=1;
			$titre=$1;			
			print "$titre\n";
			
	}
	elsif($texte==1 and $line=~s/<filename>(<|&lt;)sf_pre(>|&gt;)(.*)(<|&lt;)sf_post(>|&gt;)<\/filename>//g){
		if(length($ref)>1){
			print "cool";
			$ref=$ref."</idt>\n<idt>".$3;
		}else{
			$ref=$3;
		}
	}
	elsif ($texte==1 and $line=~s/<id>(.*)<\/id>//g){
			$id=$1;
			
			@id_temp=split(/\./,$id);
			print "$id_temp[0]\n";
			if ($#id_temp+1==2){
			$id_lg=lc($id_temp[0]);
			$id_txt=uc($id_temp[1]);
			$id_ok="crdo-".uc($id_lg)."_".$id_txt;
			}
	}
#	elsif ($texte==1 and $phrase==1 and $line=~s/<rn>(.*)<\/rn>//g){
#			$rn="\\rn $1";		
#	}
	#elsif ($texte==1 and $line=~s/<rn>(.*)<\/rn>//g){
	#		$audio=$1;
	#}
	elsif ($texte==1 and $phrase==0 and $line=~s/<rf>(.*)<\/rf>//g){
			$s=$1;
			$s=~ tr/./_/;
			
			print OUT "<TEXT id=\"$id_ok\" xml:lang=\"$id_lg\">\n";			
			print OUT "<HEADER>\n";			
			print OUT "<TITLE xml:lang=\"fr\">$titre</TITLE>\n";
			print OUT "<idt>$ref</idt>\n";
			print OUT "</HEADER>\n";	
			$phrase=1;
			$ref="";
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<tv>(.*)<\/tv>//g){
			$transcription="$1";
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<tq>(.*)<\/tq>//g){
			if(length($autretexte)>1){
				$autretexte=$autretexte."<br/><b>$1</b>";		
			}else{
				$autretexte="<b>$1</b>";
			}
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<ch>(.*)<\/ch>//g){
			if(length($autretexte)>1){
				$autretexte=$autretexte."<br/>\n<i>$1</i>";		
			}else{
				$autretexte="<i>$1</i>";
			}	
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<tf>(.*)<\/tf>//g){
			$traduction="$1";
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<ta>(.*)<\/ta>//g){
			$translation="$1";
	}
	
	# deux prochains sont ajoutés pour AUDIO
	elsif ($texte==1 and $phrase==1 and $line=~s/<AUDbegin>(.*)<\/AUDbegin>//g){
			$begin="$1";		
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<AUDend>(.*)<\/AUDend>//g){
			$end="$1";		
	}

	#elsif ($texte==1 and $phrase==1 and $line=~s/<pc>(.*)<\/pc>//g){
	#		$pc="\\pc $1";		
	#}

	elsif ($texte==1 and $phrase==1 and $line=~s/<rf>(.*)<\/rf>//g){
	
			 print OUT "<S id=\"$s\">\n";
			 if (length($transcription)>1){
				if(length($autretexte)>1){
					print OUT "<FORM>$transcription<br/>\n$autretexte</FORM>\n";	
				}else{
					print OUT "<FORM>$transcription</FORM>\n";	
				}
			}else{
				if(length($autretexte)>1){
					print OUT "<FORM>$autretexte</FORM>\n";	
				}else{
					print OUT "<FORM></FORM>\n";	
				}
			}
			 
			 if (length($traduction)>1) { print OUT "<TRANSL xml:lang=\"fr\">$traduction</TRANSL>\n";}
			 if (length($translation)>1) {print OUT "<TRANSL xml:lang=\"en\">$translation</TRANSL>\n";}			
			 # if (length($rn)>3) { print OUT "<NOTE message=\"$rn\"\/>\n";}
			 if (length($begin)>1) {print OUT "<AUDIO start=\"$begin\" end=\"$end\"></AUDIO>\n";}			

	#		 if (length($pc)>3) {print OUT "<NOTE message=\"$pc\"\/>\n";}

				
			 print OUT "</S>\n";			
			 $s=$1;
			 $s=~ tr/./_/;
			$transcription="";
			$traduction="";
			$translation="";
	#		$pc="";
			$tq="";
			$ch="";
			$sound="";
			$begin="";
			$autretexte="";
	}
	elsif ($texte==1 and $line=~s/<\/tiGroup>//g){
			$titre=$1;	
			
			print "ouifin\n";
			
			print OUT "<S id=\"$s\">\n";
			 if (length($transcription)>1){
				if(length($autretexte)>1){
					print OUT "<FORM>$transcription<br/>$autretexte</FORM>\n";	
				}else{
					print OUT "<FORM>$transcription</FORM>\n";	
				}
			}else{
				if(length($autretexte)>1){
					print OUT "<FORM>$autretexte</FORM>\n";	
				}else{
					print OUT "<FORM></FORM>\n";	
				}
			}
			 
			 if (length($traduction)>1) { print OUT "<TRANSL xml:lang=\"fr\">$traduction</TRANSL>\n";}
			 if (length($translation)>1) {print OUT "<TRANSL xml:lang=\"en\">$translation</TRANSL>\n";}			
			 # if (length($rn)>3) { print OUT "<NOTE message=\"$rn\"\/>\n";}
			 if (length($begin)>1) {print OUT "<AUDIO start=\"$begin\" end=\"$end\"></AUDIO>\n";}			

			 if (length($sound)>1) { print OUT "<NOTE message=\"Url=$sound\"\/>\n";}			 
					
			 print OUT "</S>\n";			
			 # $s=$1;
			 $s=~ tr/./_/;
			$transcription="";
			$traduction="";
			$translation="";
			#$pc="";
			$tq="";
			$ch="";
			$texte=0;
			$sound="";
			$begin="";
			$autretexte="";

			
			print OUT "</TEXT>\n";			
			
			$phrase=0;			
			
	}
}
	
	 print OUT "</ALL>\n";
	close(IN);
	close(OUT);
