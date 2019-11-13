import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api/index.dart';
import '../presenter/todo_list_presenter.dart';
import '../res/scroll_physics_theme.dart';
import 'base_view.dart';

abstract class TodoListView extends BaseView {
  void showLoading();

  void hideLoading();

  void showError(String msg);

  void showTodos(List<Todo> todos);

  void addTodo(Todo todo);

  void deleteTodo(Todo todo);
}

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key, this.todoType, this.project}) : super(key: key);

  final int todoType;
  final Project project;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends BaseState<TodoListPage, TodoListPresenter>
    with AutomaticKeepAliveClientMixin
    implements TodoListView {
  RefreshController _refreshController = RefreshController();
  Project _project = null;
  List<Todo> todoList;
  TextEditingController _projectAddController = TextEditingController();
  GlobalKey globalKey = GlobalKey();

  void _onRefresh(bool up) {
    // monitor network fetch
    /*if(_project!=null){
      debugPrint("projectId:${_project.projectId} "
          "objectId:${_project.objectId} "//groupId
          "userId:${_project.userId}"
      );
    }*/
    _refreshController.sendBack(true, RefreshStatus.completed);
  }

  void _addTodo() {
    // 添加todo
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("添加"),
        content: TextField(
          controller: _projectAddController,
          decoration: InputDecoration(
            hintText: "请输入内容",
            labelText: "项目名",
            border: OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () {
              Navigator.pop(globalKey.currentContext);
            },
          ),
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              Navigator.pop(globalKey.currentContext);
              presenter.createTodo(_projectAddController.text, _project);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets. Text("我是第list${widget.todoType}页")
    //_project = ModalRoute.of(context).settings.arguments;

    super.build(context);
    if (todoList.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: _addTodo,
              ),
            ],
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.hourglass_empty,
                size: 36,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("暂无数据"),
              ),
            ],
          )));
    }
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
              onPressed: _addTodo,
            ),
          ],
        ),
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            color: Colors.black87,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                  physics: PhysicsTheme.commonScrollPhysicsTheme,
                  itemCount: todoList.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    //如果显示到最后一个并且Icon总数小于200时继续获取数据
                    Todo item = todoList[index];
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Slidable(
                            key: Key('key$index'),
                            // 侧滑按钮所占的宽度
                            actionExtentRatio: 0.20,
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'Done',
                                color: Colors.green,
                                icon: Icons.done_all,
                                onTap: () =>
                                    presenter.finishTodo(_project, index),
                              ),
                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () =>
                                    presenter.deleteTodo(_project, index),
                              ),
                            ],
                            child: Container(
                              child: ListTile(
                                leading: Icon(Icons.access_alarm),
                                title: Text(item?.title ?? ""),
                                trailing: item?.onFile ?? false
                                    ? Icon(Icons.done)
                                    : Icon(Icons.undo),
                              ),
                              /* Divider(
                        color: Colors.grey,
                      ),*/
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                        ]);
                  }),
            )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.sendBack(true, RefreshStatus.completed);
    _refreshController = null;
    if (_project != null) {
      _project = null;
    }
  }

  @override
  void initData() {
    // TODO: implement initData
    _project = widget.project;
    if (_project != null) {
      Todos todos = _project.todos;
      if (todos != null) {
        todoList = todos.results;
        return;
      }
    }
    todoList = List();
  }

  @override
  TodoListPresenter initPresenter() {
    // TODO: implement initPresenter
    return TodoListPresenter(this);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void addTodo(Todo todo) {
    // TODO: implement addTodo
    if (_project != null) {
      setState(() {
        _project.todos.results.add(todo);
      });
    }
  }

  @override
  void deleteTodo(Todo todo) {
    // TODO: implement deleteTodo
  }

  @override
  void showTodos(List<Todo> todos) {
    // TODO: implement showTodos
  }

  @override
  void showError(String msg) {
    // TODO: implement showError
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$msg")));
  }
}
