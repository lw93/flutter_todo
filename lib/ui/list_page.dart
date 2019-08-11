import 'package:flutter/material.dart';

import '../presenter/todo_list_presenter.dart';
import 'base_view.dart';
import '../res/scroll_physics_theme.dart';
abstract class TodoListView extends BaseView {
}

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key, this.todoType}) : super(key: key);

  final int todoType;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends BaseState<TodoListPage, TodoListPresenter> with AutomaticKeepAliveClientMixin
    implements TodoListView {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    super.build(context);
    return Text("我是第list${widget.todoType}页");
  }

  @override
  void initData() {
    // TODO: implement initData
  }

  @override
  TodoListPresenter initPresenter() {
    // TODO: implement initPresenter
    return TodoListPresenter(this);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
