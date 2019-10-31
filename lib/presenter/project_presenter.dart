import '../model/project_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/project_page.dart';
import '../api/index.dart';
class ProjectPresenter extends BasePresenter<ProjectModel, ProjectView> {
  ProjectPresenter(ProjectView view) : super(view) {
    model = ProjectModel();
  }

  void queryProjects() {
    view.showLoading();
    model
        .queryProjects()
        .then((onValue) {
        view.showData(onValue);
    }).catchError((onError) {
        print(onError.toString());
    }).whenComplete(() {
      view.hideLoading();
    });
  }

  void updateProject(Project project){
    view.showLoading();
    model
        .updateProject(project)
        .then((onValue) {
      view.updateProject(onValue);
    }).catchError((onError) {
      print(onError.toString());
    }).whenComplete(() {
      view.hideLoading();
    });
  }

}
