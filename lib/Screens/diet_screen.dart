import 'package:flutter/material.dart';

class DietScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Floating App Bar';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diet"),
        ),
        backgroundColor: Colors.white,
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        body: CustomScrollView(
          slivers: <Widget>[
            // SliverAppBar(
            //   title: Text("Diet Of The Day"),
            //   backgroundColor: Colors.purpleAccent,
            //   floating: true,
            //   flexibleSpace: Placeholder(),
            //   expandedHeight: 20
            // ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Image(
                    image: NetworkImage(
                        'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/01/AN8-Eggs_on_Fryingpan-1296x728-header-1296x728.jpg?h=1528'),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 36),
                      children: <TextSpan>[
                        TextSpan(
                            text: '1. Avoid sugar and sugar-sweetened drinks\n',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text:
                                'Foods with added sugars are bad for your health. Eating a lot of these types of food can cause weight gain.Studies show that added sugar has uniquely harmful effects on metabolic health (3Trusted Source).Numerous studies have indicated that excess sugar, mostly due to the large amounts of fructose, can lead to fat building up around your abdomen and liver (6).Sugar is half glucose and half fructose. When you eat a lot of added sugar, the liver gets overloaded with fructose and is forced to turn it into fat (4Trusted Source, 5).Some believe that this is the main process behind sugar’s harmful effects on health. It increases abdominal fat and liver fat, which leads to insulin resistance and various metabolic problems (7Trusted Source).Liquid sugar is worse in this regard. The brain doesn’t seem to register liquid calories in the same way as solid calories, so when you drink sugar-sweetened beverages, you end up eating more total calories (8Trusted Source, 9Trusted Source). '),
                        //TextSpan(text: 'com', style: TextStyle(decoration: TextDecoration.underline))
                      ],
                    ),
                    textScaleFactor: 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
