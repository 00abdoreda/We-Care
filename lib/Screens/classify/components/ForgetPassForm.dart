import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
class TfliteModel extends StatefulWidget {
  @override
  _TfliteModel createState() => _TfliteModel();
}
class DiseaseInfo {
  final String name;
  final String description;
  final String isDangerous;
  final String treatment;

  DiseaseInfo({required this.name, required this.description, required this.isDangerous, required this.treatment});
}

class _TfliteModel extends State<TfliteModel> {
  final List<DiseaseInfo> diseases = [
    DiseaseInfo(
      name: 'NonDemented',
      description: '''
     refers to the earliest stage of dementia, often referred to as Mild Cognitive Impairment (MCI). At this stage, the cognitive changes are noticeable but do not significantly impact daily life and independence     ''',

      isDangerous: 'You are in great condition! Keep it up like that.',
      treatment: 'Cryotherapy, Topical Medications',
    ),
    DiseaseInfo(
      name: 'ModerateDemented',
      description: '''
refers to an intermediate stage of dementia where cognitive decline and memory loss are more pronounced than in the mild stage, but not as severe as in advanced stages. People with moderate dementia typically require more assistance with daily activities and experience more significant changes in behavior and cognition.     ''',
      isDangerous: 'Suspected moderate-phase Alzheimers disease. Urgent medical evaluation advised.',
      treatment: 'Surgery, Radiation, Topical Medications',
    ),
    DiseaseInfo(

      name: 'MILdDemented',
      description: '''
 refers to individuals who do not exhibit signs of dementia, meaning they have normal cognitive function for their age. In a medical context, it usually describes people who have not experienced significant decline in memory, thinking, or behavior that would interfere with their daily activities.      ''',
      isDangerous: 'We regret to inform you that you are in critical condition. It is imperative that you visit a doctor.',
      treatment: 'No treatment necessary',
    ),
    DiseaseInfo(
      name: 'VeryMildDemented',
      description: '''
appears to be a combination of terms "MILD" and "Demented," likely referring to a mild form of dementia. Dementia is a general term used to describe a decline in cognitive function severe enough to interfere with daily life. "Mild" dementia would be an early stage where symptoms are present but less severe.    ''',


      isDangerous: 'We regret to inform you that you are in critical condition. It is imperative that you visit a doctor.',
      treatment: 'No treatment necessary',
    ),

  ];


  Color c1 =Colors.white;
  Color c2 =Colors.white;
  Color c3 =Colors.white;
  Color c4 =Colors.white;
  Color c5 =Colors.white;
  Color c6 =Colors.white;
  Color c7 =Colors.white;
  List<Map<String, String>> skinConditions = [
    {
      'title': 'MILdDemented',
      'description': 'Actinic keratoses are scaly or crusty bumps that appear on areas of skin that get a lot of sun exposure, such as the face, ears, lips, back of the hands, forearms, scalp, and neck.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Actinic-Keratoses-AK-260x312.jpg',
    },
    {
      'title': 'ModerateDemented',
      'description': 'Basal cell carcinoma is a type of skin cancer that starts in the basal cells, which are found in the deepest layer of the epidermis. It usually appears as a waxy bump or a flesh-colored patch that grows slowly and rarely spreads to other parts of the body.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Basal-Cell-Carcinoma-BCC-260x312.jpg',
    },
    {
      'title': 'NonDemented',
      'description': 'Benign keratosis-like lesions are growths on the skin that are not cancerous. They can appear as rough, scaly patches or waxy, raised bumps, and are often mistaken for skin cancer.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Benign-Keratosis-Like-Lesions-260x312.jpg',
    },
    {
      'title': 'VeryMildDemented',
      'description': 'Dermatofibroma is a common, non-cancerous skin growth that usually appears on the arms and legs. It is a small, firm, reddish-brown bump that feels like a hard lump under the skin.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Dermatofibroma-260x312.jpg',
    },

  ];

  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker(); //allows us to pick image from gallery or camera

