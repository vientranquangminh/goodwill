import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/service/article_service.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Buy', 'Donate'];

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  String dropdownValue = list.first;
  List<DateTime> _dates = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _dates = List.generate(
        30, (index) => DateTime.now().subtract(Duration(days: index)));
    _selectedDate = _dates.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarAdmin(),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.localizations.topic,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              context.localizations.manageAllTopicPost,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            )
                          ]),
                      Row(
                        children: [
                          Container(
                            width: 140,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<DateTime>(
                                value: _selectedDate,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedDate = newValue;
                                  });
                                },
                                items: _dates.map((date) {
                                  return DropdownMenuItem<DateTime>(
                                    value: date,
                                    child: Text(
                                        '${date.day}/${date.month}/${date.year}'),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 100,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down_sharp),
                                  elevation: 10,
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: list.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<List<ArticleModel>>(
                  builder: (context, articles, child) {
                    if (articles.isEmpty) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: ColorName.black),
                      );
                    } else {
                      log(articles.length.toString(), name: 'articles');
                      List<DataRow> rows = [];
                      for (int i = 0; i < articles.length; i++) {
                        log(articles[i].toString(), name: 'articles');
                        rows.add(
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(articles[i].title ?? '')),
                              DataCell(Text(articles[i].createdAt.toString())),
                              DataCell(Text(articles[i].ownerId ?? '')),
                              DataCell(
                                PlatformIconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      log('delete article: ${articles[i].id}',
                                          name: 'delete');
                                      ArticleService.deleteArticleById(
                                          articles[i]);
                                    },
                                    icon: const Icon(
                                        CupertinoIcons.xmark_circle_fill)),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(
                                  context.localizations.id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  context.localizations.topicTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  context.localizations.createAt,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  context.localizations.createdBy,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const DataColumn(
                                label: Text(
                                  '',
                                ),
                              ),
                            ],
                            rows: rows,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
