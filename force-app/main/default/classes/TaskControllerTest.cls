@IsTest
private class TaskControllerTest {

    @IsTest
    static void testGetTasksReturnsData() {
        Task__c task1 = new Task__c(
            Name = 'Test Task 1',
            Subject__c = 'Test Subject 1',
            Done__c = false,
            DueDate__c = Date.today()
        );
        insert task1;

        Task__c task2 = new Task__c(
            Name = 'Test Task 2',
            Subject__c = 'Test Subject 2',
            Done__c = true,
            DueDate__c = Date.today().addDays(1)
        );
        insert task2;

        Test.startTest();
        List<Task__c> tasks = TaskController.getTasks();
        Test.stopTest();

        System.assertEquals(2, tasks.size());

        Set<String> subjects = new Set<String>();
        for (Task__c t : tasks) {
            subjects.add(t.Subject__c);
        }

        System.assert(subjects.contains('Test Subject 1'));
        System.assert(subjects.contains('Test Subject 2'));

        Boolean hasDoneTask = false;
        for (Task__c t : tasks) {
            if (t.Done__c == true) {
                hasDoneTask = true;
                break;
            }
        }
        System.assert(hasDoneTask);
    }

    @IsTest
    static void testMarkDoneUpdatesStatus() {
        Task__c task = new Task__c(
            Name = 'Task To Complete',
            Subject__c = 'Important Task',
            Done__c = false,
            DueDate__c = Date.today()
        );
        insert task;

        Test.startTest();
        TaskController.markDone(task.Id);
        Test.stopTest();

        Task__c updatedTask = [SELECT Done__c FROM Task__c WHERE Id = :task.Id];
        System.assertEquals(true, updatedTask.Done__c);
    }

    @IsTest
    static void testMarkDoneWithNullIdThrowsException() {
        try {
            Test.startTest();
            TaskController.markDone(null);
            Test.stopTest();
            System.assert(false);
        } catch (AuraHandledException e) {
        } catch (Exception e) {
            System.assert(false);
        }
    }
}