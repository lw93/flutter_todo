import 'dart:async';

import 'package:flutter/material.dart';

import '../presenter/splash_presenter.dart';
import 'base_view.dart';
import '../utils/image_util.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashPresenter>
    implements BaseView {
  Timer countDownTime;
  var countDownDuration = 3;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    /* return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'splash page:You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );*/

    return Image.asset(ImageUtil.getImgByName("splash"));
  }

  @override
  void dispose() {
    if (countDownTime != null) {
      countDownTime.cancel();
      countDownTime = null;
    }
    super.dispose();
  }

  @override
  void initData() {
    countDownTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countDownDuration == 0) {
          countDownTime.cancel();
          presenter.jumpToNext(context);
        } else {
          countDownDuration = countDownDuration - 1;
        }
      });
    });
  }

  @override
  SplashPresenter initPresenter() {
    return SplashPresenter(this);
  }
}
