<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" version="4.0" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="schemax/@name"/></title>
        <style type="text/css">
text,body,p,div,span { 
  font-size   : 10pt; 
  font-family : sans-serif;
  color       : #000055; 
}

a {text-decoration:none;}
a:link {color : #007;}
a:visited {color : #007;}
a:hover{color : #29E; text-decoration : underline;}


h1,h2,h3 {
  margin      : 0em;
  padding     : 0.2em;
  font-weight : normal;
  font-family : meta-bold;
/*
  font-weight : bold;
*/
}

.little {
  font-size : 80%;
  color : #088;
  font-weight : bold;
  
}

ul {
  margin          : 0em;
  padding         : 0em;
  padding-left    : 1.2em;
  padding-right   : 1.2em;
  list-style-type : none;
  text-align      : left;
}

.element {
  padding            : 0.5em;
  margin             : 0.5em;
  background-color   : #DEEFFF;
  -moz-border-radius : 1.5em;
  border             : 2px solid #AAAAFF;
}

.attributs {
  vertical-align                 : middle;
  padding                        : 0.2em;
  margin                         : 0em;
  background-color               : #DEFFDE;
  -moz-border-radius-bottomleft  : 1em;
  color                          : #005500;
}

.enfants {
  vertical-align                 : middle;
  padding                        : 0.2em;
  margin                         : 0em;
  background-color               : #FFDEDE;
  -moz-border-radius-bottomright : 1em;
  color                          : #550000;
}

.general {
  display : table-cell;
  padding                        : 0.2em;
  margin                         : 0em;
  background-color               : #FFFFDD;
  -moz-border-radius-topleft     : 1em;
  color                          : #333300;
  border-left                    : 2px solid #EEE080;
  border-top                     : 2px solid #EEE080;
}

.info {
  display : table-cell;
  padding                        : 0.2em;
  margin                         : 0em;
  background-color               : #FFFFDD;
  -moz-border-radius-topright    : 1em;
  color                          : #333300;
  border-right                   : 2px solid #EEE080;
  border-top                     : 2px solid #EEE080;
}

div.element   { display : inline-table; margin-bottom : 2em;}
div.line      { display : table-row;}
div.attributs { display : table-cell; width:300px;  
  border-left                    : 2px solid #AAEEAA;
  border-bottom                  : 2px solid #AAEEAA;
}
div.enfants   { display : table-cell; width:300px;
  border-right                   : 2px solid #FFAAAA;
  border-bottom                  : 2px solid #FFAAAA;
}

.enumeration {
  font-family : sans-serif;
  font-size : 80%;
  color : #44AA39;  
}

#title {
  text-align : center;
}

#main {
  display : table-row;
}

#menu {
  display      : table-cell;
  padding      : 1em;
  border-right : 2px solid #000055;
}

