import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../api/bean.dart';
import '../presenter/login_presenter.dart';
import '../res/scroll_physics_theme.dart';
import '../utils/image_util.dart';
import 'base_view.dart';

abstract class LoginView extends BaseView {
  void onError(String type, String message);

  void onHttpError(String message);

  void onHttpSuccess(LoginResponse response);
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginPresenter>
    implements LoginView {
  FocusNode _userNamefocusNode, _userPassdfocusNode;
  TextEditingController _userNameController, _userPassdController;
  String _userName, _userPass, _onNameError, _onPasswdError;

  @override
  void initData() {
    _userNameController = TextEditingController();
    _userPassdController = TextEditingController();
    _userNamefocusNode = FocusNode();
    _userPassdfocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black87,
        child: Scaffold(
          appBar: AppBar(title: Text("登陆")),
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
                          focusNode: _userNamefocusNode,
                          controller: _userNameController,
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (input) {
                            _userNamefocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_userPassdfocusNode);
                          },
                          decoration: InputDecoration(
                            hintText: "请输入邮箱",
                            labelText: "邮箱",
                            border: OutlineInputBorder(),
                            errorText: _onNameError,
                          ),
                          onChanged: (name) {
                            _userName = name;
                            if (_onNameError.isNotEmpty) {
                              setState(() {
                                _onNameError = null;
                              });
                            }
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
                          },
                          decoration: InputDecoration(
                            hintText: "请输入密码",
                            labelText: "密码",
                            border: OutlineInputBorder(),
                            errorText: _onPasswdError,
                          ),
                          obscureText: true,
                          onChanged: (pass) {
                            _userPass = pass;
                            if (_onPasswdError.isNotEmpty) {
                              setState(() {
                                _onPasswdError = null;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 48,
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: OutlineButton(
                          child: Text("登陆"),
                          onPressed: () {
                            showLoading();
                            presenter?.login(_userName, _userPass);
                          },
                          splashColor: Colors.black26,
                          textColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 48, right: 48),
                        ),
                      ),
                      SizedBox(height: 24),
                      InkWell(
                        child: Text(
                          "没有帐号?去注册",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                        splashColor: Colors.black12,
                        onTap: () {
                          presenter?.jumpToRegister(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  LoginPresenter initPresenter() {
    return LoginPresenter(this);
  }

  @override
  void onError(String type, String message) {
    hideLoading();
    switch (type) {
      case "name":
        {
          setState(() {
            _onNameError = message;
          });
        }
        break;
      case "password":
        {
          setState(() {
            _onPasswdError = message;
          });
        }
        break;
      default:
        {}
        break;
    }
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
