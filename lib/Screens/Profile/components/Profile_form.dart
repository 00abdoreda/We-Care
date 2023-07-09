import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../Welcome/welcome_screen.dart';
import 'model.dart';
import 'package:get_storage/get_storage.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/change pass.dart';
import '../../../constants.dart';
import '../../Change pass/change pass.dart';
import '../../Change pass/components/Change_Pass_Screen.dart';
import '../../Login/login_screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  //get account
  final introdate=GetStorage();

  late Future <user>?events2;

  var isloaded= false;

  //create account
  GlobalKey<FormState>? formKey;
  var _autoValidateMode = AutovalidateMode.disabled;
  final  firstNameController = TextEditingController();
  final  lastNameController = TextEditingController();
  final  addressController = TextEditingController();
  final  emailController = TextEditingController();
  final  mobileController = TextEditingController();
  final  nidController = TextEditingController();
  final  passwordController = TextEditingController();
  final  ageController = TextEditingController();
  String? photo='..';
  bool? isactive=true;
  final dio=Dio();
  postData(fname,lname,address,email,mobile,nid,age)async{
    try{
      var response=await dio.patch('http://192.168.1.4:8000/api/updateaccount/'+mobile
          ,data: {"firstName":fname.toString(),'lastName':lname.toString(),"address":address.toString(),"email":email.toString(),"Nid":nid.toString(),"age":age,"photo":'hhh',"isactive":isactive});
      if(response.statusCode!=400){
        customToast('update success', context);



        setState(() {
          events2=fetchCatFact(introdate.read('umobile').toString());
        });




      }else{
        customToast('error', context);
      }





    }catch(e){
      customToast('error', context);
      print(e);

    }
  }

  void customToast(String message,BuildContext context){
    showToast(message,textStyle: TextStyle(fontSize: 14,wordSpacing: .1,color: Colors.black),
      textPadding: EdgeInsets.all(16),
      toastHorizontalMargin: 25
      ,borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.red,
      alignment: Alignment.bottomLeft,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      duration: Duration(seconds: 5),
      context: context,


    );



  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    emailController.dispose();
    mobileController.dispose();
    nidController.dispose();
    passwordController.dispose();
    ageController.dispose();



    super.dispose();
  }


  @override
  void initState() {
    //introdate.write('user', '01201356363');
    super.initState();

    events2=fetchCatFact(introdate.read('umobile').toString());

    formKey = GlobalKey<FormState>();




  }
  Future<user> fetchCatFact(ph) async {
    final response = await dio.get('http://192.168.1.4:8000/api/getaccount/'+ph);

    if (response.statusCode == 200) {
      return user.fromJson(response.data);
    } else {
      throw Exception("Failed to load cat fact!");
    }
  }
  @override
  Widget build(BuildContext context){

  return FutureBuilder<user>(
  future: events2,
  builder: (context,  snapshot){
  if (snapshot.hasData) {
    return Form(
      autovalidateMode: _autoValidateMode,
      key: formKey,
      child: Column(
        children: [
        CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('assets/profile_pictuer.jpg'),
      ),
          const SizedBox(height: defaultPadding ),

          TextFormField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: firstNameController,
            onTap: (){
              setState(() {
                firstNameController.text=snapshot.data!.firstName!;
              });
            },
            decoration: InputDecoration(

              hintText: "First name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: lastNameController,
            onTap: (){
              setState(() {
                lastNameController.text=snapshot.data!.lastName!;
              });
            },
            decoration: InputDecoration(
              hintText: "Last name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person_2),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: emailController,
            onTap: (){
              setState(() {
                emailController.text=snapshot.data!.email!;
              });
            },
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: ageController,
            onTap: (){
              setState(() {
                ageController.text=snapshot.data!.age!.toString();
              });
            },
            decoration: InputDecoration(
              hintText: "Your age",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.date_range),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: mobileController,
            onTap: (){
              setState(() {
                mobileController.text=snapshot.data!.mobile!;
              });
            },
            decoration: InputDecoration(
              hintText: "Phone number",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: nidController,
            onTap: (){
              setState(() {
               nidController.text=snapshot.data!.nid!;
              });
            },
            decoration: InputDecoration(
              hintText: "National ID",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person_2),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: addressController,
            onTap: (){
              setState(() {
                addressController.text=snapshot.data!.address!;
              });
            },
            decoration: InputDecoration(
              hintText: "Address",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.place),
              ),
            ),
          ),


          // const SizedBox(height: defaultPadding ),
          // TextFormField(
          //   keyboardType: TextInputType.text,
          //   textInputAction: TextInputAction.next,
          //   cursorColor: kPrimaryColor,
          //   onSaved: (password) {},
          //   decoration: InputDecoration(
          //     hintText: "Password",
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.all(defaultPadding),
          //       child: Icon(Icons.password),
          //     ),
          //   ),
          // ),



          const SizedBox(height: defaultPadding ),
          ElevatedButton(
            onPressed:(){
             handleSubmit(snapshot.data!.firstName, snapshot.data!.lastName, snapshot.data!.address, snapshot.data!.email, snapshot.data!.mobile, snapshot.data!.nid, snapshot.data!.age);
            },
            child: Text("Update Profile"),
          ),
          const SizedBox(height: defaultPadding),
          ChangePassword(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChangePasswordScreenn();
                  },
                ),
              );
            },
          ),
          FloatingActionButton(onPressed:  (){
            setState(() async{
              await introdate.remove('displayed');

              // await introdate.write('displayed', false);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return WelcomeScreen();
                  },
                ),
                    (_) => false,
              );

            });

          },child: Icon(Icons.logout),backgroundColor: Colors.red,),
        ],
      ),
    );
  } else {
  return CircularProgressIndicator();
  }

  },


  );

}
  void handleSubmit(fname,lname,address,email,mobile,nid,age)async {
    setState(await() {
      if(firstNameController.text.isEmpty){
        firstNameController.text=fname;

      }
      if(lastNameController.text.isEmpty){
        lastNameController.text=lname;

      }
      if(addressController.text.isEmpty){
        addressController.text=address;

      }
      if(emailController.text.isEmpty){
        emailController.text=email;

      }
      if(mobileController.text.isEmpty){
        mobileController.text=mobile;

      }
      if(nidController.text.isEmpty){
        nidController.text=nid;

      }
      if(ageController.text.isEmpty){
       ageController.text=age.toString();

      }
    });
    final formState = formKey!.currentState;

    if (formState == null) {





      return;
    }
    if (formState!.validate()) {
      _autoValidateMode = AutovalidateMode.always;
      //print(nid.text);


      postData(firstNameController.text,lastNameController.text,addressController.text,emailController.text,mobileController.text,nidController.text,ageController.text);
      setState(() {
        events2=fetchCatFact(introdate.read('umobile').toString());
      });



      // name.clear();
      //
      // age.clear();
      // collage.clear();
      // grade.clear();
      // ph.clear();
      // nid.clear();





    }
    // if(formState.validate()){

    //
    // }

  }
}

// import 'package:flutter/material.dart';
//
// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _firstName;
//   late String _lastName;
//   late String _email;
//   late String _password;
//   late String _id;
//   late String _age;
//   late String _mobile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _firstName = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _lastName = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _email = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _password = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'ID'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your ID';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _id = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Age'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your age';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _age = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Mobile'),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your mobile number';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _mobile = value!;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Do something with the form data
//                   }
//                 },
//                 child: Text('Sign up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }