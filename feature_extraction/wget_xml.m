function [ document_element ] = wget_xml( url )

import org.xml.sax.InputSource
import java.io.StringReader
import javax.xml.parsers.DocumentBuilderFactory

dbf = DocumentBuilderFactory.newInstance;
dbf.setNamespaceAware(1);
db = dbf.newDocumentBuilder;

url = char(url);
[content, status] = urlread(url);
if not(status), return; end
is = InputSource();
is.setCharacterStream(StringReader(content));
feed = xmlread(is,db);
document_element = feed.getDocumentElement;

end

