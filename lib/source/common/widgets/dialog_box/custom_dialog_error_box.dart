import 'package:flutter/material.dart';
import 'package:goodwill/source/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogErrorBox extends StatefulWidget {
  const CustomDialogErrorBox({
    Key? key,
  }) : super(key: key);

  @override
  CustomDialogErrorBoxState createState() => CustomDialogErrorBoxState();
}

class CustomDialogErrorBoxState extends State<CustomDialogErrorBox>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Container contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(
            height: 24,
          ),
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Incorrect information',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              ' Some of the information that you entered\ndidn’t match with the'
              ' DOPA database.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Please double check and try again',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomElevatedButton(
              text: 'Ok',
              customFunction: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
