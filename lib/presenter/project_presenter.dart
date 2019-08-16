import '../model/project_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/project_page.dart';

class ProjectPresenter extends BasePresenter<ProjectModel,ProjectView> {
  ProjectPresenter(ProjectView view) : super(view) {
    model = ProjectModel();
  }
}
