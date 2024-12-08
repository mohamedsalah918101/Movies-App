import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movies_app/api/api_links.dart';
import 'package:flutter_movies_app/home/section_page/movies.dart';
import 'package:flutter_movies_app/home/section_page/tv_series.dart';
import 'package:flutter_movies_app/home/section_page/upcoming.dart';
import 'package:flutter_movies_app/repeated/search_bar_function.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> trendingList = [];

  Future<void> trendingListHome() async {
    if (uVal == 1) {
      var trendingWeekResponse = await http.get(Uri.parse(trendingWeekUrl));
      if (trendingWeekResponse.statusCode == 200) {
        var tempData = jsonDecode(trendingWeekResponse.body);
        var trendingWeekJson = tempData['results'];
        for (var i = 0; i < trendingWeekJson.length; i++) {
          trendingList.add({
            'id': trendingWeekJson[i]['id'],
            'poster_path': trendingWeekJson[i]['poster_path'],
            'vote_average': trendingWeekJson[i]['vote_average'],
            'media_type': trendingWeekJson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    } else if (uVal == 2) {
      var trendingDayResponse = await http.get(Uri.parse(trendingDayUrl));
      if (trendingDayResponse.statusCode == 200) {
        var tempData = jsonDecode(trendingDayResponse.body);
        var trendingDayJson = tempData['results'];
        for (var i = 0; i < trendingDayJson.length; i++) {
          trendingList.add({
            'id': trendingDayJson[i]['id'],
            'poster_path': trendingDayJson[i]['poster_path'],
            'vote_average': trendingDayJson[i]['vote_average'],
            'media_type': trendingDayJson[i]['media_type'],
            'indexno': i,
          });
        }
      }
    } else {}
  }

  int uVal = 1;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                future: trendingListHome(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          height: MediaQuery.of(context).size.height),
                      items: trendingList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken,
                                    ),
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${i['poster_path']}'),
                                    fit: BoxFit.fill,
                                  )),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Trending 🔥",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: DropdownButton(
                        onChanged: (value) {
                          setState(() {
                            trendingList.clear();
                            uVal = int.parse(value.toString());
                          });
                        },
                        autofocus: true,
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        dropdownColor: Colors.black.withOpacity(0.6),
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.amber,
                          size: 30,
                        ),
                        value: uVal,
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              'Weekly',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SearchBarFunction(),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                      physics: const BouncingScrollPhysics(),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                      isScrollable: true,
                      controller: tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber.withOpacity(0.4),
                      ),
                      tabs: const [
                        Tab(
                          child: Text("TV Series", style: TextStyle(color: Colors.white),),
                        ),
                        Tab(
                          child: Text("Movies", style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text("Upcoming", style: TextStyle(color: Colors.white)),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 1050,
                  child: TabBarView(controller: tabController, children: const [
                    TvSeries(),
                    Movies(),
                    Upcoming(),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
