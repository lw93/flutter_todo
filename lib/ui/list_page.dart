import 'package:flutter/material.dart';

import '../presenter/todo_list_presenter.dart';
import 'base_view.dart';
import '../res/scroll_physics_theme.dart';

abstract class TodoListView extends BaseView {}

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key, this.todoType}) : super(key: key);

  final int todoType;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends BaseState<TodoListPage, TodoListPresenter>
    with AutomaticKeepAliveClientMixin
    implements TodoListView {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets. Text("我是第list${widget.todoType}页")
    super.build(context);
    return GridView.builder(
        physics: PhysicsTheme.commonScrollPhysicsTheme,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.todoType == 0 ? 1 : 2, //每行三列
            childAspectRatio: 1 //显示区域宽高相等
            ),
        itemCount: 10,
        itemBuilder: (context, index) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          return Icon(Icons.ac_unit, size: 56);
        });
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
