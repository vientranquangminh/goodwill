import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DialogBuilder extends StatelessWidget {
  const DialogBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/sign_in/congratulation.png'),
              const Text(
                'Congratulations!',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              const Text(
                'Your account is ready to use. You will be redirected to the Home page in a few seconds',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 80,
                height: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  strokeWidth: 2,
                  colors: [Colors.black],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
