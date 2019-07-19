import 'package:flutter/material.dart';

import '../presenter/base_presenter.dart';

abstract class BaseView {}

abstract class BaseState<T extends StatefulWidget, P extends BasePresenter<dynamic, dynamic>> extends State<T> implements BaseView {
  P presenter;

  bool isLoading = false;

  P initPresenter();

  void initData();

  @override
  void initState() {
    super.initState();
    presenter = initPresenter();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    if (presenter != null) {
      presenter.detachView();
      presenter = null;
    }
  }

  @override
  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
