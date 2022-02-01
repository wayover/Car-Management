public class SendMailFuture {
    @future
    public static void sendmail(List<Id> inIdOfferList){
        
        if(inIdOfferList==null ||inIdOfferList.size()==0){
            return;
        }

        List<Oferta__c> offerList= [SELECT Name from Oferta__c WHERE Id IN :inIdOfferList];
        
        List <String> stringList = new List < String >();
        
        for(Oferta__C offer: OfferList){
            stringList.add(offer.Name);
        }
        String mailBody ='New offer/s: \n';
        mailBody += String.join( stringList, ', ' );  

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new string[] {'wisnia_198@wp.pl'});
        mail.setSubject('New Offer/s');
        mail.setPlainTextBody(mailBody);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}
