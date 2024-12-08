import 'package:flutter/material.dart';
import 'package:flutter_movies_app/api/api_links.dart';
import 'package:flutter_movies_app/repeated/slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popularMovies = [];
  List<Map<String, dynamic>> topRatedMovies = [];
  List<Map<String, dynamic>> nowPlayingMovies = [];
  List<Map<String, dynamic>> upComingMovies = [];


  Future<void> moviesList() async {
    var popularMoviesResponse = await http.get(Uri.parse(popularMoviesUrl));
    if (popularMoviesResponse.statusCode == 200) {
      var tempData = jsonDecode(popularMoviesResponse.body);
      var popularMoviesJson = tempData['results'];
      for (var i = 0; i < popularMoviesJson.length; i++) {
        popularMovies.add({
          'name': popularMoviesJson[i]['title'],
          'poster_path': popularMoviesJson[i]['poster_path'],
          'vote_average': popularMoviesJson[i]['vote_average'],
          'Date': popularMoviesJson[i]['release_date'],
          'id': popularMoviesJson[i]['id'],
        });
      }
    } else {
      print(popularMoviesResponse.statusCode);
    }

    var topRatedMoviesResponse = await http.get(Uri.parse(topRatedMoviesUrl));
    if (topRatedMoviesResponse.statusCode == 200) {
      var tempData = jsonDecode(topRatedMoviesResponse.body);
      var topRatedMoviesJson = tempData['results'];
      for (var i = 0; i < topRatedMoviesJson.length; i++) {
        topRatedMovies.add({
          'name': topRatedMoviesJson[i]['title'],
          'poster_path': topRatedMoviesJson[i]['poster_path'],
          'vote_average': topRatedMoviesJson[i]['vote_average'],
          'Date': topRatedMoviesJson[i]['release_date'],
          'id': topRatedMoviesJson[i]['id'],
        });
      }
    } else {
      print(topRatedMoviesResponse.statusCode);
    }

    var nowPlayingMoviesResponse = await http.get(Uri.parse(nowPlayingMoviesUrl));
    if (nowPlayingMoviesResponse.statusCode == 200) {
      var tempData = jsonDecode(nowPlayingMoviesResponse.body);
      var nowPlayingMoviesJson = tempData['results'];
      for (var i = 0; i < nowPlayingMoviesJson.length; i++) {
        nowPlayingMovies.add({
          'name': nowPlayingMoviesJson[i]['title'],
          'poster_path': nowPlayingMoviesJson[i]['poster_path'],
          'vote_average': nowPlayingMoviesJson[i]['vote_average'],
          'Date': nowPlayingMoviesJson[i]['release_date'],
          'id': nowPlayingMoviesJson[i]['id'],
        });
      }
    } else {
      print(nowPlayingMoviesResponse.statusCode);
    }

    var upComingMoviesResponse = await http.get(Uri.parse(upcomingMoviesUrl));
    if (upComingMoviesResponse.statusCode == 200) {
      var tempData = jsonDecode(upComingMoviesResponse.body);
      var upComingMoviesJson = tempData['results'];
      for (var i = 0; i < upComingMoviesJson.length; i++) {
        upComingMovies.add({
          'name': upComingMoviesJson[i]['title'],
          'poster_path': upComingMoviesJson[i]['poster_path'],
          'vote_average': upComingMoviesJson[i]['vote_average'],
          'Date': upComingMoviesJson[i]['release_date'],
          'id': upComingMoviesJson[i]['id'],
        });
      }
    } else {
      print(upComingMoviesResponse.statusCode);
    }


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesList(),
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
              sliderList(popularMovies, "Popular Movies", "movie", 20,),
              sliderList(nowPlayingMovies, "Now Playing", "movie", 20,),
              sliderList(topRatedMovies, "Top Rated Movies", "movie", 20,),
              // sliderList(upComingMovies, "Upcoming Movies", "movie", 20,),
            ],
          );
        }
      },
    );
  }
}
