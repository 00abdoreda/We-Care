import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'Screens/Profile/Update_Profile_Screen.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/classify/components/ForgetPassForm.dart';
import 'Screens/classify/forget my pass.dart';
import 'constants.dart';
import 'intro.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final introdate2=GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introdate2.writeIfNull('displayed', false);


  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: introdate2.read('displayed')?BottomNavBar() : IntroScreenDefault() ,


    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> _buildScreens() {

      return [
        TfliteModel(),
        const UpdateProfileScreen(),
        const UpdateProfileScreen(),


      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems(){
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Main"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,

        ),

        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,


        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.contact_support),
          title: ("Profile "),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),




      ];


    }

    PersistentTabController controller;
    // pushNewScreen(
    //   context,
    //   screen: WelcomeScreen(),
    //   withNavBar: false, // OPTIONAL VALUE. True by default.
    //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
    // );

    controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(

      context,
      screens:_buildScreens(),
      items: _navBarsItems(),
      controller: controller,
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
      NavBarStyle.style9,



    );

  }
}
