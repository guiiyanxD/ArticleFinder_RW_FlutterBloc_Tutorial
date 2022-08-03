import 'dart:async';

import 'package:article_finder/bloc/bloc.dart';
import 'package:article_finder/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';
import '../data/article.dart';


class ArticleDetailBloc implements Bloc{
  final String id;
  final _refreshController = StreamController<void>();
  final _client = RWClient();

  late Stream<Article?> articleStream;

  ArticleDetailBloc( {required this.id})
  {
    articleStream = _refreshController.stream
        .startWith({})
        .mapTo(id)
        .switchMap( (id) => _client.getDetailArticle(id).asStream() )
        .asBroadcastStream();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.close();
  }

}