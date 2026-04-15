public with sharing class TaskController {

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasks() {
        return [SELECT Id, Name, Subject__c, Done__c, DueDate__c 
                FROM Task__c 
                ORDER BY CreatedDate DESC];
    }

    @AuraEnabled
    public static void markDone(Id taskId) {
        if (taskId == null) {
            throw new AuraHandledException('Task ID is required');
        }
        Task__c taskToUpdate = new Task__c(Id = taskId, Done__c = true);
        update taskToUpdate;
    }
}