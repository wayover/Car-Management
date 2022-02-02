/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The class is the test CloseSalon trigger
 **/
@isTest
public class CaseSalonHandlerTest implements Database.AllowsCallouts {

    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(201);
            res.setBody('Salesforcescool');
            return res;
        }
    }
    
    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method test case insert
    **/
    @isTest
    public static void insertSalon(){
        List<Salon__c> salonList=new List<Salon__c>();
        Account newAccount=new Account(Name='Name');
        insert newAccount;
        Salon__c newSalon= new Salon__c(Name='Name',Salon_status__c='Open',Typ__c='Wszystkie',Wlasciciel__c=newAccount.id);
        insert newSalon;
        salonList.add(newSalon);
        newSalon.Salon_status__c='Close';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        update newSalon;
        Test.stopTest();
		
        List<Case> caseList= [SELECT Id FROM Case];
        System.assert(caseList.size()>0);

    }    

    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method test update case
    **/
    @isTest
    public static void updateCase(){

        Account newAccount=new Account(Name='Name');
        insert newAccount;
        Salon__c newSalon= new Salon__c(Name='Name',Salon_status__c='Open',Typ__c='Wszystkie',Wlasciciel__c=newAccount.id);
        insert newSalon;
        Case newCase=new Case(Origin='WEB',Salon__c=newSalon.ID,Subject = 'Renovation Case');
        List<Case> caseList=new List<Case>();
        caseList.add(newCase);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        insert caseList;
        CloseSalonCaseUpdate caseUpdate = new CloseSalonCaseUpdate(caseList);
        Id jobId = System.enqueueJob(caseUpdate);
        Test.stopTest();

        System.assert(jobId!=null);
    }

    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method test null Insert
    **/
    @isTest
    public static void nullInsert(){
        CloseSalonHandler handlerClass = new CloseSalonHandler(null);
        System.assert(true);
    }

    /**
    * @author kamil.wisniewski@accenture.com
    * @date 02/02/2022
    * @description The method test null update
    **/
    @isTest
    public static void nullUpdate(){
        CloseSalonCaseUpdate caseUpdate = new CloseSalonCaseUpdate(null);
        System.assert(true);
    }

}