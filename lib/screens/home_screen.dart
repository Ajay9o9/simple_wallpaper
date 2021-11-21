import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wallpaper_app/api/api_services.dart';
import 'package:wallpaper_app/components/theme.dart';
import 'package:wallpaper_app/utils/app_utils.dart';
import 'package:wallpaper_app/components/theme_switch_icon.dart';
import 'package:wallpaper_app/model/data.dart';
import 'package:wallpaper_app/model/catergories_model.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/widgets/categories_tile.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<CategorieModel> categories = [];
  List<PhotosModel> photosModel = [];

  final ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    _deleteImageFromCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(context),
        leading: IconButton(
          onPressed: () {
            AppUtils.launchURL("https://github.com/Ajay9o9");
          },
          icon: FaIcon(FontAwesomeIcons.github),
          color: Colors.blue.shade700,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          ThemeSwitchIconButton(),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            searchView(context, searchController),
            const SizedBox(
              height: 10,
            ),
            authorView(),
            const SizedBox(
              height: 10,
            ),
            _categoryView(),
            _wallpaperListView(),
          ],
        ),
      ),
    );
  }

  Widget _categoryView() {
    return FadeInUp(
      delay: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 500),
      child: Container(
        height: 80,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24),
          itemCount: categories.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FadeInRight(
              delay: Duration(milliseconds: 400),
              duration: Duration(milliseconds: 300),
              child: CategoriesTile(
                imgUrls: categories[index].imgUrl.toString(),
                categorie: categories[index].categorieName.toString(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _wallpaperListView() {
    return FutureBuilder(
      future: _apiServices.getTrendingWallpaper(),
      builder: (context, snapshot) {
        print("data is ${snapshot.data}");
        if (snapshot.hasData) {
          List<PhotosModel> photosList = snapshot.data as List<PhotosModel>;
          return WallPaper(photosList, context, true);
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ThemeProvider.optionsOf<ThisThemeOptions>(context)
                  .appbarIconColor,
            ),
          );
        }
      },
    );
  }

  Widget authorView() {
    return FadeInUp(
      delay: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Made By ",
            style: TextStyle(fontSize: 12, fontFamily: 'Overpass'),
          ),
          GestureDetector(
            onTap: () {
              AppUtils.launchURL("https://github.com/Ajay9o9");
            },
            child: Container(
                child: Text(
              "Ajay K V",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Overpass'),
            )),
          ),
        ],
      ),
    );
  }

  Future _deleteImageFromCache() async {
    String url = "your url";
    await CachedNetworkImage.evictFromCache(url);
  }
}
