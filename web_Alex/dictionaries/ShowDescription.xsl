<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="dict" select="''"/>
  <xsl:param name="lang1" select="''"/>
  <xsl:param name="lang2" select="''"/>
  <xsl:param name="langn" select="''"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <!-- Tab title -->
        </title>
        <link href="../styles.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <!-- Page title is the lexicon label -->
        <p>
          <font class="titre">
            <xsl:value-of select="//Lexicon/feat[@att='label']//@val"/>
          </font>
        </p>
        <!-- Author -->
        <p>
          <xsl:value-of select="//GlobalInformation/feat[@att='author']//@val"/>
        </p>
        <!-- Date -->
        <p>
          <xsl:value-of select="//GlobalInformation/feat[@att='lastUpdate']//@val"/>
        </p>
        <!-- Description -->
        <p>
          <xsl:value-of select="//GlobalInformation/feat[@att='description']//@val"/>
        </p>
        <p>This dictionary is part of the <xsl:value-of
            select="//GlobalInformation/feat[@att='projectName']//@val"/> project. </p>
        <!-- Display number of entries -->
        <p>This <xsl:value-of select="//Lexicon/feat[@att='lexiconType']//@val"/> contains
            <xsl:value-of select="count(//Lexicon/LexicalEntry/Lemma)"/>
          <xsl:if test="count(//Lexicon/LexicalEntry/Lemma) = 1">
            <xsl:text> entry.</xsl:text>
          </xsl:if>
          <xsl:if test="count(//Lexicon/LexicalEntry/Lemma) > 1">
            <xsl:text> entries or subentries.</xsl:text>
          </xsl:if>
        </p>
        <!-- Citation -->
        <p>To cite this dictionary:</p>
        <xsl:value-of select="//GlobalInformation/feat[@att='bibliographicCitation']//@val"/>
        <!-- Download PDF -->

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
