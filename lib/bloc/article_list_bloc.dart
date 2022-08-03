import 'dart:async';

import 'package:article_finder/bloc/bloc.dart';
import 'package:article_finder/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';

import '../data/article.dart';
//Mi primer clase BLOC
//Se debe escribir una clase BLOC por cada Screen, por ejemplo, esta case BLOC
// se complementa con la ArticleListScreen

//Basicamente se usan los SINK para recibir INPUTS y los streams devuelven los
// OUTPUTS
class ArticleListBloc implements Bloc{
  //Esta linea es instancia de la clase qhttp que se conecta con la API
  final _client = RWClient();

  
  final _searchQueryController = StreamController<String?>();//cuando el stream no es cerrado, el IDE subraya la linea de color amarillo

  Sink<String?> get searchQuery => _searchQueryController.sink;

  late Stream<List<Article>?> articleStream;

  ArticleListBloc(){
    articleStream = _searchQueryController.stream
      .startWith(null) //1
      .debounceTime(const Duration(milliseconds: 100)) //2
      .switchMap( //3
          (query) => _client.fetchArticles(query)
              .asStream() //4
              .startWith(null), //5
    );
  }

  // ignore: slash_for_doc_comments
  /**
     The code above changes the output stream of articles in the following way:

      1. startWith(null) produces an empty query to start loading all articles.
      If the user opens the search for the first time and doesn’t enter any query,
      they see a list of recent articles.

      2. debounceTime skips queries that come in intervals of less
      than 100 milliseconds. When the user enters characters,
      TextField sends multiple onChanged{} events. debounce skips most of them
      and returns the last keyword event.

      3. Replace asyncMap with switchMap. These operators are similar, but
      switchMap allows you to work with other streams.

      4. Convert Future to Stream.

      5. startWith(null) at this line sends a null event to the article output
      at the start of every fetch request. So when the user completes the search
      query, UI erases the previous list of articles and shows the widget’s
      loading. It happens because _buildResults in article_list_screen.dart
      listens to your stream and displays a loading indicator in the case of null
      data.

   **/



  @override
  void dispose() {
    // TODO: implement dispose
    _searchQueryController.close();
  }

}