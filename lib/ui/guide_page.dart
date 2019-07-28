import 'package:flutter/material.dart';
import '../presenter/guide_presenter.dart';
import '../res/scroll_physics_theme.dart';
import '../utils/image_util.dart';
import 'base_view.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends BaseState<GuidePage, GuidePresenter>
    implements BaseView {
  int guideSize = 0;
  List<String> guideImgNames;
  int _pageIndex = 0;

  @override
  void initData() {
    guideImgNames = presenter.getImgPath();
    guideSize = guideImgNames.length;
  }

  @override
  Widget build(BuildContext context) {
    return _buildGuideWidget();
  }

  Widget _buildGuideWidget() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Offstage(
            offstage: false,
            child: PageView.builder(
              physics: PhysicsTheme.commonScrollPhysicsTheme,
              itemCount: guideSize,
              itemBuilder: ((context, index) {
                if (index < guideSize - 1) {
                  return Image.asset(
                      ImageUtil.getImgByName(guideImgNames[index]));
                } else {
                  return Stack(children: <Widget>[
                    Image.asset(ImageUtil.getImgByName(guideImgNames[index])),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 48),
                      child: FlatButton(
                          onPressed: () {
                            presenter.jumpToMain(context);
                          },
                          child: Text("开始使用"),
                          color: Colors.black54,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 48, right: 48)),
                    ),
                  ]);
                }
              }),
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: _pageIndex < 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _pageIndex == 0
                              ? Colors.black45
                              : Colors.black12),
                      margin: EdgeInsets.only(left: 16, bottom: 32)),
                  Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _pageIndex == 1
                              ? Colors.black45
                              : Colors.black12),
                      margin: EdgeInsets.only(left: 16, bottom: 32)),
                  Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _pageIndex == 2
                              ? Colors.black45
                              : Colors.black12),
                      margin: EdgeInsets.only(left: 16, bottom: 32)),
                  Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black12),
                      margin: EdgeInsets.only(left: 16, bottom: 32)),
                ],
              ),
            )),
      ],
    );
  }

  @override
  GuidePresenter initPresenter() {
    return GuidePresenter(this);
  }
}
