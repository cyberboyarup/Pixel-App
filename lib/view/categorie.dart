import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pixelapp/data/data.dart';
import 'package:pixelapp/models/wallpaper_model.dart';
import 'package:pixelapp/widget/widget.dart';

class Categories extends StatefulWidget {
  final String categorieName, imgUrl;
  Categories({required this.categorieName, required this.imgUrl});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<WallpaperModel> wallpapers = [];

  getSearchgWallapers(String query) async {
    var response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$query&per_page=250&page=1'),
        headers: {"Authorization": apiKey});
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);

      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchgWallapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              wallpapersList(wallpapers, context),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
