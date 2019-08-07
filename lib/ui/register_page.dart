import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../api/bean.dart';
import '../presenter/regsiter_presenter.dart';
import '../res/scroll_physics_theme.dart';
import '../utils/image_util.dart';
import 'base_view.dart';

abstract class RegisterView extends BaseView {
  void onHttpError(String message);

  void onHttpSuccess(LoginResponse response);
}

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterPresenter>
    implements RegisterView {
  FocusNode _userEmailfocusNode, _userPassdfocusNode, _userRePassdfocusNode;
  TextEditingController _userEmailController, _userPassdController, _userRePassdController;
  String _userEamil, _userPass, _userRePass;

  @override
  void initData() {
    _userEmailController = TextEditingController();
    _userPassdController = TextEditingController();
    _userRePassdController = TextEditingController();
    _userEmailfocusNode = FocusNode();
    _userPassdfocusNode = FocusNode();
    _userRePassdfocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black87,
        child: Scaffold(
            appBar: AppBar(title: Text("注册")),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 56),
              physics: PhysicsTheme.commonScrollPhysicsTheme,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          ImageUtil.getImgByName("todo_splash"),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: TextField(
                            focusNode: _userEmailfocusNode,
                            controller: _userEmailController,
                            keyboardType: TextInputType.emailAddress,
                            onSubmitted: (input) {
                              _userEmailfocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_userPassdfocusNode);
                            },
                            decoration: InputDecoration(
                                hintText: "请输入邮箱",
                                labelText: "邮箱",
                                border: OutlineInputBorder()),
                            onChanged: (input) {
                              _userEamil = input;
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: TextField(
                            focusNode: _userPassdfocusNode,
                            controller: _userPassdController,
                            onSubmitted: (input) {
                              _userPassdfocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_userRePassdfocusNode);
                            },
                            decoration: InputDecoration(
                                hintText: "请输入密码",
                                labelText: "密码",
                                border: OutlineInputBorder()),
                            obscureText: true,
                            onChanged: (input) {
                              _userPass = input;
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: TextField(
                            focusNode: _userRePassdfocusNode,
                            controller: _userRePassdController,
                            onSubmitted: (input) {
                              _userRePassdfocusNode.unfocus();
                            },
                            decoration: InputDecoration(
                                hintText: "请再次输入密码",
                                labelText: "确认密码",
                                border: OutlineInputBorder()),
                            obscureText: true,
                            onChanged: (input) {
                              _userRePass = input;
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 48,
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: OutlineButton(
                            child: Text("注册"),
                            onPressed: () {
                              showLoading();
                              presenter?.register(_userEamil, _userPass, _userRePass);
                            },
                            splashColor: Colors.black26,
                            textColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, left: 48, right: 48),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  @override
  RegisterPresenter initPresenter() {
    return RegisterPresenter(this);
  }

  @override
  void onHttpError(String message) {
    hideLoading();
    showDialog(
        context: context,
        child: Stack(
          children: <Widget>[
            AlertDialog(
              title: Text(message),
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

  @override
  void onHttpSuccess(LoginResponse response) {
    hideLoading();
    if (response != null) {}
  }
}
