import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yolanda/constants/svgs.dart';
import 'package:yolanda/screens/home/home.dart';


class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  late Timer _timer;
  int _start = 4;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Get.off(
              () => const Home(),
              fullscreenDialog: false,
              popGesture: true,
              transition: Transition.leftToRightWithFade,
              duration: const Duration(milliseconds: 600),
            );
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Start duration of screen
    startTimer();
  }

  @override
  void dispose() {
    //end duration of screen
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(bg_double_img),
            //   fit: BoxFit.cover,
            // ),
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
                begin: Alignment.topRight, //begin of the gradient color
                end: Alignment.bottomRight, //end of the gradient color
                stops: const [0, 0.2, 0.5, 0.8] //stops for individual color
                //set the stops number equal to numbers of color
                ),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        child: Center(
          child: Column(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 120,
                    child: SvgPicture.asset(
                      logo,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                   Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0, top: 22),
                      child: Text("Welcome to Habit Tracker",
                        style: TextStyle(
                            fontSize: 16,
                            color:  Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            fontFamily: 'Helvetica-Font',
                            fontStyle: FontStyle.normal
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
