import '../model/mine_model.dart';
import '../presenter/base_presenter.dart';
import '../ui/mine_page.dart';

class MinePresenter extends BasePresenter<MineModel, MineView> {
  MinePresenter(MineView view) : super(view) {
    model = MineModel();
  }
}
