import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/ui/page/auth_wrapper/auth_wrapper.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AuthWrapper(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      imageFlex: 3,
      imageAlignment: Alignment.center,
      titleTextStyle: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 0, 0, 0)),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 100),
    );

    return ScreenUtilInit(
        designSize: const Size(428, 884),
        builder: (BuildContext context, Widget? child) {
          return IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            pages: [
              PageViewModel(
                image: Image.asset('assets/images/splash/onboard1.png'),
                title: "We provide high quality products just for you",
                body: "",
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/splash/onboard2.png'),
                title: "You satisfaction is our number one priority",
                body: "",
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/splash/onboard3.png'),
                title:
                    "Let's fulfill your daily needs with Goodwill right now!",
                body: "",
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            skipOrBackFlex: 0,
            nextFlex: 0,
            next: Container(
              height: 50,
              width: 250.w,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(1000),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 3.0),
                    )
                  ]),
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            done: Container(
              height: 50,
              width: 250.w,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(1000),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 3.0),
                    )
                  ]),
              child: const Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            curve: Curves.fastLinearToSlowEaseIn,
            dotsDecorator: const DotsDecorator(
              size: Size(15.0, 15.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(30.0, 15.0),
              activeColor: Colors.black,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          );
        });
  }
}
