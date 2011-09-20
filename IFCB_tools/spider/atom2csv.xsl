<?xml version="1.0" encoding="UTF-8"?>

<!-- converts an IFCB RSS feed into a CSV file with raw data endpoints -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:atom="http://www.w3.org/2005/Atom">
    
    <!-- suppress default rules -->
    <xsl:template match="*|@*|comment()|processing-instruction()|text()"/>
    
    <xsl:output method="text"/>
    
    <!-- for each feed entry emit the "id" and "updated" fields as a two-column CSV row -->
    <xsl:template match="atom:feed">
        <xsl:for-each select="atom:entry">
            <xsl:value-of select="atom:id"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="atom:updated"/>
            <xsl:text>
</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>