  @override
  void initState() {
    c1=Colors.white;
    c2=Colors.white;
    c3=Colors.white;
    c4=Colors.white;
    c5=Colors.white;
    c6=Colors.white;
    c7=Colors.white;
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    //dis function disposes and clears our memory
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    try{
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults:
        7, //the amout of categories our neural network can predict (here no. of animals)
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        _output = output!;
        _loading = false;
      });
      if(output?[0]['label']=='0 MILdDemented'){
        setState(() {
          c1=Colors.red;
          c2=Colors.white;
          c3=Colors.white;
          c4=Colors.white;
          c5=Colors.white;
          c6=Colors.white;
          c7=Colors.white;
          print(output?[0]['label']);
        });

      }
      if(output?[0]['label']=='1 ModerateDemented'){
        setState(() {
          c2=Colors.red;
          c1=Colors.white;
          c3=Colors.white;
          c4=Colors.white;
          c5=Colors.white;
          c6=Colors.white;
          c7=Colors.white;
          print(c1);
        });

      }
      if(output?[0]['label']=='2 NonDemented'){
        setState(() {
          c3=Colors.red;
          c2=Colors.white;
          c1=Colors.white;
          c4=Colors.white;
          c5=Colors.white;
          c6=Colors.white;
          c7=Colors.white;
          print(c1);
        });

      }
      if(output?[0]['label']=='3 VeryMildDemented'){
        setState(() {
          c4=Colors.red;
          c2=Colors.white;
          c3=Colors.white;
          c1=Colors.white;
          c5=Colors.white;
          c6=Colors.white;
          c7=Colors.white;
          print(c1);
        });

      }




    }catch(err){
      print("error "+err.toString());
    }

    //this function runs the model on the image


  }



  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
      model: 'assets/model3.tflite',
      labels: 'assets/labels.txt',
    );
  }

  pickImage() async {
    //this function to grab the image from camera
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    print("hello");
    classifyImage(_image);
    // _showDiseaseDialog2(context);
  }

  pickGalleryImage() async {
    try{

      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      setState(() {
        _image = File(image.path);
      });
      print("hello");
      classifyImage(_image);
      // _showDiseaseDialog2(context);
    }catch(err){
      print('error '+err.toString());
    }
    //this function to grab the image from gallery

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      body: Stack(
        children: <Widget>[



            Container(
              height: size.height * .3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/top_header.png')

                ),
              ),
            ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap:(){},
                          child: CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage(
                                'assets/icons/logo.png'),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'We Care',
                              style: TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[0]);
                          },
                          child: Card(
                            color: c1,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/1.png',
                                  height: 128,
                                ),
                                Text(
                                  'MILdDemented',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[1]);
                          },
                          child: Card(
                            color: c2,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/2.png',
                                  height: 128,
                                ),
                                Text(
                                  'ModerateDemented',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[2]);
                          },
                          child: Card(
                            color: c3,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/3.png',
                                  height: 128,
                                ),
                                Text(
                                  'NonDemented',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[3]);
                          },
                          child: Card(
                            color: c4,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/4.png',
                                  height: 128,
                                ),
                                Text(
                                  'VeryMildDemented',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),



                        // GestureDetector(
                        //   onTap:pickGalleryImage,
                        //   child:  Card(
                        //     color: c7,
                        //     shape:RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8)
                        //     ),
                        //     elevation: 4,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: <Widget>[
                        //         Image.asset(
                        //           'assets/images/picture.png',
                        //           height: 128,
                        //         ),
                        //         Text(
                        //           'choose image',
                        //           style: cardTextStyle,
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(onPressed:  pickGalleryImage,

                      child: Icon(Icons.photo_album),backgroundColor: Colors.blue,),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(onPressed:  pickImage,


                      child: Icon(Icons.camera),backgroundColor: Colors.blue,),
                  )

               
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
  void _showDiseaseDialog(BuildContext context, DiseaseInfo disease) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(disease.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(disease.description),
              SizedBox(height: 16.0),
              Text('Dangerous: ${disease.isDangerous}',),
              // SizedBox(height: 16.0),
              // Text('Treatment: ${disease.treatment}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close',  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
            ),
          ],
        );
      },
    );
  }

  void _showDiseaseDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Accuracy'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Accuracy is low'),
              SizedBox(height: 16.0),

            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}


