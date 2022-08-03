import 'package:article_finder/bloc/article_detail_bloc.dart';
import 'package:article_finder/bloc/bloc_provider.dart';
import 'package:article_finder/ui/article_detail.dart';
import 'package:flutter/material.dart';

import '../data/article.dart';

class ArticleDetailScreen extends StatelessWidget{
  const ArticleDetailScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    //1
    final bloc = BlocProvider.of<ArticleDetailBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article detail'),
      ),
      body: Container(
        alignment: Alignment.center,
        //2
        child: _buildContent(bloc),
      ),
    );
  }
   Widget _buildContent(ArticleDetailBloc bloc){
    return StreamBuilder<Article?>(
      stream: bloc.articleStream,
      builder: (context, snapshot){
        final article = snapshot.data;
        if(article == null){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //3
        return ArticleDetail(article);
      },
    );
   }
/**
 * The code above
 * 1. Fetches the ArticleDetailBloc instance.

 * 2. The body: property displays the content with data
 * received from ArticleDetailBloc.

 * 3. Displays details using prepared widget
 * ArticleDetail.


 */


}