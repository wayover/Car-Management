/**
* @author kamil.wisniewski@accenture.com
* @date 02/02/2022
* @description The Class update Case
**/
public with sharing class CloseSalonCaseUpdate implements Queueable, Database.AllowsCallouts{
    
    private List<Case> caseList;
    public CloseSalonCaseUpdate(List<Case> inCaseList) {
        if(inCaseList==null){
            return;
        }
        caseList=inCaseList;
    }

    public void execute(QueueableContext context) {
    
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST');
        req.setBody(JSON.serialize(caseList));
        HttpResponse resp = server.send(req);
        If(resp.getStatusCode()==201){
            for(Case corCase:caseList){
                corCase.status='Closed';
            }
        }else{
            for(Case failCase:caseList){
                failCase.status='faild';
            }
        }

        update caseList;
    }
}
