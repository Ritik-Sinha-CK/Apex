trigger NewTaskTrigger on Case (after insert) {
  List<Task> tasksToInsert = new List<Task>();

        for (Case newCase : Trigger.new) {

            if (newCase.Priority == 'High') 
            {
                Task newTask = new Task();
                newTask.Subject = 'Follow Up on High Priority Case'; 
                newTask.Description = 'High Priority Case Created: ' + newCase.Subject;
                newTask.WhatId = newCase.Id; 
                newTask.ActivityDate = Date.today(); 
                newTask.Status = 'Not Started'; 
                newTask.Priority = 'High'; 
                tasksToInsert.add(newTask);
            }
        }

            insert tasksToInsert;
}