import '../api/index.dart';
import '../model/base_model.dart';
import '../utils/preferences_util.dart';

class LoginModel extends BaseModel {
  Future<ToDoResponse> login(LoginRequest loginRequest) async {
    var response = await HttpManager.request(TodoApi.LOGIN,
        data: loginRequest.toJson(), method: HttpManager.POST);
    var loginResponse = ToDoResponse.fromJson(response);
    return loginResponse;
  }


  void saveUserInfo(LoginResponse loginResponse) {
    if (null == loginResponse) return;
    PlanerSetting setting = PlanerSetting.fromJson(loginResponse.setting);
    if (setting != null) {
      PreferencesUtil.saveMessageByBool(PreferencesKeys.emailEveryDayEable, setting.emailEveryDayEnable);
      PreferencesUtil.saveMessageByStr(PreferencesKeys.userId, setting.userId);
      PreferencesUtil.saveMessageByStr(PreferencesKeys.objectId, setting.objectId);
    }
    Planer user = Planer.fromJson(loginResponse.user);
    if (user != null) {
      PreferencesUtil.saveMessageByStr(PreferencesKeys.userName, user.email);
    }
  }

  Future<String> hasNameCache() async {
    String name = await PreferencesUtil.getMessageByStr(PreferencesKeys.userName);
    if (name != null && name != "") {
      return name;
    }
    return "";
  }

}
