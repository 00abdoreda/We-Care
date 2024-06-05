import 'package:cancer2/Screens/DoctorScreen/components/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'remoteserv.dart';
class doctorForm extends StatefulWidget {
  const doctorForm({
    Key? key,
  }) : super(key: key);

  @override
  State<doctorForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<doctorForm> {
  // Define variables for dropdowns
  String locationValue = 'cairo';
  String dayValue = 'sat';

  final introdate=GetStorage();

  List<doctors>?events;
  var isloaded= false;
  var c=0;

  // Fetch data from remote server
  getdata()async{
    events=await remoteServices().getEvents(locationValue, dayValue);

    if(events?.length!=0){
      setState(() {
        isloaded=true;
      });
    }else{
      setState(() {
        isloaded=false;
        print( isloaded);
      });
    }
  }
  final dio=Dio();

  postData(mobiledoctor)async{
    try{
      var response=await dio.post('http://192.168.124.111:8000/api/bookdoctor'
          ,data: {"day":dayValue,"mobileDoc":mobiledoctor.toString(),"mobilePat":introdate.read('umobile').toString()});

      if(response.statusCode==200){
        customToast('success', context);

        // await introdate.write('uid', response.data._id.toString());



      }else{
        customToast('Error', context);
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
      backgroundColor: Colors.green,
      alignment: Alignment.bottomLeft,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      duration: Duration(seconds: 5),
      context: context,


    );



  }

  // Define a function to build the dropdowns
  Widget buildDropdowns(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Location dropdown
        DropdownButton<String>(
          value: locationValue,
          onChanged: (String? newValue) {
            setState(() {
              locationValue = newValue!;
            });
            getdata();
          },
          items: <String>['cairo', 'Alexandria', 'Giza', 'Luxor']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        // Day dropdown
        DropdownButton<String>(
          value: dayValue,
          onChanged: (String? newValue) {
            setState(() {
              dayValue = newValue!;
            });
            getdata();
          },
          items: <String>['sat', 'sun', 'mon', 'tue', 'wen', 'thu', 'fri']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Define a function to build the GridView
// Define a function to build the GridView
  Widget buildGridView(BuildContext context) {
    return GridView.builder(
      itemCount: events!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/box1.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        events![index].firstName!+' '+events![index].lastName!,
                        style: const TextStyle(color: Colors.white ,fontSize: 20),
                      ),
                      Text(
                        events![index].specialist!,
                        style: const TextStyle(color: Colors.black ,fontSize: 16),
                      ),
                      RatingBar.builder(
                        initialRating: events![index].rate!.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 25,
                        itemPadding: EdgeInsets.symmetric(horizontal: .1),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage('assets/doctor.png'),height: 100,width: 100,),
                      // Add the InkWell widget here
                      InkWell(
                        onTap: () {
                          postData(events![index].mobile.toString());
                          // Handle the button press here
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true,
        title: Text('doctors',style:TextStyle(fontSize: 25),),
        backgroundColor: Color(0xFF6F35A5),),

     body: Column(
        children: [
          buildDropdowns(context),
          Expanded(
            child: isloaded
                ? buildGridView(context)
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}