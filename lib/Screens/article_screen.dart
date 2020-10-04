import 'package:makeuc_project/Screens/components.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List<Map> articles = [
  {
    "title": "Workout Motivation Tips!",
    "author": "Daily Burn",
    "time": "12 min read",
    "link": "https://dailyburn.com/life/fitness/workout-motivation-tips/",
    "src": "assets/icons/workout_motivation.svg",
  },
  {
    "title": "How to train your lower body?",
    "author": "Open Fit",
    "time": "10 min read",
    "link": "https://www.openfit.com/lower-body-workout-exercises",
    "src": "assets/icons/lower_body.svg",
  },
  {
    "title": "Best upper body exercises",
    "author": "Open Fit",
    "time": "8 min read",
    "link": "https://www.openfit.com/best-upper-body-workout",
    "src": "upper_body.svg"
  },
  {
    "title": "How to gain muscle faster",
    "author": "Spartan",
    "time": "12 min read",
    "link": "https://www.spartan.com/blogs/unbreakable-nutrition/grow-muscle",
  },
  {
    "title": "Losing Weight Faster",
    "author": "Diet Doctor",
    "time": "7 min read",
  },
];

class ArticleScreen extends StatelessWidget {
  final Color primaryColor = Color(0xffFD6592);
  final Color bgColor = Color(0xffF9E0E3);
  final Color secondaryColor = Color(0xff324558);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Theme(
        data: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: secondaryColor),
            actionsIconTheme: IconThemeData(
              color: secondaryColor,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).buttonColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Articles'),
            leading: Icon(Icons.category),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return _buildArticleItem(index);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBar(active: "Articles"),
        ),
      ),
    );
  }

  Widget _buildArticleItem(int index) {
    Map article = articles[index];
    // final String sample = images[2];
    final String sample = 'Image';
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
                Container(
                  height: 100,
                  color: Colors.blue,
                  width: 80.0,
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async => await _launchURL(article["link"]),
                        child: Text(
                          article["title"],
                          textAlign: TextAlign.justify,
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
                                text: article["author"],
                                style: TextStyle(fontSize: 16.0)),
                            WidgetSpan(
                              child: const SizedBox(width: 20.0),
                            ),
                            WidgetSpan(
                              child: const SizedBox(width: 5.0),
                            ),
                            TextSpan(
                              text: article["time"],
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

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
