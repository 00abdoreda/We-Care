import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/forget pass.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class ForgetPassForm extends StatelessWidget {
  const ForgetPassForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          //   child: TextFormField(
          //     textInputAction: TextInputAction.done,
          //     obscureText: true,
          //     cursorColor: kPrimaryColor,
          //     decoration: InputDecoration(
          //       hintText: "Your password",
          //       prefixIcon: Padding(
          //         padding: const EdgeInsets.all(defaultPadding),
          //         child: Icon(Icons.lock),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "Verfiy_btn",
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Verfiy",
              ),
            ),
          ),
          // const SizedBox(height: defaultPadding),
          // AlreadyHaveAnAccountCheck(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(height: defaultPadding),
          // Forget_pass(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
