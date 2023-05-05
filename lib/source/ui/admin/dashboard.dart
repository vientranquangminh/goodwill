import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  static List<charts.Series<BarModel, String>> _createChart() {
    final data = [
      BarModel(title: 'Account Admin', value: 2, colors: Colors.black),
      BarModel(title: 'Account Doctor', value: 20, colors: Colors.black),
      BarModel(title: 'Account Patient', value: 50, colors: Colors.black),
      BarModel(title: 'Article', value: 40, colors: Colors.black),
    ];
    return [
      charts.Series<BarModel, String>(
        data: data,
        id: 'Sum',
        colorFn: (datum, index) => charts.MaterialPalette.black,
        domainFn: (BarModel barModel, _) => barModel.title,
        measureFn: (BarModel barModel, _) => barModel.value,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarAdmin(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localizations.dashBoard,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContainerDashBoard(
                        title: context.localizations.adminAccount,
                        number: '2',
                        icon: 'assets/svgs/profile.svg',
                      ),
                      ContainerDashBoard(
                        title: context.localizations.userAccount,
                        number: '50',
                        icon: 'assets/svgs/user_admin.svg',
                      ),
                      ContainerDashBoard(
                        title: context.localizations.product,
                        number: '20',
                        icon: 'assets/svgs/product.svg',
                      ),
                      ContainerDashBoard(
                        title: context.localizations.topic,
                        number: '40',
                        icon: 'assets/svgs/trending-topic.svg',
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      'Statistics',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: charts.BarChart(
                        _createChart(),
                        animate: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text(
                      context.localizations.recentProductOfUsers,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    width: double.infinity,
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
                              context.localizations.product,
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
                              context.localizations.user,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              context.localizations.price,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('1')),
                            DataCell(Text('Iphone')),
                            DataCell(Text('25/11/2022')),
                            DataCell(Text('Do Minh Thanh')),
                            DataCell(Text('2000')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('2')),
                            DataCell(Text('Iphone')),
                            DataCell(Text('25/11/2022')),
                            DataCell(Text('Do Minh Thanh')),
                            DataCell(Text('2000')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('3')),
                            DataCell(Text('Iphone')),
                            DataCell(Text('25/11/2022')),
                            DataCell(Text('Do Minh Thanh')),
                            DataCell(Text('2000')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('4')),
                            DataCell(Text('Iphone')),
                            DataCell(Text('25/11/2022')),
                            DataCell(Text('Do Minh Thanh')),
                            DataCell(Text('2000')),
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
      ),
    );
  }
}

class ContainerDashBoard extends StatelessWidget {
  const ContainerDashBoard({
    Key? key,
    required this.title,
    required this.number,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String number;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Numer of \n$title',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                  number,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            SvgPicture.asset(
              icon,
              width: 60,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class BarModel {
  final String title;
  final int value;
  final Color? colors;
  BarModel({required this.title, required this.value, this.colors});
}
