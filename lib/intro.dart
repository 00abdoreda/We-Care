import 'dart:developer';

import 'package:cancer2/Screens/Profile/Update_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:get_storage/get_storage.dart';

import 'Screens/Welcome/welcome_screen.dart';
import 'main.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  final introdate=GetStorage();

  void endintro(context){

   Navigator.pop (context);


    Navigator.of(context).push(
      MaterialPageRoute(builder: (_)=>UpdateProfileScreen())
    );

  }
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Skin diseases",
        description:
        "Skin diseases are highly dangerous and some of them are infectious",
        pathImage: "images/l1.png",
        backgroundColor: Color(0xff23cff5),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "AI",
        description:
        "Our mobile application helps people identify and differ between the diseases using AI",
        pathImage: "images/l3.png",
        backgroundColor: Color(0xffb047a8),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Application",
        description:
        "application can be a faster and more reliable way to diagnose the disease",
        pathImage: "images/l2.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {

    endintro(context);
  }

  void onSkip(){

    endintro(context);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
      onSkipPress: onSkip,
    );
  }
}