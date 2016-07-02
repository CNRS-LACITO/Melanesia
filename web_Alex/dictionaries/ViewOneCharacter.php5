<!-- Banner -->

<table width="auto" height="40" align="center" cellpadding="8">
  <tr>
    <td width="auto" height="40" align="left"><a href="../../../index.htm" target="_blank"><img src="../images/cadre/pagayeurs_s.jpg" height="60" border="2"/></a></td>
    <td align="center"><img src="../images/cadre/AF-CK_Bandeau-Salaire-01.jpg" height="56" /><img src="../images/cadre/AF-CK_Bandeau-Salaire-02.jpg" height="56" alt="banner" /></td>
  </tr>
</table>
<!-- Menu --> 

<!-- Sub-menu -->
<table width="86%" height="20" align="center" class="fond">
  <tr>
    <?php
    		$dict = isset($_GET["dict"]) ? $_GET["dict"] : "*";
    		$lang1 = isset($_GET["lang1"]) ? $_GET["lang1"] : "*";
			$lang2 = isset($_GET["lang2"]) ? $_GET["lang2"] : "*";
			$langn = isset($_GET["langn"]) ? $_GET["langn"] : "*";

        	ViewAlphabet($dict, $lang1, $lang2, $langn);

    	    function ViewAlphabet($dict, $lang1, $lang2, $langn) {
       		    $xp = new XsltProcessor();
        	    $xsl = new DomDocument;

        	    $xsl->load('ShowAlphabetMenu.xsl');
        	    $xp->setParameter('', 'dict', $dict);
        	    $xp->setParameter('', 'lang1', $lang1);
				$xp->setParameter('', 'lang2', $lang2);
				$xp->setParameter('', 'langn', $langn);

        		// import the XSL stylesheet into the XSLT process
		        $xp->importStylesheet($xsl);

        		// create a DOM document and load the XML data
		        $xml_doc = new DomDocument;
		        $xml_doc->load("$dict/sort_order.xml");

        		// transform the XML into HTML using the XSL file
		        if ($html = $xp->transformToXML($xml_doc)) {
        			echo $html;
          	    } else {
            		trigger_error('XSL transformation failed.', E_USER_ERROR);
        		}
	        }
        ?>
  </tr>
</table>

<!-- Body -->
<table width="86%" height="700" align="center" class="fond" cellpadding="25">
  <tr> 
    <!-- Left menu -->
    <td width="10%" height="700" align="left" valign="top"><p class="menu"><a href="index.htm">Presentation</a></p>
           <p class="menu"><a href="SelectDictionary.php5?dict=mwotlap">Mwotlap</a></p>
      <p class="pinyin"><a href="http://alex.francois.free.fr/dict/Mwotlap/dictionaries/ViewOneCharacter.php5?dict=mwotlap&amp;lang1=fra&amp;lang2=eng&amp;langn=*&amp;char=a">Mtp–Fr–Eng</a></p>
      <p class="pinyin"><a href="http://alex.francois.free.fr/dict/Mwotlap/dictionaries/ViewOneCharacter.php5?dict=mwotlap&amp;lang1=eng&amp;lang2=fra&amp;langn=*&amp;char=a">Mtp–Eng–Fr</a></p>
      <p class="pinyin"><a href="http://alex.francois.free.fr/dict/Mwotlap/dictionaries/ViewOneCharacter.php5?dict=mwotlap&amp;lang1=eng&amp;lang2=*&amp;langn=*&amp;char=a">Mtp–Eng</a></p>
      <p class="pinyin"><a href="http://alex.francois.free.fr/dict/Mwotlap/dictionaries/ViewOneCharacter.php5?dict=mwotlap&amp;lang1=fra&amp;lang2=*&amp;langn=*&amp;char=a">Mtp–Fr</a></p></td>
    <!-- Contents -->
    <td width="auto" align="justify" valign="top" bgcolor="#FFFFFF"><?php
            	$dict = isset($_GET["dict"]) ? $_GET["dict"] : "*";
            	$lang1 = isset($_GET["lang1"]) ? $_GET["lang1"] : "*";
				$lang2 = isset($_GET["lang2"]) ? $_GET["lang2"] : "*";
				$langn = isset($_GET["langn"]) ? $_GET["langn"] : "*";
                $char = isset($_GET["char"]) ? $_GET["char"] : "*";
    
            	ViewEntries($dict, $lang1, $lang2, $langn, $char);
    
            	function ViewEntries($dict, $lang1, $lang2, $langn, $char) {
            		$xp = new XsltProcessor();
                	$xsl = new DomDocument;
    
            		$xsl->load('ShowOneCharacter.xsl');
    		        $xp->setParameter('', 'dict', $dict);
            		$xp->setParameter('', 'lang1', $lang1);
					$xp->setParameter('', 'lang2', $lang2);
					$xp->setParameter('', 'langn', $langn);
    		        $xp->setParameter('', 'char', $char);
    
            		// import the XSL stylesheet into the XSLT process
    		        $xp->importStylesheet($xsl);
    
    	           	// create a DOM document and load the XML data
            		$xml_doc = new DomDocument;
    		        $xml_doc->load("$dict/dictionary.xml");
    
            		// transform the XML into HTML using the XSL file
    		        if ($html = $xp->transformToXML($xml_doc)) {
    			        echo $html;
                	} else {
                		trigger_error('XSL transformation failed.', E_USER_ERROR);
            		}
            	}
            ?>
      <a href="#">▲ Back to top ▲</a></td>
  </tr
>
</table>
<!-- Logos -->
<table width="auto" height="40" align="center" cellpadding="20">
  <tr>
    <td align="right" valign="middle"><a href="https://lacito.hypotheses.org/lacito" target="_blank"><img src="../images/logos/Logo-LACITO_rouge.png" height="60"/></a></td>
    <td align="right" valign="middle"><img src="../images/logos/cnrs.jpg" height="70"/></td>
    <td align="right" valign="middle"><img src="../images/logos/ANR.gif" height="60"/></td>
  </tr>
</table>

<!-- Footer --> 
<!-- Start of StatCounter Code (20/11/2005) -->
<script type="text/javascript" language="javascript">
var sc_project=1001632;
var sc_invisible=1;
var sc_partition=9;
var sc_security="a7ef4667";
</script>

<script type="text/javascript" language="javascript" src="http://www.statcounter.com/counter/frames.js"></script><noscript><a href="http://www.statcounter.com/" target="_blank"><img src="http://c10.statcounter.com/counter.php?sc_project=1001632&amp;java=0&amp;security=a7ef4667&amp;invisible=0" alt="free hit counter script" border="0" /></a> </noscript>
<!-- End of StatCounter Code -->

