import '../model/base_model.dart';
import '../utils/preferences_util.dart';

class GuideModel extends BaseModel {
  static List<String> guideImgPath = [
    'guide1',
    'guide2',
    'guide3',
    'todo_splash'
  ];

  void saveGuideFlag(String key, bool flag) {
    PreferencesUtil.saveMessageByBool(key, flag);
  }

  Future<bool> getGuideFlag(String key) {
    return PreferencesUtil.getMessageByBool(key);
  }
}
