import '../api/index.dart';
import '../model/todo_list_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/list_page.dart';

class TodoListPresenter extends BasePresenter<TodoListModel, TodoListView> {
  TodoListPresenter(TodoListView view) : super(view) {
    model = TodoListModel();
  }

  void createTodo(String name, Project project) {
    view.showLoading();
    if (name == null || name.isEmpty) {
      view.hideLoading();
      return;
    }
    model.createTodo(name, project).then((result) {
      if (result == null) {
        view.showError("添加失败");
        return;
      }
      view.addTodo(result);
    }).catchError((onError) {
      print(onError.toString());
      view.showError("添加失败");
    }).whenComplete(() {
      view.hideLoading();
    });
  }

  void deleteTodo(Project project, int index) {

  }

  void finishTodo(Project project, int index) {
    view.showLoading();
    if (project != null) {
      model.finishTodo(project, index).then((onValue) {
        if (onValue != null) {
          view.showTodo(onValue);
          return;
        }
        view.showError("操作失败");
      }).catchError((onError) {
        print(onError.toString());
        view.showError("操作失败");
      }).whenComplete(() {
        view.hideLoading();
        return;
      });
    }
    view.hideLoading();
  }

  void queryTodos(Project project) {
    view.showLoading();
    if (project == null) {
      view.hideLoading();
      return;
    }
    model.queryTodos(project).then((onValue) {
      if (onValue != null) {
        view.refreshTodos(onValue);
      }
    }).catchError((onError) {
      print(onError.toString());
      view.showError("请求失败");
    }).whenComplete(() {
      view.hideLoading();
    });
  }

  void deleteImmedately(Todo todo) {
    view.showLoading();
    if (todo == null) {
      view.hideLoading();
      return;
    }
    model.delteTodoImmediately(todo).then((onValue) {
      if (onValue != null && onValue) {
        view.deleteTodo(todo);
        return;
      }
      view.showError("删除失败");
    }).catchError((onError) {
      print(onError.toString());
      view.showError("删除失败");
    }).whenComplete(() {
      view.hideLoading();
    });
  }
}
