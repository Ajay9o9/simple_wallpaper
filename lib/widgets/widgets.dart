import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/route_manager.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wallpaper_app/utils/app_utils.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/components/theme.dart';

Widget searchView(
    BuildContext context, TextEditingController searchController) {
  return FadeInUp(
    delay: Duration(milliseconds: 400),
    duration: Duration(milliseconds: 500),
    child: Container(
      decoration: BoxDecoration(
        color: ThemeProvider.optionsOf<ThisThemeOptions>(context).searchBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: "search wallpapers", border: InputBorder.none),
          )),
          InkWell(
            onTap: () {
              if (searchController.text != "") {
                Get.toNamed('/search', arguments: searchController.text);
              }
            },
            child: Container(
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget brandName(BuildContext context) {
  return FadeInUp(
    delay: Duration(milliseconds: 300),
    duration: Duration(milliseconds: 500),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Wallpaper",
          style: TextStyle(
              color: ThemeProvider.optionsOf<ThisThemeOptions>(context)
                  .appBarTextColor,
              fontSize: 22,
              fontFamily: 'Overpass'),
        ),
        Text(
          "App",
          style: TextStyle(
              color: Colors.blue, fontSize: 22, fontFamily: 'Overpass'),
        )
      ],
    ),
  );
}

Widget WallPaper(
    List<PhotosModel> listPhotos, BuildContext context, bool isData) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        child: StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          itemCount: listPhotos.length,
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            log(listPhotos[index].src!.large);

            return FadeInUp(
              delay: Duration(milliseconds: index * 50),
              duration: Duration(milliseconds: (index * 50) + 800),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/image',
                      arguments: listPhotos[index].src!.large.toString());
                },
                child: Hero(
                  tag: listPhotos[index].src!.large.toString(),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        listPhotos[index].src!.large.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) =>
              new StaggeredTile.count(2, index.isEven ? 4 : 2),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      _footerView(),
    ],
  );
}

Widget _footerView() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Photos provided By ",
        style: TextStyle(
            color: Colors.black54, fontSize: 12, fontFamily: 'Overpass'),
      ),
      GestureDetector(
        onTap: () {
          AppUtils.launchURL("https://www.pexels.com/");
        },
        child: Container(
            child: Text(
          "Pexels",
          style: TextStyle(
              color: Colors.blue, fontSize: 12, fontFamily: 'Overpass'),
        )),
      )
    ],
  );
}
