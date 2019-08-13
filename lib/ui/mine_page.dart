import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:package_info/package_info.dart';

import '../api/index.dart';
import '../presenter/mine_presenter.dart';
import '../res/scroll_physics_theme.dart';
import '../utils/image_util.dart';
import '../utils/preferences_util.dart';
import 'base_view.dart';

abstract class MineView extends BaseView {}

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
  bool dailyEable = false;
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
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
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
                    onChanged: _userSettingEmail,
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
          ),
        ));
  }

  void _userSettingEmail(bool daily) async {
    showLoading();
    PlanerSetting requestData;
    String setting = await PreferencesUtil.getMessageByStr(PreferencesKeys.emailEveryDayEable);
    if (null == setting) {
      hideLoading();
      return;
    }
    Map<String, dynamic> userSetting = jsonDecode(setting);
    requestData = PlanerSetting.fromJson(userSetting);
    requestData.emailEveryDayEnable = daily;
    if (null == requestData) {
      hideLoading();
      _showDailyDailog();
      return;
    }
    HttpManager.request(TodoApi.USER_SETTING, method: HttpManager.POST, data: requestData.toJson())
        .then((result) {
      hideLoading();
      if (result != null && result.containsKey("code")) {
        if (result['code'] == 600) {
          var todoResponse = ToDoResponse.fromJson(result);
          PreferencesUtil.saveMessageByStr(PreferencesKeys.emailEveryDayEable,jsonEncode(todoResponse.data));
          setState(() {
            dailyEable = todoResponse.data['emailEveryDayEnable'];
          });
          return;
        }
      }
      _showDailyDailog();
    }).catchError(() {
      hideLoading();
      _showDailyDailog();
    }).whenComplete(hideLoading);
  }

  void _showDailyDailog() {
    showDialog(
        context: context,
        child: Stack(
          children: <Widget>[
            AlertDialog(
              title: Text("更新失败,请稍后再试."),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      child: Text("知道了",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                          )),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )),
              ],
            )
          ],
        ));
  }

  //退出
  void _logoutApp() {
    showDialog(
        context: context,
        child: Stack(
          children: <Widget>[
            AlertDialog(
              title: Text("确定要退出?"),
              actions: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      child: Text("取消",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                          )),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      child: Text("确定",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18.0,
                          )),
                      onTap: () {
                        Navigator.of(context).pop();
                        PreferencesUtil.saveMessageByStr(
                            PreferencesKeys.userName, "");
                        PreferencesUtil.saveMessageByStr(
                            PreferencesKeys.pass, "");
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                    )),
              ],
            )
          ],
        ));
  }

  //显示对话框
  void _showAboutApp() {
    showAboutDialog(
        context: context,
        applicationName: packageInfo.appName,
        applicationVersion: packageInfo.version,
        applicationIcon: Image.asset(ImageUtil.getImgByName("todo_splash"),
            width: 40.0, height: 40.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Text("todo 便签,随时随地记录事件."),
          )
        ]);
  }

  @override
  initData() {
    // TODO: implement initData
    PreferencesUtil.getMessageByStr(PreferencesKeys.userName).then((name) {
      email = name;
    });

    PreferencesUtil.getMessageByStr(PreferencesKeys.emailEveryDayEable)
        .then((emailDaily) {
      if (null == emailDaily) {
        dailyEable = false;
        return;
      }
      Map<String, dynamic> userSetting = json.decode(emailDaily);
      dailyEable = userSetting['emailEveryDayEable'] ?? false;
    });
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
