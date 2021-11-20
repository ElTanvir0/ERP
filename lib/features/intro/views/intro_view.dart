import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:new_ways_app/features/auth/views/log_in_page.dart';
import 'package:new_ways_app/features/core/views/profile_page.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'closest_branch_finder.dart';

// ignore: must_be_immutable
class IntroView extends StatelessWidget {
  IntroView({Key? key}) : super(key: key);
  TextStyle introTextStyle = GoogleFonts.dancingScript(
    fontSize: 50,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      showDoneBtn: false,
      showNextBtn: false,
      showPrevBtn: false,
      showSkipBtn: false,
      slides: [
        Slide(
            backgroundColor: kPrimaryColor,
            widgetTitle: DelayedDisplay(
                delay: Duration(milliseconds: 300),
                child: Image.asset('assets/images/splash_logo.png')),
            centerWidget: Column(
              children: [
                DelayedDisplay(
                    delay: Duration(milliseconds: 600),
                    child: Text('Home', style: introTextStyle)),
                DelayedDisplay(
                    delay: Duration(milliseconds: 900),
                    child: Text('For', style: introTextStyle)),
                DelayedDisplay(
                    delay: Duration(milliseconds: 1200),
                    child: Text('Bachelor', style: introTextStyle))
              ],
            )),
        Slide(
            centerWidget: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedDisplay(
                delay: Duration(microseconds: 1500),
                child: LeaveRequestButton(
                    deviceSize: MediaQuery.of(context).size,
                    btnName: 'Already A Member/Employee',
                    onClick: () {
                      Get.to(() => LoginPage());
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              DelayedDisplay(
                delay: Duration(microseconds: 1800),
                child: LeaveRequestButton(
                    deviceSize: MediaQuery.of(context).size,
                    btnName: 'Find Nearest Branch',
                    onClick: () {
                      Get.to(() => ClosestBranch());
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              DelayedDisplay(
                delay: Duration(microseconds: 1800),
                child: LeaveRequestButton(
                    deviceSize: MediaQuery.of(context).size,
                    btnName: 'Book a Seat (Coming Soon)',
                    onClick: () async {
                      var googleUrl = 'https://www.superhomebd.com/';
                      if (await canLaunch(googleUrl)) {
                        await launch(googleUrl);
                      } else {
                        throw 'Could not open the map.';
                      }
                      // Get.to(() => ClosestBranch());
                      showToast('This Feature is Coming Soon');
                    }),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
