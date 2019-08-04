import 'package:flutter/material.dart';

import '../api/index.dart';
import '../model/login_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/login_page.dart';

class LoginPresenter extends BasePresenter<LoginModel, LoginView> {
  LoginPresenter(LoginView view) : super(view) {
    model = LoginModel();
  }

  void login(String name, String password) {
    if (null == name || name.isEmpty) {
      view.onError("name", "用户名不能为空");
      return;
    }
    if (null == password || password.isEmpty) {
      view.onError("password", "密码不能为空");
      return;
    }
    var request = LoginRequest.fromJson({
      'username': name,
      'password': password,
    });

    model.login(request).then((onValue) {
      print(onValue.toString());
    });
  }


  void jumpToRegister(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

}