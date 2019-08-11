import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../presenter/mine_presenter.dart';
import '../res/scroll_physics_theme.dart';
import '../utils/image_util.dart';
import 'base_view.dart';

abstract class MineView extends BaseView {
}

class MinePage extends StatefulWidget {
  MinePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BaseState<MinePage, MinePresenter>
    with AutomaticKeepAliveClientMixin
    implements MineView {
  String email;
  bool dailyEable;
  PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    super.build(context);
    return SingleChildScrollView(
      physics: PhysicsTheme.commonScrollPhysicsTheme,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 36),
            child: ClipOval(
              child: Image.asset(
                ImageUtil.getImgByName("todo_splash"),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text("个人信息"),
          SizedBox(height: 24),
          Text("邮箱: ${email}"),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("每日汇报: "),
              Switch(
                value: dailyEable,
                onChanged: (value) {
                  setState(() {
                    dailyEable = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.all(18),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlineButton(
                child: Text("关于"),
                onPressed: _showAboutApp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlineButton(
                child: Text("退出"),
                onPressed: _logoutApp,
              ),
            ),
          ),
        ],
      )
      ,
    );
  }

  //退出
  _logoutApp() {

  }

  //显示对话框
  _showAboutApp() {
    showAboutDialog(
        context: context,
        applicationName: packageInfo.appName,
        applicationVersion: packageInfo.version,
        applicationIcon: Image.asset(
            ImageUtil.getImgByName("todo_splash"), width: 40.0, height: 40.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Text("todo 便签,随时随地记录事件."),
          )
        ]
    );
  }

  @override
  initData() {
    // TODO: implement initData
    email = "guest@163.com";
    dailyEable = false;
    PackageInfo.fromPlatform().then((onValue) {
      setState(() {
        packageInfo = onValue;
      });
    });
  }

  @override
  MinePresenter initPresenter() {
    // TODO: implement initPresenter
    return MinePresenter(this);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
