import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({Key? key}) : super(key: key);

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
                  child: Column(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            context.localizations.id,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            context.localizations.topicTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            context.localizations.createAt,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            context.localizations.createdBy,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Expanded(
                          child: Text(
                            '',
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: [
                          const DataCell(Text('1')),
                          const DataCell(Text('How to do this one?')),
                          const DataCell(Text('25/11/2022')),
                          const DataCell(Text('Đỗ Minh Thành')),
                          DataCell(IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  CupertinoIcons.xmark_circle_fill))),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text('2')),
                          const DataCell(Text('Flutter is so amazing')),
                          const DataCell(Text('27/11/2022')),
                          const DataCell(Text('Viên Quang Minh')),
                          DataCell(IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  CupertinoIcons.xmark_circle_fill))),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text('3')),
                          const DataCell(Text('Is C++ important?')),
                          const DataCell(Text('27/11/2022')),
                          const DataCell(Text('Nguyen Son')),
                          DataCell(IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  CupertinoIcons.xmark_circle_fill))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
