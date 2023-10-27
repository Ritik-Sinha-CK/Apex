trigger event_trigger on New_Lead_Event__e (after insert) {
	for(New_Lead_Event__e ev : Trigger.new)
    {
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add('ritik210798@gmail.com');
        mail.setToAddresses(sendTo);
        mail.setSubject('Test Enail');
        String body = ev.Description__c;
        mail.setHtmlBody(body);
        mails.add(mail);
       Messaging.sendEmail(mails);
    }
}