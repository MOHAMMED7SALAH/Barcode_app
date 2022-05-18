import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:davinci/davinci.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class BarcodeCreatePage extends StatefulWidget {
  @override
  _BarcodeCreatePageState createState() => _BarcodeCreatePageState();
}

class _BarcodeCreatePageState extends State<BarcodeCreatePage> {
  final controller = TextEditingController();
  GlobalKey imageKey;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(179, 117, 241, 79),
              const Color(0xFF00CCFF),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Davinci(builder: (key) {
                  ///3. set the widget key to the globalkey
                  imageKey = key;
                  return Container(
                    
                    child: BarcodeWidget(
                     
                      data: controller.text.isEmpty  ? 'hello' :  controller.text,
                      backgroundColor: Colors.black,
                      color: Colors.white,
                      barcode: controller.text.contains(RegExp(
                              r'[^\p{Arabic}\w\s]',
                              caseSensitive: true,
                              multiLine: false))
                          ? Barcode.pdf417()
                          : Barcode.code128(),
                      width: 200,
                      height: 200,
                      errorBuilder: (BuildContext context, String error) {
                        return Center(
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                      drawText: false,
                    ),
                  );
                }),
              ),
              SizedBox(height: size.height * .1,),
              
              Row(
                children: [
                  Expanded(child: buildTextField(context)),
                  const SizedBox(width: 12),
                  FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.done, size: 30),
                    onPressed: () => setState(() {}),
                  )
                ],
              ),
               SizedBox(height: size.height * .1,),
              InkWell(
                onTap: () async {
                    Get.showSnackbar(const GetSnackBar(
                      titleText: Center(
                          child: Text('Congratulation 🥳🎉',
                              style: TextStyle(color: Colors.white))),
                      messageText: Center(
                        child: Text(
                          "The QR code photo is in your gallerie",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      duration: Duration(seconds: 7),
                      snackPosition: SnackPosition.TOP,
                      margin: EdgeInsets.only(top: 100.0),
                      backgroundColor: Colors.green,
                      borderRadius: 20,
                      isDismissible: true,
                      dismissDirection: DismissDirection.horizontal,
                      forwardAnimationCurve: Curves.easeOutBack,
                    ));
                   
                    await DavinciCapture.click(imageKey,
                        fileName: "code",
                        saveToDevice: true,
                        openFilePreview: true,
                        albumName: 'QR code');
                  },
                child: Container(
                  height: size.width * .12,
                  width: size.width * .7,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Download Barcode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildTextField(BuildContext context) => TextField(
        controller: controller ,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: 'Enter the data',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            
            borderSide: BorderSide(color: Colors.white, ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white, ),
          ),
        ),
      );
}
