<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8" version="1.0" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="analysis"/>
  </xsl:template>

  <xsl:template match="analysis">
    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:attribute name="type">
        <xsl:value-of select="text/xsl"/>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:value-of select="opa2html.xsl"/>
      </xsl:attribute>
    </xsl:processing-instruction>
    <xsl:element name="analysis">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="table">
        <xsl:value-of select="@table"/>
      </xsl:attribute>
      <xsl:attribute name="view">
        <xsl:value-of select="@view"/>
      </xsl:attribute>
      <xsl:apply-templates select="text"/>
      <xsl:apply-templates select="table"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="text">
    <xsl:element name="text">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="table">
    <xsl:element name="table">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="label">
        <xsl:value-of select="@label"/>
      </xsl:attribute>
      <xsl:apply-templates select="text"/>
      <xsl:apply-templates select="column"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="column">
    <xsl:element name="column">
      <xsl:variable name="ctable">
        <xsl:value-of select="../@name"/>
      </xsl:variable>
      <xsl:variable name="ccolumn">
        <xsl:value-of select="@name"/>
      </xsl:variable>      
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:if test="@notnull!=''">
        <xsl:attribute name="notnull">
          <xsl:value-of select="@notnull"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:variable name="nb_pkey">
        <xsl:value-of select="count(/analysis/constraint[@type='primarykey' and @table=$ctable and @column=$ccolumn])"/>
      </xsl:variable>
      <xsl:if test="number($nb_pkey)=1">
        <xsl:attribute name="pkey">
          <xsl:value-of select="'true'"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@default!=''">
        <xsl:attribute name="default">
          <xsl:value-of select="@default"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:variable name="nb_fkey">
        <xsl:value-of select="count(/analysis/constraint[@type='foreignkey' and @table=$ctable and @column=$ccolumn])"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="number($nb_fkey)=0"/>
        <xsl:when test="number($nb_fkey)=1">
          <xsl:apply-templates select="/analysis/constraint[@type='foreignkey' and @table=$ctable and @column=$ccolumn]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> -- ERROR -- </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="nb_index">
        <xsl:value-of select="count(/analysis/index[@table=$ctable and @column=$ccolumn])"/>
      </xsl:variable>
      <xsl:if test="number(nb_index)=1 and number(nb_fkey)=0">
        <xsl:attribute name="index">
          <xsl:text>true</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="constraint">
    <xsl:attribute name="fkey">
      <xsl:value-of select="@references"/>
    </xsl:attribute>
    <xsl:attribute name="opt">
      <xsl:value-of select="@opt"/>
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>