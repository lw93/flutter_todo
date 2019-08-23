import 'package:flutter/material.dart';

import '../res/scroll_physics_theme.dart';

typedef EditChangeListener();
typedef Widget WidgetBuilder<T>(BuildContext context, T data, int position);
typedef void OnDragFinish(int oldIndex, int newIndex);

class DraggableGridView<T> extends StatefulWidget {
  final WidgetBuilder<T> itemBuilder;
  final List<T> items;
  final bool canAccept; //是否接受拖拽过来的数据的回调函数

  ///GridView一行显示几个child
  final int crossAxisCount;

  ///为了便于计算 Item之间的空隙都用crossAxisSpacing
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final Axis scrollDirection;

  //cross-axis to the main-axis
  final double childAspectRatio;

  ///编辑开关控制器，可通过点击按钮触发编辑
  //final EditSwitchController editSwitchController;
  ///长按触发编辑状态，可监听状态来改变编辑按钮（编辑开关 ，通过按钮触发编辑）的状态
  final EditChangeListener editChangeListener;

  //final bool isOpenDraggable;
  final int animationDuration;
  final int longPressDuration;

  ///删除按钮
  final Widget deleteIcon;

  //final DeleteIconClickListener deleteIconClickListener;

  DraggableGridView({
    @required this.items,
    @required this.itemBuilder,
    this.crossAxisCount: 2,
    this.childAspectRatio: 1.0,
    this.mainAxisSpacing: 0.0,
    this.crossAxisSpacing: 0.0,
    this.scrollDirection: Axis.vertical,
    //this.editSwitchController,
    this.editChangeListener,
    //this.isOpenDragAble: false,
    this.animationDuration: 300,
    this.longPressDuration: 800,
    this.deleteIcon,
    this.canAccept: true,
    //this.deleteIconClickListener,
  }) : assert(
  items != null,
  itemBuilder != null,
  );

  @override
  State<StatefulWidget> createState() => new _DraggableGridViewState<T>();
}

