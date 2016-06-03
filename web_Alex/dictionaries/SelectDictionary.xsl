<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="dict" select="''"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <!-- Tab title -->
        </title>
        <link href="../styles.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="htmlExportStyleSheet.css"/>
      </head>
      <body>
        <xsl:text>Please select dictionary languages: </xsl:text>
        <xsl:if test="$dict='mwotlap'">
          <form id="form" name="form" action="ViewDictionary.php5">
            <p>
              <input type="checkbox" name="lang1" id="lang1" value="fra" checked="checked"/>
              <label for="lang1"> French</label>
            </p>
            <p>
              <input type="checkbox" name="lang2" id="lang2" value="eng" checked="checked"/>
              <label for="lang2"> English</label>
            </p>
            <p>
              <input type="submit" name="dict" id="dict" value="mwotlap"/>
            </p>
          </form>
        </xsl:if>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
