import 'package:flutter/material.dart';
import '../model/register_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/base_view.dart';

class RegisterPresenter extends BasePresenter<RegisterModel, BaseView> {
  RegisterPresenter(BaseView view) : super(view) {
    model = RegisterModel();
  }

  void register(String name, String password) {

  }


  void jumpToMain(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/main");
  }

}