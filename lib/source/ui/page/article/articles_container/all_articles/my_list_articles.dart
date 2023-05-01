import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/page/article/article_object.dart';
import 'package:goodwill/source/ui/page/article/articles_container/article_detail_page.dart';

import '../my_articles_container.dart';

class MyListArticles extends StatelessWidget {
  const MyListArticles({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ArticleDetailPage(
                            article: articles[index],
                          )));
            }),
            child: MyArticleContainer(
              imgUrl: articles[index].imgUrl ?? '',
              time: articles[index].time ?? '',
              title: articles[index].title ?? '',
            ),
          );
        });
  }
}