#list {
  width   : 600px;
  display : table-cell;
  padding : 1em;
}
        </style>
      </head>
      <body>
        <div id="title">
          <h1><xsl:value-of select="schemax/@name"/> (<xsl:value-of select="schemax/@shortname"/>)</h1>
          <h2><xsl:value-of select="schemax/@version"/></h2>
        </div>
        <center>
        <div class="element">
          <ul class="std">
            <li><xsl:value-of select="count(schemax/element)"/> éléments</li>
            <li><xsl:value-of select="count(schemax/element/attribute)"/> attributs</li>
            <li><xsl:value-of select="count(schemax/element/attribute/enumeration)"/> choix</li>
            <li><xsl:value-of select="count(schemax/element/element) div count(schemax/element)"/> fils par éléments</li>
            <li><xsl:value-of select="count(schemax/element/attribute) div count(schemax/element)"/> attributs par éléments</li>
            <li><xsl:value-of select="count(schemax/element/attribute/enumeration) div count(schemax/element/attribute)"/> choix par attribut</li>
	  </ul>
        </div>
        <div id="main">
          <div class="line">
          <div id="menu">
            <h2><a id="top">Menu</a></h2>
            <ul class="std">
              <xsl:apply-templates select="schemax/element" mode="menu">
                <xsl:sort select="@name"/>
              </xsl:apply-templates>
            </ul>
          </div>
          <div id="list">
            <xsl:apply-templates select="schemax/element" mode="list">
              <xsl:sort select="@name"/>
            </xsl:apply-templates>
          </div>
        </div>
        </div>
        </center>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="element" mode="menu">
    <li><a href="#elem-{@name}"><xsl:value-of select="@name"/></a></li>
  </xsl:template>

  <xsl:template match="element" mode="list">
    <div class="element">
      <h2><a id="elem-{@name}"><xsl:value-of select="@name"/></a></h2>
      <div class="line">
        <div class="general">
          <small><a href="#top">Menu</a></small>
          <xsl:variable name="moi"><xsl:value-of select="@name"/></xsl:variable>
          <ul>
	  <xsl:apply-templates select="/schemax/element[element/@name=$moi]" mode="menu">
            <xsl:sort select="@name"/>
          </xsl:apply-templates>
          </ul>
        </div>
        <div class="info">
          <xsl:value-of select="@type"/>
        </div>
      </div>
      <div class="line">

        <div class="attributs">
          <xsl:choose>
            <xsl:when test="count(attribute)=0">
              <h3 class="attributs">Pas d'attributs</h3>
            </xsl:when>
            <xsl:otherwise>
              <h3 class="attributs">Attributs</h3>
              <ul class="std">
                <xsl:apply-templates select="attribute" mode="detail"/>
              </ul>
            </xsl:otherwise>
          </xsl:choose>
        </div>

        <div class="enfants">
          <xsl:choose>
            <xsl:when test="count(element)+count(choice)=0">
              <h3 class="enfants">Pas d'éléments fils</h3>
            </xsl:when>
            <xsl:otherwise>
              <h3 class="enfants">Peut contenir</h3>
              <ul class="std">
                <xsl:apply-templates select="element" mode="detail"/>
                <xsl:apply-templates select="choice" mode="list"/>
              </ul>
            </xsl:otherwise>
          </xsl:choose>
        </div>

      </div>
    </div>
  </xsl:template>

  <xsl:template match="attribute" mode="detail">
    <li>
      <span class="little"><xsl:value-of select="@type"/></span>
      <xsl:text>   </xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:if test="@use='optional'">
        <xsl:text> ~</xsl:text>
      </xsl:if>
      <ul class="std"> 
        <xsl:apply-templates select="enumeration" mode="detail"/>
      </ul>
    </li>
  </xsl:template>

  <xsl:template match="enumeration" mode="detail">
    <li><a class="enumeration"><xsl:value-of select="@name"/> (<xsl:value-of select="@value"/>)</a></li>
  </xsl:template>

  <xsl:template match="element" mode="detail">
    <li>
      <small><tt>
      <xsl:choose>
        <xsl:when test="@minOccurs='unbounded'"><blink>n</blink></xsl:when>
        <xsl:when test="@minOccurs!=''"><xsl:value-of select="@minOccurs"/></xsl:when>
	<xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
      <xsl:text>-</xsl:text>
      <xsl:choose>
        <xsl:when test="@maxOccurs='unbounded'">n</xsl:when>
        <xsl:when test="@maxOccurs!=''"><xsl:value-of select="@maxOccurs"/></xsl:when>
	<xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
      </tt></small>
      <xsl:text> </xsl:text>
      <a href="#elem-{@name}">
        <xsl:value-of select="@name"/>
      </a>
    </li>
  </xsl:template>

  <xsl:template match="choice" mode="list">
    <li style="margin-top:6px">
      <xsl:value-of select="@card"/>
      <xsl:text> </xsl:text>
      <b style="background-color:#B22; color:white; padding: 2px 4px 0px 4px; -moz-border-radius-topleft:8px; -moz-border-radius-topright:8px;">
        <xsl:value-of select="@name"/>
      </b>
      <xsl:variable name="name"><xsl:value-of select="@name"/></xsl:variable>
      <xsl:apply-templates select="../../choice[@name=$name]" mode="detail"/>
    </li>
  </xsl:template>

  <xsl:template match="choice" mode="detail">
    <div style="border : 2px solid #B22; background-color: #F99; padding:3px">
      <xsl:apply-templates select="element" mode="detail"/>
    </div>
  </xsl:template>


</xsl:stylesheet>