import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/api/api_key.dart';
import 'package:flutter_movies_app/home/home_page.dart';
import 'package:flutter_movies_app/repeated/slider.dart';
import 'package:flutter_movies_app/repeated/user_review.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../repeated/trailer_ui.dart';

class MovieDetails extends StatefulWidget {
  final dynamic movieID;

  const MovieDetails({super.key, required this.movieID});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<Map<String, dynamic>> MovieDetails = [];
  List<Map<String, dynamic>> UserREviews = [];
  List<Map<String, dynamic>> similarmovieslist = [];
  List<Map<String, dynamic>> recommendedmovieslist = [];
  List<Map<String, dynamic>> movietrailerslist = [];

  List MoviesGeneres = [];

  Future<void> MoviesDetails() async {
    var moviedetailurl =
        'https://api.themoviedb.org/3/movie/${widget.movieID}?api_key=$apiKey';
    var UserReviewurl =
        'https://api.themoviedb.org/3/movie/${widget
        .movieID}/reviews?api_key=$apiKey';
    var similarmoviesurl =
        'https://api.themoviedb.org/3/movie/${widget
        .movieID}/similar?api_key=$apiKey';
    var recommendedmoviesurl =
        'https://api.themoviedb.org/3/movie/${widget
        .movieID}/recommendations?api_key=$apiKey';
    var movietrailersurl =
        'https://api.themoviedb.org/3/movie/${widget
        .movieID}/videos?api_key=$apiKey';

    /////////////////////////////Movie Details///////////////////////////////
    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetailjson = jsonDecode(moviedetailresponse.body);
      for (var i = 0; i < 1; i++) {
        MovieDetails.add({
          "backdrop_path": moviedetailjson['backdrop_path'],
          "title": moviedetailjson['title'],
          "vote_average": moviedetailjson['vote_average'],
          "overview": moviedetailjson['overview'],
          "release_date": moviedetailjson['release_date'],
          "runtime": moviedetailjson['runtime'],
          "budget": moviedetailjson['budget'],
          "revenue": moviedetailjson['revenue'],
        });
      }
      for (var i = 0; i < moviedetailjson['genres'].length; i++) {
        MoviesGeneres.add(moviedetailjson['genres'][i]['name']);
      }
    } else {}

    /////////////////////////////User Reviews///////////////////////////////
    var UserReviewresponse = await http.get(Uri.parse(UserReviewurl));
    if (UserReviewresponse.statusCode == 200) {
      var UserReviewjson = jsonDecode(UserReviewresponse.body);
      for (var i = 0; i < UserReviewjson['results'].length; i++) {
        UserREviews.add({
          "name": UserReviewjson['results'][i]['author'],
          "review": UserReviewjson['results'][i]['content'],
          //check rating is null or not
          "rating":
          UserReviewjson['results'][i]['author_details']['rating'] == null
              ? "Not Rated"
              : UserReviewjson['results'][i]['author_details']['rating']
              .toString(),
          "avatarphoto": UserReviewjson['results'][i]['author_details']
          ['avatar_path'] ==
              null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
              : "https://image.tmdb.org/t/p/w500" +
              UserReviewjson['results'][i]['author_details']['avatar_path'],
          "creationdate":
          UserReviewjson['results'][i]['created_at'].substring(0, 10),
          "fullreviewurl": UserReviewjson['results'][i]['url'],
        });
      }
    } else {}
    /////////////////////////////similar movies
    var similarmoviesresponse = await http.get(Uri.parse(similarmoviesurl));
    if (similarmoviesresponse.statusCode == 200) {
      var similarmoviesjson = jsonDecode(similarmoviesresponse.body);
      for (var i = 0; i < similarmoviesjson['results'].length; i++) {
        similarmovieslist.add({
          "poster_path": similarmoviesjson['results'][i]['poster_path'],
          "name": similarmoviesjson['results'][i]['title'],
          "vote_average": similarmoviesjson['results'][i]['vote_average'],
          "Date": similarmoviesjson['results'][i]['release_date'],
          "id": similarmoviesjson['results'][i]['id'],
        });
      }
    } else {}
    // print(similarmovieslist);
    /////////////////////////////recommended movies
    var recommendedmoviesresponse =
    await http.get(Uri.parse(recommendedmoviesurl));
    if (recommendedmoviesresponse.statusCode == 200) {
      var recommendedmoviesjson = jsonDecode(recommendedmoviesresponse.body);
      for (var i = 0; i < recommendedmoviesjson['results'].length; i++) {
        recommendedmovieslist.add({
          "poster_path": recommendedmoviesjson['results'][i]['poster_path'],
          "name": recommendedmoviesjson['results'][i]['title'],
          "vote_average": recommendedmoviesjson['results'][i]['vote_average'],
          "Date": recommendedmoviesjson['results'][i]['release_date'],
          "id": recommendedmoviesjson['results'][i]['id'],
        });
      }
    } else {}
    // print(recommendedmovieslist);
    /////////////////////////////movie trailers
    var movietrailersresponse = await http.get(Uri.parse(movietrailersurl));
    if (movietrailersresponse.statusCode == 200) {
      var movietrailersjson = jsonDecode(movietrailersresponse.body);
      for (var i = 0; i < movietrailersjson['results'].length; i++) {
        if (movietrailersjson['results'][i]['type'] == "Trailer") {
          movietrailerslist.add({
            "key": movietrailersjson['results'][i]['key'],
          });
        }
      }
      movietrailerslist.add({'key': 'aJ0cZTcTh90'});
    } else {}
    print(movietrailerslist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
          future: MoviesDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(FontAwesomeIcons.circleArrowLeft),
                      iconSize: 28,
                      color: Colors.white,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                                  (route) => false);
                        },
                        icon: const Icon(FontAwesomeIcons.houseUser),
                        iconSize: 25,
                        color: Colors.white,
                      )
                    ],
                    backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
                    centerTitle: false,
                    pinned: true,
                    expandedHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: FittedBox(
                        fit: BoxFit.fill,
                        child: TrailerWatch(
                          trailerID: movietrailerslist[0]['key'],
                        ),
                      ),
                    ),
                  ),
                  SliverList(delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: MoviesGeneres.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(25, 25, 25, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          MoviesGeneres[index].toString() ,style: const TextStyle(color: Colors.white),),
                                    );
                                  }
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 10, top: 10),
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('${MovieDetails[0]['runtime']}min', style: const TextStyle(color: Colors.white)),
                            )
                          ],
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Movie Story : ',style: TextStyle(color: Colors.white)),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(MovieDetails[0]['overview'].toString() ,style: const TextStyle(color: Colors.white)),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20, top: 10),
                      child: UserReview(revDetails: UserREviews),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('Release Date : ${MovieDetails[0]['release_date']}', style: const TextStyle(color: Colors.white)),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('Budget : ${MovieDetails[0]['budget']}', style: const TextStyle(color: Colors.white)),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text('Revenue : ${MovieDetails[0]['revenue']}' , style: const TextStyle(color: Colors.white)),
                    ),
                    sliderList(similarmovieslist, "Similar Movies", 'movie', similarmovieslist.length),
                    sliderList(recommendedmovieslist, "Recommended Movies", 'movie', recommendedmovieslist.length),
                  ]))
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          }),
    );
  }
}
