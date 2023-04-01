// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_utilities/ui/resources/app_assets/app_assets.dart';

// class AppToasts {
//   static void showToast({
//     required BuildContext context,
//     required String title,
//   }) {
//     FToast().init(context);
//     FToast().showToast(
//       positionedToastBuilder: (_,Widget child) {
//         return Positioned(top: 44.0, left: 24.0, right: 24.0, child: child);
//       },
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color:
//                 Colors.green,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: Colors.green,
//             )),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Row(
//             children: <Widget>[
//               Image.asset(AppAssets.icCheck),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(color: Colors.black, fontSize: 20),
//                 ),
//               ),
//               Image.asset(AppAssets.icCross),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static void showErrorToast({
//     required String title,
//     required BuildContext context,
//   }) {
//     FToast().init(context);
//     FToast().showToast(
//       positionedToastBuilder: (_,Widget child) {
//         return Positioned(top: 44.0, left: 24.0, right: 24.0, child: child);
//       },
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color:
//                   Colors.red,
//             )),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(color: Colors.black, fontSize: 20),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Image.asset(AppAssets.icCross),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
