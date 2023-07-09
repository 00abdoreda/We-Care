import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/ForgetPassForm.dart';
import 'components/Forget_pass_screen.dart';

class Classe extends StatelessWidget {
  const Classe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: ClassifyScreen(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SizedBox(
                      width: 450,
                      child: TfliteModel(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         const ClassifyScreen(),
        Row(
          children:  [
            Spacer(),
            Expanded(
              flex: 8,
              child:TfliteModel( ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
