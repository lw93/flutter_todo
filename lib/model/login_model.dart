import '../api/index.dart';
import '../model/base_model.dart';

class LoginModel extends BaseModel {


  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var response = HttpManager.request(
        TodoApi.LOGIN, data: loginRequest.toJson(), method: HttpManager.POST);
    response.then((onValue) {
      print("onValue:" + onValue.toString());
      var loginResponse = LoginResponse.fromJson(onValue);
      return loginResponse;
    });
  }
}