<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="dict" select="''"/>
  <xsl:param name="lang1" select="''"/>
  <xsl:param name="lang2" select="''"/>
  <xsl:param name="langn" select="''"/>
  <xsl:template match="/">
    <xsl:if test="$dict='mwotlap'">
      <!-- Display only meaningfull characters: rank value must be a float between 1 and 26 -->
      <xsl:call-template name="loop">
        <xsl:with-param name="rank" select="'1'"/>
        <xsl:with-param name="max_rank" select="'46'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="loop">
    <xsl:param name="dictionary"/>
    <xsl:param name="rank"/>
    <xsl:param name="max_rank"/>
    <xsl:if test="//rules/rule[floor(@rank) = number($rank)]">
      <xsl:element name="td">
        <xsl:attribute name="width">1200 div number($max_rank)</xsl:attribute>
        <xsl:attribute name="height">20</xsl:attribute>
        <xsl:attribute name="align">center</xsl:attribute>
        <xsl:attribute name="class">menu</xsl:attribute>
        <xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
        <xsl:for-each select="//rules/rule[floor(@rank) = number($rank)]">
          <xsl:element name="a">
            <xsl:attribute name="href">ViewOneCharacter.php5?dict=<xsl:value-of select="$dict"
                />&amp;lang1=<xsl:value-of select="$lang1"/>&amp;lang2=<xsl:value-of select="$lang2"
                />&amp;langn=<xsl:value-of select="$langn"/>&amp;char=<xsl:value-of select="./@str"
              /></xsl:attribute>
            <xsl:value-of select="./@str"/>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:if>
    <xsl:if test="$rank &lt; $max_rank">
      <xsl:call-template name="loop">
        <xsl:with-param name="rank" select="number($rank) + 1"/>
        <xsl:with-param name="max_rank" select="$max_rank"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
