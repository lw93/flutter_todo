import '../model/todo_list_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/list_page.dart';

class TodoListPresenter extends BasePresenter<TodoListModel,TodoListView> {
  TodoListPresenter(TodoListView view) : super(view) {
    model = TodoListModel();
  }
}
