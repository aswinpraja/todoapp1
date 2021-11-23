class TaskItem {
  late bool isTaskComplete;
  late String taskName;


  TaskItem({required this.taskName,required this.isTaskComplete});

  String getTaskName(){
    return taskName;
  }

  setTaskDone(bool isDone){
    isTaskComplete=isDone;
  }


  }