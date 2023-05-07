import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';
import 'package:goodwill/source/ui/admin/widget/dummy/product_object.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    for (int i = 0; i < listProduct.length; i++) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(listProduct[i].id)),
            DataCell(Text(listProduct[i].title)),
            DataCell(Text(listProduct[i].category)),
            DataCell(Text(listProduct[i].createAt)),
            DataCell(Text(listProduct[i].user)),
            DataCell(Text(listProduct[i].phone)),
            DataCell(Text(listProduct[i].price.toString())),
            DataCell(IconButton(
              icon: const Icon(CupertinoIcons.xmark_circle_fill),
              onPressed: () {},
            )),
          ],
        ),
      );
    }
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
                Container(
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(context.localizations.productTitle,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(context.localizations.category,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(context.localizations.createAt,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(context.localizations.owner,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(context.localizations.phoneNumber,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(context.localizations.price,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const DataColumn(
                          label: Text(''),
                        ),
                      ], rows: rows),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
