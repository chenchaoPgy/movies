import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'movieDetail.dart';

class MovieList extends StatefulWidget {
  final String mt;

  @override
  _MovieListState createState() => _MovieListState();

  //固定写法  MovieList(Key key):(key: key)
  MovieList({Key key, this.mt}) : super(key: key);
}

Dio dio = new Dio();

class _MovieListState extends State<MovieList> {
  //默认显示第一页数据
  int page = 1;

  //默认显示的数据条数
  int pageSize = 10;

  //电影列表数据
  var mList = [];

  //数据总条数
  var total = 0;

  var mListAl = [];

  //控件被创建的时候会执行initState()
  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mList.length,
        itemBuilder: (BuildContext context, int pos) {
          var item = mList[pos];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return new MovieDetail(id: item['id'], title: item['title']);
              }));
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    item['images']['small'],
                    height: 180,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('电影名称：${item['title']}'),
                        Text('上映年份：${item['year']}'),
                        Text('电影类型：${item['genres'].join(',')}'),
                        Text('豆瓣评分：${item['rating']['average']}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('主要演员：'),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1501911452.02.webp'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //获取电影列表
  getMovieList() async {
    //偏移量 计算公式  (page - 1) * pagesize
    int offset = (page - 1) * pageSize;
    var response = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pageSize');
    var result = response.data;
    print(result);
    //只要是要赋值 就要放到setState函数中
    setState(() {
      //通过dio返回数据 必须用[]来访问
      mList = result['subjects'];
      total = result['total'];
    });
  }
}
