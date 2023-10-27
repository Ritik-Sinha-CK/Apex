@RESTResource(urlMapping='/CreateLeadx/')
global class createApi {
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