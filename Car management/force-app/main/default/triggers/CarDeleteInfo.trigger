trigger CarDeleteInfo on Pojazd__c (before delete) {


    CarDeleteInfoHandler.carDeleteCleanup(trigger.old);
}