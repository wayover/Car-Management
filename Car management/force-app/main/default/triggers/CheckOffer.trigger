trigger CheckOffer on Oferta__c  (before insert) {
   
   
    CheckOfferHandler.check(trigger.new);
    
}