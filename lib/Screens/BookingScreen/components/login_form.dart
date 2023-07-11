import 'model.dart';
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
import 'package:intl/intl.dart';

class bookingForm extends StatefulWidget {
  const bookingForm({
    Key? key,
  }) : super(key: key);

  @override
  State<bookingForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<bookingForm> {
  // Define variables for dropdowns
 

  final introdate=GetStorage();

  List<booking>?events;
  var isloaded= false;
  var c=0;

  // Fetch data from remote server
  getdata()async{

    events=await remoteServices().getEvents(introdate.read('umobile'));

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


  // Define a function to build the GridView
// Define a function to build the GridView
  Widget buildGridView(BuildContext context) {
    // return GridView.builder(
    //   itemCount: events!.length,
    //   physics: const NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
    //   itemBuilder: (context, index) {
    //     return GestureDetector(
    //       onTap: () {},
    //       child: Container(
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage("assets/images/box1.png"),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Text(
    //                     events![index].firstName!+' '+events![index].lastName!,
    //                     style: const TextStyle(color: Colors.white ,fontSize: 20),
    //                   ),
    //                   Text(
    //                     events![index].time!,
    //                     style: const TextStyle(color: Colors.black ,fontSize: 16),
    //                   ),
    //                   Text(
    //                     events![index].date!,
    //                     style: const TextStyle(color: Colors.black ,fontSize: 16),
    //                   ),
    //
    //                 ],
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Image(image: AssetImage('assets/doctor.png'),height: 100,width: 100,),
    //                   // Add the InkWell widget here
    //
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );

    return Container(
      height: 700,
      // set a specific height for the GridView
      child: GridView.builder(
        itemCount: events!.length,
        physics: AlwaysScrollableScrollPhysics(), // set physics to AlwaysScrollableScrollPhysics
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 16 / 7,
          crossAxisCount: 1,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          DateTime date = DateTime.parse(events![index].date!);
          String formattedDate = DateFormat('yyyy-MM-dd').format(date);
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
                          events![index].firstName! +
                              ' ' +
                              events![index].lastName!,
                          style:
                          const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                        'time : '+  events![index].time!,
                          style:
                          const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                         'date : '+ formattedDate,
                          style:
                          const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage('assets/doctor.png'),
                          height: 100,
                          width: 100,
                        ),
                        // Add the InkWell widget here
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
        title: Text('Booking Times',style:TextStyle(fontSize: 25),),
        backgroundColor: Color(0xFF6F35A5),),

     body: Column(
       children: [
         isloaded
             ? buildGridView(context)
             : const Center(child: CircularProgressIndicator()),

       ],


          ),

      );

  }
}