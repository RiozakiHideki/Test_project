import { LightningElement, wire, track } from 'lwc';
import getTasks from '@salesforce/apex/TaskController.getTasks';
import markDone from '@salesforce/apex/TaskController.markDone';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TaskList extends LightningElement {
    @track tasks = [];
    error;

    @wire(getTasks)
    wiredTasks({ error, data }) {
        if (data) {
            this.tasks = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.tasks = undefined;
            this.showToast('Error', 'Failed to load tasks', 'error');
        }
    }

    handleMarkDone(event) {
        const taskId = event.target.dataset.id;

        if (!taskId) return;

        markDone({ taskId: taskId })
            .then(() => {
                this.showToast('Success', 'Task marked as done', 'success');
                
                const updatedTasks = this.tasks.map(task => {
                    if (task.Id === taskId) {
                        return { ...task, Done__c: true };
                    }
                    return task;
                });
                this.tasks = updatedTasks;
            })
            .catch(error => {
                this.showToast('Error', 'Failed to update task', 'error');
                console.error(error);
            });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}