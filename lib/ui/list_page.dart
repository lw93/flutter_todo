import 'package:flutter/material.dart';
import '../api/index.dart';
import '../presenter/todo_list_presenter.dart';
import 'base_view.dart';
import '../res/scroll_physics_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class TodoListView extends BaseView {}

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key, this.todoType, this.project}) : super(key: key);

  final int todoType;
  final Project project;

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends BaseState<TodoListPage, TodoListPresenter>
    with AutomaticKeepAliveClientMixin implements TodoListView {

  RefreshController _refreshController = RefreshController();
  Project _project = null;

  void _onRefresh(bool up) {
    // monitor network fetch
    if(_project!=null){
      debugPrint("projectId:${_project.projectId} "
          "objectId:${_project.objectId}"
          "userId:${_project.userId}"
      );
    }
    _refreshController.sendBack(true, RefreshStatus.completed);
  }

  void _addTodo() {
    // 添加todo
    debugPrint("addTodo");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets. Text("我是第list${widget.todoType}页")
    _project = ModalRoute.of(context).settings.arguments;

    super.build(context);
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
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView.builder(
              physics: PhysicsTheme.commonScrollPhysicsTheme,
              itemCount: 10,
              itemBuilder: (context, index) {
                //如果显示到最后一个并且Icon总数小于200时继续获取数据
                return Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 16),
                    child: Text(widget.project.name + "  " + index.toString()));
              }),
        ));
  }

  @override
  void didUpdateWidget(TodoListPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    //_refreshController.sendBack(true, RefreshStatus.refreshing);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController?.scrollController?.dispose();
    _refreshController = null;
    if (_project != null) {
      _project = null;
    }
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
