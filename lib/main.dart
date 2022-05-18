import 'package:barcode_scanner_example/helper/error_handler.dart';
import 'package:barcode_scanner_example/page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  customError();
  
  // RenderErrorBox.backgroundColor = Colors.amber;
  ErrorWidget.builder = ((FlutterErrorDetails details) => Container(
        color: Colors.green,
      ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Barcode Scanner';

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Colors.green,
          scaffoldBackgroundColor: Colors.black,
        ),
        home:
        // BarcodeCreatePage()
        // ScanBarcode()
         Welcome()
        // MainPage(title: title),
      );
}

