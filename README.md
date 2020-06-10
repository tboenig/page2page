# page2page
This repository save the stylesheet and workaround for transforming the properitary PAGE XML file from 
Transkribus (https://transkribus.eu/Transkribus) into a PAGE XML valid format 
(https://www.primaresearch.org/schema/PAGE/gts/pagecontent/ newest version from 2019-07-16.

Parameter `standard`: 
- n = stands for no element `PrintSpace` transformation, 
- y = stands for element `PrintSpace` transformation into element `Border`
- #default = n


Transformation
-------------------------------

```sh
java -jar saxon-he-10.1.jar -xsl:page2page.xsl -s:transkribusPage.xml standard=y -o:standardPage.xml
```

Attention
-------------------------------
The transformation is not a conversation into PAGE XML. This transformation deletes the proprietary transcript elements the first time. Important information in custom attributes is not converted to type values. An example:

TanskribusPage
```xml
        <GraphicRegion id="Graphic_1591786590801_37" 
                       custom="readingOrder {index:5;} structure {type:handwritten-annotation;}">
            <Coords points="937,132 417,131 417,58 937,59"/>
        </GraphicRegion>
        <GraphicRegion id="Graphic_1591786870232_47" 
                       custom="readingOrder {index:6;} structure {type:stamp;}">
            <Coords points="478,1296 778,1296 778,1523 478,1523"/>
        </GraphicRegion>
```
a right PAGE XML intance
```xml
        <GraphicRegion id="Graphic_1591786590801_37" type="handwritten-annotation" 
                       custom="readingOrder {index:5;} structure {type:handwritten-annotation;}">
            <Coords points="937,132 417,131 417,58 937,59"/>
        </GraphicRegion>
        <GraphicRegion id="Graphic_1591786870232_47"  type="stamp" 
                       custom="readingOrder {index:6;} structure {type:stamp;}">
            <Coords points="478,1296 778,1296 778,1523 478,1523"/>
        </GraphicRegion>
```



ToDo
--------------------------------
Transkibus Page also uses an invalid PAGE XML table model. This model must also be transformed into PAGE XML.
