/**
* @author kamil.wisniewski@accenture.com
* @date 31/01/2022
* @description The class is the test CheckOffer trigger
 **/

@isTest
private class CheckOfferTest {



    /**
    * @author kamil.wisniewski@accenture.com
    * @date 31/01/2022
    * @description The method tests insert correct offers
    **/
    @isTest static void testSinglePhysicalCar(){

        List<Pojazd__c> vehicleList=new List<Pojazd__C>();
        List<Salon__c> salonList = new List<Salon__c>();
        List<Oferta__c> offerList = new List<Oferta__c>();

        for(Integer i=0;i<200;i++){
            vehicleList.add(new Pojazd__c(Name='CarName'+i,Numer_seryjny__c='serialNumber'+i));
        }
        insert vehicleList;

        Account account=new Account(Name='Accname');
        insert account;


        for(Integer i=0;i<200;i++){
            salonList.add(new Salon__c(name='SalonName'+i,Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=account.id));
        }
        insert salonList;


        for(Integer i=0;i<200;i++){
        
            offerList.add(new Oferta__c(name='of1'+i,Pojazd__c=vehicleList.get(i).id,Stan__c=Constant.PHYSICAL,Salon__c=salonList.get(i).id));
        }

        Test.startTest();
        List<Database.SaveResult> result = Database.insert(offerList);
        Test.stopTest();


        for(Database.SaveResult r:result){
            System.assert(r.isSuccess(),true);
        }

    }


    /**
    * @author kamil.wisniewski@accenture.com
    * @date 31/01/2022
    * @description The method tests insert 2 phisical offer with the same vehicle
    **/
    @isTest static void testDoublePhysicalCar(){
    
        Pojazd__c vehicle = new Pojazd__c(Name='CarName',Numer_seryjny__c='serialNumber');
        insert vehicle;

        Account account=new Account(Name='Accname');
        insert account;

        Salon__c salon= new Salon__c(name='SalonName',Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=account.id);
        insert salon;


        Oferta__c correctOffer= new Oferta__c(name='offer',Pojazd__c=vehicle.id,Stan__c=Constant.PHYSICAL,Salon__c=salon.id);
        insert correctOffer;

        Oferta__c wrongOffer= new Oferta__c(name='of2',Pojazd__c=vehicle.id,Stan__c=Constant.PHYSICAL,Salon__c=salon.id);

        Test.startTest();
        Database.SaveResult result = Database.insert(wrongOffer,false);
        Test.stopTest();

        System.assertEquals(result.isSuccess(),false);
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You can not set again this car as physical', result.getErrors()[0].getMessage());
    
    }

    /**
    * @author kamil.wisniewski@accenture.com
    * @date 31/01/2022
    * @description The method tests insert 2 of the same offers
    **/
    @isTest static void testSameCar(){

        Pojazd__c vehicle = new Pojazd__c(Name='CarName',Numer_seryjny__c='serialNumber');
        insert vehicle;

        Account account=new Account(Name='Accname');
        insert account;

        Salon__c salon= new Salon__c(name='SalonName',Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=account.id);
        insert salon;



        Oferta__c correctOffer= new Oferta__c(name='of1',Pojazd__c=vehicle.id,Stan__c=Constant.PHYSICAL,Salon__c=salon.id);		
        Oferta__c wrongOffer=new Oferta__c(name='of1',Pojazd__c=vehicle.id,Stan__c=Constant.PHYSICAL,Salon__c=salon.id);

        List <Oferta__c> offerList = new List<Oferta__c>();
        offerList.add(correctOffer);
        offerList.add(wrongOffer);
        Test.startTest();
        List<Database.SaveResult> result = Database.insert(offerList,false);
        Test.stopTest();

        List<Oferta__c> offList =[SELECT Id from Oferta__c];
        System.assert(offList.size()==1);
    }


    /**
    * @author kamil.wisniewski@accenture.com
    * @date 01/02/2022
    * @description The method tests null insert 
    **/
    @isTest static void testNullCar(){

        Test.startTest();
        CarDeleteInfoHandler.carDeleteCleanup(null);
        Test.stopTest();

    }


}