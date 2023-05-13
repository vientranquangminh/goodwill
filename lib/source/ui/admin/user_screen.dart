import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/ui/admin/widget/appbar_admin.dart';
import 'package:provider/provider.dart';

import 'widget/dialog_edit_profile_user.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

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
                Consumer<List<UserProfile>>(
                  builder: (context, listUser, child) {
                    if (listUser.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorName.black,
                        ),
                      );
                    } else {
                      List<DataRow> rows = [];
                      for (int i = 0; i < listUser.length; i++) {
                        rows.add(
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('${i + 1}')),
                              DataCell(Text(listUser[i].fullName ?? '')),
                              DataCell(Text(listUser[i].nickName ?? '')),
                              DataCell(
                                  Text(listUser[i].dateOfBirth.toString())),
                              DataCell(Text(listUser[i].phoneNumber ?? '')),
                              DataCell(Text(listUser[i].gender ?? '')),
                              DataCell(PlatformIconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: EditUserInformation(
                                        userProfile: listUser[i],
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
                              label: Text(context.localizations.fullName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.nickname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.dateOfBirth,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.phoneNumber,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text(context.localizations.gender,
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
                  // child:
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
