import 'package:flutter/material.dart';

import '../../../constants.dart';
// import '../../Contact/login_screen.dart';
// import '../../Login/login_screen.dart';
// import '../../Signup/signup_screen.dart';
import 'already_have_an_account_acheck.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            // onPressed: () {
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute<dynamic>(
            //       builder: (context) {
            //         return LoginScreen();
            //       },
            //     ),
            //         (route) => false,
            //   );
            // },
            onPressed: () {  },
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          // onPressed: () {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute<dynamic>(
          //       builder: (context) {
          //         return SignUpScreen();
          //       },
          //     ),
          //         (route) => false,
          //   );
          // },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          onPressed: () {  },
          child: Text(
            "تسجيل حساب جديد",
            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: defaultPadding),
        AlreadyHaveAnAccountChec(press: null,
          // press: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute<dynamic>(
          //       builder: (context) {
          //         return ContactScreen();
          //       },
          //     ),
          //
          //   );
          // },
        ),
      ],
    );
  }
}
