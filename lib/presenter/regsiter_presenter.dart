import 'package:flutter/material.dart';

import '../api/index.dart';
import '../model/register_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/register_page.dart';

class RegisterPresenter extends BasePresenter<RegisterModel, RegisterView> {
  RegisterPresenter(RegisterView view) : super(view) {
    model = RegisterModel();
  }

  void register(String email, String password, String repassword) {
    if (null == email || email.isEmpty) {
      view..onHttpError("邮箱不能为空");
      return;
    }
    if (null == password || password.isEmpty) {
      view.onHttpError("密码不能为空");
      return;
    }
    if (null == repassword || repassword.isEmpty) {
      view.onHttpError("确认密码不能为空");
      return;
    }
    if (password != repassword) {
      view.onHttpError("两次输入的密码不一致");
      return;
    }
    var request = RegisterRequest.fromJson({
      'email': email,
      'password': password,
    });
    model.register(request).then((onValue) {
      if (onValue != null) {
        if (onValue.code == 600 && onValue.data != null) {
          var registerResponse = LoginResponse.fromJson(onValue.data);
          view.onHttpSuccess(registerResponse);
        }
      }
      view.onHttpError("请求失败");
    }).catchError((Object error) {
      view.onHttpError("请求失败");
    });
  }

  void jumpToMain(BuildContext context) {
    Navigator.popAndPushNamed(context, "/main");
  }
}
