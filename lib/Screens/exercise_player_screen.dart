import 'package:flutter/material.dart';
import 'package:makeuc_project/Screens/upload_final_screen.dart';
import 'package:video_player/video_player.dart';

class ExercisePlayerScreen extends StatefulWidget {
  final String mainTitle;
  final String videoUrl;

  ExercisePlayerScreen(
    this.mainTitle,
    this.videoUrl,
  ) : super();

  @override
  ExercisePlayerScreenState createState() => ExercisePlayerScreenState();
}

class ExercisePlayerScreenState extends State<ExercisePlayerScreen> {
  //
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl);
    // _controller = VideoPlayerController.asset("assets/videos/running.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(1.0);
    super.initState();

    void checkVideo() {
      // Implement your calls inside these conditions' bodies :
      if (_controller.value.position ==
          Duration(seconds: 0, minutes: 0, hours: 0)) {
        print('video Started');
      }

      if (_controller.value.position == _controller.value.duration) {
        print('video Ended');
        showAlertDialog1(context);
      }
    }

    _controller.addListener(checkVideo);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mainTitle),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
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
              return UploadFinalScreen();
            },
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Awesome!"),
      content: Text("Congratulations! You have completed the workout!!"),
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
