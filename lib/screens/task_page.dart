import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rxdart/subjects.dart';

import 'word_page.dart';
import 'scan_page.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
    return Container(
      child: Stack(
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
                              'Tasks',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            _buildTaskRows(
                              taskText: 'Watch Pinnochio Movie',
                              showArrow: false,
                              value: toggleList[0],
                              changeValue: (value) {
                                toggleMode(0);
                              },
                            ),
                            _buildTaskRows(
                              taskText: 'Eat Fruits',
                              showArrow: false,
                              value: toggleList[1],
                              changeValue: (value) {
                                toggleMode(1);
                              },
                            ),
                            _buildTaskRows(
                              taskText: 'Homework',
                              showArrow: false,
                              value: toggleList[2],
                              changeValue: (value) {
                                toggleMode(2);
                              },
                            ),
                            _buildTaskRows(
                              taskText: 'Daily Challange',
                              showArrow: true,
                              value: toggleList[3],
                              changeValue: (value) {
                                toggleMode(3);
                              },
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScanPage(),
                                  ),
                                );
                              },
                            ),
                            _buildTaskRows(
                                taskText: 'Word of the day',
                                showArrow: true,
                                value: toggleList[4],
                                changeValue: (value) {
                                  toggleMode(4);
                                },
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WordPage(),
                                    ),
                                  );
                                }),
                            //_buildTaskRows1(taskText: 'Homework'),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset('assets/TaskPage1.png'),
                          Container(
                            margin: EdgeInsets.only(
                              left: 18.0,
                              right: 18.0,
                              top: 15.0,
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: 
                            CircularPercentIndicator(
                              radius: 120.0,
                              lineWidth: 12.0,
                              percent: _percentTaskComplete(),
                              center: Text(_stringTaskComplete()),
                              progressColor: Color(0xffffc668),
                            ),
                          ),
                          Image.asset('assets/TaskPage2.png'),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 18.0,
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              'Reward: 100 Curos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Strike: 3 day(s)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
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
          ),
        ],
      ),
    );
  }

  Widget _buildTaskRows({
    @required String taskText,
    @required Function changeValue,
    @required bool showArrow,
    @required bool value,
    Function onPressed,
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
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: Checkbox(
                      value: value,
                      onChanged: changeValue,
                      checkColor: Colors.white,
                      activeColor: Colors.transparent,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                    ),
                  ),
                  Text(
                    taskText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              !showArrow
                  ? Container()
                  : GestureDetector(
                      onTap: onPressed,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
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

  double _percentTaskComplete() {
    var sum = 0;
    var total = toggleList.length;
    for (int i = 0; i < toggleList.length; i++) {
      if (toggleList[i]) {
        sum += 1;
      }
    }

    return sum / total;
  }

  String _stringTaskComplete() {
    var sum = 0;
    var total = toggleList.length;
    for (int i = 0; i < toggleList.length; i++) {
      if (toggleList[i]) {
        sum += 1;
      }
    }

    return '$sum / $total';
  }

  Widget _buildTaskRows1({
    @required String taskText,
    @required bool showArrow,
    Function onPressed,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          CheckboxListTile(
            onChanged: (bool) {},
            value: false,
            title: Text(
              taskText,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            checkColor: Colors.white,
            activeColor: Colors.transparent,
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
