import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class ApiServices {
  String baseUrl = "https://api.pexels.com/v1/";

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/api_key.txt');
  }

  Future<List<PhotosModel>?> getTrendingWallpaper() async {
    String apiKey = await loadAsset();

    var url = Uri.parse('https://api.pexels.com/v1/curated?per_page=40&page=1');
    var response = await http.get(url, headers: {"Authorization": apiKey});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      List<PhotosModel> photos = [];
      jsonData["photos"].forEach((element) {
        // print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      return photos;
    } else {
      return null;
    }
  }

  Future<List<PhotosModel>?> getFutureWallpaper(String search) async {
    String apiKey = await loadAsset();

    var url = Uri.parse(
        'https://api.pexels.com/v1/search?query=$search&per_page=40&page=1');
    var response = await http.get(url, headers: {"Authorization": apiKey});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      List<PhotosModel> photos = [];
      jsonData["photos"].forEach((element) {
        // print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      return photos;
    } else {
      return null;
    }
  }

  Future<List<PhotosModel>?> getCategories(String category) async {
    String apiKey = await loadAsset();

    var url = Uri.parse(
        'https://api.pexels.com/v1/search?query=$category&per_page=40&page=1');
    var response = await http.get(url, headers: {"Authorization": apiKey});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      List<PhotosModel> photos = [];
      jsonData["photos"].forEach((element) {
        // print(element);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      return photos;
    } else {
      return null;
    }
  }
}
