import 'package:flutter/material.dart';

import '../model/splash_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/base_view.dart';
import '../utils/preferences_util.dart';

class SplashPresenter extends BasePresenter<SplashModel, BaseView> {
  SplashPresenter(BaseView view) : super(view) {
    model = SplashModel();
  }

  void jumpToNext(BuildContext context) {
    Future<bool> flag = model.getGuideFlag(PreferencesKeys.showGuide);
    flag.then((onValue) {
      if (onValue == null || !onValue) {
        Navigator.pushReplacementNamed(context, "/guide");
        return;
      }
      Future<String> name = PreferencesUtil.getMessageByStr(PreferencesKeys.userName);
      name.then((onValue) {
        if (onValue!=null && onValue.isNotEmpty) {
          Navigator.pushReplacementNamed(context, "/main");
          return;
        }
      });
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

}