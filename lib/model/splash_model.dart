import '../model/base_model.dart';
import '../utils/preferences_util.dart';
class SplashModel extends BaseModel{
  void saveGuideFlag(String key, bool flag) {
    PreferencesUtil.saveMessageByBool(key, flag);
  }

  Future<bool> getGuideFlag(String key) {
    return PreferencesUtil.getMessageByBool(key);
  }
}