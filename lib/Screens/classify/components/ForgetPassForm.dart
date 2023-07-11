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
  final bool isDangerous;
  final String treatment;

  DiseaseInfo({required this.name, required this.description, required this.isDangerous, required this.treatment});
}

class _TfliteModel extends State<TfliteModel> {
  final List<DiseaseInfo> diseases = [
    DiseaseInfo(
      name: 'Actinic keratoses',
      description: '''
      Actinic keratoses (AKs) are rough, scaly patches of skin that develop in areas exposed to sun over time, such as the face, scalp, ears, neck, and hands. They are precancerous and can potentially develop into skin cancer. AKs can be treated with cryotherapy, topical medications, chemical peels, photodynamic therapy, and surgical removal. Protection from sun exposure is also important to prevent further damage.
      ''',
      isDangerous: false,
      treatment: 'Cryotherapy, Topical Medications',
    ),
    DiseaseInfo(
      name: 'Basal cell carcinoma',
      description: '''
      Basal cell carcinoma (BCC) is the most common type of skin cancer that develops in the basal cells, which are located in the lower part of the epidermis (the outermost layer of skin). BCCs usually appear as flesh-colored or pink bumps or patches that may bleed, crust over, or develop a central depression. They are typically slow-growing and rarely spread to other parts of the body. Treatment for BCCs includes surgical removal, radiation therapy, and topical medications. BCCs are often caused by long-term exposure to the sun and can be prevented by taking protective measures such as wearing sunscreen and avoiding prolonged sun exposure.
      ''',
      isDangerous: true,
      treatment: 'Surgery, Radiation, Topical Medications',
    ),
    DiseaseInfo(
      name: 'Benign keratosis-like lesions',
      description: '''
      Benign keratosis-like lesions (BKLLs) are harmless growths on the skin that often develop in older adults. They can appear as rough, scaly patches or plaques that are white, pink, or brown in color and may be mistaken for actinic keratoses or other types of skin lesions. BKLLs are typically asymptomatic and do not require treatment, although they can be removed for cosmetic reasons. The exact cause of BKLLs is unknown, but they may be related to long-term sun exposure, genetics, or other factors. Protective measures such as wearing sunscreen and avoiding prolonged sun exposure can help prevent the development of BKLLs and other types of skin lesions.
      ''',
      isDangerous: false,
      treatment: 'No treatment necessary',
    ),
    DiseaseInfo(
      name: 'Dermatofibroma',
      description: '''
      Dermatofibroma is a common benign skin lesion that typically appears as a small, firm bump on the skin. It is also known as a benign fibrous histiocytoma or a sclerosing hemangioma. Dermatofibromas are most commonly found on the legs, but can also appear on the arms, trunk, and other parts of the body.

The exact cause of dermatofibroma is unknown, but it is believed to be a reaction to a minor injury or irritation, such as an insect bite or a splinter. Dermatofibromas typically do not cause any symptoms, but they may be itchy or tender to the touch.

Dermatofibromas are usually diagnosed based on their appearance and location, and a biopsy may be performed to confirm the diagnosis. Treatment is usually not necessary, as dermatofibromas are benign and do not pose a health risk. However, if a dermatofibroma is causing discomfort or is located in a cosmetically sensitive area, it can be surgically removed.
      ''',
      isDangerous: false,
      treatment: 'No treatment necessary',
    ),
    DiseaseInfo(
      name: 'Melanocytic nevi',
      description: '''
      Melanocytic nevi, commonly known as moles, are benign (non-cancerous) growths on the skin that are caused by the proliferation of melanocytes, the cells that produce pigment in the skin. Melanocytic nevi can occur anywhere on the body and can vary in size, shape, and color. While most melanocytic nevi are harmless and do not require treatment, some may develop into melanoma, a type of skin cancer.
      ''',
      isDangerous: false,
      treatment: 'No treatment necessary',
    ),
    DiseaseInfo(
      name: 'Melanoma',
      description: '''
      Melanoma is a type of skin cancer that develops in the cells that produce pigment in the skin, called melanocytes. It typically appears as a dark, irregularly shaped mole or patch on the skin, and may bleed or develop a crust. Melanoma is the most serious type of skin cancer and can be life-threatening if not detected and treated early. Risk factors for melanoma include long-term sun exposure, a history of sunburns, and a family history of the disease.
      ''',
      isDangerous: true,
      treatment: 'Surgery, Chemotherapy, Immunotherapy',
    ),
    DiseaseInfo(
      name: 'Vascular lesions',
      description: '''
      Vascular lesions are a group of skin conditions characterized by abnormal blood vessels in the skin. They can include hemangiomas, which are clusters of small blood vessels that form a red or purple bump on the skin, and port-wine stains, which are flat, red or purple birthmarks caused by abnormal blood vessels. Vascular lesions are usually not a cause for concern, but they may be removed if they are causing discomfort or are located in a cosmetically sensitive area.0
      ''',
      isDangerous: false,
      treatment: 'Laser Therapy, Surgery, Sclerotherapy',
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
      'title': 'Actinic keratoses',
      'description': 'Actinic keratoses are scaly or crusty bumps that appear on areas of skin that get a lot of sun exposure, such as the face, ears, lips, back of the hands, forearms, scalp, and neck.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Actinic-Keratoses-AK-260x312.jpg',
    },
    {
      'title': 'Basal cell carcinoma',
      'description': 'Basal cell carcinoma is a type of skin cancer that starts in the basal cells, which are found in the deepest layer of the epidermis. It usually appears as a waxy bump or a flesh-colored patch that grows slowly and rarely spreads to other parts of the body.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Basal-Cell-Carcinoma-BCC-260x312.jpg',
    },
    {
      'title': 'Benign keratosis-like lesions',
      'description': 'Benign keratosis-like lesions are growths on the skin that are not cancerous. They can appear as rough, scaly patches or waxy, raised bumps, and are often mistaken for skin cancer.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Benign-Keratosis-Like-Lesions-260x312.jpg',
    },
    {
      'title': 'Dermatofibroma',
      'description': 'Dermatofibroma is a common, non-cancerous skin growth that usually appears on the arms and legs. It is a small, firm, reddish-brown bump that feels like a hard lump under the skin.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Dermatofibroma-260x312.jpg',
    },
    {
      'title': 'Melanocytic nevi',
      'description': 'Melanocytic nevi, also known as moles, are a type of skin growth that develops when pigment cells (melanocytes) grow in clusters. They can be flat or raised, and can vary in color from pink to brown to black.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Melanocytic-Nevi-260x312.jpg',
    },
    {
      'title': 'Melanoma',
      'description': 'Melanoma is a type of skin cancer that develops in the cells that produce pigment (melanocytes). It can spread quickly to other parts of the body, and is the deadliest form of skin cancer. Melanoma often appears as a dark, irregularly shaped mole or patch on the skin.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Melanoma-260x312.jpg',
    },
    {
      'title': 'Vascular lesions',
      'description': 'Vascular lesions are abnormalities of the blood vessels that appear on the skin. They can be red, blue, or purple in color, and can appear as birthmarks, spider veins, or port-wine stains.',
      'imageUrl': 'https://www.skincancer.org/wp-content/uploads/2019/05/Vascular-Lesions-260x312.jpg',
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
    //this function runs the model on the image
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
    if(output?[0]['label']=='0 Actinic keratoses'){
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
    if(output?[0]['label']=='1 Basal cell carcinoma'){
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
    if(output?[0]['label']=='2 Benign keratosis-like lesions'){
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
    if(output?[0]['label']=='3 Dermatofibroma'){
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
    if(output?[0]['label']=='4 Melanocytic nevi'){
      setState(() {
        c5=Colors.red;
        c2=Colors.white;
        c3=Colors.white;
        c4=Colors.white;
        c1=Colors.white;
        c6=Colors.white;
        c7=Colors.white;
        print(c1);
      });

    }
    if(output?[0]['label']=='5 Melanoma'){
      setState(() {
        c6=Colors.red;
        c2=Colors.white;
        c3=Colors.white;
        c4=Colors.white;
        c5=Colors.white;
        c1=Colors.white;
        c7=Colors.white;
        print(c1);
      });

    }
    if(output?[0]['label']=='6 Vascular lesions'){
      setState(() {
        c7=Colors.red;
        c2=Colors.white;
        c3=Colors.white;
        c4=Colors.white;
        c5=Colors.white;
        c6=Colors.white;
        c1=Colors.white;
        print(c1);
      });

    }
  }



  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
      model: 'assets/model2.tflite',
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
    classifyImage(_image);
    _showDiseaseDialog2(context);
  }

  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
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
                                'assets/logo.png'),
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
                              'Disease detector',
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
                                  'assets/images/s1.png',
                                  height: 128,
                                ),
                                Text(
                                  'Actinic keratoses',
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
                                  'assets/images/s2.png',
                                  height: 128,
                                ),
                                Text(
                                  'Basal cell carcinoma',
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
                                  'assets/images/s3.png',
                                  height: 128,
                                ),
                                Text(
                                  'Benign keratosis',
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
                                  'assets/images/s4.png',
                                  height: 128,
                                ),
                                Text(
                                  'Dermatofibroma',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[4]);
                          },
                          child: Card(
                            color: c5,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/s5.png',
                                  height: 128,
                                ),
                                Text(
                                  'Melanocytic nevi',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[5]);
                          },
                          child: Card(
                            color: c6,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/s6.png',
                                  height: 128,
                                ),
                                Text(
                                  'Melanoma',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _showDiseaseDialog(context, diseases[6]);
                          },
                          child: Card(
                            color: c7,
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/s7.png',
                                  height: 128,
                                ),
                                Text(
                                  'Vascular lesions',
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
              Text('Dangerous: ${disease.isDangerous ? 'Yes' : 'No'}'),
              SizedBox(height: 16.0),
              Text('Treatment: ${disease.treatment}'),
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


