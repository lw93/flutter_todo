import '../ui/base_view.dart';
import '../model/guide_model.dart';
import '../presenter/base_presenter.dart';

class GuidePresenter extends BasePresenter<GuideModel,BaseView>{
  GuidePresenter(BaseView view) : super(view);

  List<String> getImgPath() {
    return GuideModel.guideImgPath;
  }
}
