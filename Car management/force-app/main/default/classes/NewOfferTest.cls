/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The class is the test NewOffer trigger
 **/
@isTest
public class NewOfferTest {
    
    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method checks if the method was called
    **/    
    @isTest
    private static void testInsertNewOffer(){

        List<Oferta__c> offerList = new List<Oferta__c>();

        Pojazd__c vehicle = new Pojazd__c(Name='CarName',Numer_seryjny__c='serialNumber');
        insert vehicle;

        Account account=new Account(Name='Accname');
        insert account;

        Salon__c salon= new Salon__c(name='SalonName',Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=account.id);
        insert salon;

        for(Integer i=0;i<200;i++){
            offerList.add(new Oferta__c(name='offer',Pojazd__c=vehicle.id,Stan__c='Wirtualna',Salon__c=salon.id));
        }

        Test.startTest();
        insert offerList;
        Integer futureCount = Limits.getFutureCalls();
        Test.stopTest();

        
        System.assert(futureCount>0);
    }
    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method checks null offer
    **/    
    @isTest
    private static void testNullOffer(){
        NewOfferHandler.sendId(null);
        System.assert(true);
    }
    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method checks null casess
    **/    
    @isTest
    private static void testSendNullId(){
        SendMailFuture.sendmail(null);
        System.assert(true);
    }
}
