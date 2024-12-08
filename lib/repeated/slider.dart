import 'package:flutter/material.dart';
import 'package:flutter_movies_app/details/movie_details.dart';
import 'package:flutter_movies_app/details/tvseries_details.dart';

Widget sliderList(
    List firstListName, String categoryTitle, String type, int itemCount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 15, bottom: 40),
        child: Text(
          categoryTitle.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      SizedBox(
        height: 250,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if(type == 'movie'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(movieID: firstListName[index]['id'])));
                  } else if(type == 'tv'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TvSeriesDetails(tvID: firstListName[index]['id'])));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${firstListName[index]['poster_path']}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 13),
                  width: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 6),
                        child: Text(firstListName[index]['Date'],
                            style: const TextStyle(color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                          right: 6,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2, bottom: 2, left: 5, right: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                    firstListName[index]['vote_average']
                                        .toString(),
                                    style: const TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      )
    ],
  );
}
