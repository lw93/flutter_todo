import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../presenter/regsiter_presenter.dart';
import '../res/scroll_physics_theme.dart';
import '../utils/image_util.dart';
import 'base_view.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterPresenter>
    implements BaseView {
  FocusNode _userNamefocusNode, _userPassdfocusNode;
  TextEditingController _userNameController, _userPassdController;

  @override
  void initData() {
    _userNameController = TextEditingController();
    _userPassdController = TextEditingController();
    _userNamefocusNode = FocusNode();
    _userPassdfocusNode = FocusNode();
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.black87,
        child: Scaffold(
            appBar: AppBar(title: Text("注册")),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 56),
              physics: PhysicsTheme.commonScrollPhysicsTheme,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Image.asset(
                        ImageUtil.getImgByName("todo_splash"),
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: TextField(
                          focusNode: _userNamefocusNode,
                          controller: _userNameController,
                          onSubmitted: (input) {
                            _userNamefocusNode.unfocus();
                            FocusScope.of(context).requestFocus(
                                _userPassdfocusNode);
                          },
                          decoration: InputDecoration(
                              hintText: "请输入邮箱",
                              labelText: "邮箱",
                              border: OutlineInputBorder()
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: TextField(
                          focusNode: _userPassdfocusNode,
                          controller: _userPassdController,
                          onSubmitted: (input) {
                            _userPassdfocusNode.unfocus();
                          },
                          decoration: InputDecoration(
                              hintText: "请输入密码",
                              labelText: "密码",
                              border: OutlineInputBorder()
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: TextField(
                          focusNode: _userPassdfocusNode,
                          controller: _userPassdController,
                          onSubmitted: (input) {
                            _userPassdfocusNode.unfocus();
                          },
                          decoration: InputDecoration(
                              hintText: "请再次输入密码",
                              labelText: "确认密码",
                              border: OutlineInputBorder()
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 48,
                        padding: EdgeInsets.only(
                            left: 24, right: 24),
                        child: OutlineButton(
                          child: Text("注册"),
                          onPressed: () {
                            //TODO 登陆
                          },
                          splashColor: Colors.black26,
                          textColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 48, right: 48),
                        ),
                      ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }


  @override
  RegisterPresenter initPresenter() {
    return RegisterPresenter(this);
  }

}
