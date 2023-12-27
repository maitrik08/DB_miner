import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Quatedetail extends StatefulWidget {
  const Quatedetail({super.key});

  @override
  State<Quatedetail> createState() => _QuatedetailState();
}
String Quote = '';
String Author = '';
class _QuatedetailState extends State<Quatedetail> {
  List<String> Imges=[
    'assets/wp1.jpeg',
    'assets/wp2.jpeg',
    'assets/wp3.jpeg',
    'assets/wp4.jpeg',
  ];
  List<String> Font = [
    'Caveat',
    'DancingScript',
    'VariableFont',
    'Sevillana',
  ];
  static GlobalKey wallpperKey = GlobalKey();
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: wallpperKey,
        child: wallpaaper()
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _setWallpaper();
        },
        child: Text(
            'Set as wallpaper'
        ),
      )
    );
  }
  Widget wallpaaper(){
    return Stack(
      children: [
        Image.asset(
          Imges[random.nextInt(4)],
          height: double.infinity, // Set a fixed height
          width: double.infinity,  // Set a fixed width
          fit: BoxFit.fill,
        ),
        Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Quote,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: Font[random.nextInt(Font.length-1)]
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    '-$Author',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: Font[random.nextInt(Font.length-1)]
                    ),
                  ),
                ],
              ),
            )
        ),
      ],
    );
  }

  void _setWallpaper() async {
    try {
      RenderRepaintBoundary boundary =
      wallpperKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      File tempFile =
      File('${(await getExternalStorageDirectory())!.path}/screenshot.png');
      await tempFile.writeAsBytes(pngBytes);

      await AsyncWallpaper.setWallpaperFromFile(
          filePath: '${tempFile.path}');
      print('Wallpaper set successfully');

      Fluttertoast.showToast(
        msg: 'Wallpaper set successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error setting wallpaper: $e');
      Fluttertoast.showToast(
        msg: 'Error setting wallpaper',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
