
import 'package:flutter/material.dart';
import './movice/movice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '电影app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  List<Widget> _listTab = [
    Tab(
      text: '正在热映',
      icon: Icon(Icons.movie_creation),
    ),
    Tab(
      text: '正在热映',
      icon: Icon(Icons.movie_filter),
    ),
    Tab(
      text: '正在热映',
      icon: Icon(Icons.local_movies),
    ),
  ];

  List<Widget> _listMovie = [
    MovieList(mt: 'in_theaters'),
    MovieList(mt: 'coming_soon'),
    MovieList(mt: 'top250'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('电影列表'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('UserName'),
                  accountEmail: Text('test@163.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316'),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://www.liulongbin.top:3005/images/bg1.jpg'),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('我要反馈'),
                  trailing: Icon(Icons.feedback),
                ),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('我要发布'),
                  trailing: Icon(Icons.send),
                ),
                Divider(),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.black),
            child: TabBar(
              tabs: _listTab,
              indicatorWeight: 0.5,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(fontSize: 10, height: 0),
            ),
          ),
          body: TabBarView(children: _listMovie),
        ));
  }
}