class _DraggableGridViewState<T> extends State<DraggableGridView<T>> {
  List<T> _dataList; //数据源
  //List<T> _dataBackup; //数据源备份，在拖动时 会直接在数据源上修改 来影响UI变化，当拖动取消等情况，需要通过备份还原
  bool _showItemWhenCovered = false; //手指覆盖的地方，即item被拖动时 底部的那个widget是否可见；
  int _willAcceptIndex = -1; //当拖动覆盖到某个item上的时候，记录这个item的坐标
//  int _draggingItemIndex = -1; //当前被拖动的item坐标
  ScrollController
  _scrollController; //当item数量超出屏幕 拖动Item到底部或顶部 可使用ScrollController滚动GridView 实现自动滚动的效果。
  List<GlobalKey> pressKeys = List();
  GlobalKey grideKey = GlobalKey();
  bool onDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataList = widget.items;
    for (int i = 0; i < _dataList.length; i++) {
      pressKeys.add(GlobalKey());
    }
    //_dataBackup = _dataList.sublist(0);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
        key: grideKey,
        controller: _scrollController,
        physics: PhysicsTheme.commonScrollPhysicsTheme,
        scrollDirection: widget.scrollDirection,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: widget.childAspectRatio,
          //item宽高比
          crossAxisCount: widget.crossAxisCount,
          //列数
          mainAxisSpacing: widget.mainAxisSpacing,
        ),
        itemCount: _dataList.length,
        itemBuilder: (context, index) {
          return LayoutBuilder(builder: (context, constraint) {
            return LongPressDraggable(
              key: pressKeys[index],
              data: _dataList[index],
              child: DragTarget<T>(
                //松手时 如果onWillAccept返回true 那么就会调用，本案例不使用。
                  onAccept: (T data) {
                    print('onAccept');
                  },
                  //绘制widget
                  builder: (context, data, rejects) {
                    return _willAcceptIndex >= 0 && _willAcceptIndex == index
                        ? null
                        : widget.itemBuilder(context, _dataList[index], index);
                  },
                  //手指拖着一个widget从另一个widget头上滑走时会调用
                  onLeave: (T data) {
                    //TODO 这里应该还可以优化，当用户滑出而又没有滑入某个item的时候 可以重新排列  让当前被拖走的item的空白被填满
                    print('onLeave ${index}');
                    int fromIndex = _dataList.indexOf(data);
                    print('$data is Leaving item $fromIndex');
                    _willAcceptIndex = -1;
                    RenderBox renderBox =
                    pressKeys[index].currentContext.findRenderObject();
                    var offset = renderBox.localToGlobal(Offset.zero);
                    print(
                        'onLeave offset x = ${offset.dx} y = ${offset.dy} ${offset.distance} key = ${pressKeys[index].currentContext.size.height} ${pressKeys[index].currentContext.size.width}');
                    setState(() {
                      _showItemWhenCovered = false;
                      //_dataList = _dataBackup.sublist(0);
                    });
                  },
                  //接下来松手 是否需要将数据给这个widget？  因为需要在拖动时改变UI，所以在这里直接修改数据源
                  onWillAccept: (T fromData) {
                    print('onWillAccept');
                    int fromIndex = _dataList.indexOf(fromData);
                    print('$index will accept item ${fromIndex}');
                    final accept = fromData != _dataList[index];
                    RenderBox renderBox =
                    grideKey.currentContext.findRenderObject();
                    var offset = renderBox.localToGlobal(Offset.zero);
                    print(
                        'onWillAccept girde height ${grideKey.currentContext.size.height} y= ${offset.dy}');

                    double mod = index % 2.0;
                    double height = pressKeys[index].currentContext.size.height;
                    double positiomn;
                    if (mod == 1) {
                      positiomn = index / 2 * height;
                    } else {
                      positiomn = (index + 1) / 2 * height;
                    }
                    print('onWillAccept positiomn height ${positiomn}');
                    _scrollController.animateTo(positiomn - height,
                        curve: Curves.ease, duration: Duration(milliseconds: 800));
                    if (accept) {
                      _willAcceptIndex = index;
                      _showItemWhenCovered = true;
                      //_dataList = _dataBackup.sublist(0);
                      //final fromData = _dataList[index];
                      setState(() {
                        T tmp = _dataList[index];
                        _dataList[index] = fromData;
                        _dataList[fromIndex] = tmp;
//                    _dataList.removeAt(index);
//                    _dataList.insert(index, fromData);
                      });
                    }
                    return accept;
                  }),
              onDragStarted: () {
                //开始拖动，备份数据源
                //_draggingItemIndex = index;
                //_dataBackup = _dataList.sublist(0);
                print('item $index ---------------------------onDragStarted');
                Scaffold.of(context).showBottomSheet((BuildContext context) {
                  String textDelete =  onDelete ? "释放删除" : "移除";
                  return Container(
                      width: double.infinity,
                      height: 72,
                      color: onDelete ? Colors.red.shade700 : Colors.red.shade400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            textDelete,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ));
                });
              },
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                print(
                    'item $index ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
                //拖动取消，还原数据源
                setState(() {
                  _willAcceptIndex = -1;
                  _showItemWhenCovered = false;
                  //_dataList = _dataBackup.sublist(0);
                });
                Navigator.pop(context);
              },
              onDragCompleted: () {
                //拖动完成，刷新状态，重置willAcceptIndex
                print("item $index ---------------------------onDragCompleted");
                setState(() {
                  _showItemWhenCovered = false;
                  _willAcceptIndex = -1;
                });
                Navigator.pop(context);
              },
              //用户拖动item时，那个给用户看起来被拖动的widget，（就是会跟着用户走的那个widget）
              feedback: SizedBox(
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                child: widget.itemBuilder(context, _dataList[index], index),
              ),
              //这个是当item被拖动时，item原来位置用来占位的widget，（用户把item拖走后原来的地方该显示啥？就是这个）
              childWhenDragging: Container(
                child: SizedBox(
                  child: _showItemWhenCovered
                      ? widget.itemBuilder(context, _dataList[index], index)
                      : null,
                ),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController?.dispose();
  }
}
