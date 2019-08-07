import '../model/base_model.dart';
import '../api/index.dart';

class RegisterModel extends BaseModel{
  Future<ToDoResponse> register(RegisterRequest registerRequest) async {
    var response = await HttpManager.request(TodoApi.LOGIN,
        data: registerRequest.toJson(), method: HttpManager.POST);
    var registerResponse = ToDoResponse.fromJson(response);
    return registerResponse;
  }
}