import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixelapp/data/data.dart';
import 'package:pixelapp/models/wallpaper_model.dart';
import 'package:pixelapp/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = false;

  TextEditingController searchController = new TextEditingController();
  List<WallpaperModel> wallpapers = [];

  getSearchgWallapers(String query) async {
    setState(() {
      isLoading = true;
    });

    wallpapers = [];
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getSearchgWallapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(hintText: "Search"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getSearchgWallapers(searchController.text);
                      },
                      child: Container(child: Icon(Icons.search)),
                    )
                  ],
                ),
              ),
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
