import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';
import 'components.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  String usern, pass, confirmPass;

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseDatabase.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final ref = fb.reference().child("login_data");
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.035),
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                usern = value;
              },
            ),
            RoundedPasswordField(
              hint: "Password",
              onChanged: (value) {
                pass = value;
              },
            ),
            RoundedPasswordField(
              hint: "Confirm Password",
              onChanged: (value) {
                confirmPass = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                if (pass == confirmPass) {
                  print("success");
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: "$usern@fitness.com", password: pass);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                    showAlertDialog(context,
                        "Your account has been created, you can now log in!");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showAlertDialog(context, "The password is too weak");
                    } else if (e.code == 'email-already-in-use') {
                      showAlertDialog(context,
                          "The account for that username already exists");
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                } else {
                  showAlertDialog(
                      context, "Your passwords do not match, please try again");
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String theText) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  String alertText;
  if (theText == "You have been logged in!") {
    alertText = "Success!";
  } else {
    alertText = "Alert!";
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(alertText),
    content: Text(theText),
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
