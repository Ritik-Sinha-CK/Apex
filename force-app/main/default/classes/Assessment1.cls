public class Assessment1 {

public void f()

{

     List<Opportunity> Op = new List<Opportunity>();

     op = [select id, StageName , Amount from Opportunity];

     List<Opportunity> newOp = new List<Opportunity>();

     for(Opportunity updatedOp : Op)

     {

         if(updatedOp.Amount > 10000)

         {

         updatedOp.StageName = 'Closed-won';

         }

         newOp.add(updatedOp);

     }

   update newOp;

}

}