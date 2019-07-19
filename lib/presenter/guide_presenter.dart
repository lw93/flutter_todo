import 'package:flutter/material.dart';

import '../model/guide_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/base_view.dart';
import '../utils/preferences_util.dart';

class GuidePresenter extends BasePresenter<GuideModel, BaseView> {
  GuidePresenter(BaseView view) : super(view) {
    model = GuideModel();
  }

  List<String> getImgPath() {
    return GuideModel.guideImgPath;
  }

  jumpToMain(BuildContext context) {
    Future<bool> flag = model.getGuideFlag(PreferencesKeys.showGuide);
  }
}
