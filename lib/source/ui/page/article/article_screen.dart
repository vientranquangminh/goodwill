import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/article_service.dart';
import 'package:goodwill/source/ui/page/article/articles_container/all_articles/my_list_articles.dart';
import 'package:goodwill/source/ui/page/article/custom_topic/custom_topic.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with TickerProviderStateMixin {
  List<String> item = ['', 'donate', 'buy'];
  List<int> selectedIndices = [0];
  List<ArticleModel> filterArticlesBySelectedIndices(
      List<ArticleModel> articles, List<int> selectedIndices) {
    if (selectedIndices.contains(0)) {
      return articles;
    }
    List<ArticleModel> filteredArticles = [];
    for (int index in selectedIndices) {
      String selectedText = item[index];
      List<ArticleModel> selectedArticles =
          articles.where((article) => article.type == selectedText).toList();
      filteredArticles.addAll(selectedArticles);
    }
    return filteredArticles;
  }

  final _future = ArticleService.getAllArticles();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> types = [
      context.localizations.all,
      context.localizations.donate,
      context.localizations.buy
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Assets.svgs.mainIcon.svg(),
        title: Text(
          context.localizations.topic,
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
                  context.localizations.topic,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.pushNamed(Routes.createTopic);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      context.localizations.createTopic,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
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
                          if (index == 0) {
                            selectedIndices = [0];
                          } else if (selectedIndices.contains(index)) {
                            selectedIndices.remove(index);
                            if (selectedIndices.isEmpty) {
                              selectedIndices = [0];
                            }
                          } else {
                            selectedIndices = [index];
                          }
                        });
                      },
                      child: CustomTopicContainer(
                        hour: types[index],
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
              child: FutureProvider<List<ArticleModel>?>.value(
                  initialData: [],
                  value: _future,
                  builder: (context, ___) {
                    List<ArticleModel>? articles =
                        context.watch<List<ArticleModel>?>();
                    if (articles == null) {
                      return const NotFoundScreen();
                    }
                    return MyListArticles(
                      articles: filterArticlesBySelectedIndices(
                          articles, selectedIndices),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
