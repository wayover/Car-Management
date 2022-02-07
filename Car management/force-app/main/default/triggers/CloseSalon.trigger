/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The trigger Selects cases changed to 'Close'
 **/
trigger CloseSalon on Salon__c (after update) {
    
    List<Salon__c> salonList = new List<Salon__c>();
    Map<Id,Salon__c> salonMap = trigger.oldMap;
    for(Salon__c salon:trigger.new){

        Salon__c oldSalon= salonMap.get(salon.Id);

         if(oldSalon.Salon_status__c!='Close' && salon.Salon_status__c=='Close'){
             salonList.add(salon);
         }
    }

    if(salonList.size()>0){
        CloseSalonHandler handlerClass = new CloseSalonHandler(salonList);
        System.enqueueJob(handlerClass);
    }
}