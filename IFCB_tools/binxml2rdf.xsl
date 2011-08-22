<?xml version="1.0" encoding="UTF-8"?>

<!-- note: this is a proof-of-concept and may not work with current output of bin2xml -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ifcb="http://ifcb.whoi.edu/terms#"
    xmlns:data="http://ifcb-data.whoi.edu/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/">
    
    <!-- convert output of bin2xml to nicely-formatted RDF/XML -->
    
    <!-- suppress default rules -->
    <xsl:template match="*|@*|comment()|processing-instruction()|text()"/>

    <!-- "pretty" output please -->
    <xsl:output indent="yes"/>
    
    <xsl:template match="ifcb:Bin">
        <rdf:RDF>
            <ifcb:Bin rdf:about="{dc:identifier}">
                <dc:date><xsl:value-of select="dc:date"/></dc:date>
                <xsl:for-each select="ifcb:*[name(.)!='Target']">
                    <xsl:element name="ifcb:{name()}">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
                <ifcb:hasTargets>
                    <rdf:Seq rdf:about="{dc:identifier}/targets">
                        <xsl:apply-templates/>
                    </rdf:Seq>
                </ifcb:hasTargets>
            </ifcb:Bin>
         </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="ifcb:Target">
        <rdf:li>
            <ifcb:Target rdf:about="{dc:identifier}">
                <xsl:for-each select="*[local-name() != 'identifier']">
                    <xsl:element name="ifcb:{local-name(.)}">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </ifcb:Target>
        </rdf:li>
    </xsl:template>
</xsl:stylesheet>