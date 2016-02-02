#! C:\perl\bin\perl.exe

# Emplacement du fichier d entree
  open (IN, '1_Exports-Tbx/1- txt_sans_son2.xml')|| die "Probleme à l'ouverture du fichier d'entrée";
 # open (IN, 'Fichiers_Toolbox/wenagon.xml')|| die "Probleme à l'ouverture du fichier d'entrée";
 
# Emplacement du fichier resultat
  open (OUT, '>2_Fichiers_XML/2- xml_sans_son.xml')|| die "Probleme à l'ouverture du fichier de sortie";
 #  open (OUT, '>Fichiers_XML/volow_son.xml')|| die "Probleme à l'ouverture du fichier de sortie";
 
 print OUT "<ALL>\n";
 
$texte=0;
$phrase=0;

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
	elsif ($texte==1 and $line=~s/<rn>(.*)<\/rn>//g){
			$audio=$1;
	}
	elsif ($texte==1 and $phrase==0 and $line=~s/<rf>(.*)<\/rf>//g){

			$s=$1;
			$s=~ tr/./_/;
			
			print OUT "<TEXT id=\"$id_ok\" xml:lang=\"$id_lg\">\n";			
			print OUT "<HEADER>\n";			
			print OUT "<TITLE xml:lang=\"fr\">$titre</TITLE>\n";
			print OUT "</HEADER>\n";	
			$phrase=1;
			
			print OUT "<S id=\"$s\">\n";	
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<tv>(.*)<\/tv>//g){
			$transcription="$1";
			 print OUT "<FORM>$transcription</FORM>\n";	
			
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<tf>(.*)<\/tf>//g){
			$traduction="$1";
			if (length($traduction)>1) { print OUT "<TRANSL xml:lang=\"fr\">$traduction</TRANSL>\n";}			
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<ta>(.*)<\/ta>//g){
			$translation="$1";
			 if (length($translation)>1) {print OUT "<TRANSL xml:lang=\"en\">$translation</TRANSL>\n";}
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<nt>(.*)<\/nt>//g){
			$nt="\\nt $1";
			if (length($nt)>3) {print OUT "<NOTE message=\"$nt\"\/>\n";}			
			 
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<ng>(.*)<\/ng>//g){
			$ng="\\ng $1";
			if (length($ng)>3) { print OUT "<NOTE message=\"$ng\"\/>\n";}
		
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<nl>(.*)<\/nl>//g){
			$nl="\\nl $1";	
			if (length($nl)>3) {print OUT "<NOTE message=\"$nl\"\/>\n";}			
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<nq>(.*)<\/nq>//g){
			$nq="\\nq $1";	
			 if (length($nq)>3) {print OUT "<NOTE message=\"$nq\"\/>\n";}
		
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<pc>(.*)<\/pc>//g){
			$pc="\\pc $1";	
			 if (length($pc)>3) {print OUT "<NOTE message=\"$pc\"\/>\n";}
				
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<tq>(.*)<\/tq>//g){
			$tq="\\tq $1";	
			 if (length($tq)>3) { print OUT "<NOTE message=\"$tq\"\/>\n";}
		
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<ch>(.*)<\/ch>//g){
			$ch="\\ch $1";		
			if (length($ch)>3) { print OUT "<NOTE message=\"$ch\"\/>\n";}		
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<rf>(.*)<\/rf>//g){
			print OUT "</S>\n";
			$s=$1;
			$s=~ tr/./_/;
			 print OUT "<S id=\"$s\">\n";			
						
			 # if (length($rn)>3) { print OUT "<NOTE message=\"$rn\"\/>\n";}
			 
			 
					
			
			 $s=$1;
			 $s=~ tr/./_/;
			$transcription="";
			$traduction="";
			$translation="";
			$nt="";
			$ng="";
			$nq="";
			$nl="";
			$pc="";
			$tq="";
			$ch="";
	}
	elsif ($texte==1 and $line=~s/<\/tiGroup>//g){
			$titre=$1;	
			
			print "ouifin\n";
			
			print OUT "<S id=\"$s\">\n";			
					
			 print OUT "</S>\n";			
			 # $s=$1;
			 $s=~ tr/./_/;
			$transcription="";
			$traduction="";
			$translation="";
			$nt="";
			$nq="";
			$nl="";
			$ng="";
			$pc="";
			$tq="";
			$ch="";
			$texte=0;
			
			print OUT "</TEXT>\n";

			
			
			
			$phrase=0;			
			
	}
	

	
}
	
	 print OUT "</ALL>\n";
	close(IN);
	close(OUT);
