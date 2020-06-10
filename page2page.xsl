<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:o="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
    xmlns:n="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xi="http://www.w3.org/2001/XInclude"
    xpath-default-namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
    version="3.0">
    <xsl:output method="xml" indent="no"/>

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Author:</xd:b> Matthias Boenig, boenig@bbaw.de</xd:p>
            <xd:p>OCR-D, Berlin-Brandenburg Academy of Sciences and Humanities
                http://ocr-d.de/eng</xd:p>
            <xd:p/>
            <xd:p>This stylesheet, transforms the properitary PAGE XML file from
                    <xd:i>Transkribus</xd:i> (<xd:a href="https://transkribus.eu/Transkribus/"
                    >https://transkribus.eu/Transkribus</xd:a>) into a <xd:i>PAGE XML</xd:i> valid
                format (<xd:a href="https://www.primaresearch.org/schema/PAGE/gts/pagecontent/"
                    >https://www.primaresearch.org/schema/PAGE/gts/pagecontent/</xd:a> newest
                version from <xd:b>2019-07-16</xd:b></xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>


    <xd:doc>
        <xd:desc>Parameter <xd:pre>standard</xd:pre> with value:<xd:ul>
            <xd:li>n = stands for no element <xd:pre>PrintSpace</xd:pre> transformation</xd:li>
            <xd:li>y = stands for element <xd:pre>PrintSpace</xd:pre> transformation to element <xd:pre>Border</xd:pre></xd:li>
            <xd:li>#default = n</xd:li>
        </xd:ul></xd:desc>
    </xd:doc>
    <xsl:param name="standard">n</xsl:param>

    <xd:doc>
        <xd:desc>the root element <xd:pre>PcGts</xd:pre> transform and make available the newest
            PAGE XML schema</xd:desc>
    </xd:doc>
    <xsl:template match="PcGts">
        <xsl:element name="PcGts"
            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
            <xsl:attribute name="xsi:schemaLocatio">http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15/pagecontent.xsd</xsl:attribute>
            <xsl:apply-templates select="Metadata"/>
            <xsl:apply-templates select="Page"/>
        </xsl:element>
    </xsl:template>

    <xd:doc>
        <xd:desc>the element <xd:pre>Page</xd:pre> is a key for the subelements
            <xd:pre>Printspace</xd:pre>and <xd:pre>Border</xd:pre></xd:desc>
    </xd:doc>
    <xsl:template match="Page">
        <xsl:variable name="transborder">
            <xsl:element name="Border"
                namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                <xsl:element name="Coords"
                    namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                    <xsl:attribute name="points">
                        <xsl:value-of select="PrintSpace/Coords/@points"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:variable>

        <xsl:variable name="border">
            <xsl:element name="Border"
                namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                <xsl:element name="Coords"
                    namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                    <xsl:attribute name="points">
                        <xsl:value-of select="Border/Coords/@points"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:variable>



        <xsl:variable name="printspace">
            <xsl:element name="PrintSpace"
                namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                <xsl:element name="Coords"
                    namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                    <xsl:attribute name="points">
                        <xsl:value-of select="PrintSpace/Coords/@points"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:variable>



        <xsl:message select="$printspace"/>
        <xsl:element name="Page"
            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
            <xsl:copy-of select="@*"/>
            <xsl:choose>
                <xsl:when test="PrintSpace and Border">
                    <xsl:copy-of select="$border | $printspace"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$standard = 'n'">
                            <xsl:choose>
                                <xsl:when test="PrintSpace">
                                    <xsl:copy-of select="$transborder"/>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="$printspace"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xd:doc>
        <xd:desc>deletes for this moment the nodes <xd:pre>PrintSpace</xd:pre> and
            <xd:pre>Border</xd:pre> and contructs a new <xd:pre>Border</xd:pre> or
            <xd:pre>PrintSpace</xd:pre> possibility in the template <xd:pre>Page</xd:pre></xd:desc>
    </xd:doc>
    <xsl:template match="PrintSpace | Border"/>


    <xd:doc>
        <xd:desc>transforms/copies all element without the old namespace</xd:desc>
    </xd:doc>
    <xsl:template match="*">
        <xsl:element name="{local-name()}"
            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    <xd:doc>
        <xd:desc>transforms/copies all attributes</xd:desc>
    </xd:doc>
    <xsl:template match="@*">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>



    <xd:doc>
        <xd:desc>deletes the non-konform PAGE XML elements from Transkribus implementation</xd:desc>
    </xd:doc>
    <xsl:template match="TranskribusMetadata"/>




</xsl:stylesheet>
