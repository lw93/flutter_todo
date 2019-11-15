import '../model/base_model.dart';
import '../api/index.dart';
import 'package:intl/intl.dart';

class TodoListModel extends BaseModel {
  @deprecated
  Future<List<Todo>> queryTodos(Project project) async {
    var todos = List<Todo>();
    var response = await HttpManager.request(TodoApi.GET_PROJECT_TODOS_ONFILE,
        data: {
//          "objectId": project.objectId,
//          "projectId": project.projectId,
          "userId": project.userId,
          "groupId": project.objectId,
        },
        method: HttpManager.GET);
    ToDoResponse toDoResponse = ToDoResponse.fromJson(response);
    if (null != toDoResponse && toDoResponse.code == HttpStatus.SUCCESS) {
      Todo todo = Todo.fromJson(toDoResponse.data);
      return todos;
    }
    return todos;
  }

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

  Future<Todo> finishTodo(Project project, int index) async {
    Todo todo = project.todos.results.elementAt(index);
    if (todo != null) {
      todo.onFile = true;
      todo.onFileAt = DateTime.now().millisecondsSinceEpoch.toDouble();
      var response = await HttpManager.request(TodoApi.UPDATE_TODOS,
          data: todo.toJson(), method: HttpManager.PUT);
      ToDoResponse toDoResponse = ToDoResponse.fromJson(response);
      if (null != toDoResponse && toDoResponse.code == HttpStatus.SUCCESS) {
        Todo todo = Todo.fromJson(toDoResponse.data);
        return todo;
      }
    }
    return null;
  }

  Future<bool> delteTodoImmediately(Todo todo) async {
    if (todo != null) {
      var response = await HttpManager.request(TodoApi.DELETE_TODO_NOW,
          data: {"objectId": todo.objectId}, method: HttpManager.DELETE);
      ToDoResponse toDoResponse = ToDoResponse.fromJson(response);
      if (null != toDoResponse && toDoResponse.code == HttpStatus.SUCCESS) {
        return true;
      }
    }
    return false;
  }
}
