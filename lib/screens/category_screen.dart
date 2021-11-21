import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wallpaper_app/api/api_services.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/components/theme.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ApiServices _apiServices = ApiServices();
  String categoryTxt = "";
  List<PhotosModel> _photosModel = [];

  @override
  void initState() {
    super.initState();
    categoryTxt = Get.arguments;
    getInitialData();
  }

  void getInitialData() async {
    _photosModel = (await _apiServices.getFutureWallpaper(categoryTxt))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: brandName(context),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ThemeProvider.optionsOf<ThisThemeOptions>(context)
                .appbarIconColor,
          ),
          onPressed: () {
            Get.offNamed('/home');
          },
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 6,
              ),
              WallPaper(_photosModel, context, true),
            ],
          ),
        ),
      ),
    );
  }
}
