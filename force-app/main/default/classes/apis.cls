@RestResource(urlMapping='/Industry/*')

//retrieve the details of all "Account" records
// with the "Industry" field set to "Technology".
global with sharing class apis {
    /*@HttpGet
    global static Account getCaseById()
    {
        RestRequest request = RestContext.request;
        String IndustryID = request.requestURI.substring(
        	request.requestURI.lastIndexOf('/')+1);
        
        Account res = [select Name from Account where Industry = :IndustryID];
        return res;
    
    }*/
    
      @HttpGet
    global static Account getCaseById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String IndustryName = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Name
                        FROM Account
                        WHERE Industry = :IndustryName];
        return result;

    }
    
   /* @HttpPatch
    global static String changeIndustry(String id)
    {
        Account acc = [select name,industry from Account where ID = :id Limit 1];
        if(acc!=null)
        {
            if(acc.Industry == 'Technology')
            {
                acc.Industry = 'Medical';
                update acc;
                return 'Industry Updated Successfully';
            }
            else {
                return 'No technology Account Found';
            }
            
        }
        else {
            return 'Account not Found';
        }    
        
    } */
}