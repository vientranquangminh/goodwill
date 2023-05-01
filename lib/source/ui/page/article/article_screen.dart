import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/page/article/article_object.dart';
import 'package:goodwill/source/ui/page/article/articles_container/all_articles/my_list_articles.dart';
import 'package:goodwill/source/ui/page/article/custom_topic/custom_topic.dart';

import 'dummy/list_article.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with TickerProviderStateMixin {
  List<String> item = ['Donate', 'Buy'];
  List<int> selectedIndices = [];
  String type = '';
  List<Article> filterArticlesBySelectedIndices(
      List<Article> articles, List<int> selectedIndices) {
    if (selectedIndices.isEmpty) {
      return articles;
    }
    List<Article> filteredArticles = [];
    for (int index in selectedIndices) {
      String selectedText = item[index];
      List<Article> selectedArticles = articles
          .where((article) => article.category == selectedText)
          .toList();
      filteredArticles.addAll(selectedArticles);
    }
    return filteredArticles;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Assets.svgs.mainIcon.svg(),
          title: Text(
            context.localizations.article,
            style: const TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.localizations.article,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        context.localizations.createArticle,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndices.contains(index)) {
                              selectedIndices.remove(index);
                            } else {
                              selectedIndices.add(index);
                            }
                          });
                          print(selectedIndices);
                        },
                        child: CustomTopicContainer(
                          hour: item[index],
                          buttonColor: selectedIndices.contains(index)
                              ? Colors.black
                              : Colors.white,
                          textColor: selectedIndices.contains(index)
                              ? Colors.white
                              : Colors.black,
                        ),
                      );
                    }),
              ),
              Expanded(
                child: MyListArticles(
                  articles: filterArticlesBySelectedIndices(
                      listArticles, selectedIndices),
                ),
              ),
            ],
          ),
        ));
  }
}
