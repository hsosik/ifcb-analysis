<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ifcb="http://ifcb.whoi.edu/terms#"
    xmlns:data="http://ifcb.whoi.edu/data/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/">
    
    <!-- convert output of roi2xml to nicely-formatted RDF/XML -->
    
    <!-- suppress default rules -->
    <xsl:template match="*|@*|comment()|processing-instruction()|text()"/>

    <xsl:template match="ifcb:bin">
        <rdf:RDF>
            <ifcb:Bin rdf:about="{dc:identifier}">
                <ifcb:hasRois>
                    <rdf:Seq rdf:about="{dc:identifier}/rois">
                        <xsl:apply-templates/>
                    </rdf:Seq>
                </ifcb:hasRois>
            </ifcb:Bin>
         </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="ifcb:roi">
        <rdf:li>
            <ifcb:Roi rdf:about="{dc:identifier}">
                <xsl:for-each select="*[local-name() != 'identifier']">
                    <xsl:element name="ifcb:{local-name(.)}">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </ifcb:Roi>
        </rdf:li>
    </xsl:template>
</xsl:stylesheet>