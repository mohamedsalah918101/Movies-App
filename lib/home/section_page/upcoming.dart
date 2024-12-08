import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/api/api_key.dart';
import 'package:http/http.dart' as http;

import '../../repeated/slider.dart';


class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List<Map<String, dynamic>> getUpcomingList = [];
  Future<void> getUpcoming() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var i = 0; i < json['results'].length; i++) {
        getUpcomingList.add({
          "poster_path": json['results'][i]['poster_path'],
          "name": json['results'][i]['title'],
          "vote_average": json['results'][i]['vote_average'],
          "Date": json['results'][i]['release_date'],
          "id": json['results'][i]['id'],
        });
      }
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUpcoming(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sliderList(getUpcomingList, "Upcoming", "movie", 20),
                  const Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, top: 15, bottom: 40),
                      child: Text("Many More Coming Soon... ", style: TextStyle(color: Colors.white),))
                ]);
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amber));
          }
        });
  }
}