@RestResource (urlMapping = '/wsFetchIndustryAccount/*')
global class WsFetchIndustryAccountApi{

    global class Response{
        String status;
        Integer statusCode;
        String message;
        List<Account> data;
    }

 

   
    @HttpGET

    global static Response fetchAccountDetails(){
        List<Account> accList = [SELECT id, name, Industry  FROM Account WHERE Industry  = 'Technology'];

        Response res = new Response();
        res.status = 'SUCCESS';
        res.statusCode = 200;
        res.message = 'Operation successful!';
        res.data = accList;

        return res;
    } 
}