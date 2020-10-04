import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makeuc_project/Screens/exercise_player_screen.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  Query _ref;
  final Color primaryColor = Color(0xffFD6592);
  final Color bgColor = Color(0xffF9E0E3);
  final Color secondaryColor = Color(0xff324558);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Videos Link')
        .orderByChild('Date');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workouts'),
        ),
        body: Container(
            color: Color(0xffF9E0E3),
            height: double.infinity,
            child: FirebaseAnimatedList(
              query: _ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map exercises = snapshot.value;

                return _buildExerciseItem(exercises: exercises);
              },
            )));
  }

  Widget _buildExerciseItem({Map exercises}) {
    // final String sample = images[2];
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            color: bgColor,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/muscles.svg",
                  color: Colors.blue,
                  width: 80.0,
                ),
                // const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ExercisePlayerScreen(
                                    exercises['title'], exercises['link']);
                              },
                            ),
                          );
                        },
                        child: Text(
                          exercises["title"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: CircleAvatar(
                                radius: 10.0,
                                backgroundColor: primaryColor,
                              ),
                            ),
                            WidgetSpan(
                              child: const SizedBox(width: 5.0),
                            ),
                            TextSpan(
                                text:
                                    "${exercises["Author"][0].toUpperCase()}${exercises["Author"].substring(1)}",
                                style: TextStyle(fontSize: 16.0)),
                            // WidgetSpan(
                            //   child: const SizedBox(width: 20.0),
                            // ),
                            // WidgetSpan(
                            //   child: const SizedBox(width: 5.0),
                            // ),
                            TextSpan(
                              text: "\n" + exercises["Description"],
                            ),
                          ],
                        ),
                        style: TextStyle(height: 2.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
