import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

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
                ),
                const SizedBox(height: 20),
                Consumer<List<ProductModel>>(
                  builder: (context, products, child) {
                    if (products.isEmpty) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: ColorName.black),
                      );
                    } else {
                      List<DataRow> rows = [];
                      for (int i = 0; i < products.length; i++) {
                        rows.add(
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(products[i].title ?? '')),
                              DataCell(Text(products[i].category ?? '')),
                              DataCell(Text(products[i].createdAt.toString())),
                              DataCell(Text(products[i].location ?? '')),
                              DataCell(Text(products[i].ownerId ?? '')),
                              DataCell(Text(products[i].price.toString())),
                              DataCell(IconButton(
                                icon: const Icon(
                                    CupertinoIcons.xmark_circle_fill),
                                onPressed: () {
                                  ProductService.deleteProductById(products[i]);
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
