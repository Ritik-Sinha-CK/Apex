@RESTResource(urlMapping='/CreateLead/')
/*global class GetID {
    @HTTPGet 
    global static String showLead()
    {
        String objName;
        Id i;
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        objName = req.headers.get('ObjectName');
        i = req.headers.get('Id');
        //System.debug(req.headers.toString());
        String qr = 'Select Name from '+objName+' where id = :i ' Limit 1;';
        sObject s = Database.query(qr);
        String jsonResponse = '{\"Name\":\" + s.get('Name')+"\"} ';
        return jsonResponse;
    }
}*/
global class Post {
    @HTTPPost
global static String creatingLead()
{
    String fname,lname , comp;
    String fieldName, fieldValue;
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    String jsonBody = req.requestBody.toString();
    JSONParser parser = JSON.createParser(jsonBody);
    while(parser.nextToken()!=null)
    {
        if(parser.getCurrentToken() != JSONToken.END_OBJECT)
        {
            fieldName = parser.getCurrentName(); // firstNAme
            fieldValue = parser.getText(); //Amisha
            if(fieldName == 'firstName')
            {
                fname = fieldValue;
            }
            else if(fieldName == 'LastName')
            {
                lname = fieldValue;
            }
            else if(fieldName == 'Company')
            {
                comp = fieldValue;
            }
        }
    }
    Lead l = new Lead(firstName = fname , lastName = lname , company = comp);
    insert l;
    return l.id;
}
}