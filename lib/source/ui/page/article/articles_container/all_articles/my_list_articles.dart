import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/ui/page/article/articles_container/article_detail_page.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/date_time_helper.dart';

import '../my_articles_container.dart';

class MyListArticles extends StatelessWidget {
  const MyListArticles({Key? key, required this.articles}) : super(key: key);
  final List<ArticleModel> articles;

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
              imgUrl: articles[index].image ?? Constant.SAMPLE_AVATAR_URL,
              time: DateTimeHelper.toFriendlyString(articles[index].createdAt),
              title: articles[index].title ?? '',
            ),
          );
        });
  }
}
