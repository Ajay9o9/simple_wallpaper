import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wallpaper_app/model/data.dart';
import 'package:get/route_manager.dart';
import 'package:wallpaper_app/utils/app_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ScrollController _scrollController = ScrollController();

  IconData githubIcon = FontAwesomeIcons.githubSquare;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(seconds: splashImageUrls.length * 10),
          curve: Curves.linear);
    });

    super.initState();
    startSplashScreenTimer();
  }

  void startSplashScreenTimer() {
    Future.delayed(Duration(seconds: 3), () {
      // Get.offNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              controller: _scrollController,
              itemCount: splashImageUrls.length,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black,
                  child: Image.network(
                    splashImageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              staggeredTileBuilder: (indx) =>
                  new StaggeredTile.count(2, indx.isEven ? 2 : 4),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(1),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.network(
                      'https://images.pexels.com/lib/api/pexels-white.png',
                      // color: Colors.black,
                      height: 20,
                    ),
                    Text(
                      "WallPaper App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Made By Ajay9o9",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      splashColor: Colors.green,
                      onTap: () {
                        AppUtils.launchURL("https://github.com/Ajay9o9");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('github.com/Ajay9o9',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: () {
                              AppUtils.launchURL("https://github.com/Ajay9o9");
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.githubAlt,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
