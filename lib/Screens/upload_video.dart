import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makeuc_project/Screens/components.dart';
import 'package:makeuc_project/Screens/home_screen.dart';
import 'package:makeuc_project/Screens/signup_screen.dart';
import 'package:uuid/uuid.dart';

class UploadVideo extends StatefulWidget {
  @override
  _UploadVideoState createState() => _UploadVideoState();
}

String title;
String desc;

class _UploadVideoState extends State<UploadVideo> {
  final fb = FirebaseDatabase.instance.reference().child("Videos Link");
  List<String> itemList = new List();
  FirebaseAuth auth = FirebaseAuth.instance;
  String email;
  String username;

  @override
  Widget build(BuildContext context) {
    email = auth.currentUser.email;
    username = email.split("@")[0];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Upload A Workout",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.035),
            ),
            RoundedInputField(
              hintText: "Title",
              onChanged: (value) {
                title = value;
              },
            ),
            RoundedInputField(
                hintText: "Description",
                onChanged: (value) {
                  desc = value;
                }),
            Text(
              "Upload the video by clicking the plus icon below.",
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: size.height * 0.017),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (title == null || title.length < 3) {
              showAlertDialog(context, "Invalid Title!");
            } else if (desc == null || desc.length < 5) {
              showAlertDialog(context, "Invalid Description!");
            } else {
              uploadToStorage();
            }
          },
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          )),
    );
  }

  Future uploadToStorage() async {
    var uuid = Uuid();
    dynamic id = uuid.v1();

    try {
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      String d = date.toString();
      email = auth.currentUser.email;
      username = email.split("@")[0];
      final file = await ImagePicker.pickVideo(source: ImageSource.gallery);
      showAlertDialog2(context);
      StorageReference ref =
          FirebaseStorage.instance.ref().child("video").child(id);
      StorageUploadTask uploadTask =
          ref.putFile(file, StorageMetadata(contentType: 'video/mp4'));
      var storageTaskSnapshot = await uploadTask.onComplete;
      var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();
      fb.child(id).set({
        "id": id,
        "link": url,
        "title": title,
        "Description": desc,
        "Author": username,
        "Date": d,
      }).then((value) {
        print("Uploaded to Firebase: $title : $desc " + url + "by $username");
        showAlertDialog1(context);
      });
    } catch (error) {
      print(error);
    }
  }
}

showAlertDialog1(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Uploaded"),
    content: Text("Your video has been uploaded!"),
    actions: [
      okButton,
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

showAlertDialog2(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Uploading"),
    content: Text(
        "Please wait, Your video is uploading, you will be notified when its uploaded!"),
    actions: [
      okButton,
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
