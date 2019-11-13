import '../model/base_model.dart';
import '../api/index.dart';

class TodoListModel extends BaseModel {
  Future<Todo> createTodo(String name, Project project) async {
    var response = await HttpManager.request(TodoApi.CREATE_TODOS,
        data: {
          "title": name,
          "groupId": project.objectId,
          "priority": project.todos.results.length,
          "userId": project.userId,
        },
        method: HttpManager.POST);
    ToDoResponse toDoResponse = ToDoResponse.fromJson(response);
    if (null != toDoResponse && toDoResponse.code == HttpStatus.SUCCESS) {
      Todo todo = Todo.fromJson(toDoResponse.data);
      return todo;
    }
    return null;
  }
}
