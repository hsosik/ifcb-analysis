function [ document_element ] = wget_xml( url )
% given a url, fetch it, parse it as XML, and return the top DOM element in
% the document.
import org.xml.sax.InputSource
import java.io.StringReader
import javax.xml.parsers.DocumentBuilderFactory

persistent ifcb_xml_db;

if isempty(ifcb_xml_db)
    dbf = DocumentBuilderFactory.newInstance;
    dbf.setNamespaceAware(1);
    ifcb_xml_db = dbf.newDocumentBuilder;
end

url = char(url);
[content, status] = urlread(url);
if not(status), return; end
is = InputSource();
is.setCharacterStream(StringReader(content));
feed = xmlread(is,ifcb_xml_db);
document_element = feed.getDocumentElement;

end

