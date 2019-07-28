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
      Navigator.pushReplacementNamed(context, "/main");
    });
  }

}