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
java -jar ../saxon9he.jar -xsl:page2page.xsl -s:transkribusPage.xml standard=y -o: standardPage.xml
```

ToDo
--------------------------------
Transkibus Page also uses an invalid PAGE XML table model. This model must also be transformed into PAGE XML.
