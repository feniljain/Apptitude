import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rxdart/subjects.dart';

class RecordsPage extends StatefulWidget {
  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  File imageFile;

  List<bool> toggleList = <bool>[
    false,
    false,
    false,
    false,
    false,
  ];
  final BehaviorSubject<List<bool>> _toggleController =
      BehaviorSubject<List<bool>>.seeded(<bool>[
    false,
    false,
    false,
    false,
    false,
  ]);
  Stream<List<bool>> get toggleListStream => _toggleController.stream;
  List<bool> get toggleListValue => _toggleController.value;
  Future<void> toggleMode(int index) async {
    for (var i = 0; i < toggleList.length; i++) {
      if (i == index) {
        setState(() {
          toggleList[i] = !toggleList[i];
        });
      }
    }
    _toggleController.value = toggleList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 6.0),
                  child: Text(
                    'Hey Satyam!',
                    style: TextStyle(
                      color: Color(0xfff39c11),
                      fontSize: 33.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Let\'s get started with your tasks today',
                    style: TextStyle(
                      color: Color(0xfff39c11),
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff39c11),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'Records',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            _buildSettingsRow(
                              taskText: 'Mon, 20/07/2020',
                              widget: CircularPercentIndicator(
                                radius: 21.0,
                                lineWidth: 4.0,
                                percent: 0.5,
                                progressColor: Colors.green,
                              ),
                            ),
                            _buildSettingsRow(
                              taskText: 'Tues, 21/07/2020',
                              widget: CircularPercentIndicator(
                                radius: 21.0,
                                lineWidth: 4.0,
                                percent: 1.0,
                                progressColor: Colors.green,
                              ),
                            ),
                            _buildSettingsRow(
                              taskText: 'Wed, 22/07/2020',
                              widget: CircularPercentIndicator(
                                radius: 21.0,
                                lineWidth: 4.0,
                                percent: 0.7,
                                progressColor: Colors.green,
                              ),
                            ),
                            _buildSettingsRow(
                              taskText: 'Thrus, 23/07/2020',
                              widget: CircularPercentIndicator(
                                radius: 21.0,
                                lineWidth: 4.0,
                                percent: 0.3,
                                progressColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/RecordsPage.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow({
    @required String taskText,
    @required Widget widget,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    taskText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  widget,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 3.0,
          ),
        ],
      ),
    );
  }
}
