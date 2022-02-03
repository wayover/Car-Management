/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The Class is the handler to CloseSalon trigger that insert Case
**/
public class CloseSalonHandler implements Queueable, Database.AllowsCallouts {
    
    private List<Salon__c> salonList;
    public CloseSalonHandler(List<Salon__c> inSalonList){
        if(inSalonList==null){
            return;
        }

        List<Salon__c> salonCloseList = new List<Salon__c>();

        for(Salon__c salon:inSalonList){
            if(salon.Salon_status__c==Constant.close){
                salonCloseList.add(salon);
            }
        }
        salonList=salonCloseList;
    }

    public void execute(QueueableContext context) {

        List<Case> caseList=new List<Case>();
        for(Salon__c  salons:salonList){
            caseList.add(new Case(Origin='WEB',Salon__c=salons.ID,Subject = 'Renovation Case'+salons.Name));
        }

        insert caseList;

        if(!Test.isRunningTest()){
            CloseSalonCaseUpdate caseUpdate = new CloseSalonCaseUpdate(caseList);
            Id jobId = System.enqueueJob(caseUpdate);
        }
    }

    

}
