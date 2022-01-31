trigger CarDeleteInfo on Pojazd__c (before delete) {


    CarDeleteInfoHandler.check(trigger.old);
}