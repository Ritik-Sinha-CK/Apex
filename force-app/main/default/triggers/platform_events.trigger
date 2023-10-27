trigger platform_events on Lead (before insert) {
	New_Lead_Event__e event1 = new New_Lead_Event__e();
    event1.Description__c = 'Description updated through Platform event';
    EventBus.publish(event1);
}