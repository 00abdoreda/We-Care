import 'package:flutter/material.dart';


import '../../responsive.dart';
import 'background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class TScreen extends StatefulWidget {
  const TScreen({Key? key}) : super(key: key);

  @override
  State<TScreen> createState() => _TScreenState();
}

class _TScreenState extends State<TScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(


          appBar: AppBar(
            centerTitle: true,
            title: Text('doctors',style:TextStyle(fontSize: 25),),
            backgroundColor: Color(0xFF6F35A5),


          ),
          body: Background(
            child: SingleChildScrollView(
              child: Responsive(
                mobile: const MobileLoginScreen(),
                desktop: Row(
                  children: [

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 450,
                            child:bookingForm(),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) ,
        ),);



  }
}

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  @override
  Widget build(BuildContext context) {


    return Directionality(textDirection: TextDirection.rtl,
        child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[




        Row(

          children: const [

            Spacer(),
            Expanded(
              flex: 8,
              child: bookingForm(),
            ),
            Spacer(),
          ],
        ),

      ],
    ) );

  }
}
