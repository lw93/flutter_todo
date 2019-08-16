import 'package:flutter/material.dart';

import '../presenter/main_presenter.dart';
import 'base_view.dart';
import 'project_page.dart';
import 'mine_page.dart';

abstract class MainView extends BaseView {
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage, MainPresenter>
    implements MainView {

  int _selectedIndex = 0;
  int _listType = 1;
  var _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("便签"),
        centerTitle: true,
        actions: <Widget>[
          _listType == 0 ?
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () {
              setState(() {
                _listType = 1;
              });
            },
          )
              :
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              setState(() {
                _listType = 0;
              });
            },
          )
          ,
        ],
      ),
      body: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        }
        ,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return index == 0 ? ProjectPage(todoType: _listType) : MinePage();
        }
        ,
        itemCount: 2,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            title: Text('清单'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('我的'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
                index, duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut);
          });
        },
      ),
    );
  }

  @override
  void initData() {
    // TODO: implement initData
  }

  @override
  MainPresenter initPresenter() {
    // TODO: implement initPresenter
    return MainPresenter(this);
  }

}
