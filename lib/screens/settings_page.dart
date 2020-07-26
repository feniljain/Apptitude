import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                  height: MediaQuery.of(context).size.height * 0.7,
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
                              'Settings',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            _buildSettingsCheckRow(
                              taskText: 'Rewards',
                              value: toggleList[0],
                              changeValue: (value) {
                                toggleMode(0);
                              },
                            ),
                            _buildSettingsCheckRow(
                              taskText: 'Streaks',
                              value: toggleList[1],
                              changeValue: (value) {
                                toggleMode(1);
                              },
                            ),
                            _buildSettingsRow(
                                taskText: 'Number Of Questions', txt: '5'),
                            _buildSettingsRow(
                                taskText: 'Timer', txt: '10:00 AM'),
                          ],
                        ),
                      ),
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

  Widget _buildSettingsCheckRow({
    @required String taskText,
    @required Function changeValue,
    @required bool value,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
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
              Switch(
                value: value,
                onChanged: changeValue,
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

  Widget _buildSettingsRow({
    @required String taskText,
    @required String txt,
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
                  Text(
                    txt,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
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
