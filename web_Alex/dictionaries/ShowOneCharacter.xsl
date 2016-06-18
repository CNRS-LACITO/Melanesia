<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="dict" select="''"/>
  <xsl:param name="lang1" select="''"/>
  <xsl:param name="lang2" select="''"/>
  <xsl:param name="langn" select="''"/>
  <xsl:param name="char" select="''"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <!-- Tab title -->
          <xsl:value-of select="//Lexicon/@id"/>
          <xsl:text> dictionary</xsl:text>
        </title>
        <link href="../styles.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <!-- Create table -->
        <xsl:element name="table">
          <xsl:attribute name="width">auto</xsl:attribute>
          <xsl:attribute name="border">0</xsl:attribute>
          <xsl:attribute name="align">left</xsl:attribute>
          <tbody>
            <!-- Name of columns -->
            <xsl:element name="tr">
              <xsl:element name="td">
                <xsl:attribute name="width">18%</xsl:attribute>
                <b>
                  <xsl:text>Index</xsl:text>
                </b>
              </xsl:element>
              <xsl:element name="td">
                <xsl:attribute name="width">82%</xsl:attribute>
                <b>
                  <xsl:value-of select="$char"/>
                </b>
              </xsl:element>
            </xsl:element>
            <!-- Display index -->
            <xsl:element name="td">
              <xsl:attribute name="width">18%</xsl:attribute>
              <xsl:attribute name="valign">top</xsl:attribute>
              <xsl:call-template name="index"/>
            </xsl:element>
            <!-- Create list -->
            <xsl:element name="td">
              <xsl:attribute name="width">82%</xsl:attribute>
              <xsl:apply-templates select="//Lexicon/LexicalEntry"/>
            </xsl:element>
          </tbody>
        </xsl:element>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="index">
    <xsl:for-each select="//Lexicon/LexicalEntry">
      <xsl:if test="starts-with(./Lemma/feat[@att='lexeme']//@val, $char)">
        <!-- Insert link -->
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="./@id"/>
          </xsl:attribute>
          <xsl:attribute name="style">
            <xsl:text>text-decoration:none;</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="class">lexindex</xsl:attribute>
          <xsl:call-template name="get">
            <xsl:with-param name="value" select="./Lemma/feat[@att='lexeme']//@val"/>
          </xsl:call-template>
          <xsl:if test="./feat[@att='homonymNumber']//@val">
            <!-- Display number as subscript -->
            <span class="char_hm">
              <xsl:value-of select="./feat[@att='homonymNumber']//@val"/>
            </span>
          </xsl:if>
        </xsl:element>
        <br/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="//Lexicon/LexicalEntry">
    <xsl:if test="starts-with(./Lemma/feat[@att='lexeme']//@val, $char)">
      <dl>
        <dt class="p_lex">
          <span class="lexeme">
            <!-- Create an anchor -->
            <xsl:element name="a">
              <xsl:attribute name="name">
                <xsl:value-of select="./@id"/>
              </xsl:attribute>
            </xsl:element>
            <!-- Create another anchor with homonym number if any -->
            <xsl:if test="./feat[@att='homonymNumber']//@val">
              <xsl:element name="a">
                <xsl:attribute name="name">
                  <xsl:value-of select="./@id"/>
                  <xsl:value-of select="./feat[@att='homonymNumber']//@val"/>
                </xsl:attribute>
              </xsl:element>
            </xsl:if>
            <!-- Display lexeme -->
            <xsl:call-template name="get">
              <xsl:with-param name="value" select="./Lemma/feat[@att='lexeme']//@val"/>
            </xsl:call-template>
          </span>
          <!-- Display homonym number -->
          <xsl:if test="./feat[@att='homonymNumber']//@val">
            <xsl:choose>
              <xsl:when
                test="number(substring(./feat[@att='homonymNumber']//@val, 1, 1)) = substring(./feat[@att='homonymNumber']//@val, 1, 1)">
                <!-- Display number as subscript -->
                <span class="hm_number">
                  <xsl:value-of select="substring(./feat[@att='homonymNumber']//@val, 1, 1)"/>
                </span>
                <!-- Display circled latin capital letter if any -->
                <xsl:call-template name="square">
                  <xsl:with-param name="letter"
                    select="substring(./feat[@att='homonymNumber']//@val, 2, 1)"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <!-- Display circled latin capital letter -->
                <xsl:call-template name="square">
                  <xsl:with-param name="letter"
                    select="substring(./feat[@att='homonymNumber']//@val, 1, 1)"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:text>	</xsl:text>
          <!-- Display citation form -->
          <xsl:if test="./Lemma/FormRepresentation/feat[@att='citationForm']//@val">
            <xsl:text>(</xsl:text>
            <span class="vernacular">
              <xsl:value-of select="./Lemma/FormRepresentation/feat[@att='citationForm']//@val"/>
            </span>
            <xsl:text>)	</xsl:text>
          </xsl:if>
          <!-- Display phonetic form -->
          <xsl:if test="./Lemma/FormRepresentation/feat[@att='phoneticForm']//@val">
            <xsl:text>[</xsl:text>
            <span class="ipa">
              <xsl:value-of select="./Lemma/FormRepresentation/feat[@att='phoneticForm']//@val"/>
            </span>
            <xsl:text>]	</xsl:text>
          </xsl:if>
          <!-- Display variant -->
          <xsl:if test="./Lemma/FormRepresentation/feat[@att='variantForm']//@val">
            <xsl:if test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
              <xsl:text>~ </xsl:text>
            </xsl:if>
            <xsl:if test="$lang1='eng' or $lang2='eng'">
              <xsl:text>~ </xsl:text>
            </xsl:if>
            <span class="vernacular">
              <xsl:value-of select="./Lemma/FormRepresentation/feat[@att='variantForm']//@val"/>
            </span>
            <xsl:text>	</xsl:text>
          </xsl:if>
          <!-- Listen audio -->
          <xsl:for-each select="./Lemma/FormRepresentation/Audio">
            <xsl:call-template name="play_audio">
              <xsl:with-param name="sound_url"
                select="concat($dict, '/data/audio/wav/', ./feat[@att='fileName']//@val)"/>
              <xsl:with-param name="file_format" select="./feat[@att='audioFileFormat']//@val"/>
            </xsl:call-template>
            <xsl:text>	</xsl:text>
          </xsl:for-each>
          <!-- Display part of speech or '-' if None -->
          <span class="part_of_speech">
            <xsl:value-of select="./feat[@att='partOfSpeech']//@val"/>
            <xsl:if test="not(./feat[@att='partOfSpeech']//@val)">
              <xsl:text>-</xsl:text>
            </xsl:if>
            <xsl:text>.</xsl:text>
          </span>
          <xsl:text>	</xsl:text>
          <!-- Display semantic domain -->
          <xsl:if test="./Sense/SubjectField/feat[@att='semanticDomain']//@val">
            <span class="sd">
              <xsl:text>&lt;</xsl:text>
              <xsl:value-of select="./Sense/SubjectField/feat[@att='semanticDomain']//@val"/>
              <xsl:text>&gt; </xsl:text>
            </span>
          </xsl:if>
          <!-- Display paradigm -->
          <xsl:if test="./Sense/Paradigm">
            <xsl:for-each select="./Sense/Paradigm">
              <xsl:value-of select="./feat[@att='paradigmLabel']//@val"/>
              <xsl:if test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
                <xsl:text> : </xsl:text>
              </xsl:if>
              <xsl:if test="$lang1='eng' or $lang2='eng'">
                <xsl:text>: </xsl:text>
              </xsl:if>
              <span class="vernacular">
                <xsl:value-of select="./feat[@att='paradigm']//@val"/>
              </span>
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:if>
          <!-- Display borrowed word -->
          <xsl:if test="./Sense/Definition/Statement/feat[@att='borrowedWord']">
            <xsl:if test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
              <xsl:text>De : </xsl:text>
            </xsl:if>
            <xsl:if test="$lang1='eng' or $lang2='eng'">
              <xsl:text>From: </xsl:text>
            </xsl:if>
            <xsl:value-of select="./Sense/Definition/Statement/feat[@att='borrowedWord']//@val"/>
            <xsl:text> </xsl:text>
            <!-- Check if value has already been formatted in XML -->
            <xsl:choose>
              <xsl:when
                test="./Sense/Definition/Statement/feat[@att='borrowedWord']//ancestor::Statement/feat[@att='writtenForm']//@val/../span//@class">
                <xsl:copy-of
                  select="./Sense/Definition/Statement/feat[@att='borrowedWord']//ancestor::Statement/feat[@att='writtenForm']//@val/../node()"
                />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of
                  select="./Sense/Definition/Statement/feat[@att='borrowedWord']//ancestor::Statement/feat[@att='writtenForm']//@val"
                />
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>. </xsl:text>
          </xsl:if>
          <!-- Display definition in selected language(s) -->
          <xsl:apply-templates select="./Sense[@id='0']"/>
          <!-- TODO lexical functions -->
          <!-- Cross references -->
          <xsl:for-each select="./RelatedForm">
            <!--xsl:if test="./feat[@att='semanticRelation' and (@val='subentry' or @val='main entry')]"-->
            <!--Alex fait apparaître les Cf etc.-->
            <xsl:if test="./feat[@att='semanticRelation']">
              <xsl:element name="p">
                <xsl:attribute name="class">subentry</xsl:attribute>
                <xsl:if
                  test="./feat[@att='semanticRelation' and (@val='subentry' or @val='main entry')]">
                  <xsl:text>&#9658; </xsl:text>
                </xsl:if>
                <xsl:if
                  test="not(./feat[@att='semanticRelation' and (@val='subentry' or @val='main entry')])">
                  <xsl:text>&#9659; </xsl:text>
                </xsl:if>
                <span class="char_fl">
                  <!-- confer -->
                  <xsl:if test="./feat[@att='semanticRelation' and @val='simple link']">
                    <!--i>Cf. </i-->
                  </xsl:if>
                  <!-- synonym -->
                  <xsl:if test="./feat[@att='semanticRelation' and @val='synonym']">
                    <xsl:if
                      test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
                      <xsl:text>Syn : </xsl:text>
                    </xsl:if>
                    <xsl:if test="$lang1='eng' or $lang2='eng'">
                      <xsl:text>Syn: </xsl:text>
                    </xsl:if>
                  </xsl:if>
                  <!-- antonym -->
                  <xsl:if test="./feat[@att='semanticRelation' and @val='antonym']">
                    <xsl:if
                      test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
                      <xsl:text>Ant : </xsl:text>
                    </xsl:if>
                    <xsl:if test="$lang1='eng' or $lang2='eng'">
                      <xsl:text>Ant: </xsl:text>
                    </xsl:if>
                  </xsl:if>
                  <!-- homonym -->
                  <xsl:if test="./feat[@att='semanticRelation' and @val='homonym']">
                    <xsl:if
                      test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
                      <xsl:text>&#9659; </xsl:text>
                    </xsl:if>
                    <xsl:if test="$lang1='eng' or $lang2='eng'">
                      <xsl:text>&#9659; </xsl:text>
                    </xsl:if>
                  </xsl:if>
                </span>
                <!-- subentry -->
                <!-- Insert link -->
                <xsl:choose>
                  <xsl:when
                    test="./feat[@att='semanticRelation' and (@val='simple link' or @val='synonym' or @val='antonym' or @val='subentry' or @val='main entry')]">
                    <xsl:if test="./a//@href">
                      <xsl:variable name="targets" select="./a[@href][1]"/>
                      <!-- Local link -->
                      <xsl:if test="starts-with($targets, $char)">
                        <xsl:element name="a">
                          <xsl:attribute name="href">
                            <xsl:text>#</xsl:text>
                            <xsl:value-of select="./a//@href"/>
                          </xsl:attribute>
                          <xsl:attribute name="class">vern_link</xsl:attribute>
                          <xsl:value-of select="$targets"/>
                        </xsl:element>
                      </xsl:if>
                      <!-- Hyperlink -->
                      <xsl:if test="not(starts-with($targets, $char))">
                        <xsl:element name="a">
                          <xsl:attribute name="href">
                            <xsl-text>ViewOneCharacter.php5?dict=</xsl-text>
                            <xsl:value-of select="$dict"/>
                            <xsl:text>&amp;lang1=</xsl:text>
                            <xsl:value-of select="$lang1"/>
                            <xsl:text>&amp;lang2=</xsl:text>
                            <xsl:value-of select="$lang2"/>
                            <xsl:text>&amp;langn=</xsl:text>
                            <xsl:value-of select="$langn"/>
                            <xsl:text>&amp;char=</xsl:text>
                            <xsl:value-of select="substring($targets, 1, 1)"/>
                            <xsl:text>#</xsl:text>
                            <xsl:value-of select="./a//@href"/>
                          </xsl:attribute>
                          <xsl:attribute name="class">vern_link</xsl:attribute>
                          <xsl:value-of select="$targets"/>
                        </xsl:element>
                      </xsl:if>
                    </xsl:if>
                    <xsl:text>	</xsl:text>
                  </xsl:when>
                </xsl:choose>
                <xsl:if test="not(./a//@href)">
                  <span class="vernac_noklik">
                    <xsl:value-of select="./@targets"/>
                    <xsl:text>	</xsl:text>
                  </span>
                </xsl:if>
                <!-- Link gloss -->
                <xsl:if test="./FormRepresentation/feat[@att='writtenForm']">
                  <xsl:text>‘</xsl:text>
                  <xsl:call-template name="get">
                    <xsl:with-param name="value"
                      select="./FormRepresentation/feat[@att='writtenForm']//@val"/>
                  </xsl:call-template>
                  <xsl:text>’</xsl:text>
                </xsl:if>
              </xsl:element>
            </xsl:if>
          </xsl:for-each>
        </dt>
        <!-- Apply another template to display examples -->
        <xsl:apply-templates select="./Sense[@id='0']/Context"/>
        <!-- Display other senses with their number -->
        <xsl:for-each select="./Sense">
          <xsl:if test="./feat[@att='senseNumber' and @val!='0']">
            <p class="p_sn">
              <xsl:text>(</xsl:text>
              <span class="char_sn">
                <xsl:value-of select="./feat[@att='senseNumber']//@val"/>
              </span>
              <xsl:text>) </xsl:text>
              <xsl:apply-templates select="."/>
            </p>
            <xsl:apply-templates select="./Context"/>
          </xsl:if>
        </xsl:for-each>
        <!-- Display etymology -->
        <xsl:if test="./Sense/Definition/Statement/feat[@att='etymology']">
          <p class="p_etym">
            <b>[</b>
            <xsl:call-template name="get">
              <xsl:with-param name="value"
                select="./Sense/Definition/Statement/feat[@att='termSourceLanguage']//@val"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <span class="vernacular">
              <xsl:call-template name="get">
                <xsl:with-param name="value"
                  select="./Sense/Definition/Statement/feat[@att='etymology']//@val"/>
              </xsl:call-template>
            </span>
            <xsl:text> </xsl:text>
            <xsl:if test="./Sense/Definition/Statement/feat[@att='etymologyGloss']">
              <xsl:text>‘</xsl:text>
              <span class="eng_s">
                <xsl:call-template name="get">
                  <xsl:with-param name="value"
                    select="./Sense/Definition/Statement/feat[@att='etymologyGloss']//@val"/>
                </xsl:call-template>
              </span>
              <xsl:text>’</xsl:text>
            </xsl:if>
            <b>]</b>
          </p>
        </xsl:if>
        <!-- Dipslay picture if any -->
        <xsl:if test="./Lemma/FormRepresentation/Picture/feat[@att='fileName']">
          <table width="200" height="50" align="center">
            <tr>
              <td align="center">
                <figure>
                  <xsl:element name="a">
                    <xsl:attribute name="href">
                      <xsl:value-of
                        select="concat('../images/', ./Lemma/FormRepresentation/Picture/feat[@att='fileName']//@val)"
                      />
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:element name="img">
                      <xsl:attribute name="src">
                        <xsl:value-of
                          select="concat('../images/', ./Lemma/FormRepresentation/Picture/feat[@att='fileName']//@val)"
                        />
                      </xsl:attribute>
                      <xsl:attribute name="class"> picture </xsl:attribute>
                    </xsl:element>
                  </xsl:element>
                  <xsl:if
                    test="./Lemma/FormRepresentation/Picture/Statement/feat[@att='writtenForm']//@val">
                    <figcaption>
                      <xsl:call-template name="get">
                        <xsl:with-param name="value"
                          select="./Lemma/FormRepresentation/Picture/Statement/feat[@att='writtenForm']//@val"
                        />
                      </xsl:call-template>
                    </figcaption>
                  </xsl:if>
                </figure>
              </td>
            </tr>
          </table>
        </xsl:if>
      </dl>
    </xsl:if>
  </xsl:template>

  <xsl:template name="square">
    <xsl:param name="letter"/>
    <!-- Display squared latin capital letter -->
    <xsl:text> </xsl:text>
    <span class="hmlt">
      <xsl:choose>
        <xsl:when test="$letter = 'A'">&#9398;</xsl:when>
        <xsl:when test="$letter = 'B'">&#9399;</xsl:when>
        <xsl:when test="$letter = 'C'">&#9400;</xsl:when>
        <xsl:when test="$letter = 'D'">&#9401;</xsl:when>
        <xsl:when test="$letter = 'E'">&#9402;</xsl:when>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="//Lexicon/LexicalEntry/Sense">
    <!-- 1st language -->
    <!--span class="$lang1"-->
    <span class="fra">
      <!-- Display semantics and restrictions -->
      <span class="com_fra">
        <xsl:if
          test="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='noteType']//@val = 'semantics'">
          <xsl:text>(</xsl:text>
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='noteType' and @val='semantics']//ancestor::Statement/feat[@att='note']//@val"
            />
          </xsl:call-template>
          <xsl:text>) </xsl:text>
        </xsl:if>
        <xsl:if
          test="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='noteType']//@val = 'restriction'">
          <xsl:text>[</xsl:text>
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='noteType' and @val='restriction']//ancestor::Statement/feat[@att='note']//@val"
            />
          </xsl:call-template>
          <xsl:text>] </xsl:text>
        </xsl:if>

        <!-- Display literal meaning -->
        <xsl:if
          test="./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='literally']//@val">
            <xsl:if test="($lang1='fra' or $lang2='fra') and $lang1!='eng' and $lang2!='eng'">
              <span class="char_fl">litt.</span>
            </xsl:if>
            <xsl:if test="$lang1='eng' or $lang2='eng'">
              <span class="char_fl">lit.</span>
            </xsl:if>
          <xsl:text> “</xsl:text>
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='literally']//@val"
            />
          </xsl:call-template>” <xsl:text> : </xsl:text>
        </xsl:if>
      </span>
      <!-- Display definition -->
      <xsl:if
        test="not(./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='definition']//@val) and (./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='gloss']//@val)">
        <span class="def1">
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='gloss']//@val"
            />
          </xsl:call-template>
        </span>
      </xsl:if>
      <xsl:if
        test="./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='definition']//@val">
        <span class="def1">
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/feat[@att='language' and @val=$lang1]//ancestor::Definition/feat[@att='definition']//@val"
            />
          </xsl:call-template>
        </span>
        <xsl:text>. </xsl:text>
      </xsl:if>
    </span>
    <!-- 2nd language -->
    <xsl:if test="($lang2='fra' or $lang2='eng')">
        <span class="symbol"> &#9671; </span>
    </xsl:if>    
    <!--span class="$lang2"-->
    <span class="eng">
      <!-- Display semantics and restrictions -->
      <xsl:if
        test="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='noteType']//@val = 'semantics'">
        <xsl:text>(</xsl:text>
        <span class="com_eng">
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='noteType' and @val='semantics']//ancestor::Statement/feat[@att='note']//@val"
            />
          </xsl:call-template>
        </span>
        <xsl:text>) </xsl:text>
      </xsl:if>
      <xsl:if
        test="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='noteType']//@val = 'restriction'">
        <xsl:text>[</xsl:text>
        <xsl:call-template name="get">
          <xsl:with-param name="value"
            select="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='noteType' and @val='restriction']//ancestor::Statement/feat[@att='note']//@val"
          />
        </xsl:call-template>
        <xsl:text>] </xsl:text>
      </xsl:if>
      <!-- Display literal meaning -->
      <xsl:if
        test="./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='literally']//@val">
        <i>lit. “</i>
        <xsl:call-template name="get">
          <xsl:with-param name="value"
            select="./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='literally']//@val"
          />
        </xsl:call-template>
        <i>”</i>
        <xsl:text> : </xsl:text>
      </xsl:if>
      <!-- Display definition -->
      <xsl:if
        test="not(./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='definition']//@val) and (./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='gloss']//@val)">
        <span class="def2">
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='gloss']//@val"
            />
          </xsl:call-template>
        </span>
        <xsl:text>. </xsl:text>
      </xsl:if>
      <xsl:if
        test="./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='definition']//@val">
        <span class="def2">
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/feat[@att='language' and @val=$lang2]//ancestor::Definition/feat[@att='definition']//@val"
            />
          </xsl:call-template>
        </span>
        <xsl:text>. </xsl:text>
      </xsl:if>
    </span>
    <!-- Display scientific name -->
    <xsl:if test="./Definition/Statement/feat[@att='scientificName']//@val">
      <span class="sc">
        <xsl:element name="a">
          <xsl:attribute name="href"
              >https://www.google.com/search?as_st=y&amp;tbm=isch&amp;hl=en&amp;safe=images&amp;as_q=&quot;<xsl:call-template
              name="get">
              <xsl:with-param name="value"
                select="./Definition/Statement/feat[@att='scientificName']//@val"/>
            </xsl:call-template>
            <xsl:text>&quot;</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="target">_blank</xsl:attribute>
          <xsl:call-template name="get">
            <xsl:with-param name="value"
              select="./Definition/Statement/feat[@att='scientificName']//@val"/>
          </xsl:call-template>
        </xsl:element>
      </span>
      <xsl:text>.</xsl:text>
    </xsl:if>
    <!-- Display notes -->
    <xsl:if
      test="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='encyclopedicInformation']">
      <xsl:text> &#9672; </xsl:text>
      <span class="fra">
        <xsl:if
          test="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='usageNote']">
          <xsl:value-of
            select="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='usageNote']//@val"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:call-template name="get">
          <xsl:with-param name="value"
            select="./Definition/Statement/feat[@att='language' and @val=$lang1]//ancestor::Statement/feat[@att='encyclopedicInformation']//@val"
          />
        </xsl:call-template>
      </span>
    </xsl:if>
    <xsl:if
      test="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='encyclopedicInformation']">
      <xsl:text> &#9674; </xsl:text>
      <span class="eng">
        <xsl:if
          test="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='usageNote']">
          <xsl:value-of
            select="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='usageNote']//@val"/>
          <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:call-template name="get">
          <xsl:with-param name="value"
            select="./Definition/Statement/feat[@att='language' and @val=$lang2]//ancestor::Statement/feat[@att='encyclopedicInformation']//@val"
          />
        </xsl:call-template>
      </span>
    </xsl:if>
  </xsl:template>

  <xsl:template match="//Lexicon/LexicalEntry/Sense/Context">
    <p/>
    <dd class="vernacular">
      <xsl:call-template name="get">
        <xsl:with-param name="value"
          select="./TextRepresentation/feat[@att='language' and @val='mlv']//ancestor::TextRepresentation/feat[@att='writtenForm']//@val"
        />
      </xsl:call-template>
    </dd>
    <dd class="ex_lg1">
      <xsl:call-template name="get">
        <xsl:with-param name="value"
          select="./TextRepresentation/feat[@att='language' and @val=$lang1]//ancestor::TextRepresentation/feat[@att='writtenForm']//@val"
        />
      </xsl:call-template>
    </dd>
    <dd class="ex_lg2">
      <i>
        <xsl:call-template name="get">
          <xsl:with-param name="value"
            select="./TextRepresentation/feat[@att='language' and @val=$lang2]//ancestor::TextRepresentation/feat[@att='writtenForm']//@val"
          />
        </xsl:call-template>
      </i>
    </dd>
    <dd class="national">
      <xsl:call-template name="get">
        <xsl:with-param name="value"
          select="./TextRepresentation/feat[@att='language' and @val=$langn]//ancestor::TextRepresentation/feat[@att='writtenForm']//@val"
        />
      </xsl:call-template>
    </dd>
  </xsl:template>

  <xsl:template name="play_audio">
    <xsl:param name="sound_url" select="''"/>
    <xsl:param name="file_format" select="''"/>
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl-text>PlayAudio.php5?sound_url=</xsl-text>
        <xsl:value-of select="$sound_url"/>
        <xsl-text>&amp;file_format=</xsl-text>
        <xsl:value-of select="$file_format"/>
      </xsl:attribute>
      <xsl:attribute name="title">Listen</xsl:attribute>
      <xsl:attribute name="target">popup</xsl:attribute>
      <xsl:attribute name="onClick"
        >window.open(this.href,'popup','width=350,height=35,scrollbars=yes,resizable=yes',1).focus();return
        false</xsl:attribute>
      <img height="14px" width="14px" src="../images/icones/sound1_bleu.jpg"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="get">
    <xsl:param name="value"/>
    <xsl:choose>
      <!-- Check if value has already been formatted in XML -->
      <xsl:when test="$value/../span//@class">
        <xsl:copy-of select="$value/../node()"/>
      </xsl:when>
      <xsl:when test="$value/../sub">
        <xsl:copy-of select="$value/../node()"/>
      </xsl:when>
      <xsl:when test="$value/../i">
        <xsl:copy-of select="$value/../node()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
