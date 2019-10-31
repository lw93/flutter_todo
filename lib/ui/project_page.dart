import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../api/index.dart';
import '../presenter/project_presenter.dart';
import '../res/strings.dart';
import '../widgets/draggable_grideview2.dart';
import 'base_view.dart';

abstract class ProjectView extends BaseView {
  void showLoading();

  void hideLoading();

  void showData(List<Project> todos);

  void updateProject(Project project);
}

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
  List<Project> icons;
  List<GlobalKey> keys = List();
  Project updateCurrProject;
  Project olderCurrProject;
  GlobalKey globalKey;
  //GlobalKey anchorKey = GlobalKey();

  @override
  void initData() {
    // TODO: implement initData
    globalKey = GlobalKey();
    icons = List();
    icons.add(Project.fromJson(Map()));
    presenter.queryProjects();
    /*for (int i = 0; i < 20; i++) {
      icons.add(i);
    }
    icons.insert(0, -1);
    for (int j = 0; j < icons.length; j++) {
      keys.add(GlobalKey(debugLabel: j.toString()));
    }*/
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
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black87,
        key: globalKey,
        child: DraggableGridView(
            items: icons,
            itemBuilder: (context, obj, index) {
              //如果显示到最后一个并且Icon总数小于200时继续获取数据
              if (index == 0) {
                return Card(
                  child: InkWell(
                    splashColor: Colors.grey.shade400,
                    onTap: () {
                      //TODO 点击事件
                    },
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
                  ),
                  color: Colors.grey.shade300,
                );
              }
              Project currentPro = icons[index];
              List<Todo> todes = currentPro.todos.results;
              int year, mon, day;
              if (null != currentPro) {
                DateTime dateTime = DateFormat(StringUtil.DATE_PATTER)
                    .parse(currentPro.createdAt);
                year = dateTime.year;
                mon = dateTime.month;
                day = dateTime.day;
              }

              return Card(
                child: InkWell(
                  splashColor: Colors.grey.shade300,
                  onTap: () {
                    //TODO 点击事件
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("项目: ${currentPro.name}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            GestureDetector(
                              onTapDown: (detail) {
                                updateCurrProject = currentPro;
                                olderCurrProject = currentPro;
                                _showEditDialog(context, index);
                              },
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  todes.length > 0
                                      ? "1.${todes?.elementAt(0)?.title ?? "新建计划任务"}"
                                      : "1.新建计划任务",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                  todes.length > 1
                                      ? "2.${todes?.elementAt(1)?.title ?? "长按可移动、删除"}"
                                      : "2.长按可移动、删除",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ),
                        Align(
                          child: year != 0
                              ? Text("日期: ${year}-${mon}-${day}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                              : Text("日期: yyyy-mm-dd",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
                color: Colors.grey.shade400,
              );
            }));
//    return GridView.builder(
//        physics: PhysicsTheme.commonScrollPhysicsTheme,
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            crossAxisCount: widget.todoType == 0 ? 1 : 2, //每行三列
//            childAspectRatio: 1 //显示区域宽高相等
//            ),
//        itemCount: icons.length,
//        itemBuilder: (context, index) {
//          //如果显示到最后一个并且Icon总数小于200时继续获取数据
//          if (index == 0) {
//            return Card(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Icon(
//                    Icons.add,
//                    size: 56,
//                    color: Colors.white,
//                  ),
//                  Text("新建项目", style: TextStyle(color: Colors.white)),
//                ],
//              ),
//              color: Colors.grey.shade300,
//            );
//          }
//          final childDragg = DragTarget<Object>(
//            onWillAccept: (Object data) {
//              return true;
//            },
//            builder: (context, old, backup) {
//              return Card(
//                child: Padding(
//                  padding: EdgeInsets.all(10),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text("项目名",
//                              style:
//                                  TextStyle(color: Colors.white, fontSize: 12)),
//                          GestureDetector(
//                            key: keys[index],
//                            onTapDown: (detail) {
//                              //_showEditPopMenu(context, detail, index);
//                              _showEditDialog(context, index);
//                            },
//                            onTap: () {
//                              //_showEditDialog(context, index);
//                            },
//                            child: Icon(
//                              Icons.edit,
//                              size: 18,
//                              color: Colors.white,
//                            ),
//                          ),
//                        ],
//                      ),
//                      Center(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("1.新建计划任务",
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 12)),
//                            SizedBox(
//                              height: 16,
//                            ),
//                            Text("2.长按可移动、删除",
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 12)),
//                          ],
//                        ),
//                      ),
//                      Align(
//                        child: Text("日期:2018-10-25",
//                            style:
//                                TextStyle(color: Colors.white, fontSize: 12)),
//                      ),
//                    ],
//                  ),
//                ),
//                color: Colors.grey.shade400,
//              );
//            },
//          );
//          return LongPressDraggable<Object>(
//            child: childDragg,
//            feedback: childDragg,
//          );
//        });
  }

  void _showEditPopMenu(
      BuildContext context, TapDownDetails detail, int index) {
    RenderBox renderBox = keys[index].currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    final RelativeRect position = RelativeRect.fromLTRB(
        detail.globalPosition.dx, //取点击位置坐弹出x坐标
        offset.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        detail.globalPosition.dx,
        offset.dy);
    showMenu(
      context: context,
      position: position,
      items: <PopupMenuEntry<String>>[
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _showEditDialog(BuildContext context, int index) {
    TextEditingController _projectController = TextEditingController();
    String updateName = icons[index].name;
    _projectController
      ..clear()
      ..text = updateName;
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("更新"),
        content: TextField(
          controller: _projectController,
          decoration: InputDecoration(
            hintText: "请输入内容",
            labelText: "项目名",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            updateName = value;
          },
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
              updateCurrProject.name = _projectController.text;
              presenter.updateProject(updateCurrProject);
            },
          ),
        ],
      ),
    );
  }

  @override
  void showData(List<Project> todos) {
    //icons.clear();
    icons.removeRange(1, icons.length);
    icons.addAll(todos);
    setState(() {});
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
    super.showLoading();
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    super.hideLoading();
  }

  @override
  void updateProject(Project project) {
    // TODO: implement updateProject
    var index = icons.indexOf(olderCurrProject);
    if (index != -1) {
      setState(() {
        icons[index].name = project.name;
      });
    }
  }
}
