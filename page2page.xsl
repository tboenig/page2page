<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:o="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15"
    xmlns:n="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xi="http://www.w3.org/2001/XInclude"
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
                version from <xd:b>2021-12-14</xd:b></xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>


    <xd:doc>
        <xd:desc>Parameter <xd:pre>standard</xd:pre> with values:<xd:ul>
            <xd:li>np = stands for no element <xd:pre>PrintSpace</xd:pre> transformation</xd:li>
            <xd:li>yp = stands for element <xd:pre>PrintSpace</xd:pre> transformation to element <xd:pre>Border</xd:pre></xd:li>
            <xd:li>nb = stands for no element <xd:pre>Border</xd:pre> transformation</xd:li>
            <xd:li>yb = stands for element <xd:pre>Border</xd:pre> transformation to element <xd:pre>PrintSpace</xd:pre></xd:li>
            <xd:li>#default = n</xd:li>
        </xd:ul></xd:desc>
    </xd:doc>
    <xsl:param name="standard">n</xsl:param>
    
    <xd:doc>
        <xd:desc>Parameter <xd:pre>standard</xd:pre> with values:<xd:ul>
            <xd:li>pi = uses the element Page with the attribute <xd:pre>imageFilename</xd:pre></xd:li>
            <xd:li>ti = uses the element TranskribusMetadata with the attribute <xd:pre>imgUrl</xd:pre></xd:li>
            <xd:li>#default = pi</xd:li>
        </xd:ul></xd:desc>
    </xd:doc>
    <xsl:param name="image">pi</xsl:param>

    
    <xd:doc>
        <xd:desc>Variable <xd:pre>cBorder</xd:pre> count all Border elements</xd:desc>
    </xd:doc>
    <xsl:variable name="cBorder" select="count(//Border) + count(//n:Border)"/>
    
    <xd:doc>
        <xd:desc>Variable <xd:pre>cPrintSpace</xd:pre> count all PrintSpace elements</xd:desc>
    </xd:doc>
    <xsl:variable name="cPrintSpace" select="count(//PrintSpace) + count(//n:PrintSpace)"/>


    <xd:doc>
        <xd:desc>the root element <xd:pre>PcGts</xd:pre> transform and make available the newest
            PAGE XML schema</xd:desc>
    </xd:doc>
    <xsl:template match="PcGts">
        <xsl:element name="PcGts"
            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
            <xsl:attribute name="xsi:schemaLocation">http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15/pagecontent.xsd</xsl:attribute>
            <xsl:apply-templates select="Metadata"/>
            <xsl:apply-templates select="Page"/>
            
        </xsl:element>
    </xsl:template>

    <xd:doc>
        <xd:desc>the element <xd:pre>Page</xd:pre> is a key for the subelements
            <xd:pre>Printspace</xd:pre>and <xd:pre>Border</xd:pre></xd:desc>
    </xd:doc>
    <xsl:template match="Page | n:Page">
        
            <xsl:if test="$cBorder >= 2 or $cPrintSpace >=2">
            <xsl:message>
                <xsl:if test="$cBorder > 1">There are at least two Border elements in the page file, this is an error. Only the frist element was transformed.</xsl:if>
                <xsl:if test="$cPrintSpace > 1">There are at least two PrintSpace elements in the page file, this is an error. Only the frist element was transformed.</xsl:if>
            </xsl:message>
            </xsl:if>
        
        <xsl:variable name="transborder">
            <xsl:element name="Border"
                namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                <xsl:element name="Coords"
                    namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                    <xsl:attribute name="points">
                        <xsl:choose>
                            <xsl:when test="$standard = 'nb'">
                                <xsl:value-of select="o:Border[1]/o:Coords/@points | n:Border[1]/n:Coords/@points"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="o:PrintSpace[1]/o:Coords/@points | n:PrintSpace[1]/n:Coords/@points"/></xsl:otherwise>
                        </xsl:choose>
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
                        <xsl:value-of select="o:Border[1]/o:Coords/@points | n:Border[1]/n:Coords/@points"/>
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
                        <xsl:choose>
                            <xsl:when test="$standard = 'yb'">
                                <xsl:value-of select="o:Border[1]/o:Coords/@points | n:Border[1]/n:Coords/@points"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="o:PrintSpace[1]/o:Coords/@points | n:PrintSpace[1]/n:Coords/@points"/></xsl:otherwise>
                        </xsl:choose>
                     </xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:variable>


        <xsl:element name="Page"
            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
            <xsl:copy-of select="@* except (@imageFilename)"/>
            <xsl:choose>
                <xsl:when test="$image ='pi'">
            <xsl:attribute name="imageFilename">
                <xsl:copy-of select="//o:Page/@imageFilename | //n:Page/@imageFilename"/>
            </xsl:attribute>
                    <xsl:element name="AlternativeImage"
                        namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                        <xsl:attribute name="filename">
                            <xsl:copy-of select="//o:TranskribusMetadata/@imgUrl | //n:TranskribusMetadata/@imgUrl"/>
                        </xsl:attribute>
                    </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="imageFilename">
                        <xsl:copy-of select="//o:TranskribusMetadata/@imgUrl | //n:TranskribusMetadata/@imgUrl"/>
                        </xsl:attribute>
                        <xsl:element name="AlternativeImage"
                            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
                            <xsl:attribute name="filename">
                                <xsl:copy-of select="@imageFilename"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
                
            
            <xsl:choose>
                <xsl:when test="o:PrintSpace and o:Border or n:PrintSpace and n:Border">
                    <xsl:copy-of select="$border | $printspace"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$standard = 'yp'">
                            <xsl:choose>
                                <xsl:when test="o:PrintSpace | n:PrintSpace">
                                    <xsl:copy-of select="$transborder"/>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$standard = 'nb'">
                            <xsl:choose>
                                <xsl:when test="o:Border | n:Border">
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
    <xsl:template match="o:PrintSpace | o:Border | n:PrintSpace | n:Border"/>


    <xd:doc>
        <xd:desc>transforms/copies all element without the old namespace</xd:desc>
    </xd:doc>
    <xsl:template match="*">
        <xsl:element name="{name()}"
            namespace="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    <xd:doc>
        <xd:desc>transforms/copies all attributes</xd:desc>
    </xd:doc>
    <xsl:template match="@*">
        <xsl:attribute name="{name()}" namespace="{namespace-uri()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>



    <xd:doc>
        <xd:desc>deletes the non-konform PAGE XML elements from Transkribus implementation</xd:desc>
    </xd:doc>
    <xsl:template match="o:TranskribusMetadata | n:TranskribusMetadata"/>
    




</xsl:stylesheet>
