import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MovieList extends StatefulWidget {
  final String mt;
  int start;

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
  int pagesize = 10;

  //电影列表数据
  var mList = [];

  //数据总条数
  var total = 0;

  //控件被创建的时候会执行initState()
  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.mt + "total===$total");
  }

  //获取电影列表
  getMovieList() async {
    //偏移量 计算公式  (page - 1) * pagesize
    int offset = (page - 1) * pagesize;
    var response = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pagesize');
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
