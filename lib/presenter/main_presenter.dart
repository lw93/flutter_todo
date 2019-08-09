import '../model/main_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/main_page.dart';

class MainPresenter extends BasePresenter<MainModel, MainView> {
  MainPresenter(MainView view) : super(view) {
    model = MainModel();
  }
}
