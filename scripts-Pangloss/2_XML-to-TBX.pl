#! C:\perl\bin\perl.exe

use Encode;
use utf8;

# Emplacement du fichier d entree
  open (IN,'3_Fichiers_XML_synkro/TEA_tout.xml')|| die "Probleme  l'ouverture du fichier d'entre";

# Emplacement du fichier resultat
  open (OUT, '>4_Fichiers_retoolbox/Teanu_texts_Audio.txt')|| die "Probleme  l'ouverture du fichier de sortie";

$texte=0;
$phrase=0;
$soundfile="SOUNDFILE";
			print OUT "\\_sh v3.0  779  TextBankis\n\\_DateStampHasFourDigitYear\n\n\n";

while ($line=<IN>) {

	if ($texte==0 and $line=~s/<TITLE (.*)>(.*)<\/TITLE>//g){
			$texte=1;
			$titre=$2;			

			print OUT "\\ti $titre\n";
			print OUT"\\filename $soundfile\n\n";
			
	}
	elsif ($texte==1 and $phrase==0 and $line=~s/<S id="(.*)"><AUDIO(.*)><\/AUDIO>//g){
			$phrase=1;
			$rf=$1;
			print OUT "\\rf $rf \n";
			$audio=$2;
			$audio=~s/ start="(.*)" end="(.*)"//g;
			$audbeg=$1;
			$audend=$2;
			print OUT "\\AUDbegin $audbeg\n";
			print OUT "\\AUDend $audend\n";
			print OUT "\\wav $soundfile $audbeg $audend\n\n";
	}
	elsif ($texte==1 and $phrase==0 and $line=~s/<S id="(.*)">//g){
			$phrase=1;
			$rf=$1;
			print OUT "\\rf $rf \n";
	}

	elsif ($texte==1 and $phrase==1 and $line=~s/<FORM>(.*)<\/FORM>//g){
	
			$tv=$1;
			print OUT "\\tv $tv \n";
			
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<FORM>(.*)//g){
			$tv=$1;
			print OUT "\\tv $tv \n";
			
	}
	elsif ($texte==1 and $phrase==1 and $line=~s/<TRANSL (.*)"fr">(.*)//g){
			$tf=$2;
			$tf=~s/<\/TRANSL>//g;
			print OUT "\\tf $tf \n";
			
	}

	elsif ($texte==1 and $phrase==1 and $line=~s/<TRANSL (.*)"en">(.*)//g){
			$ta=$2;
			$ta=~s/<\/TRANSL>//g;
			print OUT "\\ta $ta \n";			
	}
	
	elsif ($texte==1 and $phrase==1 and $line=~s/<NOTE message="(.*)"\/>//g){
			$note=$1;
			print OUT "$note\n";
			
	}
	elsif ($texte==1 and $phrase==1 and $line=~m/<\/S>/g){
			print OUT "\n";
			$phrase=0;
			$note="";
			$titre="";
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
			$tv="";
			$tf="";
			$ta="";
			}
	
	elsif ($texte==1 and $line=~m/<\/TEXT>/g){
			$texte=0;			
			
	}

	
}

	close(IN);
	close(OUT);
