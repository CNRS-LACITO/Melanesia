<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Mwotlap-French-English dictionary</title>
<link href="../styles.css" rel="stylesheet" type="text/css" />
<style type="text/css">
a:link {
	text-decoration: none;
	color: #630;
}
a:visited {
	text-decoration: none;
	color: #640;
}
a:hover {
	text-decoration: underline;
}
a:active {
	text-decoration: none;
}
</style>
</head>

<body>
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
    <td width="auto" height="700" align="justify" valign="top" bgcolor="#FFFFFF"><?php
                	$dict = isset($_GET["dict"]) ? $_GET["dict"] : "*";
                	$lang1 = isset($_GET["lang1"]) ? $_GET["lang1"] : "*";
					$lang2 = isset($_GET["lang2"]) ? $_GET["lang2"] : "*";
					$langn = isset($_GET["langn"]) ? $_GET["langn"] : "*";

                	ViewDescription($dict, $lang1, $lang2, $langn);

                	function ViewDescription($dict, $lang1, $lang2, $langn) {
                		$xp = new XsltProcessor();
                	    $xsl = new DomDocument;

	                   	$xsl->load('ShowDescription.xsl');
                		$xp->setParameter('', 'dict', $dict);
                		$xp->setParameter('', 'lang1', $lang1);
										$xp->setParameter('', 'lang2', $lang2);
										$xp->setParameter('', 'langn', $langn);

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
                ?></td>
  </tr>
</table>
<!-- Footer -->
<!-- Logos -->
<table width="auto" height="40" align="center" cellpadding="20">
  <tr>
    <td align="right" valign="middle"><a href="https://lacito.hypotheses.org/lacito" target="_blank"><img src="../images/logos/Logo-LACITO_rouge.png" height="60"/></a></td>
    <td align="right" valign="middle"><img src="../images/logos/cnrs.jpg" height="70"/></td>
    <td align="right" valign="middle"><img src="../images/logos/ANR.gif" height="60"/></td>
  </tr>
</table>

</body>
</html>
