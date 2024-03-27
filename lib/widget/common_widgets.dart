
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:kanglei_taxi/conts/firebase/size_constants.dart';
import 'package:kanglei_taxi/conts/resposive_settings.dart';
import 'package:kanglei_taxi/conts/text_class.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'dart:math' as math;

import 'package:pinch_zoom/pinch_zoom.dart';
const List<Color> _kDefaultRainbowColors = const [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];
Widget LoadingWithoutProgress(String msg) {
  return Center(
    child: Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ResponsiveFile.height20 / 1.23),
        color: Colors.black.withOpacity(0.5), // Set background color with transparency
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOut,
              colors: _kDefaultRainbowColors,
              strokeWidth: 4.0,
              pathBackgroundColor: Colors.transparent, // Make the indicator background transparent
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "KANGLEI",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "TAXI",
                  style: TextStyle(
                    color: Color(0xffFFA700),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$msg",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  "........",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget ZoomPhoto(String url) {
  return Builder(builder: (context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            splashRadius: ResponsiveFile.height15,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Hero(
        tag: "imageSrc",
        child: PinchZoom(
          zoomEnabled: true,
          maxScale: 5.5,
          child: CachedNetworkImage(
              width: ResponsiveFile.screenWidth,
              height: ResponsiveFile.screenHeight,
              imageUrl: url,
              errorWidget: (context, url, error) =>const Icon(Icons.zoom_out_map_outlined)
          ),
        ),
      ),
    );
  });
}

Widget chatImage({
  required String imageSrc,
  required Function onTap,
  required String dateText,
}) {
  return Builder(builder: (context) {

    return GestureDetector(
      onTap: () {
        showDialog(
            context: (context),
            builder: (BuildContext context) {
              return ZoomPhoto(imageSrc);
            });
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveFile.height10 / 4),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent),
                borderRadius:
                BorderRadius.all(Radius.circular(ResponsiveFile.height10))),
            child: Hero(
              tag: "imageSrc",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ResponsiveFile.height10),
                child: CachedNetworkImage(
                  imageUrl: imageSrc,
                  width: Sizes.dimen_200,
                  height: Sizes.dimen_250,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.image_search_rounded),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 5,
              right: 0.1,
              child: Container(
                padding: EdgeInsets.all(ResponsiveFile.height10 / 6),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius:
                    BorderRadius.circular(ResponsiveFile.height10 / 2)),
                child: Text(dateText,
    style: Theme.of(context).textTheme.bodySmall
    )
              ))
        ],
      ),
    );
  });
}


class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget messageBubbleSender(
    {required String timeText,
    required String chatContent,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return Builder(
    builder: (context) {
      return Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: ResponsiveFile.height10),
                padding: EdgeInsets.all(ResponsiveFile.height10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ResponsiveFile.radius17),
                    bottomLeft: Radius.circular(ResponsiveFile.radius17),
                    bottomRight: Radius.circular(ResponsiveFile.radius17),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: chatContent,
                    style: DefaultTextStyle.of(context).style.merge(TextStyle(fontSize: ResponsiveFile.font16)),
                    children: <TextSpan>[
                      TextSpan(text: '  ' + timeText,
                        style: Theme.of(context).textTheme.caption?.merge(
                            TextStyle(
                              color: Colors.black54,
                              fontSize: ResponsiveFile.font20/2,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: ResponsiveFile.height10, right: 5),
                child: CustomPaint(painter: CustomShape(Colors.greenAccent))),
          ],
        ),
      );
    }
  );
}

Widget messageBubbleRecever(
    {required String timeText,
    required String chatContent,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return Builder(
    builder: (context) {
      return Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Container(
                margin: EdgeInsets.only(top: ResponsiveFile.height10, right: ResponsiveFile.height10),
                child: CustomPaint(
                  painter: CustomShape(Colors.deepPurpleAccent),
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: ResponsiveFile.height10),
                padding: EdgeInsets.all(ResponsiveFile.height10),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ResponsiveFile.radius17),
                    bottomLeft: Radius.circular(ResponsiveFile.radius17),
                    bottomRight: Radius.circular(ResponsiveFile.radius17),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: chatContent,
                    style: DefaultTextStyle.of(context).style.merge(TextStyle(fontSize: ResponsiveFile.font16,color: Colors.white)),
                    children: <TextSpan>[
                      TextSpan(text: '  ' + timeText,
                        style: Theme.of(context).textTheme.caption?.merge(
                            TextStyle(
                              color: Colors.white70,
                              fontSize: ResponsiveFile.font20/2,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  );
  // return Container(
  //   margin: const EdgeInsets.only(left: Sizes.dimen_8, top: Sizes.dimen_8, right: Sizes.dimen_8),
  //   decoration: BoxDecoration(
  //     color: Colors.greenAccent,
  //     border: Border.all(
  //         color: Colors.greenAccent),
  //     borderRadius: BorderRadius.circular(Sizes.dimen_10),
  //   ),
  //   child: Flexible(
  //     child: Row(
  //       children: [
  //         Container(
  //
  //           margin: margin,
  //           padding: const EdgeInsets.all(10),
  //           child: Text(
  //             chatContent,
  //             style: TextStyle(fontSize: Sizes.dimen_16, color: textColor),
  //           ),
  //         ),
  //         SizedBox(width: ResponsiveFile.height10,),
  //         Container(
  //           alignment: Alignment.bottomRight,
  //           margin: const EdgeInsets.only(right: 0.1),
  //           padding: const EdgeInsets.all(1),
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius:
  //               BorderRadius.circular(ResponsiveFile.height10 / 2)),
  //           child: AppText(
  //             textAlign: TextAlign.right,
  //             text: timeText,
  //             size: ResponsiveFile.height10/1.2,
  //           ),
  //
  //         ),
  //         Container( margin: EdgeInsets.only(top:10, left:20),child: CustomPaint(painter: CustomShape(Colors.greenAccent))),
  //       ],
  //     ),
  //   ),
  // );
}
