import 'dart:async';
import 'dart:io';
import 'bean.dart';
import 'package:dio/dio.dart';
import '../utils/preferences_util.dart';
import 'todo_api.dart';

class HttpManager {
  /// global dio object
  static Dio dio;

  /// default options
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 10000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
  static const String OPTION = 'options';

  /// request method
  static Future<Map> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    /// restful 请求处理
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll('<$key>', value.toString());
      }
    });

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());

    Dio dio = createInstance();
    var result;
    try {
      Response response =
          await dio.request(url, data: data, options: Options(method: method));

      result = response.data;

      /// 打印响应相关信息
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
      result = e.response.data;
    }
    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      Options options = new Options(
          baseUrl: TodoApi.BASE_URL,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          contentType: ContentType.parse("application/x-www-form-urlencoded"));
      dio = Dio(options);
      dio.interceptor.request.onSend = (Options options) async {
        //...If no token, request token firstly.
        if(!options.path.contains("/login") && !options.path.contains("/register")){
          String name = await PreferencesUtil.getMessageByStr(PreferencesKeys.userName);
          String pass = await PreferencesUtil.getMessageByStr(PreferencesKeys.pass);
          var request = LoginRequest.fromJson({
            'username': name,
            'password': pass,
          });
          Response response = await dio.post(TodoApi.LOGIN,data: request.toJson());
          //options.headers["token"] = response.data["data"]["token"];
        }
        //Set the token to headers
        return options; //continue
      };
    }
    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    if (dio != null) {
      dio.clear();
    }
    dio = null;
  }
}
