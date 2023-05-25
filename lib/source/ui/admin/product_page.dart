import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

const List<String> list = <String>[
  'All',
  'Clothes',
  'Shoes',
  'Bags',
  'Electronic',
  'Watch',
  'Jewelry',
  'Kitchen',
  'Toys',
];

class _ProductPageState extends State<ProductPage> {
  String dropdownValue = list.first;

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
                              context.localizations.product,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              context.localizations.manageAllProduct,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            )
                          ]),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                ),
                const SizedBox(height: 20),
                StreamBuilder<List<ProductModel>?>(
                  stream: ProductService.getProductsByCondition(dropdownValue),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: ColorName.black),
                      );
                    }
                    if (snapshot.hasData) {
                      List<DataRow> rows = [];
                      int length = snapshot.data?.length ?? 0;
                      for (int i = 0; i < length; i++) {
                        rows.add(
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(snapshot.data?[i].title ?? '')),
                              DataCell(Text(snapshot.data?[i].category ?? '')),
                              DataCell(
                                  Text(snapshot.data![i].createdAt.toString())),
                              DataCell(Text(snapshot.data?[i].location ?? '')),
                              DataCell(Text(snapshot.data?[i].ownerId ?? '')),
                              DataCell(
                                  Text(snapshot.data![i].price.toString())),
                              DataCell(IconButton(
                                icon: const Icon(
                                    CupertinoIcons.xmark_circle_fill),
                                onPressed: () {
                                  ProductService.deleteProductById(
                                      snapshot.data![i].id!);
                                },
                              )),
                            ],
                          ),
                        );
                      }
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(columns: <DataColumn>[
                            DataColumn(
                              label: Text(context.localizations.id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.productTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.category,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.createAt,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.location,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.owner,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.price,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            const DataColumn(
                              label: Text(''),
                            ),
                          ], rows: rows),
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
