import 'package:flutter/material.dart';

import '../api/index.dart';
import '../presenter/project_presenter.dart';
import '../res/scroll_physics_theme.dart';
import 'base_view.dart';

abstract class ProjectView extends BaseView {}

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key, this.todoType}) : super(key: key);

  final int todoType;

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends BaseState<ProjectPage, ProjectPresenter>
    with AutomaticKeepAliveClientMixin
    implements ProjectView {
  List<Project> projects;
  List<int> icons;

  @override
  void initData() {
    // TODO: implement initData
    icons = List();
    for (int i = 0; i < 20; i++) {
      icons.add(i);
    }
    icons.insert(0, -1);
  }

  @override
  ProjectPresenter initPresenter() {
    // TODO: implement initPresenter
    return ProjectPresenter(this);
  }

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
        itemCount: icons.length,
        itemBuilder: (context, index) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          if (index == 0) {
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 56,
                    color: Colors.white,
                  ),
                  Text("新建项目", style: TextStyle(color: Colors.white)),
                ],
              ),
              color: Colors.grey.shade300,
            );
          }
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("项目名",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      PopupMenuButton(
                        child: Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: "1",
                                child: ListTile(
                                  leading: Icon(Icons.backup),
                                  title: Text('修改名称'),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: "2",
                                child: ListTile(
                                  leading: Icon(Icons.check_circle),
                                  title: Text('完成归档'),
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: "3",
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('删除任务'),
                                ),
                              ),
                            ],
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("1.新建计划任务",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(
                          height: 16,
                        ),
                        Text("2.长按可移动、删除",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  Align(
                    child: Text("日期:2018-10-25",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
            color: Colors.grey.shade400,
          );
        });
  }

  void _showEditPopMenu(int index) {}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
