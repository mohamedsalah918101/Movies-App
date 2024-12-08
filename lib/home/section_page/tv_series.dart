import 'package:flutter/material.dart';
import 'package:flutter_movies_app/api/api_links.dart';
import 'package:flutter_movies_app/repeated/slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  List<Map<String, dynamic>> popularTVSeries = [];
  List<Map<String, dynamic>> topRatedTVSeries = [];
  List<Map<String, dynamic>> onAirTVSeries = [];


  Future<void> tvSeriesFunction() async {
    var popularTVResponse = await http.get(Uri.parse(popularTVSeriesUrl));
    if (popularTVResponse.statusCode == 200) {
      var tempData = jsonDecode(popularTVResponse.body);
      var popularTVJson = tempData['results'];
      for (var i = 0; i < popularTVJson.length; i++) {
        popularTVSeries.add({
          'name': popularTVJson[i]['name'],
          'poster_path': popularTVJson[i]['poster_path'],
          'vote_average': popularTVJson[i]['vote_average'],
          'Date': popularTVJson[i]['first_air_date'],
          'id': popularTVJson[i]['id'],
        });
      }
    } else {
      print(popularTVResponse.statusCode);
    }

    var topRatedTVResponse = await http.get(Uri.parse(topRatedTVSeriesUrl));
    if (topRatedTVResponse.statusCode == 200) {
      var tempData = jsonDecode(topRatedTVResponse.body);
      var topRatedTVJson = tempData['results'];
      for (var i = 0; i < topRatedTVJson.length; i++) {
        topRatedTVSeries.add({
          'name': topRatedTVJson[i]['name'],
          'poster_path': topRatedTVJson[i]['poster_path'],
          'vote_average': topRatedTVJson[i]['vote_average'],
          'Date': topRatedTVJson[i]['first_air_date'],
          'id': topRatedTVJson[i]['id'],
        });
      }
    } else {
      print(topRatedTVResponse.statusCode);
    }

    var onAirTVResponse = await http.get(Uri.parse(onAirTVSeriesUrl));
    if (onAirTVResponse.statusCode == 200) {
      var tempData = jsonDecode(onAirTVResponse.body);
      var onAirTVJson = tempData['results'];
      for (var i = 0; i < onAirTVJson.length; i++) {
        onAirTVSeries.add({
          'name': onAirTVJson[i]['name'],
          'poster_path': onAirTVJson[i]['poster_path'],
          'vote_average': onAirTVJson[i]['vote_average'],
          'Date': onAirTVJson[i]['first_air_date'],
          'id': onAirTVJson[i]['id'],
        });
      }
    } else {
      print(onAirTVResponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tvSeriesFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sliderList(popularTVSeries, "Popular TV Series", "tv", 20,),
              sliderList(onAirTVSeries, "On the Air", "tv", 20,),
              sliderList(topRatedTVSeries, "Top Rated Series", "tv", 20,),
            ],
          );
        }
      },
    );
  }
}
