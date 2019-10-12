import '../api/index.dart';
import '../model/base_model.dart';

class ProjectModel extends BaseModel {
  Future<Project> queryProjects() async {
    var response = await HttpManager.request(TodoApi.GET_DEFAULT_PROJECTS,
        method: HttpManager.GET);
    var project = Project.fromJson(response);
    return project;
  }
}
