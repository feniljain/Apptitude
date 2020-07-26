import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File imageFile;
  String keyWord = 'shoe';
  String sentence = 'Find a shoe and take a photo of it';

  IconData status = Icons.file_upload;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff39c11),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 6.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Daily Challenge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 39.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(),
              child: Text(
                'Today\'s Question',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10.0,
                bottom: 24.0,
              ),
              child: Text(
                sentence,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.symmetric(horizontal: 18.0),
              padding: EdgeInsets.all(12.0),
              color: Color(0xffffc668),
              child: imageFile == null
                  ? Center(
                      child: Text(
                        "No image selected!",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Image.file(imageFile),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: loading
                              ? CircularProgressIndicator()
                              : Icon(
                                  status,
                                  color: Colors.blue,
                                  size: 39.0,
                                ),
                        ),
                      ],
                    ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 18.0,
              ),
              width: double.infinity,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ButtonTheme(
                  height: MediaQuery.of(context).size.height * 0.08,
                  minWidth: MediaQuery.of(context).size.width * 0.7,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      File imgFile = await FilePicker.getFile();
                      setState(() {
                        imageFile = imgFile;
                      });
                      final FirebaseVisionImage visionImage =
                          FirebaseVisionImage.fromFile(imageFile);
                      final ImageLabeler cloudLabeler =
                          FirebaseVision.instance.cloudImageLabeler();
                      final List<ImageLabel> labels =
                          await cloudLabeler.processImage(visionImage);
                      for (ImageLabel label in labels) {
                        final String text = label.text;
                        final String entityId = label.entityId;
                        final double confidence = label.confidence;
                        if (confidence > 0.75) {
                          print(text.toLowerCase());
                          print(keyWord);
                          print(confidence);
                          print(text.toLowerCase().contains(keyWord));
                          if (text.toLowerCase().contains(keyWord)) {
                            setState(() {
                              status = Icons.done;
                              loading = false;
                            });
                            break;
                          } else {
                            setState(() {
                              status = Icons.cancel;
                              loading = false;
                            });
                          }
                        }
                      }
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
