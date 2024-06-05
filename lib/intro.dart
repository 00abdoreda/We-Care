import 'dart:developer';

import 'package:cancer2/Screens/Profile/Update_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:get_storage/get_storage.dart';

import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/classify/components/ForgetPassForm.dart';
import 'Screens/classify/forget my pass.dart';
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
      MaterialPageRoute(builder: (_)=>WelcomeScreen())
    );

  }
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Precocious",
        description:
        "Early stage Alzheimer's disease, characterized by mild cognitive decline, memory, language, and problem-solving difficulties, necessitates prompt diagnosis and intervention to manage symptoms and prepare for the future.",
        pathImage: "images/l1.png",
        backgroundColor: Color(0xff23cff5),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Advanced",
        description:
        "Advanced stage Alzheimer's disease involves severe cognitive decline, memory loss, and behavioral changes, requiring comprehensive care and support to manage symptoms and maintain quality of life.",
        pathImage: "images/l3.png",
        backgroundColor: Color(0xffb047a8),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Intermediary",
        description:"The protein mediator in Alzheimer's disease is crucial for neurofibrillary tangle formation, leading to neuronal damage and impaired memory, potentially aiding in the development of potential treatments.",
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