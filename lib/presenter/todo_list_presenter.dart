import '../model/todo_list_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/list_page.dart';
import '../api/index.dart';

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
      }
      view.addTodo(result);
    }).catchError((onError) {
      print(onError.toString());
      view.showError("添加失败");
    }).whenComplete(() {
      view.hideLoading();
    });
  }

  void deleteTodo(Project project, int index) {}

  void finishTodo(Project project, int index) {}
}
