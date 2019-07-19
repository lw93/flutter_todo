import '../model/base_model.dart';
import '../ui/base_view.dart';

abstract class BasePresenter<M extends BaseModel, V extends BaseView> {
  M get model => _model;

  set model(M model) => _model = model;

  M _model;

  V get view => _view;
  V _view;

  BasePresenter(this._view);

  void detachView() {
    _model.destoryModel();
    _model = null;
    _view = null;
  }

  bool isViewAttached() {
    return null != _view;
  }

  void clearRequest() {
    _model.clearRequest();
  }
}
