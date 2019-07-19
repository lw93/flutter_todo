import '../api/http.dart';
import 'package:dio/dio.dart';

abstract class BaseModel {
  Dio client = HttpManager.createInstance();

  void destoryModel() {
    clearRequest();
  }

  void clearRequest() {
    HttpManager.clear();
  }
}
