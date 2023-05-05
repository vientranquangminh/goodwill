import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';

import 'widget/dialog_edit_profile_user.dart';
import 'widget/dummy/user_object.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    for (int i = 0; i < listUser.length; i++) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(listUser[i].id)),
            DataCell(Text(listUser[i].name)),
            DataCell(Text(listUser[i].nickname)),
            DataCell(Text(listUser[i].dayOfBirth)),
            DataCell(Text(listUser[i].phone)),
            DataCell(Text(listUser[i].gender)),
            DataCell(IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: EditUserInformation(
                      userId: listUser[i].id,
                    ),
                  ),
                );
              },
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
                          context.localizations.user,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          context.localizations.manageAllUser,
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
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text(context.localizations.fullName,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text(context.localizations.nickname,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text(context.localizations.dateOfBirth,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text(context.localizations.phoneNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text(context.localizations.gender,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const DataColumn(
                        label: Text(''),
                      ),
                    ], rows: rows),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
