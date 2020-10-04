import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeuc_project/Screens/evaluation_screen.dart';
import 'package:uuid/uuid.dart';

class UploadFinalScreen extends StatefulWidget {
  @override
  _UploadFinalScreenState createState() => _UploadFinalScreenState();
}

class _UploadFinalScreenState extends State<UploadFinalScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You have completed the workout! Upload a video of yourself doing the workout by clicking the plus icon below!",
              // "Congratulations, you have completed the workout! Click the button to go back to the home screen!",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.035),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAlertDialog1(context);
          },
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          )),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return HomeScreen();
      //           },
      //         ),
      //       );
      //     },
      //     child: Icon(Icons.arrow_forward)),
    );
  }

  Future uploadToFB() async {
    var uuid = Uuid();
    dynamic id = uuid.v1();

    try {
      final file = await ImagePicker.pickVideo(source: ImageSource.gallery);
      if (file != null) {
        showAlertDialog1(context);
      }
    } catch (error) {
      print(error);
    }
  }

  showAlertDialog1(BuildContext context) {
    // set up the button
    Widget nextButton = FlatButton(
      child: Text("Next"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EvaluationScreen();
            },
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Awesome!"),
      content: Text("Click next to see your results!"),
      actions: [
        nextButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
