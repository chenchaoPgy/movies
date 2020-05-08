import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
  final String id;
  final String title;

  MovieDetail({Key key, @required this.id, @required this.title,}) : super(key: key);
}

class _MovieDetailState extends State<MovieDetail> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Text('${widget.id}    ${widget.title} ');
  }

  @override
  bool get wantKeepAlive => true;
}
