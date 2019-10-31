import '../api/index.dart';
import '../model/base_model.dart';
import '../utils/preferences_util.dart';
import 'dart:convert';

class ProjectModel extends BaseModel {
  Future<List<Project>> queryProjects() async {
    String userId =
        await PreferencesUtil.getMessageByStr(PreferencesKeys.userId);
    print("userId:${userId}");
    if (null == userId || userId.isEmpty) {
      return null;
    }
    var responsePro = await HttpManager.request(TodoApi.GET_DEFAULT_PROJECTS,
        data: {"projectId": userId}, method: HttpManager.GET);

    if (responsePro["code"] == HttpStatus.SUCCESS &&
        responsePro["data"] != null) {
      List json = responsePro["data"];
      List<Project> projects = json.map((f) => Project.fromJson(f)).toList();
      if (null != projects && projects.isNotEmpty) {
        Project defaultPro = projects[0];
        var response = await HttpManager.request(TodoApi.GET_PROJECT_TODOS,
            data: {"projectId": userId, "objectId": defaultPro.objectId},
            method: HttpManager.GET);
        List json = response["data"];
        List<Project> todos = json.map((f) => Project.fromJson(f)).toList();
        return todos;
      }
    }
    return null;
  }

  Future<Project> updateProject(Project project) async {
    var responsePro = await HttpManager.request(TodoApi.UPDATE_GROUP,
        data: project.toJson(), method: HttpManager.PUT);
    if (null != responsePro && responsePro["code"] == HttpStatus.SUCCESS) {
      ToDoResponse toDoResponse = ToDoResponse.fromJson(responsePro);
      if (null != toDoResponse && toDoResponse.code == HttpStatus.SUCCESS) {
        Project result = Project.fromJson(toDoResponse.data);
        return result;
      }
    }
    return null;
  }
}
