@isTest
private class CheckOfferTest {


    @isTest static void testSinglePhysicalCar(){

        List<Pojazd__c> cars=new List<Pojazd__C>();
        List<Salon__c> salons = new List<Salon__c>();
        List<Oferta__c> offers = new List<Oferta__c>();

        for(Integer i=0;i<200;i++){
            cars.add(new Pojazd__c(Name='CarName'+i,Numer_seryjny__c='serialNumber'+i));
        }
        insert cars;

        Account ac=new Account(Name='Accname');
        insert ac;


        for(Integer i=0;i<200;i++){
            salons.add(new Salon__c(name='SalonName'+i,Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=ac.id));
        }
        insert salons;


        for(Integer i=0;i<200;i++){
        
            offers.add(new Oferta__c(name='of1'+i,Pojazd__c=cars.get(i).id,Stan__c='Fizyczna',Salon__c=salons.get(i).id));
        }

        Test.startTest();
        List<Database.SaveResult> result = Database.insert(offers);
        Test.stopTest();


        for(Database.SaveResult r:result){
            System.assert(r.isSuccess(),true);
        }

    }


    @isTest static void testDoublePhysicalCar(){
    
        Pojazd__c car = new Pojazd__c(Name='CarName',Numer_seryjny__c='serialNumber');
        insert car;

        Account ac=new Account(Name='Accname');
        insert ac;

        Salon__c salon= new Salon__c(name='SalonName',Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=ac.id);
        insert salon;


        Oferta__c of1= new Oferta__c(name='of1',Pojazd__c=car.id,Stan__c='Fizyczna',Salon__c=salon.id);
        insert of1;

        Oferta__c of2= new Oferta__c(name='of2',Pojazd__c=car.id,Stan__c='Fizyczna',Salon__c=salon.id);

        Test.startTest();
        Database.SaveResult result = Database.insert(of2,false);
        Test.stopTest();

        System.assertEquals(result.isSuccess(),false);
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You can not set again this car as physical', result.getErrors()[0].getMessage());
    
    }


    @isTest static void testSameCar(){

        Pojazd__c car = new Pojazd__c(Name='CarName',Numer_seryjny__c='serialNumber');
        insert car;

        Account ac=new Account(Name='Accname');
        insert ac;

        Salon__c salon= new Salon__c(name='SalonName',Salon_status__c='open',Typ__c='Wszystkie',Wlasciciel__c=ac.id);
        insert salon;


        Oferta__c of1= new Oferta__c(name='of1',Pojazd__c=car.id,Stan__c='Fizyczna',Salon__c=salon.id);		
        Oferta__c of2=new Oferta__c(name='of1',Pojazd__c=car.id,Stan__c='Fizyczna',Salon__c=salon.id);

        List <Oferta__c> offers = new List<Oferta__c>();
        offers.add(of1);
        offers.add(of2);
        Test.startTest();
        List<Database.SaveResult> result = Database.insert(offers,false);
        Test.stopTest();

        List<Oferta__c> offs =[SELECT Id from Oferta__c];
        System.assert(offs.size()==1);
    }


}