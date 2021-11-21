import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wallpaper_app/api/api_services.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/components/theme.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices _apiServices = ApiServices();
  String searchTxt = "";
  TextEditingController searchController = TextEditingController();
  List<PhotosModel> _photosModel = [];

  @override
  void initState() {
    super.initState();
    searchTxt = Get.arguments;
    searchController.text = searchTxt;
    getInitialData();
  }

  void getInitialData() async {
    _photosModel = (await _apiServices.getFutureWallpaper(searchTxt))!;
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
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: ThemeProvider.optionsOf<ThisThemeOptions>(context)
                      .searchBgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () async {
                          _photosModel = (await _apiServices
                              .getFutureWallpaper(searchController.text))!;
                          setState(() {});
                        },
                        child:  const Icon(Icons.search))
                  ],
                ),
              ),
             const SizedBox(
                height: 30,
              ),
              WallPaper(_photosModel, context, true),
            ],
          ),
        ),
      ),
    );
  }
}
