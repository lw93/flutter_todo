import '../api/index.dart';
import '../model/base_model.dart';

class LoginModel extends BaseModel {
  Future<ToDoResponse> login(LoginRequest loginRequest) async {
    var response = await HttpManager.request(TodoApi.LOGIN,
        data: loginRequest.toJson(), method: HttpManager.POST);
    var loginResponse = ToDoResponse.fromJson(response);
    return loginResponse;
  }
}
